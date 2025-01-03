import argparse
import time
from pathlib import Path
import dlib
import time  


import cv2
import torch
import torch.backends.cudnn as cudnn
from numpy import random

from models.experimental import attempt_load
from utils.datasets import LoadStreams, LoadImages
from utils.general import check_img_size, check_requirements, check_imshow, non_max_suppression, apply_classifier, \
    scale_coords, xyxy2xywh, strip_optimizer, set_logging, increment_path
from utils.plots import plot_one_box
from utils.torch_utils import select_device, load_classifier, time_synchronized, TracedModel


def detect(save_img=False):
    source, weights, view_img, save_txt, imgsz, trace = opt.source, opt.weights, opt.view_img, opt.save_txt, opt.img_size, not opt.no_trace
    save_img = not opt.nosave and not source.endswith('.txt')  # save inference images
    webcam = source.isnumeric() or source.endswith('.txt') or source.lower().startswith(
        ('rtsp://', 'rtmp://', 'http://', 'https://'))

    # Directories
    save_dir = Path(increment_path(Path(opt.project) / opt.name, exist_ok=opt.exist_ok))  # increment run
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
#***********************************************************************************************
    #frame counter 
    frame_counter = 0  
#*********************************************************************************************************

    # Run inference
    if device.type != 'cpu':
        model(torch.zeros(1, 3, imgsz, imgsz).to(device).type_as(next(model.parameters())))  # run once
    old_img_w = old_img_h = imgsz
    old_img_b = 1

    t0 = time.time()
    for path, img, im0s, vid_cap in dataset:
#*************************************************************************************************
#to take one frame in each 20 frame in viseo
        if dataset.mode == 'video':  
            frame_counter += 1  
        
        # Only process very 30th frame for video  
        if dataset.mode == 'video' and frame_counter % 2 != 0:  
            continue  # Skip to the next iteration for video  
            
#*************************************************************************************************

#********************************************************************************************
# Convert to grayscale  
        img = cv2.cvtColor(im0s, cv2.COLOR_BGR2GRAY)  # Convert each frame/image to grayscale  

#*******************************************************************************************
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
        with torch.no_grad():   # Calculating gradients would cause a GPU memory leak
            pred = model(img, augment=opt.augment)[0]
        t2 = time_synchronized()

        # Apply NMS
        pred = non_max_suppression(pred, opt.conf_thres, opt.iou_thres, classes=opt.classes, agnostic=opt.agnostic_nms)
        t3 = time_synchronized()

        # Apply Classifier
        if classify:
            pred = apply_classifier(pred, modelc, img, im0s)
        #**********************************************************************
        
        #**********************************************************************
#***********************************************************************************************************
 #for face predict and recognation by land mark    
        detector = dlib.get_frontal_face_detector()  
        sp = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")  
        face_encoder = dlib.face_recognition_model_v1("dlib_face_recognition_resnet_model_v1.dat")  

        # Start video capture (0 for default camera)  

        # Dictionary to hold the face descriptors  
        face_descriptors = {}  
        unique_faces = {}
        face_id_counter = 0  
#******************************************************************************************************************
        # Add initialization for person_detections at the start of your detection logic  
        person_detections = []  
        centers = []  # Default to an empty list  
        distances = []  # Default to an empty list  

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
            if len(det):
                # Rescale boxes from img_size to im0 size
                det[:, :4] = scale_coords(img.shape[2:], det[:, :4], im0.shape).round()
#********************************************************************************************
#pdetect by land mark            
#                detector = dlib.get_frontal_face_detector()
#                predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")
#                gray= cv2.cvtColor(im0,cv2.COLOR_BGR2GRAY)
#                faces = detector(gray)
#                for face in faces:
 #                   #print(face)
  #                  x1 = face.left()
   #                 y1 = face.top()
    #                x2=face.right()
     #               y2 = face.bottom()
      #              #cv2.rectangle(frame,(x1,y2),(x2,y2),(0,255,0),3)
       #             landmarks = predictor(gray,face)
        #            for n in range(0, 68):
         #               x = landmarks.part(n).x
          #              y = landmarks.part(n).y
           #             cv2.circle(im0, (x, y), 4, (0, 255, 0), -1)
#********************************************************************************************                
                
#**********************************************************************
# Add condition to filter for the person class (index 0)  
                person_detections = det[det[:, 5] == 0]  # Filter for 'person' class 
                
