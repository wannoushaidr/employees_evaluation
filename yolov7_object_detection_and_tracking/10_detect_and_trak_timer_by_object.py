# -*- coding: utf-8 -*-
"""
Created on Fri Aug 30 05:42:08 2024

@author: L
"""




import argparse
import time
from pathlib import Path
import cv2
import torch
import torch.backends.cudnn as cudnn
from numpy import random

from models.experimental import attempt_load
from utils.datasets import LoadStreams, LoadImages
from utils.general import check_img_size, check_requirements, \
                check_imshow, non_max_suppression, apply_classifier, \
                scale_coords, xyxy2xywh, strip_optimizer, set_logging, \
                increment_path
from utils.plots import plot_one_box
from utils.torch_utils import select_device, load_classifier, time_synchronized, TracedModel

from sort import *

import dlib
import numpy as  nb


"""Function to Draw Bounding boxes"""
def draw_boxes(img, bbox, identities=None, categories=None, confidences=None, names=None, colors=None, time_spent=None):  
    centers = []  # List to store centers  
    for i, box in enumerate(bbox):  
        x1, y1, x2, y2 = [int(j) for j in box]  
        center_x = (x1 + x2) // 2  
        center_y = (y1 + y2) // 2  
        centers.append((center_x, center_y))  # Store the center   
        tl = opt.thickness or round(0.002 * (img.shape[0] + img.shape[1]) / 2) + 1  # line/font thickness  
        
        #cat = int(categories[i]) if categories is not None else 0  
        #id = int(identities[i]) if identities is not None else 0  
        
        #color = colors[cat]  
        # Safely access categories and identities  
        cat = int(categories[i]) if categories is not None and i < len(categories) else 0  
        id = int(identities[i]) if identities is not None and i < len(identities) else 0  

        color = colors[cat] if colors is not None and cat < len(colors) else (255, 0, 0)  # Default color if colors are not provided or cat is out of bounds  
       
        
        if not opt.nobbox:   
            cv2.rectangle(img, (x1, y1), (x2, y2), color, tl)  
        
        # Calculate area of the bounding box  
        area = (x2 - x1) * (y2 - y1)   
        pixel_to_meter_ratio = 10 / 500   
        area_meters = area * (pixel_to_meter_ratio ** 2)  

        # Draw space above the bounding box for area display  
        label_height = 30  # Height of the space above the bounding box  
        cv2.rectangle(img, (x1, y1 - label_height), (x2, y1), color, -1)  # Filled rectangle above the box  
        
        # Display area above the bounding box  
        area_text = f'Area: {area_meters:.2f} m²'  
        tf = max(tl - 1, 1)  # font thickness  
        cv2.putText(img, area_text, (x1, y1 - 2 - label_height), 0, tl / 3, [225, 255, 255], thickness=tf, lineType=cv2.LINE_AA)  

        # Draw the time spent above the bounding box  
        if time_spent is not None and id in time_spent:  
            time_text = f'Time: {time_spent[id]["duration"]:.2f} s'  
            cv2.putText(img, time_text, (x1, y1 - 22), 0, tl / 3, [225, 255, 0], thickness=tf, lineType=cv2.LINE_AA)  

        if not opt.nolabel:  
            label = f'ID: {id} {names[cat]}' if identities is not None else names[cat]  
            tf = max(tl - 1, 1)  # font thickness  
            t_size = cv2.getTextSize(label, 0, fontScale=tl / 3, thickness=tf)[0]  
            c2 = x1 + t_size[0], y1 - t_size[1] - 3  
            cv2.rectangle(img, (x1, y1), c2, color, -1, cv2.LINE_AA)  # filled  
            cv2.putText(img, label, (x1, y1 - 2), 0, tl / 3, [225, 255, 255], thickness=tf, lineType=cv2.LINE_AA)  
        
        # Draw confidence above the bounding box  
        if confidences is not None and len(confidences) > i:  
            cv2.putText(img, f'Conf: {confidences[i]:.2f}', (x1, y1 - 20), cv2.FONT_HERSHEY_PLAIN, 1, (0, 0, 255), 2)  
        else:  
            print(f'No confidence value available for index {i}.')  

    return img, centers  


