





 

import argparse
import time
from pathlib import Path
import cv2 # type: ignore
import torch # type: ignore
import torch.backends.cudnn as cudnn # type: ignore
from numpy import random # type: ignore

from models.experimental import attempt_load
from utils.datasets import LoadStreams, LoadImages
from utils.general import check_img_size, check_requirements, \
                check_imshow, non_max_suppression, apply_classifier, \
                scale_coords, xyxy2xywh, strip_optimizer, set_logging, \
                increment_path
from utils.plots import plot_one_box
from utils.torch_utils import select_device, load_classifier, time_synchronized, TracedModel
from PIL import Image  
import dlib # type: ignore
from sort import *

# to get employee (service cutomer ) from database
import requests  
import json  
from bs4 import BeautifulSoup  


# Initialize face detector and other necessary models  
face_detector = dlib.get_frontal_face_detector()  # Initialize face detector  
shape_predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")  # Load shape predictor  
face_encoder = dlib.face_recognition_model_v1("dlib_face_recognition_resnet_model_v1.dat")  # Load face recognition model  


from sort import *
 
# import dlib # type: ignore


"""Function to Draw Bounding boxes"""

def scale_coords(img1_shape, coords, img0_shape):  
##########################################################
# for cpu

    # # Function to scale coordinates  
    # gain = np.array([img0_shape[1] / img1_shape[1], img0_shape[0] / img1_shape[0]] * 2)  
    # coords = (coords * gain).round()  
    # return coords  
##########################################################


##########################################################
#use GPU
     # Function to scale coordinates  
    # Convert shapes to torch tensors and ensure they are on the correct device  
    gain = torch.tensor([img0_shape[1] / img1_shape[1], img0_shape[0] / img1_shape[0]], device=coords.device)  # Gain tensor on the same device as coords  
    gain = gain.repeat(2)  # Repeat gain to match number of coordinates (x1, y1, x2, y2)     
    # Scale and round coords  
    coords = (coords * gain).round()  
    return coords  




def draw_boxes(img, bbox, identities=None, categories=None, confidences=None, colors=None, time_spent=None, opt=None, names=None,object_name=None,not_avalable_ident_for_face_id=None):  

    DEFAULT_ID = "not available"      
    temporary_ids = {}  # Initialize temporary IDs dictionary  
    centers = {}  # List to store centers  
    object_name=object_name

    #if object_name is not None :
        #if len (object_name) >0 :
            #print("keys of object_name ",object_name.keys())
    #print("identities:",identities)
    #for i in identities:
        #print("identities  :",i)
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
            

        color = colors[cat] if colors is not None and cat < len(colors) else (0, 0, 255)  # Default color if colors are not provided or cat is out of bounds  
       
        
        if not opt.nobbox:   
            cv2.rectangle(img, (x1, y1), (x2, y2), color, tl)  
        
        # Calculate area of the bounding box  
        area = (x2 - x1) * (y2 - y1)   
        pixel_to_meter_ratio = 10 / 10000
        area_meters = area * (pixel_to_meter_ratio ** 2)  

        # Draw space above the bounding box for area display  
        label_height = 30  # Height of the space above the bounding box  
        #cv2.rectangle(img, (x1, y1 - label_height), (x2, y1), color, -1)  # Filled rectangle above the box  
        
        # Display area above the bounding box  
        area_text = f'Area: {area_meters:.2f} m²'  
        tf = max(tl - 1, 1)  # font thickness  
        #cv2.putText(img, area_text, (x1, y1 - 2 - label_height), 0, tl / 3, [0, 0, 255], thickness=tf, lineType=cv2.LINE_AA)  
        #print("id : ",id)
        # Draw the time spent above the bounding box  
        if time_spent is not None and id in time_spent and id in not_avalable_ident_for_face_id:  
            time_text = f'Time: {time_spent[id]["duration"]:.2f} s'  
            #cv2.putText(img, time_text, (x1, y1 - 22), 0, tl / 3, [0, 0, 255], thickness=1    , lineType=cv2.LINE_AA)  
        if(object_name is not None and len(object_name)>0):
            object_name_keys=[list(object_name.keys())]
            ##for  object_name
            #if identities is not None and  len(identities) >0:
                #if object_name is not None and len(object_name)>0 and id in object_name_keys  :  
                    #object_name = f'object_name: {object_name[id]}'  
                    # cv2.putText(img, object_name, (x1+20, y1 - 52), 0, tl / 3, [0, 0, 255], thickness=tf, lineType=cv2.LINE_AA)  
                    
        if identities is not None and  len(identities) >0 and  id in not_avalable_ident_for_face_id and object_name is not None:
            #if object_name is not None and len(object_name)>0 and id in object_name_keys  :  
            # Assuming object_name is a dictionary and id is a valid integer key  
            obj_name = object_name.get(id, "Unknown")  # Default to "Unknown" if id is not found  
            
            # Optional: Ensure obj_name is a string  
            obj_name = str(obj_name)  # Convert to string if necessary  
            
            # Now you can use obj_name in putText                  
            cv2.putText(img, obj_name, (x1+20, y1 + 52), 0, tl / 3, [255, 255, 0], thickness=tf, lineType=cv2.LINE_AA)  
                                           
        if not opt.nolabel:  
            label = f'ID: {id} {names[cat]}' if identities is not None else names[cat]  
            tf = max(tl - 1, 1)  # font thickness  
            t_size = cv2.getTextSize(label, 0, fontScale=tl / 3, thickness=tf)[0]  
            c2 = x1 + t_size[0], y1 - t_size[1] - 3  
            cv2.rectangle(img, (x1, y1), c2, color, -1, cv2.LINE_AA)  # filled  
            cv2.putText(img, label, (x1, y1 - 2), 0, tl / 3, [0, 0, 255], thickness=tf, lineType=cv2.LINE_AA)  
        
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



def calculate_histogram(image):  
    # Convert the image to HSV color space (or another preferred color space)  
    #hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)  

    # Calculate the histogram  
    # Using 256 bins for each channel (Hue, Saturation, Value)  
    hist = cv2.calcHist([image], [0, 1, 2], None, [256, 256, 256], [0, 256, 0, 256, 0, 256])  

    # Normalize the histogram to sum to 1  
    hist = cv2.normalize(hist, hist).flatten()  

    return hist