#**********************************************************************
#********************************************************************************************
#pdetect by land mark            
                # Convert the frame to RGB (dlib uses RGB)  
                rgb_frame = cv2.cvtColor(im0, cv2.COLOR_BGR2RGB)
                gray_frame = cv2.cvtColor(rgb_frame, cv2.COLOR_BGR2GRAY)
                
  
            
                # Detect faces in the frame  
                dets = detector(gray_frame)  
            
                # Get current time  
                #current_time = time.time()  
            
                # Loop through detected faces  
                for det in dets:  
                    current_time = time.time()  

                    # Get landmarks  
                    shape = sp(im0, det)  
                    # Draw landmarks on the face  
                    for i in range(68):  # 68 landmarks for face  
                        x = shape.part(i).x  
                        y = shape.part(i).y  
                        cv2.circle(im0, (x, y), 1, (0, 255, 0), -1)  # Drawing landmark points  


                    
                    # Create face descriptor  
                    face_descriptor = face_encoder.compute_face_descriptor(im0, shape)  
            
                    # Convert to a numpy array for easier comparison  
                    face_descriptor_np = np.array(face_descriptor)  
            
                    # Find the closest face descriptor already stored  
                    found = False  
                    for face_id, stored_descriptor in face_descriptors.items():  
                        # Calculate the Euclidean distance between the stored descriptor and current descriptor  
                        distance = np.linalg.norm(face_descriptor_np - stored_descriptor)  
                        if distance < 0.6:  # Threshold for recognizing as the same face  
                            unique_faces[face_id] = current_time  # Update last seen time  
                            found = True  
                            break  
                    
                    # If the face is not recognized, assign a new ID  
                    if not found:  
                        face_id = face_id_counter  
                        face_descriptors[face_id] = face_descriptor_np  # Store the descriptor    
                        unique_faces[face_id] = current_time  # Record appearance time  
                        face_id_counter += 1  
                    
                    # Draw a rectangle around the face  
                    cv2.rectangle(im0, (det.left(), det.top()), (det.right(), det.bottom()), (255, 0, 0), 2)  
                        
                    # Calculate time spent for the current unique face  
                    time_spent = current_time - unique_faces[face_id]  

                    # Put the face ID text above the face  
                    cv2.putText(im0, f"ID: {face_id}", (det.left(), det.top() - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 0, 0), 2)  
                    cv2.putText(im0, f"Time: {int(time_spent)}s", (det.left(), det.top() + 10),  
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 0), 2)  

                # Display the number of unique faces detected  
                unique_faces_count = len(unique_faces)  
                cv2.putText(im0, f"Unique Faces: {unique_faces_count}", (10, 30),   
                            cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 255, 255), 2)  
            
                 


#********************************************************************************************                
                

                
                # Print results
                for c in person_detections[:, -1].unique():
                    n = (person_detections[:, -1] == c).sum()  # detections per class
                    s += f"{n} {names[int(c)]}{'s' * (n > 1)}, "  # add to string

                # Write results
                for *xyxy, conf, cls in reversed(person_detections):
                    if save_txt:  # Write to file
                        xywh = (xyxy2xywh(torch.tensor(xyxy).view(1, 4)) / gn).view(-1).tolist()  # normalized xywh
                        line = (cls, *xywh, conf) if opt.save_conf else (cls, *xywh)  # label format
                        with open(txt_path + '.txt', 'a') as f:
                            f.write(('%g ' * len(line)).rstrip() % line + '\n')

                    if save_img or view_img:  # Add bbox to image
                        label = f'{names[int(cls)]} {conf:.2f}'
                        plot_one_box(xyxy, im0, label=label, color=colors[int(cls)], line_thickness=1)
#****************************************************************************************************************
# calc space of boundingboc and put it top of boundibg box
                        # Calculate width and height  
                        bbox_width = xyxy[2] - xyxy[0]  
                        bbox_height = xyxy[3] - xyxy[1]  
                        
                        # Calculate area  
                        bbox_area = bbox_width * bbox_height  
                
                        # Create the area label  
                        area_label = f'Area: {bbox_area:.2f}'  
                
                        # Calculate position for area label (above the bounding box)  
                        label_position = (int(xyxy[0]), int(xyxy[1]) - 10)  # Adjust -10 to position above the box  
                
                        # Put the area text on the image  
                        cv2.putText(im0, area_label, label_position, cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 1) 
            else:
                #If there are no detections, we can simply leave it as is or log a message  
                person_detections = torch.empty((0, det.size(1)))  # Ensure it's an empty tensor with the same number of columns  

#****************************************************************************************************************


                                 
#****************************************************************************************
            # Print results (modified to include center points and distances)
            if person_detections.numel() > 0:  
                centers, distances = calculate_center_and_distance(person_detections)  
            else:
                print("No person detections.")  
                
                print("no thing detected")
            #enters, distances = calculate_center_and_distance(person_detections)
            print("Image {}:".format(i))
            print("  * Detections:", person_detections)  # Print original detections for reference
            print("  * Centers:", centers)
            print("  * Distances:", distances)
#****************************************************************
#*******************************************************************************   
        # Draw lines between centers and label distances  
            for m in range(len(centers)):  
                for n in range(m + 1, len(centers)):  
                    center1 = centers[m]  
                    center2 = centers[n]  
                    # Calculate the linear index based on total centers  
                    
