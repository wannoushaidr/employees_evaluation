




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

def scale_coords(img1_shape, coords, img0_shape):  
    # Function to scale coordinates  
    gain = np.array([img0_shape[1] / img1_shape[1], img0_shape[0] / img1_shape[0]] * 2)  
    coords = (coords * gain).round()  
    return coords  


def draw_boxes(img, bbox, identities=None, categories=None, confidences=None, colors=None, time_spent=None, opt=None, names=None,object_name=None):  

    DEFAULT_ID = "not available"      
    temporary_ids = {}  # Initialize temporary IDs dictionary  
    centers = {}  # List to store centers  
    object_name=object_name

    if object_name is not None :
        if len (object_name) >0 :
            print("keys of object_name ",object_name.keys())
    print("identities:",identities)
    for i in identities:
        print("identities  :",i)
    for i, box in enumerate(bbox):  
        x1, y1, x2, y2 = [int(j) for j in box]  
        #center_x = (x1 + x2) // 2  
        #center_y = (y1 + y2) // 2  
        #centers.append(identities[i],(center_x, center_y))  # Store the center   
        
        # Initialization for temporary ID (id2)  
        if i not in temporary_ids:  
            temporary_ids[i] = DEFAULT_ID  # Assign default value indicating not available
            
            
        tl = opt.thickness or round(0.002 * (img.shape[0] + img.shape[1]) / 2) + 1  # line/font thickness  
        
        #cat = int(categories[i]) if categories is not None else 0  
        #id = int(identities[i]) if identities is not None else 0  
        
        #color = colors[cat]  
        # Safely access categories and identities  
        cat = int(categories[i]) if categories is not None and i < len(categories) else 0  
        id = int(identities[i]) if identities is not None and i < len(identities) else 0  
                
        center_x = (x1 + x2) // 2  
        center_y = (y1 + y2) // 2  
        # Ensure id is within the bounds of the centers list  
        #if id >= len(centers):  
            ## If id exceeds the current length, append None or handle as needed  
            #centers.extend([None] * (id - len(centers) + 1))  
        
        centers[id]=(center_x, center_y)  # Store the center   
            

        color = colors[cat] if colors is not None and cat < len(colors) else (255, 0, 0)  # Default color if colors are not provided or cat is out of bounds  
       
        
        if not opt.nobbox:   
            cv2.rectangle(img, (x1, y1), (x2, y2), color, tl)  
        
        # Calculate area of the bounding box  
        area = (x2 - x1) * (y2 - y1)   
        pixel_to_meter_ratio = 10 / 10000
        area_meters = area * (pixel_to_meter_ratio ** 2)  

        # Draw space above the bounding box for area display  
        label_height = 30  # Height of the space above the bounding box  
        cv2.rectangle(img, (x1, y1 - label_height), (x2, y1), color, -1)  # Filled rectangle above the box  
        
        # Display area above the bounding box  
        area_text = f'Area: {area_meters:.2f} m²'  
        tf = max(tl - 1, 1)  # font thickness  
        cv2.putText(img, area_text, (x1, y1 - 2 - label_height), 0, tl / 3, [225, 255, 255], thickness=tf, lineType=cv2.LINE_AA)  
        print("id : ",id)
        # Draw the time spent above the bounding box  
        if time_spent is not None and id in time_spent:  
            time_text = f'Time: {time_spent[id]["duration"]:.2f} s'  
            cv2.putText(img, time_text, (x1, y1 - 22), 0, tl / 3, [225, 255, 0], thickness=1    , lineType=cv2.LINE_AA)  
          
        object_name_keys=[list(object_name.keys())]
        #for  object_name
        if identities is not None and  len(identities) >0:
            if object_name is not None and len(object_name)>0 and id in object_name_keys  :  
                object_name = f'object_name: {object_name[id]}'  
                cv2.putText(img, object_name, (x1+20, y1 - 52), 0, tl / 3, [225, 255, 0], thickness=tf, lineType=cv2.LINE_AA)  


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
    #return np.sqrt((point2[0] - point1[0]) ** 2 + (point2[1] - point1[1]) ** 2)  
    # Calculate the distance in pixels  
    pixel_distance = np.sqrt((point2[0] - point1[0]) ** 2 + (point2[1] - point1[1]) ** 2)  
    
    # Define the pixel to meter ratio  
    pixel_to_meter_ratio = 10 / 10000  # 10 meters for 500 pixels  
    
    # Convert pixel distance to meters  
    meter_distance = pixel_distance * pixel_to_meter_ratio  
    
    return meter_distance  