def calculate_histogram_gray_img(image):  
    # If the image is in grayscale, no conversion is needed.  
    # Calculate the histogram for the single channel (grayscale)  
    hist = cv2.calcHist([image], [0], None, [256], [0, 256])  

    # Normalize the histogram to sum to 1  
    hist = cv2.normalize(hist, hist).flatten()  

    return hist


# Define the cosine similarity function  
def cosine_similarity(hist1, hist2):  
    # Calculate the dot product  
    #hist1 = hist1.flatten()  
    #hist2 = hist2.flatten()  
    
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
    #distance = 1 - similarity  
    distance = similarity  

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


# to load employees images  and save them in this list "images"

def read_images_from_folders(base_folder):  
    images = []  # List to store images and their names  
    for folder_name in os.listdir(base_folder):  
        folder_path = os.path.join(base_folder, folder_name)  
        if os.path.isdir(folder_path):  
            for file_name in os.listdir(folder_path):  
                file_path = os.path.join(folder_path, file_name)  
                if file_name.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp')):  
                    try:  
                        img = Image.open(file_path)  
                        images.append((folder_name, file_name, img, file_path))  # Append folder name, file name, image, and path  
                        print(f"Loaded image: {file_path}")  
                    except Exception as e:  
                        print(f"Could not load image {file_path}: {e}")  
    return images  


# to load employees images from "images" and save them in this dictinary "face_descriptors"
def detect_faces_and_save_descriptors(images, face_descriptors):  
    for folder_name, file_name, img, file_path in images:  
        # Load the image using OpenCV for face detection  
        image_cv = cv2.imread(file_path)  
        
        # Detect faces  
        faces = face_detector(image_cv)  

        # Initialize a list for descriptors for this folder if not already present  
        if folder_name not in face_descriptors:  
            face_descriptors[folder_name] = []  # Create a list to store descriptors for this folder  

        for face in faces:  
            # Draw a rectangle around the detected face  
            x1, y1, x2, y2 = (face.left(), face.top(), face.right(), face.bottom())  
            cv2.rectangle(image_cv, (x1, y1), (x2, y2), (0, 255, 0), 2)  # Draw rectangle in green  

            # Get the landmarks and compute the face descriptor  
            shape = shape_predictor(image_cv, face)  
            face_descriptor = face_encoder.compute_face_descriptor(image_cv, shape)  
            face_descriptor_np = np.array(face_descriptor)  

            # Append the face descriptor to the corresponding folder list  
            face_descriptors[folder_name].append(face_descriptor_np)  
            print(f"Saved descriptor for {folder_name} from {file_name}")  

    return face_descriptors






def retrieve_employees():  
    """Retrieve employee data from the API."""  
    base_url = 'http://127.0.0.1:8000/api/admin/employees/get_all_employees'  
    
    try:  
        # Perform a GET request to fetch employee data  
        retrieve_response = requests.get(base_url)  
        retrieve_response.raise_for_status()  # Ensure the request was successful  
        
        # Clean and parse the JSON response  
        retrieve_clean_response = BeautifulSoup(retrieve_response.text, "html.parser").get_text()  
        retrieve_response_data = json.loads(retrieve_clean_response)  

        print("Data retrieved successfully!")  

        # Filter for customer service employees and only keep specific fields  
        customer_service_employees = [  
            {  
                'id': employee['id'],  
                'name': employee['name'],  
                'active': employee['active'],  
            }  
            for employee in retrieve_response_data  
            if employee.get("position") == "customer_service"  
        ]  

        print("Customer Service Employees:", customer_service_employees)  
        return customer_service_employees  

    except requests.exceptions.HTTPError as http_err:  
        print(f"HTTP error occurred: {http_err}")  
    except requests.exceptions.RequestException as req_err:  
        print(f"Error occurred: {req_err}")  
        if retrieve_response is not None:  
            print(retrieve_response.text)  # Print the raw response for debugging  



# connect between images and there eservice_customer
def connect_images_to_employees(base_folder):  
    images = read_images_from_folders(base_folder)  
    employees = retrieve_employees()  

    # Create a mapping of employee ID to employee's information  
    employee_mapping = {str(employee['id']): employee for employee in employees}  # Ensure ID is a string  
    print("employee_mapping")  
    print(employee_mapping)  
    
    # Dictionary to keep track of employee info mapped to folder names  
    connected_employees = {}  

    # Match images to employee data  
    for folder_name, file_name, img, file_path in images:  
        # Split folder name to get employee ID  
        parts = folder_name.split('_')  
        if len(parts) > 0:  
            emp_id = parts[0]  # Take the first part as the employee ID  
            # Check if the ID exists in our employee mapping  
            if emp_id in employee_mapping:  
                employee_info = employee_mapping[emp_id]  
                
                # Use full folder name as the key  
                folder_key = folder_name  # or you can define it more explicitly  
                
                # Store employee info using folder name as key  
                connected_employees[folder_key] = {  
                    'id': employee_info['id'],  
                    'name': employee_info['name'],  
                    'active': employee_info['active'],  
                }  
                print(f"Connected Folder: {folder_key} with Employee: {employee_info['name']} (ID: {emp_id})")  
            else:  
                print(f"Employee ID {emp_id} not found in employee data.")  

    # Return the dictionary with folder names as keys and employee info  
    return connected_employees  




# to update customer service stats (active or not active , false or true)
def update_customer_service_status(employees,id,active):
    """Update the active status for customer service employees."""
    customer_service_employees = [
        employee for employee in employees 
        if employee.get("position") == "customer_service"
    ]

    print("Customer Service Employees:", customer_service_employees)

    # for employee in customer_service_employees:
    update_data = {
            'id': id,
            'active': active
         }
        
        # Send PUT request to update employee status
    update_response = requests.put(update_url, json=update_data)
        
        # Check if update was successful
    if update_response.status_code == 200:
            print(f"Successfully updated employee {id}")
    else:
            print(f"Failed to update employee {id}")
            print("Response:", update_response.text)