def calculate_distance(point1, point2):  
    return np.sqrt((point2[0] - point1[0]) ** 2 + (point2[1] - point1[1]) ** 2)  



def detect(save_img=False):
    source, weights, view_img, save_txt, imgsz, trace = opt.source, opt.weights, opt.view_img, opt.save_txt, opt.img_size, not opt.no_trace
    save_img = not opt.nosave and not source.endswith('.txt')  # save inference images
    webcam = source.isnumeric() or source.endswith('.txt') or source.lower().startswith(
        ('rtsp://', 'rtmp://', 'http://', 'https://'))
    save_dir = Path(increment_path(Path(opt.project) / opt.name, exist_ok=opt.exist_ok))  # increment run
    if not opt.nosave:  
        (save_dir / 'labels' if save_txt else save_dir).mkdir(parents=True, exist_ok=True)  # make dir

    # Initialize
    set_logging()
    device = select_device(opt.device)
    half = device.type != 'cpu'  # half precision only supported on CUDA

    # Load model
    model = attempt_load(weights, map_location=device)  # load FP32 model
    stride = int(model.stride.max())  # model stride
    imgsz = check_img_size(imgsz, s=stride)  # check img_size

    if trace:
        model = TracedModel(model, device, opt.img_size)

    if half:
        model.half()  # to FP16

    # Second-stage classifier
    classify = False
    if classify:
        modelc = load_classifier(name='resnet101', n=2)  # initialize
        modelc.load_state_dict(torch.load('weights/resnet101.pt', map_location=device)['model']).to(device).eval()

    # Set Dataloader
    vid_path, vid_writer = None, None
    if webcam:
        view_img = check_imshow()
        cudnn.benchmark = True  # set True to speed up constant image size inference
        dataset = LoadStreams(source, img_size=imgsz, stride=stride)
    else:
        dataset = LoadImages(source, img_size=imgsz, stride=stride)

    # Get names and colors
    names = model.module.names if hasattr(model, 'module') else model.names
    colors = [[random.randint(0, 255) for _ in range(3)] for _ in names]
    
    
    frame_counter=0
    # Run inference
    if device.type != 'cpu':
        model(torch.zeros(1, 3, imgsz, imgsz).to(device).type_as(next(model.parameters())))  # run once
    old_img_w = old_img_h = imgsz
    old_img_b = 1
    
#**************************************************
    face_detector = dlib.get_frontal_face_detector()  
    shape_predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")  
  
    
    # Dictionary to store the time spent on each detected face by ID  
    face_time_spent = {} 
    face_next_id = 0  # For giving new face IDs  
    face_id_map = {}  # Initialize the mapping for face IDs to rectangles  
    object_time_spent={}
    detected_face_ids = {}  # Initialize as an empty set  
    time_spent = {}
    
    # Initialize an empty array for dets_to_sort to avoid UnboundLocalError  
    dets_to_sort = np.empty((0, 6))  # Initialize this variable here  