import cv2  

def calculate_histogram(image):  
    # Convert the image to HSV color space (or another preferred color space)  
    #hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)  

    # Calculate the histogram  
    # Using 256 bins for each channel (Hue, Saturation, Value)  
    hist = cv2.calcHist([image], [0, 1, 2], None, [256, 256, 256], [0, 256, 0, 256, 0, 256])  

    # Normalize the histogram to sum to 1  
    hist = cv2.normalize(hist, hist).flatten()  

    return hist

# Define the cosine similarity function  
def cosine_similarity(hist1, hist2):  
    # Calculate the dot product  
    dot_product = np.dot(hist1, hist2)  
    # Calculate the norms  
    norm1 = np.linalg.norm(hist1)  
    norm2 = np.linalg.norm(hist2)  
    
    # Avoid division by zero  
    if norm1 == 0 or norm2 == 0:  
        return 0  
    
    # Calculate cosine similarity  
    similarity = dot_product / (norm1 * norm2)  
    # Convert to distance (0 = similar, 1 = dissimilar)  
    distance = 1 - similarity  
    return distance  




# Function to draw the object ID as text below the bounding box  
def draw_id(image, object_id, x, y):  
    text = f"his_id: {object_id}"  
    font = cv2.FONT_HERSHEY_SIMPLEX  
    font_scale = 0.5  
    color = (0, 0, 255)  # Red color in BGR format  
    thickness = 2  
    # Get the size of the text box  
    text_size = cv2.getTextSize(text, font, font_scale, thickness)[0]  

    # Calculate the position for the text to be centered at (x, y)  
    text_x = int(round(x))  
    text_y = int(round(y)) - 5  # Offset the text slightly above the point  

    # Optionally draw a rectangle behind the text for visibility  
    box_x1 = text_x  
    box_y1 = text_y - text_size[1] - 5  # Offset for rectangle to be above text  
    box_x2 = text_x + text_size[0]  
    box_y2 = text_y + 5  # Small height for the rectangle  
    
    


    # Draw the text on the image  
    # Draw the text on the image  
    #cv2.putText(image, text, (text_x, text_y), font, font_scale, color, thickness, cv2.LINE_AA)  
    cv2.putText(image, text, (text_x, text_y), cv2.FONT_HERSHEY_PLAIN, 1, (0, 0, 255), 1)  






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
    face_encoder = dlib.face_recognition_model_v1('dlib_face_recognition_resnet_model_v1.dat')  # and this model  

    # Example initialization (adjust based on your actual face encoder library)  

    # Initialize the face encoder  
    #face_encoder = FaceEncoder()  # Adjust parameters as necessary
      
    
    # Dictionary to store the time spent on each detected face by ID  
    face_time_spent = {} 
    face_next_id = 0  # For giving new face IDs  
    face_id_map = {}  # Initialize the mapping for face IDs to rectangles  
    object_time_spent={}
    detected_face_ids = {}  # Initialize as an empty set  
    time_spent = {}
    face_ids_dict = {}  
    tracked_faces = {}  
    face_descriptors = {}  
    unique_faces = {}  
    last_seen_times = {}  
    
    
    current_time = time.time()  # Capture current time   
    bbox_xyxy = None  
    identities = None  
    number_of_employee = 0 
        

#****************************************************************************************************************
# to save faces employee for detect if it employee or customer
    number_of_employee = 0
 #****************************************************************************************************************   
 
#***********************************************************************************************************
    employee_services = {}  
    customer_services = {}  
    service_timers = {}  # Stores start time for service between employees and customers
#****************************************************************************************************************