# send point to database 
def set_points_to_employee(points_count,description,employee_id,customer_id):  
    url = 'http://127.0.0.1:8000/api/admin/points/set_new_points'  
    data = {  
        'points_count': points_count,  
        'description': description,
        'employee_id': employee_id,
        'customer_id':customer_id,
    }  

    try:  
        response = requests.post(url, json=data)  
        print(f"Response Code: {response.status_code}")  

        # Print raw response body for debugging purposes  
        print("Response Body:", response.text)  # Show the raw content of the response  
        
        # Strip leading whitespace and any unwanted characters  
        response_text = response.text.strip()  

        # Remove any leading HTML comments; this can be done by splitting  
        # the response by new lines and finding the first meaningful JSON.  
        if response_text.startswith("<!--"):  
            # Split into lines and find the first JSON line  
            response_lines = response_text.splitlines()  
            response_json_text = ""  
            # Look for the line that starts like a JSON object  
            for line in response_lines:  
                # Strip whitespace  
                line = line.strip()  
                if line.startswith("{"):  # Found the JSON line  
                    response_json_text = line  
                    break  
            else:  # In case the valid JSON line isn't found  
                print("No valid JSON found in response.")  
                return False  
        else:  
            response_json_text = response_text  # Treat it as valid JSON if it does not start with <!--  

        # Now, try to parse the cleaned JSON text  
        try:  
            response_data = json.loads(response_json_text)  # Using json.loads on the cleaned response  
            print("Success:", response_data)  
            return True  
        except json.JSONDecodeError as json_err:  
            print(f"JSON decode error: {json_err}")  

    except requests.exceptions.RequestException as e:  
        print(f"An error occurred: {e}")  





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


    #########################################################
    ##########################################################
    # Load the second model (new code)
    # Flags to track if objects have been detected
    fitting_room_detected = False
    cashier_detected = False

    # Variables to store bounding box dimensions and centers
    fitting_room_boxes = []  # List to store all fitting room bounding boxes
    cashier_boxes = []  # List to store all cashier bounding boxes


    weights2 = 'runs/best.pt'  # Path to the second model's weights
    model2 = attempt_load(weights2, map_location=device)  # Load the second model
    stride2 = int(model2.stride.max())  # Model stride for the second model
    imgsz2 = check_img_size(imgsz, s=stride2)  # Check img_size for the second model
    # Define class names for the second model
    names2 = ['fitting_room', 'cashier']

    ##########################################################
    ##########################################################

    if trace:
        model = TracedModel(model, device, opt.img_size)

    if half:
        model.half()  # to FP16

    ##########################################################
    ##########################################################
    # If tracing is enabled, trace the second model
    if trace:
        model2 = TracedModel(model2, device, opt.img_size)

    # If using half precision, convert the second model to FP16
    if half:
        model2.half()
    ##########################################################
    ##########################################################
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
    
#****************************************************
    face_detector = dlib.get_frontal_face_detector()  
    shape_predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")  
    face_encoder = dlib.face_recognition_model_v1('dlib_face_recognition_resnet_model_v1.dat')  # and this model  
    face_descriptors = {}

        
    base_folder = 'C:/Users/LENOVO/AndroidStudioProjects/faces_images'  

    # to read images from folder
    images = read_images_from_folders(base_folder)  # Read images 
    face_descriptors = detect_faces_and_save_descriptors(images, face_descriptors)  # Detect faces and save descriptors  

    print("9999999999999999999999   ace_descriptors.keys() 9999999999999")

    print(face_descriptors.keys())  

#*****************************************************

#*****************************************************
    # to get employee from database
    employees = retrieve_employees()

    print("9999999999999999999999   employees are : 9999999999999")
    print(employees)
#*****************************************************

#*****************************************************
    # to connect between images and there employees fro customer_service
    connected_employees={}
    connected_employees = connect_images_to_employees(base_folder)
    print("connected_employees")
    print(connected_employees)

#*****************************************************

#*****************************************************





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
    # face_descriptors = {}  
    unique_faces = {}  
    last_seen_times = {}  
    face_id_for_employee=0
    
    
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
    not_avalable_ident_for_face_id=set()
    temp_not_avalable_ident_for_face_id=set()

    
#***********************************************************************************************************

#***********************************************************************************************************
#to save employee id 
    employees_id=set()

#to save customer id 
    customers_id=set()

# connect between employee and his customer
    employee_with_his_customer={}
    number_of_cople=0

    not_available_employee_and_cusomer=set()
    

    
#*****************************************************

#***********************************************************************************************************
#to save object name
    object_name={}

#***********************************************************************************************************

    
    # Initialize an empty array for dets_to_sort to avoid UnboundLocalError  
    dets_to_sort = np.empty((0, 6))  # Initialize this variable here  

#**************************************************
#**************************************************

#for template macthing 

    pass_to_template=False
    pass_to_template2=False

    # #to sav etemplate matching 
    # # for dressing room 
    # centers_Template1=[]
    # # for exit door
    # centers_Template2=[]

    
    #to sav etemplate matching 
    # for dressing room 
    centers_Template1=[]
    # for exit door
    centers_Template2=[]

    template1_dimensions=None
    template2_dimensions=None

    detected_template=False
    detected_template2=False


    # Load template image for matching  
    template_path1 = 'runs/fitting.jpg'

    if not os.path.exists(template_path1):  
        print(f"File not found: {template_path1}")  
    else:  
        template = cv2.imread(template_path1,cv2.IMREAD_COLOR)  
        template_gray = cv2.cvtColor(template, cv2.COLOR_BGR2GRAY)  
        #template_gray = cv2.resize(template_gray, (640, 480))  # Adjust size as needed
        template_height, template_width = template_gray.shape  
        #print("template_height = ",template_height)
        #print("template_width = ",template_width)
        
    
    template_path2 = 'runs/cashier.jpg'      
    if not os.path.exists(template_path2):  
        print(f"File not found: {template_path2}")  
    else:  
        template2 = cv2.imread(template_path2,cv2.IMREAD_COLOR)  
        template_gray2 = cv2.cvtColor(template2, cv2.COLOR_BGR2GRAY)  
        #template_gray = cv2.resize(template_gray, (640, 480))  # Adjust size as needed
        template_height2, template_width2 = template_gray2.shape  
        #print("template_height = ",template_height)
        #print("template_width = ",template_width)

        
        
        
 

#****************************************************************************************************


#*********************************************************************************
# to save object histogram
    object_histograms = {}
    object_counter = 0  # Counter for unique histogram keys  


#*****************************************************************************