#**************************************************
    video_path = opt.source  # This gets the video path from command line argument  

    cap = cv2.VideoCapture(video_path)


    t0 = time.time()
    ###################################
    startTime = 0
    ###################################
    while True:
        ret, frame = cap.read()
        if dataset.mode == 'video':  
            if not ret:
                break
        if cv2.waitKey(1) == ord('q'):
            quit_flag = True
            break
        for path, img, im0s, vid_cap in dataset:
            if dataset.mode == 'video':  
                frame_counter += 1  
            
            # Only process very 30th frame for video  
            if dataset.mode == 'video' and frame_counter % 12 != 0:  
                continue  # Skip to the next iteration for video  
                
            img = torch.from_numpy(img).to(device)
            img = img.half() if half else img.float()  # uint8 to fp16/32
            img /= 255.0  # 0 - 255 to 0.0 - 1.0
            if img.ndimension() == 3:
                img = img.unsqueeze(0)
    
            # Warmup
            if device.type != 'cpu' and (old_img_b != img.shape[0] or old_img_h != img.shape[2] or old_img_w != img.shape[3]):
                old_img_b = img.shape[0]
                old_img_h = img.shape[2]
                old_img_w = img.shape[3]
                for i in range(3):
                    model(img, augment=opt.augment)[0]
    
            # Inference
            t1 = time_synchronized()
            pred = model(img, augment=opt.augment)[0]
            t2 = time_synchronized()
    
            # Apply NMS
            pred = non_max_suppression(pred, opt.conf_thres, opt.iou_thres, classes=opt.classes, agnostic=opt.agnostic_nms)
            t3 = time_synchronized()
    
            # Apply Classifier
            if classify:
                pred = apply_classifier(pred, modelc, img, im0s)
    
            # Process detections
            for i, det in enumerate(pred):  # detections per image
                if webcam:  # batch_size >= 1
                    p, s, im0, frame = path[i], '%g: ' % i, im0s[i].copy(), dataset.count
                else:
                    p, s, im0, frame = path, '', im0s, getattr(dataset, 'frame', 0)
    
                p = Path(p)  # to Path
                save_path = str(save_dir / p.name)  # img.jpg
                txt_path = str(save_dir / 'labels' / p.stem) + ('' if dataset.mode == 'image' else f'_{frame}')  # img.txt
                gn = torch.tensor(im0.shape)[[1, 0, 1, 0]]  # normalization gain whwh
                
                ####
                if len(det):  
                    # Rescale boxes from img_size to im0 size  
                    det[:, :4] = scale_coords(img.shape[2:], det[:, :4], im0.shape).round()  
                    
                    # Prepare for face detection and tracking time spent  
                    dets_to_sort = np.empty((0, 6))  
                    for x1, y1, x2, y2, conf, detclass in det.cpu().detach().numpy():  
                        dets_to_sort = np.vstack((dets_to_sort, np.array([x1, y1, x2, y2, conf, detclass])))  
            
                    if opt.track:  
                        tracked_dets = sort_tracker.update(dets_to_sort, opt.unique_track_color)  
                        tracks = sort_tracker.getTrackers()  
            
                        # Draw boxes for visualization             
                        if  tracked_dets is not None and len(tracked_dets) > 0:  
                            current_time = time.time()  # Capture the current time before processing identities  

                            bbox_xyxy = tracked_dets[:, :4]  
                            identities = tracked_dets[:, 8]  
                            
                            # If identities is None, set it to an empty list to avoid errors  
                            #if identities is None or len(identities) == 0:   
                                #identities = []  

                            categories = tracked_dets[:, 4]  
                            confidences = None  
                            
                            
                            # Initialize time tracking for new identities  
                            for identity in identities:  
                                if identity not in time_spent:  
                                    time_spent[identity] = {'start_time': time.time(), 'duration': 0} 
                                else:
                                    # Update duration  
                                    time_spent[identity]['duration'] = current_time - time_spent[identity]['start_time']  
    
                
                            # Draw boxes and timers  
                            for idx, identity in enumerate(identities):  
                                x1, y1, x2, y2 = bbox_xyxy[idx]  
                                duration = time_spent[identity]['duration']  
                                cv2.rectangle(im0, (int(x1), int(y1)), (int(x2), int(y2)), (255, 0, 0), 2)  
                                cv2.putText(im0, f'ID: {identity}, Time: {duration:.2f}s', (int(x1)+100, int(y1) - 50),  
                                            cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 0, 0), 2)  
  

            
                
                            #if opt.show_track:  
                                ## Loop over tracks  s
                                #for t, track in enumerate(tracks):  
                                    #track_color = colors[int(track.detclass)] if not opt.unique_track_color else sort_tracker.color_list[t]  
            
                                    #[cv2.line(im0, (int(track.centroidarr[i][0]), int(track.centroidarr[i][1])),   
                                                   #(int(track.centroidarr[i + 1][0]), int(track.centroidarr[i + 1][1])),  
                                                   #track_color, thickness=opt.thickness)   
                                     #for i, _ in enumerate(track.centroidarr)   
                                     #if i < len(track.centroidarr) - 1]  
            
                
                        else:
                            # Handle the case where no tracked detections are available  
                            identities = []  
                            detected_face_ids = set()  # Initialize as an empty set  
                
                        # Before you attempt to use 'identities', check if it is None  
                        if identities is not None:  
                            detected_face_ids = {identity for identity in identities}  # Current detected faces  
                        else:  
                           print('is none')  # Initialize an empty set if no identities are found  
                           
                           
                        faces = face_detector(im0)  # Ensure faces is assigned here  
                        if len(faces) > 0:  # If any faces are detected  
        
                            # Face detection logic goes here  
                            #faces = face_detector(im0)  # Detect faces  
                            current_time = time.time()  # Get current time  
                    
                            # Print results  
                            for c in det[:, -1].unique():  
                                n = (det[:, -1] == c).sum()  # detections per class  
                                s += f"{n} {names[int(c)]}{'s' * (n > 1)}, "  # add to string  
                    
                            
                            for face in faces:  
                                x, y, w, h = (face.left(), face.top(), face.right() - face.left(), face.bottom() - face.top())
                                face_id = None  
        
                                if identities is not None:  # Only iterate if identities is valid  
                                    for idx, identity in enumerate(identities):  # Assuming identities is a list of IDs  
                                        bbox = bbox_xyxy[idx]  # Bounding box for the tracking object  
                                        # Check if the detected face is within the bounding box  
                                        if (x >= bbox[0] and x + w <= bbox[2]) and (y >= bbox[1] and y + h <= bbox[3]):  
                                            face_id = identity  # Assign matched identity  
                                            break  
                    
                                # Logic for new detected face  
                                if face_id is None:  
                                    face_id = face_next_id  # Assign a new ID if no existing match  
                                    time_spent[face_id] = {'start_time': time.time(), 'duration': 0}  # Initialize timer for new face  
                                    face_next_id += 1  # Increment to prepare for next new face ID  
                    
                                # Draw a rectangle around the detected face  
                                cv2.rectangle(im0, (x, y), (x + w, y + h), (255, 0, 0), 2)  
    
                          
                                        
                    #####     
                    else:
                        bbox_xyxy = dets_to_sort[:,:4]
                        identities = None
                        categories = dets_to_sort[:, 5]
                        confidences = dets_to_sort[:, 4]
                        # Update the active status of faces that are not detected  
                        detected_face_ids = {identity for identity in identities}  # Current detected faces  
                        for face_id in list(face_time_spent.keys()):  # Use list to avoid modifying during iteration  
                           if face_id not in detected_face_ids:  
                               face_time_spent[face_id]['active'] = False  # Mark the face as inactive  
                                
     
                    print("confidience befor sent ",confidences)
                    im0,centers = draw_boxes(im0, bbox_xyxy, identities, categories, confidences, names, colors)
                    
                    # Draw lines between each center  
                    for i in range(len(centers)):  
                        for j in range(i + 1, len(centers)):  # Ensure pairs are not repeated  
                            point1 = centers[i]  
                            point2 = centers[j]  
                
                            # Draw line between the points  
                            cv2.line(im0, point1, point2, (255, 0, 0), thickness=2)  
                
                            # Calculate distance between center points  
                            distance = calculate_distance(point1, point2)  
                
                            # Calculate position for displaying the distance  
                            text_pos = ((point1[0] + point2[0]) // 2, (point1[1] + point2[1]) // 2)  
                
                            # Put text above the line  
                            cv2.putText(im0, f'{distance:.2f}', text_pos, cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 2)          
                                    
                                
                    
                # Print time (inference + NMS)
                print(f'{s}Done. ({(1E3 * (t2 - t1)):.1f}ms) Inference, ({(1E3 * (t3 - t2)):.1f}ms) NMS')
    
                # Stream results
                ######################################################
                if dataset.mode != 'image' and opt.show_fps:
                    currentTime = time.time()
    
                    fps = 1/(currentTime - startTime)
                    startTime = currentTime
                    cv2.putText(im0, "FPS: " + str(int(fps)), (20, 70), cv2.FONT_HERSHEY_PLAIN, 2, (0,255,0),2)
    
                #######################################################
                if view_img:
                    cv2.imshow(str(p), im0)
                    cv2.waitKey(1)  # 1 millisecond
    
                # Save results (image with detections)
                if save_img:
                    if dataset.mode == 'image':
                        cv2.imwrite(save_path, im0)
                        print(f" The image with the result is saved in: {save_path}")
                    else:  # 'video' or 'stream'
                        if vid_path != save_path:  # new video
                            vid_path = save_path
                            if isinstance(vid_writer, cv2.VideoWriter):
                                vid_writer.release()  # release previous video writer
                            if vid_cap:  # video
                                fps = vid_cap.get(cv2.CAP_PROP_FPS)
                                w = int(vid_cap.get(cv2.CAP_PROP_FRAME_WIDTH))
                                h = int(vid_cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
                            else:  # stream
                                fps, w, h = 30, im0.shape[1], im0.shape[0]
                                save_path += '.mp4'
                            vid_writer = cv2.VideoWriter(save_path, cv2.VideoWriter_fourcc(*'mp4v'), fps, (w, h))
                        vid_writer.write(im0)

    if save_txt or save_img:
        s = f"\n{len(list(save_dir.glob('labels/*.txt')))} labels saved to {save_dir / 'labels'}" if save_txt else ''
        #print(f"Results saved to {save_dir}{s}")

    print(f'Done. ({time.time() - t0:.3f}s)')


if __name__ == '__main__':  
    parser = argparse.ArgumentParser()
    parser.add_argument('--weights', nargs='+', type=str, default='yolov7.pt', help='model.pt path(s)')
    parser.add_argument('--source', type=str, default='0', help='source')  # file/folder, 0 for webcam
    parser.add_argument('--img-size', type=int, default=640, help='inference size (pixels)')
    parser.add_argument('--conf-thres', type=float, default=0.25, help='object confidence threshold')
    parser.add_argument('--iou-thres', type=float, default=0.45, help='IOU threshold for NMS')
    parser.add_argument('--device', default='', help='cuda device, i.e. 0 or 0,1,2,3 or cpu')
    parser.add_argument('--view-img', action='store_true', help='display results')
    parser.add_argument('--save-txt', action='store_true', help='save results to *.txt')
    parser.add_argument('--save-conf', action='store_true', help='save confidences in --save-txt labels')
    parser.add_argument('--nosave', action='store_true', help='do not save images/videos')
    parser.add_argument('--classes', nargs='+', type=int,default=[0], help='filter by class: --class 0, or --class 0 2 3')
    parser.add_argument('--agnostic-nms', action='store_true', help='class-agnostic NMS')
    parser.add_argument('--augment', action='store_true', help='augmented inference')
    parser.add_argument('--update', action='store_true', help='update all models')
    parser.add_argument('--project', default='runs/detect', help='save results to project/name')
    parser.add_argument('--name', default='exp', help='save results to project/name')
    parser.add_argument('--exist-ok', action='store_true', help='existing project/name ok, do not increment')
    parser.add_argument('--no-trace', action='store_true', help='don`t trace model')

    parser.add_argument('--track', action='store_true', help='run tracking')
    parser.add_argument('--show-track', action='store_true', help='show tracked path')
    parser.add_argument('--show-fps', action='store_true', help='show fps')
    parser.add_argument('--thickness', type=int, default=2, help='bounding box and font size thickness')
    parser.add_argument('--seed', type=int, default=1, help='random seed to control bbox colors')
    parser.add_argument('--nobbox', action='store_true', help='don`t show bounding box')
    parser.add_argument('--nolabel', action='store_true', help='don`t show label')
    parser.add_argument('--unique-track-color', action='store_true', help='show each track in unique color')


    opt = parser.parse_args()
    print(opt)
    np.random.seed(opt.seed)

    sort_tracker = Sort(max_age=5,
                       min_hits=2,
                       iou_threshold=0.2) 

    #check_requirements(exclude=('pycocotools', 'thop'))

    with torch.no_grad():
        if opt.update:  # update all models (to fix SourceChangeWarning)
            for opt.weights in ['yolov7.pt']:
                detect()
                strip_optimizer(opt.weights)
        else:
            detect()