#***********************************************************************************************************
#to 
    saved_cople={}
    not_available_people=[]
    cople_count=0
    cople_id=0
#***********************************************************************************************************

#***********************************************************************************************************
#to save same id face to same object
    object_id_and_his_face={}
#***********************************************************************************************************

#***********************************************************************************************************
#to save object name
    object_name={}

#***********************************************************************************************************

    
    # Initialize an empty array for dets_to_sort to avoid UnboundLocalError  
    dets_to_sort = np.empty((0, 6))  # Initialize this variable here  

#**************************************************

#*********************************************************************************
# to save object histogram
    object_histograms = {}
    object_counter = 0  # Counter for unique histogram keys  


#*****************************************************************************
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
        # Check for key press to stop the webcam  
        if cv2.waitKey(1) == ord('s'):  # Press 's' to stop the webcam  
            print("Stopping webcam as per user request.")  
            break  
        for path, img, im0s, vid_cap in dataset:
            if dataset.mode == 'video':  
                frame_counter += 1  
            
            # Only process very 30th frame for video  
            if dataset.mode == 'video' and frame_counter % 1 != 0:  
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
    
                p = Path(p)  # to Path print
                save_path = str(save_dir / p.name)  # img.jpg
                txt_path = str(save_dir / 'labels' / p.stem) + ('' if dataset.mode == 'image' else f'_{frame}')  # img.txt
                gn = torch.tensor(im0.shape)[[1, 0, 1, 0]]  # normalization gain whwh
                
#**********************************************************************************************************
#to check nuber of faces for if there faces  assign to employee
                face_detected_check=None  
#**********************************************************************************************************

                
                if len(det):  
                    print(type(det))  # Check the type of `det`  
                    
                    # Rescale boxes from img_size to im0 size  
                    det[:, :4] = scale_coords(img.shape[2:], det[:, :4], im0.shape).round()
    
                    # If det is a Tensor, convert it to numpy  
                    if isinstance(det, torch.Tensor):  
                        det_np = det.cpu().numpy()  # Convert to numpy if it's a tensor on GPU  
                    else:  
                        det_np = det  # It's already a NumPy array  

                  
                    # Now you can safely access indices  
                    categories = det_np[:, 4].astype(int)  # Assuming the 5th column is for categories  
#***************************************************************************************
# Extract object bounding box and calc histogram 
#next_object_id = 0  # Counter for generating unique object IDs

                    ####
                    # Loop through detected objects (excluding faces)  
                    for i, (x1, y1, x2, y2, conf, detclass) in enumerate(det_np):  
                        # Extract the object region from the image  
                        object_image = im0[int(y1):int(y2), int(x1):int(x2)]  
                    
                        # Calculate the histogram for the detected object  
                        object_hist = calculate_histogram(object_image)  
                    
                        # Initialize variables for finding the most similar histogram  
                        most_similar_key = None  
                        min_distance = float('inf')  # Start with an infinitely large distance  
                        is_similar = False  
                        tem_to_draw_id = None  
                    
                        # Check for most similar histogram  
                        for key, existing_hist in object_histograms.items():  
                            # Use the cosine similarity function instead of Chi-Squared distance  
                            dist = cosine_similarity(existing_hist, object_hist)  
                            print("Distance is:", dist)  
                            #print("Existing histogram is:", existing_hist)  
                    
                            # Keep track of the most similar histogram (smallest distance)  
                            if dist < min_distance:  
                                min_distance = dist  
                                most_similar_key = key  
                                tem_to_draw_id = key  
                    
                        # Define a threshold for comparison  
                        threshold = 0.7  # Adjust based on your application needs  
                    
                        # After finding the most similar histogram, apply the threshold check  
                        if min_distance < threshold:  # If the most similar histogram is within the threshold  
                            is_similar = True  
                            print(f"Object with key {most_similar_key} found with similar histogram. Distance: {min_distance}")  
                    
                        # If no similar histogram was found above the threshold, add a new entry  
                        if not is_similar:  
                            object_histograms[object_counter] = object_hist  # Store new histogram with the current counter  
                            print(f"Added new histogram for object with key {object_counter}.")  
                            tem_to_draw_id = object_counter  
                            object_counter += 1  # Increment the counter for the next new object  
                    
                        # Draw the histogram below the bounding box  
                        text = f"his_id: {tem_to_draw_id}" 
                        cv2.putText(im0, f"his_id: {tem_to_draw_id}", (int(x1-10), int(y1 + 30)), cv2.FONT_HERSHEY_PLAIN, 1, (0, 0, 255), 1)  

                        #im0=draw_id(im0, tem_to_draw_id, x1, y1)  # Pass the ID and coordinates  
                        tem_to_draw_id = None  
                  