#*************************************************************************************************************
#calc distance to draw all line between center
                    distance = np.sqrt((center2[0] - center1[0])**2 + (center2[1] - center1[1])**2)
                    cv2.line(im0, (int(center1[0]), int(center1[1])), (int(center2[0]), int(center2[1])), (0, 0, 0), 1)
#/********************************************************************************************************
                    # Draw a line between the centers  
                    
                    # Put the distance text on the midpoint of the line  
                    mid_x = (center1[0] + center2[0]) // 2  
                    mid_y = (center1[1] + center2[1]) // 2  
                    #mid_x = int(mid_x)  
                    #mid_y = int(mid_y)  
                    
                    
                     # Ensure mid_x and mid_y are within the image bounds  
                    if 0 <= mid_x < im0.shape[1] and 0 <= mid_y < im0.shape[0]:  
                        # Ensure distance is a float  
                        distance = int(distance)  # Make sure distance is float for formatting  
                        # Put the distance text on the midpoint  
                        cv2.putText(im0, f"{distance:.2f}", (int(mid_x), int(mid_y)),cv2.FONT_HERSHEY_COMPLEX_SMALL, 0.5, (255, 255, 255), 1)  
                    else:  
                        print("Midpoint is out of image bounds.")  
                    
                    # Rest of your code...  
#*******************************************************************************
            # Print time (inference + NMS)
            print(f'{s}Done. ({(1E3 * (t2 - t1)):.1f}ms) Inference, ({(1E3 * (t3 - t2)):.1f}ms) NMS')

            # Stream results
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

import numpy as np

# ... rest of your code ...

def calculate_center_and_distance(detections):
    """Calculates the center points of bounding boxes and distances between them.

    Args:
        detections: A list of detections, where each detection is a list of
                    [x1, y1, x2, y2, confidence, class].

    Returns:
        A list of center points (x, y) for each bounding box.
        A list of distances between all pairs of center points.
    """

    centers = []
    for detection in detections:
        x1, y1, x2, y2 = detection[:4]
        center_x = (x1 + x2) / 2
        center_y = (y1 + y2) / 2
        centers.append((center_x, center_y))

    distances = []
    for i in range(len(centers)):
        for j in range(i + 1, len(centers)):
            x1, y1 = centers[i]
            x2, y2 = centers[j]
            distance = np.sqrt((x2 - x1)**2 + (y2 - y1)**2)
            distances.append(distance)

    return centers, distances



# ... rest of the code ..


if __name__ == '__main__':

    print("ss")
    parser = argparse.ArgumentParser()
    parser.add_argument('--weights', nargs='+', type=str, default='yolov7.pt', help='model.pt path(s)')
  #  parser.add_argument('--source', type=str, default='inference/images', help='source')  # file/folder, 0 for webcam
    #for test image path
    parser.add_argument('--source', type=str, default='new_Images_for_test/9.jpg', help='6_jpg')  # file/folder, 0 for webcam
    parser.add_argument('--img-size', type=int, default=640, help='inference size (pixels)')
    parser.add_argument('--conf-thres', type=float, default=0.6, help='object confidence threshold')
    parser.add_argument('--iou-thres', type=float, default=0.6, help='IOU threshold for NMS')
    parser.add_argument('--device', default='', help='cuda device, i.e. 0 or 0,1,2,3 or cpu')
    parser.add_argument('--view-img', action='store_true', help='display results')
    parser.add_argument('--save-txt', action='store_true', help='save results to *.txt')
    parser.add_argument('--save-conf', action='store_true', help='save confidences in --save-txt labels')
    parser.add_argument('--nosave', action='store_true', help='do not save images/videos')
    parser.add_argument('--classes', nargs='+', type=int, help='filter by class: --class 0, or --class 0 2 3')
    parser.add_argument('--agnostic-nms', action='store_true', help='class-agnostic NMS')
    parser.add_argument('--augment', action='store_true', help='augmented inference')
    parser.add_argument('--update', action='store_true', help='update all models')
    parser.add_argument('--project', default='runs/detect', help='save results to project/name')
    parser.add_argument('--name', default='exp', help='save results to project/name')
    parser.add_argument('--exist-ok', action='store_true', help='existing project/name ok, do not increment')
    parser.add_argument('--no-trace', action='store_true', help='don`t trace model')
    print("ssss")
    opt = parser.parse_args()
    print("sssss")
    print(opt)
    #check_requirements(exclude=('pycocotools', 'thop'))

    print("ssssss")
    with torch.no_grad():
        if opt.update:  # update all models (to fix SourceChangeWarning)
            for opt.weights in ['yolov7.pt']:
                detect()
                strip_optimizer(opt.weights)
        else:
            detect()