#**************************************************************************
# Initialize the SURF detector  
    ##surf = cv2.xfeatures2d.SURF_create(hessianThreshold=1000)  # Hessian threshold can be adjusted   ORB_create()
    #surf=cv2.xfeatures2d.SURF_create(hessianThreshold=1000) 
    surf=cv2.ORB_create(nfeatures=1500, scaleFactor=1.2, nlevels=8) 

    
    # Initializes a dictionary to store SURF descriptors by unique ID  
    object_surf_descriptors = {}  
    surf_next_id = 0  # Unique ID for new objects  
    link_obj_id_with_template={}
    avalabel_identifier=set()




#*********************************************************************





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
            if dataset.mode == 'video' and frame_counter % 5 != 0:  
                continue  # Skip to the next iteration for video  


                
            img = torch.from_numpy(img).to(device)
            img = img.half() if half else img.float()  # uint8 to fp16/32
            img /= 255.0  # 0 - 255 to 0.0 - 1.0
            if img.ndimension() == 3:
                img = img.unsqueeze(0)

            #im0s = cv2.medianBlur(im0s, 5)  # Apply Gaussian filter (5x5 kernel)  
            #im0s = cv2.boxFilter(im0s, -1, (5, 5))  
            #im0s = cv2.fastNlMeansDenoisingColored(im0s, None, 10, 10, 7, 21)  



    
            # Warmup
            if device.type != 'cpu' and (old_img_b != img.shape[0] or old_img_h != img.shape[2] or old_img_w != img.shape[3]):
                old_img_b = img.shape[0]
                old_img_h = img.shape[2]
                old_img_w = img.shape[3]
                for i in range(3):
                    model(img, augment=opt.augment)[0]
                    model2(img, augment=opt.augment)[0]  # Warmup for the second model
    
            # Inference
            t1 = time_synchronized()
            pred = model(img, augment=opt.augment)[0]
            t2 = time_synchronized()

            #############################################################
            ############################################################
            # Inference with the second model (for fitting room and cashier)
            if not (fitting_room_detected and cashier_detected):  # Only detect if objects are not already detected
                pred2 = model2(img, augment=opt.augment)[0]
                pred2 = non_max_suppression(pred2, opt.conf_thres, opt.iou_thres, classes=opt.classes, agnostic=opt.agnostic_nms)

                    # Process detections from the second model
                for det in pred2:
                    if len(det):
                        # Rescale boxes from img_size to im0 size
                        det[:, :4] = scale_coords(img.shape[2:], det[:, :4], im0.shape).round()

                        # Convert detection to numpy if needed
                        if isinstance(det, torch.Tensor):
                            det_np = det.cpu().numpy()
                        else:
                            det_np = det

                        # Extract categories and bounding boxes
                        for *xyxy, conf, cls in det_np:
                            label = names2[int(cls)]  # Use the second model's class names
                            if label == 'fitting_room' and not fitting_room_detected:
                                # Save fitting room bounding box and center
                                x1, y1, x2, y2 = xyxy
                                center_x = (x1 + x2) / 2
                                center_y = (y1 + y2) / 2
                                fitting_room_boxes.append((x1, y1, x2, y2, center_x, center_y))
                                fitting_room_detected = True  # Stop further detection for fitting room

                            elif label == 'cashier' and not cashier_detected:
                                # Save cashier bounding box and center
                                x1, y1, x2, y2 = xyxy
                                center_x = (x1 + x2) / 2
                                center_y = (y1 + y2) / 2
                                cashier_boxes.append((x1, y1, x2, y2, center_x, center_y))
                                cashier_detected = True  # Stop further detection for cashier

            # Skip detection if objects are already detected
            if fitting_room_detected and cashier_detected:
               continue  # Skip to the next frame



            ###############################################################
            ##############################################################
    
            # Apply NMS
            pred = non_max_suppression(pred, opt.conf_thres, opt.iou_thres, classes=opt.classes, agnostic=opt.agnostic_nms)
            t3 = time_synchronized()
    
            # Apply Classifier
            if classify:
                pred = apply_classifier(pred, modelc, img, im0s)
                
            
            print("8888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888")
#**************************************************************************************
#to pass for tempalte one time in each image note for each object etected 
            # pass_to_template=False
            # pass_to_template2=False

            
            
            # #to redetect tempalte from each tempalte 
            # centers_Template1=[]
            # centers_Template2=[]

            
#**************************************************************************************

            #######################################################
            #######################################################
            # Draw bounding boxes and centers for fitting rooms
            for box in fitting_room_boxes:
                x1, y1, x2, y2, center_x, center_y = box
                cv2.rectangle(im0, (int(x1), int(y1)), (int(x2), int(y2)), (255, 255, 255), 2)  # Draw bounding box
                cv2.circle(im0, (int(center_x), int(center_y)), 5, (0, 255, 0), -1)  # Draw center

            # Draw bounding boxes and centers for cashiers
            for box in cashier_boxes:
                x1, y1, x2, y2, center_x, center_y = box
                cv2.rectangle(im0, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 255), 2)  # Draw bounding box
                cv2.circle(im0, (int(center_x), int(center_y)), 5, (0, 0, 255), -1)  # Draw center

            #######################################################
            #######################################################


            ########
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
#to check number of faces for if there faces  assign to employee
                face_detected_check=None  
#**********************************************************************************************************
                
                if len(det):  
                    print(type(det))  # Check the type of `det`  

                    ####################################################################
                    # # for cpu
                    # # Rescale boxes from img_size to im0 size  
                    # det[:, :4] = scale_coords(img.shape[2:], det[:, :4], im0.shape).round()
    
                    # # If det is a Tensor, convert it to numpy  
                    # if isinstance(det, torch.Tensor):  
                    #     det_np = det.cpu().numpy()  # Convert to numpy if it's a tensor on GPU  
                    # else:  
                    #     det_np = det  # It's already a NumPy array  

                    ####################################################################


                    ####################################################################
                    # use GPu
                    # Rescale boxes from img_size to im0 size  
                    det[:, :4] = scale_coords(img.shape[2:], det[:, :4], im0.shape).round()  # Ensure shapes are correct  

                    # Convert detection to numpy if needed, handled below  
                    if isinstance(det, torch.Tensor):  
                        det_np = det.cpu().numpy()  # Convert to numpy if it's on GPU  
                    else:  
                        det_np = det  # No conversion is needed  
                    ####################################################################


                  

                  
                    # Now you can safely access indices  
                    categories = det_np[:, 4].astype(int)  # Assuming the 5th column is for categories  

                    # Draw bounding boxes and labels
                    for *xyxy, conf, cls in det_np:
                        label = f'{names[int(cls)]} {conf:.2f}'
                        plot_one_box(xyxy, im0, label=label, color=colors[int(cls)], line_thickness=2)