#*******************************************************************************************

                    #bbox_xyxy = det_np[:, :4]  # Get bounding box coordinates  
                    #identities = det_np[:, 5]  # Get identities if it's located here  
                    
                    faces = face_detector(im0)  # Detect faces  


                    # Prepare for face detection and tracking time spent  
                    dets_to_sort = np.empty((0, 6))  
                    for x1, y1, x2, y2, conf, detclass in det.cpu().detach().numpy():  
                        dets_to_sort = np.vstack((dets_to_sort, np.array([x1, y1, x2, y2, conf, detclass])))  
                    
                    if opt.track:  
                        current_time = time.time()  # Capture the current time  
                        tracked_dets = sort_tracker.update(dets_to_sort, opt.unique_track_color)  

                        if tracked_dets is not None and len(tracked_dets) > 0:  
                            bbox_xyxy = tracked_dets[:, :4]  
                            identities = tracked_dets[:, 8]  

                            # Initialize time tracking for existing identities   
                            for identity in identities:  
                                if identity not in time_spent:  
                                    time_spent[identity] = {'start_time': current_time, 'duration': 0}  
                                else:  
                                    time_spent[identity]['duration'] += current_time - time_spent[identity]['start_time']  
                                    time_spent[identity]['start_time'] = current_time  # Reset start time for the next frame  
                                    
#***********************************************************************************************************
# to save faces employee for detect if it employee or customer
                            if number_of_employee==0:
                                    # Face detection logic  
                                    image1 = cv2.imread('output_face_0.jpg',cv2.IMREAD_COLOR)
                                    image2 = cv2.imread('output_face_1.jpg',cv2.IMREAD_COLOR)
                                        
                                    faces1 = face_detector(image1)  # Detect faces  
                                    faces2 = face_detector(image2)  # Detect faces  
                                    face_id_for_employee=0
                                    for face in faces1:                                     
                                        # Extract the shape of the face to compute the descriptor  
                                        print("test")
                                        shape = shape_predictor(image1, face)  
                                        face_descriptor_1 = face_encoder.compute_face_descriptor(image1, shape)  
                                        face_descriptor_np_1 = np.array(face_descriptor_1)  
                                        face_id_for_employee=face_next_id
                                        face_descriptors[face_id_for_employee]=face_descriptor_np_1
                                        face_next_id += 1  

                                    for face in faces2:                                     

                                            shape = shape_predictor(image2, face)  
                                            face_descriptor_1 = face_encoder.compute_face_descriptor(image2, shape)  
                                            face_descriptor_np_1 = np.array(face_descriptor_1)  
                                            face_id_for_employee=face_next_id
                                            face_descriptors[face_id_for_employee]=face_descriptor_np_1                                            
                                            face_next_id += 1  
                                            number_of_employee=1

#******************************************************************************************************************
                            #tosave name of object detection
                            object_name={}
                            # Face detection logic  
                            faces = face_detector(im0)  # Detect faces  
                            face_detected_check=faces
                        
                            for face in faces:  
                                x, y, w, h = (face.left(), face.top(), face.right() - face.left(), face.bottom() - face.top())  
                                
                                # Extract the shape of the face to compute the descriptor  
                                shape = shape_predictor(im0, face)  
                                face_descriptor = face_encoder.compute_face_descriptor(im0, shape)  
                                face_descriptor_np = np.array(face_descriptor)                                  
                                face_id = None  # Initialize as None  
                
                               
                                        
                                # Initialize variables to track the best match  
                                best_distance = float('inf')  # Start with a very large number  
                                best_face_id = None  # Initialize best face ID  
                                #print(face_descriptors)

                                # Find the closest face descriptor already stored  
                                found = False  
                                for stored_face_id, stored_descriptor in face_descriptors.items():  
                                    distance = np.linalg.norm(face_descriptor_np - stored_descriptor)  
                                    
                                    # Update the best match if the distance is smaller than the current best  
                                    if distance < best_distance:  
                                        best_distance = distance  
                                        best_face_id = stored_face_id  
                                        
                                        
                                    # After checking all stored descriptors, decide what to do  
                                    #if best_distance < 0.6:  # If the closest match is within the threshold  
                                        #face_id = best_face_id  
                                        #unique_faces[face_id] = current_time  # Update last seen time  
                                        #found = True  
                                #ss
                                # After checking all stored descriptors, decide what to do  
                                if best_distance < 0.8:  # If the closest match is within the threshold  
                                    face_id = best_face_id  
                                    unique_faces[face_id] = current_time  # Update last seen time  
                                    found = True  
                                else:  
                                    # If no match is found, assign a new ID  
                                    face_id = face_next_id  
                                    face_descriptors[face_id] = face_descriptor_np  # Store the descriptor    
                                    unique_faces[face_id] = current_time  # Record appearance time  
                                    last_seen_times[face_id] = [current_time, 0]  # Last seen and time spent  
                                    face_time_spent[face_id] = {'start_time': current_time, 'duration': 0, 'active': True,'customer_id':f'customer_id:{face_id}'}  
                                    face_next_id += 1  
                            
                                # Start or resume the timer for the matched face  
                                if face_id not in face_time_spent:  
                                    face_time_spent[face_id] = {'start_time': current_time, 'duration': 0, 'active': True,'customer_id':f'customer_id:{face_id}'}  
                                else:  
                                    face_time_spent[face_id]['duration'] += current_time - face_time_spent[face_id]['start_time']  
                                    face_time_spent[face_id]['start_time'] = current_time  
                            
                                # Display the timer for the detected face  
                                duration = face_time_spent[face_id]['duration'] + (current_time - face_time_spent[face_id]['start_time'])  
                                customer_id=face_time_spent[face_id]['customer_id']
                                cv2.putText(im0, f'Time: {duration:.2f}s', (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 0, 0), 2)  
                                cv2.putText(im0, f'face_id: {face_id}', (x, y - 30), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 2)   
                                #cv2.putText(im0, f'customer_id: {customer_id}', (x, y - 50), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 2)          

                                
                                # Check if detected face overlaps with any tracked identity  
                                if len(identities)== len(faces):
                                    for idx, identity in enumerate(identities):  
                                        bbox = bbox_xyxy[idx]  
                                        if (x >= bbox[0] and x + w <= bbox[2]) and (y >= bbox[1] and y + h <= bbox[3]):  
                                            #identities[idx] = face_id  
                                            object_id_and_his_face[face_id]=[identity,face_time_spent[face_id]['customer_id']]
                                            
                                            print("identity",identity)
                                           # object_name={}
                                            s=int(identity)
                                            object_name[s]=object_id_and_his_face[face_id][1]
                                            cv2.putText(im0, f'customer_id: {customer_id}', (x, y - 50), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 2)          


                                     
                            # If no faces are detected, remember the last known face ID  
                            if not faces:  
                                for idx, identity in enumerate(identities):  
                                    # Maintain object ID if no new face is detected  
                                    if identity in unique_faces:  
                                        continue  # Keep the same identity  

                            #         

                            