# #***********************************************************************************************************
# #surf algorithm 
                
#********************************************

                    
#************************************************************************************************************************************
#                   if opt.track:  
                    tracked_dets = sort_tracker.update(dets_to_sort, opt.unique_track_color)  
                
                    if tracked_dets is not None and len(tracked_dets) > 0:  
                        bbox_xyxy = tracked_dets[:, :4]  
                        identities = tracked_dets[:, 8]  
                        #print("identities is ",identities)

                
#************************************************************************************************************************************
                    #######
                        for idx, identity in enumerate(identities):  
#************************************************************************************
#to remove not avalable identity from not_avalable_ident_for_face_id  set
                                for i in not_avalable_ident_for_face_id.copy():
                                    if i not in identities:
                                        del object_name[i]  
                                        not_avalable_ident_for_face_id.remove(i)
                                #temp_not_avalable_ident_for_face_id=not_avalable_ident_for_face_id

#**********************************************************************************
#for surf or hisogram
                             
                               

# #***************************************************************************************
# # Extract object bounding box and calc histogram 

# #*******************************************************************************************

#************************************************************************************************************************************
                        #########
                        #template matching
                        if pass_to_template==False:

                            # Load the template image and resize it to 200x200 pixels  
                            template = cv2.imread('runs/fitting.jpg')  # Replace with your template image filename  
                            resized_template = cv2.resize(template, (200, 200))  # Resize to 200x200 pixels  

                            # # Load the target image  
                            # target = cv2.imread(im0,1)  # Replace with your target image filename  

                            # Initialize SIFT detector  
                            sift = cv2.SIFT_create()  

                            # Convert the images to grayscale for SIFT processing  
                            template_gray = cv2.cvtColor(resized_template, cv2.COLOR_BGR2GRAY)  

                            # Detect keypoints and compute descriptors  
                            keypoints_template, descriptors_template = sift.detectAndCompute(template_gray, None)  
                            keypoints_target, descriptors_target = sift.detectAndCompute(im0, None)  

                            # Create the matcher  
                            index_params = dict(algorithm=1, trees=5)  
                            search_params = dict(checks=50)  
                            flann = cv2.FlannBasedMatcher(index_params, search_params)  

                            # Match descriptors  
                            matches = flann.knnMatch(descriptors_template, descriptors_target, k=2)  

                            # Filter good matches using Lowe's ratio test  
                            good_matches = []  
                            for m, n in matches:  
                                if m.distance < 0.7 * n.distance:  
                                    good_matches.append(m)

                            

                            # Find homography and draw bounding box if there are enough good matches  
                            if len(good_matches) >= 4:  
                                # Extract location of good matches  
                                template_pts = np.zeros((len(good_matches), 2), dtype=np.float32)  
                                target_pts = np.zeros((len(good_matches), 2), dtype=np.float32)  

                                for i, match in enumerate(good_matches):  
                                    template_pts[i, :] = keypoints_template[match.queryIdx].pt  
                                    target_pts[i, :] = keypoints_target[match.trainIdx].pt  

                                # Find homography  
                                H, mask = cv2.findHomography(template_pts, target_pts, cv2.RANSAC)  

                                # Use homography to draw bounding box  
                                h, w = resized_template.shape[:2]  # Get height and width of the resized template  
                                template_corners = np.array([[0, 0], [0, h - 1], [w - 1, h - 1], [w - 1, 0]], dtype=np.float32)  
                                
                                # Reshape to (-1, 1, 2)  
                                template_corners = template_corners.reshape(-1, 1, 2)  

                                # Transform corners  
                                target_corners = cv2.perspectiveTransform(template_corners, H)  

                                # Draw bounding box on the target image in green  
                                # target_with_box = im0.copy()  
                                cv2.polylines(im0, [np.int32(target_corners)], isClosed=True, color=(0, 255, 0), thickness=3)  

                                # Calculate the center of the matched rectangle  
                                center_x = int((target_corners[0][0][0] + target_corners[2][0][0]) / 2)  
                                center_y = int((target_corners[0][0][1] + target_corners[2][0][1]) / 2)  
                                centers_Template1.append((center_x, center_y))    
                                template1_dimensions = (w, h)  # Save width and height
                                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                                pass_to_template=True 
                                detected_template = True 

                                # pass_to_template=True 

                        # Draw bounding box for the first template if it has been detected  
                        if detected_template  and template1_dimensions is not None:  
                            # Use the saved dimensions and center to draw the bounding box  
                            h, w = template1_dimensions  
                            # Assuming you have the last detected center  
                            if centers_Template1:  
                                center_x, center_y = centers_Template1[-1]  
                                top_left = (int(center_x - w // 2), int(center_y - h // 2))  
                                bottom_right = (int(center_x + w // 2), int(center_y + h // 2))  
                                cv2.rectangle(im0, top_left, bottom_right, (0, 255, 0), 3)  

                                
                                                                
                                    
                                    
                        #######
                        # #template matching
                        #template matching
                        if pass_to_template2==False:

                            # Load the template image and resize it to 200x200 pixels  
                            template = cv2.imread('runs/cashier.jpg')  # Replace with your template image filename  
                            resized_template = cv2.resize(template, (200, 200))  # Resize to 200x200 pixels  

                            # # Load the target image  
                            # target = cv2.imread(im0,1)  # Replace with your target image filename  

                            # Initialize SIFT detector  
                            sift = cv2.SIFT_create()  

                            # Convert the images to grayscale for SIFT processing  
                            template_gray = cv2.cvtColor(resized_template, cv2.COLOR_BGR2GRAY)  

                            # Detect keypoints and compute descriptors  
                            keypoints_template, descriptors_template = sift.detectAndCompute(template_gray, None)  
                            keypoints_target, descriptors_target = sift.detectAndCompute(im0, None)  

                            # Create the matcher  
                            index_params = dict(algorithm=1, trees=5)  
                            search_params = dict(checks=50)  
                            flann = cv2.FlannBasedMatcher(index_params, search_params)  

                            # Match descriptors  
                            matches = flann.knnMatch(descriptors_template, descriptors_target, k=2)  

                            # Filter good matches using Lowe's ratio test  
                            good_matches = []  
                            for m, n in matches:  
                                if m.distance < 0.7 * n.distance:  
                                    good_matches.append(m)

                            

                            # Find homography and draw bounding box if there are enough good matches  
                            if len(good_matches) >= 4:  
                                # Extract location of good matches  
                                template_pts = np.zeros((len(good_matches), 2), dtype=np.float32)  
                                target_pts = np.zeros((len(good_matches), 2), dtype=np.float32)  

                                for i, match in enumerate(good_matches):  
                                    template_pts[i, :] = keypoints_template[match.queryIdx].pt  
                                    target_pts[i, :] = keypoints_target[match.trainIdx].pt  

                                # Find homography  
                                H, mask = cv2.findHomography(template_pts, target_pts, cv2.RANSAC)  

                                # Use homography to draw bounding box  
                                h, w = resized_template.shape[:2]  # Get height and width of the resized template  
                                template_corners = np.array([[0, 0], [0, h - 1], [w - 1, h - 1], [w - 1, 0]], dtype=np.float32)  
                                
                                # Reshape to (-1, 1, 2)  
                                template_corners = template_corners.reshape(-1, 1, 2)  

                                # Transform corners  
                                target_corners = cv2.perspectiveTransform(template_corners, H)  

                                # Draw bounding box on the target image in green  
                                # target_with_box = im0.copy()  
                                cv2.polylines(im0, [np.int32(target_corners)], isClosed=True, color=(0, 255, 0), thickness=3) 

                                # Calculate the center of the matched rectangle  
                                center_x = int((target_corners[0][0][0] + target_corners[2][0][0]) / 2)  
                                center_y = int((target_corners[0][0][1] + target_corners[2][0][1]) / 2)  
                                centers_Template2.append((center_x, center_y))  
                                template2_dimensions = (w, h)  # Save width and height
                                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")

                                pass_to_template2=True 
                                detected_template2=True

                                # pass_to_template=True 

                        # Draw bounding box for the second template if it has been detected  
                        if detected_template2 and template2_dimensions is not None:  
                            # Use the saved dimensions and center to draw the bounding box  
                            h, w = template2_dimensions  
                            if centers_Template2:  
                                center_x, center_y = centers_Template2[-1]  
                                top_left = (int(center_x - w // 2), int(center_y - h // 2))  
                                bottom_right = (int(center_x + w // 2), int(center_y + h // 2))  
                                cv2.rectangle(im0, top_left, bottom_right, (0, 255, 0), 3)  


                        print("11111111111111111111111111111111")
                        print(pass_to_template)
                        print(pass_to_template2)
                        print(centers_Template1)
                        print(centers_Template2)
                        print("222222222222222222222222222222222222222222222222")
                                     

                                
                                                

#**********************************************************************
                       
                        
                        
                
#************************************************************************************************************************************

                    #bbox_xyxy = det_np[:, :4]  # Get bounding box coordinates  
                    #identities = det_np[:, 5]  # Get identities if it's located here  
                    
                    # faces = face_detector(im0,1)  # Detect faces  


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
                            #print("identities is ",identities)

                            # Initialize time tracking for existing identities   
                            for identity in identities:  
                                if identity not in time_spent:  
                                    time_spent[identity] = {'start_time': current_time, 'duration': 0}  
                                else:  
                                    time_spent[identity]['duration'] += current_time - time_spent[identity]['start_time']  
                                    time_spent[identity]['start_time'] = current_time  # Reset start time for the next frame  
                                    
#***********************************************************************************************************


#******************************************************************************************************************
                            #tosave name of object detection
                            #object_name={}
                            # Face detection logic  
                            print("/////////  **********          face_descriptors is *********** //////////// :")
                            # print(face_descriptors)
                            faces = face_detector(im0,1)  # Detect faces  
                            face_detected_check=faces

                            for i in face_time_spent.keys():
                                if isinstance(i, int):  
                                    if face_time_spent[i]['state']==0:
                                        if face_time_spent[i]['duration']>1:
                                            face_time_spent[i]['state']=1
                                            # face_time_spent[i] = {'start_time': current_time, 'duration': 0, 'active': True,'customer_id':f'customer_id:{face_id}','state':0}  
                                        else:
                                            print("duration is small than 1")
                                            print("duration = ",face_time_spent[i]['duration'])
                                            print("isinstance = ",face_time_spent[i]['state'])


                                else:  
                                    print("key is string")  
                                    print("key = ",i)  

                        
                            for face in faces:  
                                x, y, w, h = (face.left(), face.top(), face.right() - face.left(), face.bottom() - face.top())  
                                
                                # Extract the shape of the face to compute the descriptor  
                                shape = shape_predictor(im0, face)  
                                face_descriptor = face_encoder.compute_face_descriptor(im0, shape)  
                                face_descriptor_np = np.array(face_descriptor)                                  
                                face_id = None  # Initialize as None  
                
#**************************************************************************************         
#ecludina distance way                               
                                ## Initialize variables to track the best match  
                                best_distance = float('inf')  # Start with a very large number  
                                best_face_id = None  # Initialize best face ID  
                                ##print(face_descriptors)



#                                 ## Find the closest face descriptor already stored  
#                                 found = False  
#                                 for stored_face_id, stored_descriptor in face_descriptors.items():  
#                                     distance = np.linalg.norm(face_descriptor_np - stored_descriptor)  
#                                     #print("================distance :" ,distance)
                                    
#                                     ## Update the best match if the distance is smaller than the current best  
#                                     if distance < best_distance:  
#                                         best_distance = distance  
#                                         best_face_id = stored_face_id  
                                        
                                        
#                                      ## After checking all stored descriptors, decide what to do  
#                                     ##if best_distance < 0.6:  # If the closest match is within the threshold  
#                                         ##face_id = best_face_id  
#                                         ##unique_faces[face_id] = current_time  # Update last seen time  
#                                         ##found = True  
# #********************************************************************************************************************



  
#                                 # Optional: Print the best match found  
#                                 #if best_face_id is not None:  
#                                     #print(f"Best match found: {best_face_id} with cosine similarity: {best_distance}")  
#                                 #else:  
#                                     #print("No match found.")  
#                                                                 #ss
#                                 # After checking all stored descriptors, decide what to do  
#                                 if best_distance <0.65:  # If the closest match is within the threshold  
#                                     face_id = best_face_id  
#                                     unique_faces[face_id] = current_time  # Update last seen time  
#                                     found = True  
#                                 else:  
#                                     # If no match is found, assign a new ID  
#                                     face_id = face_next_id  
#                                     face_descriptors[face_id] = face_descriptor_np  # Store the descriptor    
#                                     unique_faces[face_id] = current_time  # Record appearance time  
#                                     last_seen_times[face_id] = [current_time, 0]  # Last seen and time spent  
#                                     # face_time_spent[face_id] = {'start_time': current_time, 'duration': 0, 'active': True,'customer_id':f'customer_id:{face_id}','state':0,'counter':0}  
#                                     # face_next_id += 1  


                                #####################

                                ####
                                ## Find the closest face descriptor already stored  
                                found = False  
                                for stored_face_id, stored_descriptors in face_descriptors.items():  
                                    # Ensure stored_descriptors is a list, even if it contains a single descriptor  
                                    if not isinstance(stored_descriptors, list):  
                                        stored_descriptors = [stored_descriptors]  
                                    
                                    for stored_descriptor in stored_descriptors:  
                                        distance = np.linalg.norm(face_descriptor_np - stored_descriptor)  
                                        #print("================distance :" ,distance)  
                                        
                                        ## Update the best match if the distance is smaller than the current best  
                                        if distance < best_distance:  
                                            best_distance = distance  
                                            best_face_id = stored_face_id  

                                # After checking all stored descriptors, decide what to do  
                                if best_distance < 0.65:  # If the closest match is within the threshold  
                                    face_id = best_face_id  
                                    unique_faces[face_id] = current_time  # Update last seen time  
                                    found = True  
                                else:  
                                    # If no match is found, assign a new ID  
                                    face_id = face_next_id  
                                    face_descriptors[face_id] = face_descriptor_np  # Store the descriptor    
                                    unique_faces[face_id] = current_time  # Record appearance time  
                                    last_seen_times[face_id] = [current_time, 0]  # Last seen and time spent  
                                    
                                    # Store the descriptor as a list if it doesn't already exist  
                                    # # if face_id in face_descriptors:  
                                    # #     if isinstance(face_descriptors[face_id], list):  
                                    # #         face_descriptors[face_id].append(face_descriptor_np)  # Append to existing list  
                                    # #     else:  
                                    # #         face_descriptors[face_id] = [face_descriptors[face_id], face_descriptor_np]  # Convert to list  
                                    # # else:  
                                    # #     face_descriptors[face_id] = face_descriptor_np  # Store the descriptor    
                                        
                                    # # unique_faces[face_id] = current_time  # Record appearance time  
                                    # # last_seen_times[face_id] = [current_time, 0]  # Last seen and time spent
                                    # # face_time_spent[face_id] = {'start_time': current_time, 'duration': 0, 'active': True,'customer_id':f'customer_id:{face_id}','state':0,'counter':0}  
                                    # # face_next_id += 1

                                                            











                                # Start or resume the timer for the matched face  
                                if face_id not in face_time_spent:  
                                    face_time_spent[face_id] = {'start_time': current_time, 'duration': 0, 'active': True,'customer_id':f'customer_id:{face_id}','state':0,'counter':0,'points':0}  
                                    face_next_id += 1  

                                else:  
                                    face_time_spent[face_id]['duration'] += current_time - face_time_spent[face_id]['start_time']  
                                    face_time_spent[face_id]['start_time'] = current_time  
                            
                                # Display the timer for the detected face  
                                duration = face_time_spent[face_id]['duration'] + (current_time - face_time_spent[face_id]['start_time'])  
                                customer_id=face_time_spent[face_id]['customer_id']
                                cv2.putText(im0, f'Time: {duration:.2f}s', (x+60, y - 60), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 0, 0), 2)  
                                cv2.putText(im0, f'face_id: {face_id}', (x+60, y - 75), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)   
                                #cv2.putText(im0, f'customer_id: {customer_id}', (x, y - 50), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 2)  
                                face_id_current=face_time_spent[face_id]['customer_id']
                                # cv2.putText(im0, f'{face_id_current}', (x+60, y - 90), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)          


                                #print('len of not_avalable_ident_for_face_id ',len(not_avalable_ident_for_face_id))
                                #print("===============item of not_avalable_ident_for_face_id==============",not_avalable_ident_for_face_id)
                                #print('len of object_name',len(object_name))
                                #print("=====================item of object_name==================",object_name)

                                # Check if detected face overlaps with any tracked identity  
                                if len(identities)>= len(faces):                                            
                                    for idx, identity in enumerate(identities):  
                                            #for i in not_avalable_ident_for_face_id.copy():                                                
                                                    #if i not in identities:
                                                        #del object_name[i]  
                                                        #not_avalable_ident_for_face_id.remove(i)
                                            ##temp_not_avalable_ident_for_face_id=not_avalable_ident_for_face_id
                                             
                                        #if identity  not in not_avalable_ident_for_face_id:
                                            bbox = bbox_xyxy[idx]  
                                            if (x >= bbox[0] and x + w <= bbox[2]) and (y >= bbox[1] and y + h <= bbox[3]):  
                                                #identities[idx] = face_id  
                                                object_id_and_his_face[face_id]=[identity,face_time_spent[face_id]['customer_id'],face_id]
                                                not_avalable_ident_for_face_id.add(identity)
                                                #temp_not_avalable_ident_for_face_id=not_avalable_ident_for_face_id
                                                #print("identity",identity)
                                               # object_name={}
                                                s=int(identity)
                                                object_name[s]=object_id_and_his_face[face_id][2]
                                                #object_name[s]=object_id_and_his_face[face_id][2]

                                                cv2.putText(im0, f'{customer_id}', (x+60, y - 90), cv2.FONT_HERSHEY_PLAIN, 1, (255, 0, 0), 2)          


                            ######         
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
                        #print("identities in main video: ",identities)
                        #for i in identities:
                            #print("identities in main video :",i)
                        
                        
                        img, centers = draw_boxes(im0, bbox_xyxy, identities, categories, confidences=None, colors=colors, time_spent=time_spent, opt=opt, names=names,object_name=object_name,not_avalable_ident_for_face_id=not_avalable_ident_for_face_id)  
                        #object_name={}
                        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                        print('cople_number = ',cople_count)
                        print('face_next_id = ',face_next_id) 
                        print('number of faces = ',len(face_descriptors))
                        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                        print("object_histograms id are",object_histograms.keys())
                        print('number of histogram = ',len(object_histograms))
                        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")





                        keys = list(centers.keys())  # Convert keys to a list  
                        # Draw lines between each center  
                        for i in range(len(keys)):  
                            for j in range(i + 1, len(keys)):  # Ensure pairs are not repeated  
                                point1 = centers[keys[i]] 
                                point2 = centers[keys[j]]   
                    
                                # Draw line between the points  
                                # cv2.line(im0, point1, point2, (255, 0, 0), thickness=2)  
                    
                                # Calculate distance between center points  
                                distance = calculate_distance(point1, point2)  
                    
                                # Calculate position for displaying the distance  
                                text_pos = ((point1[0] + point2[0]) // 2, (point1[1] + point2[1]) // 2)  
                                
                    
                                # Put text above the line  
                                cv2.putText(im0, f'{distance:.2f}', text_pos, cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0), 2) 


#**************************************************************************************************************************************     

#put employee for customer 


                        # put employee in set
                        for i in face_time_spent.keys():
                                if isinstance(i, str):  
                                    employees_id.add(i)

                        # put  customer in set
                        for i in face_time_spent.keys():
                                if isinstance(i, int):  
                                    customers_id.add(i)

                        # to specify  employee has service minimum count of customer 
                        minimun_count_of_employee={}
                        for i in employees_id:
                            minimun_count_of_employee[i]=face_time_spent[i]['counter']

                        minimun_count_of_employee = dict(sorted(minimun_count_of_employee.items(), key=lambda item: item[1]))  
                        for i in minimun_count_of_employee.keys():
                           print("face_time_spent id are ",face_time_spent.keys())
                           if face_time_spent[i]['state']==0:
                               for j in customers_id:
                                       print("face_time_spent id are ",face_time_spent.keys())

                                       if j in face_time_spent and face_time_spent[j]['state'] == 0 and face_time_spent[j]['duration'] >= 1:  
                                            number_of_cople=number_of_cople + 1
                                            employee_with_his_customer[number_of_cople]=[face_time_spent[i],face_time_spent[j],current_time]
                                            face_time_spent[i]['state']=1
                                            face_time_spent[j]['state']=1
                                            face_time_spent[i]['counter']=face_time_spent[i]['counter']+1
                                            face_time_spent[i]['counter']=face_time_spent[i]['points']+1

                                            not_available_employee_and_cusomer.add(i)
                                            not_available_employee_and_cusomer.add(j)

                                            # send point to employee
                                            employee_id=connected_employees[i]['id']
                                            set_points_to_employee(3,'discover',employee_id,j)
                                            set_points_to_employee(5,'GO',employee_id,j)
                                            print("connect key with cutomer")
                                            break

                                       else:
                                            print(f"Key '{j}' with anoher one ")
                           else:
                                continue

                        ############
# start calculate distance between custmer and template
                        #saved_cople
                        keys = list(centers.keys())  # Convert keys to a list  
                        print("keys = ",keys)

                        object_id_and_his_face_keyes=list(object_id_and_his_face.keys())
                        keys_i_id=None
                        keys_j_id=None
                            
                        # not_avalable_ident_for_face_id = identity for object detected
                        temp_not_avalable_ident_for_face_id_list=list(not_avalable_ident_for_face_id)
                        temp_centers=list(centers)
                        distance_1_for_temp=-1
                        distance_2_for_temp=-1

                        # to remove none exists identity that exists in temp_not_avalable_ident_for_face_id_list and note exists in center.keys()
                        for key in temp_not_avalable_ident_for_face_id_list:
                            if key not in keys:
                                temp_not_avalable_ident_for_face_id_list.remove(key)
                        print("temp_not_avalable_ident_for_face_id_list = ",temp_not_avalable_ident_for_face_id_list)

                        # get center of bounding box
                        temp_centers=list(centers)


                        # to calculate distance between customer and template
                        for k in temp_not_avalable_ident_for_face_id_list:
                                    print("enter to connect between customer and template 1")
                                    face_id_temp=object_name[k]
                                    if isinstance(face_id_temp, int):
                                        cutomer_point=centers[k]
                                        if len(centers_Template1)>0:
                                                template_1_point=centers_Template1[0]
                                                distance_1_for_temp = calculate_distance(cutomer_point, template_1_point)  
                                                if distance_1_for_temp >0 and distance_1_for_temp < 1.2:
                                                    face_time_spent[i]['points']+=1
                                                    print(f'employee{i} incresse one point by template 1')
                                                    print(f'total of template is {face_time_spent[i]["points"]}')



                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("connect between template 1 and customer")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")


                                               
                        for k in temp_not_avalable_ident_for_face_id_list:
                                    print("enter to connect between customer and template 2")
                                    face_id_temp=object_name[k]
                                    if isinstance(face_id_temp, int):
                                        cutomer_point=centers[k]
                                        if len(centers_Template2)>0:
                                                template_2_point=centers_Template2[0]
                                                distance_2_for_temp = calculate_distance(cutomer_point, template_2_point)  
                                                if distance_2_for_temp >0 and distance_2_for_temp < 1.2:
                                                    face_time_spent[i]['points']+=1
                                                    print(f'employee{i} incresse one point by template 2')
                                                    print(f'total of template is {face_time_spent[i]["points"]}')



                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("connect between template 2 and customer")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                                               


                                       
                                          
                                       
     
#**************************************************************************************************************************************                                
                                 

                # Print time (inference + NMS)  
                #print(f'{s}Done. ({(1E3 * (t2 - t1)):.1f}ms) Inference, ({(1E3 * (t3 - t2)):.1f}ms) NMS')  
        

#***********************************************************************************************************************                
                                    
                    
                # Print time (inference + NMS)
                #print(f'{s}Done. ({(1E3 * (t2 - t1)):.1f}ms) Inference, ({(1E3 * (t3 - t2)):.1f}ms) NMS')
    
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
    parser.add_argument('--conf-thres', type=float, default=0.30, help='object confidence threshold')
    parser.add_argument('--iou-thres', type=float, default=0.50, help='IOU threshold for NMS')
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