#****************************************************************************************************************************************************


                         

                            # Draw rectangles only if at least one face was detected  
                            if len(faces) > 0:   
                                for face in faces:  
                                    x, y, w, h = (face.left(), face.top(), face.right() - face.left(), face.bottom() - face.top())  
                                    cv2.rectangle(im0, (x, y), (x + w, y + h), (255, 0, 0), 2)  
                            else:  
                                # Optionally handle the case when no faces are found  
                                print("No faces detected.")  

                            # Draw a rectangle around the detected face  
                            #cv2.rectangle(im0, (x, y), (x + w, y + h), (255, 0, 0), 2)  

                        # Call draw_boxes to display bounding box information  
                        #names = ['Object'] * len(identities)  # Example names for detected objects  
                        #colors = [(0, 255, 0)] * len(identities)  # Example colors for boxes  
                        #area_values = np.array([[0, 0, 0, 0]] * len(identities))  # Dummy area values, replace with actual  
                        #im0, centers = draw_boxes(im0, bbox_xyxy, identities, categories=None, confidences=None, names=names, colors=colors) 
                        print("identities in main video: ",identities)
                        for i in identities:
                            print("identities in main video :",i)
                        
                        
                        img, centers = draw_boxes(im0, bbox_xyxy, identities, categories, confidences=None, colors=colors, time_spent=time_spent, opt=opt, names=names,object_name=object_name)  
                        #object_name={}

                        keys = list(centers.keys())  # Convert keys to a list  
                        # Draw lines between each center  
                        for i in range(len(keys)):  
                            for j in range(i + 1, len(keys)):  # Ensure pairs are not repeated  
                                point1 = centers[keys[i]] 
                                point2 = centers[keys[j]]   
                    
                                # Draw line between the points  
                                cv2.line(im0, point1, point2, (255, 0, 0), thickness=2)  
                    
                                # Calculate distance between center points  
                                distance = calculate_distance(point1, point2)  
                    
                                # Calculate position for displaying the distance  
                                text_pos = ((point1[0] + point2[0]) // 2, (point1[1] + point2[1]) // 2)  
                                
                    
                                # Put text above the line  
                                cv2.putText(im0, f'{distance:.2f}', text_pos, cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 2) 
                                
#**************************************************************************************************************************************     
#put employee for customer                           
    
                        if face_detected_check is not None:   
                            #saved_cople
                            keys = list(centers.keys())  # Convert keys to a list  
                            object_id_and_his_face_keyes=list(object_id_and_his_face.keys())
                            keys_i_id=None
                            keys_j_id=None
    
                            for i in range(len(keys)):  
                                for j in range(i + 1, len(keys)):  # Ensure pairs are not repeated  
                                    point1 = centers[keys[i]]  
                                    point2 = centers[keys[j]]  
                                    distance = calculate_distance(point1, point2)  
                                    print(f"Point1: {point1}, Point2: {point2}") 
                                    print('cople_count = ',cople_count)
                                    print('not_available_people',not_available_people)
                                    
                                    if(distance<1.4 and  (keys[i]  not in not_available_people and  keys[j] not in not_available_people) ):
                                        print("ss")
                                        not_available_people.append(keys[i])
                                        not_available_people.append(keys[j])
                                        for face_id in object_id_and_his_face_keyes:
                                            if object_id_and_his_face[face_id][0]==keys[i]:
                                                keys_i_id=face_id
                                            if object_id_and_his_face[face_id][0]==keys[j]:
                                                keys_j_id=face_id
                                            
                                        #current_time = time.time()  # Capture the current time  

                                            
                                        #object_id_and_his_face[face_id]=[identities[idx],face_time_spent[face_id]['customer_id']]

                                        #saved_cople[cople_id]={keys_i_id:face_time_spent[keys[i]]['start_time'],keys_j_id:face_time_spent[keys[j]]['start_time']}
                                        saved_cople[cople_id]=[keys_i_id,keys_j_id,current_time]
                                        print('saved_cople',saved_cople.keys())
                                        
                                        cople_id+=1
                                        cople_count+=1
                                        print('cople_number = ',cople_count)

                                    

                                
#**************************************************************************************************************************************                                
                                
                            
                                  
                    
     
                                
                                

                # Print time (inference + NMS)  
                print(f'{s}Done. ({(1E3 * (t2 - t1)):.1f}ms) Inference, ({(1E3 * (t3 - t2)):.1f}ms) NMS')  
        

#***********************************************************************************************************************                
                                    
                    
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
