


# import requests  
# import json  
# from bs4 import BeautifulSoup  

# # Define the base URLs where the Laravel APIs are hosted  
# base_url = 'http://127.0.0.1:8000/api/admin/employees/get_all_employees'  
# update_url = 'http://127.0.0.1:8000/api/employees/update_customer_service_active'

# def retrieve_employees():
#     """Retrieve employee data from the API."""
#     base_url = 'http://127.0.0.1:8000/api/admin/employees/get_all_employees'  

#     # Step 1: Retrieve the data from the API  
#     try:  
#         # Perform a GET request to fetch employee data  
#         retrieve_response = requests.get(base_url)  

#         # Check the response for fetching data  
#         retrieve_response.raise_for_status()  # Ensure the request was successful  
#         retrieve_clean_response = BeautifulSoup(retrieve_response.text, "html.parser").get_text()  
#         retrieve_response_data = json.loads(retrieve_clean_response)  # Parse the cleaned JSON response  

#         # Successfully retrieved data  
#         print("Data retrieved successfully!")  
#         # print("Retrieved employee data:", retrieve_response_data)  

#         # Check if the response data is a list
#         if isinstance(retrieve_response_data, list):
#             customer_service_employees = [
#                 employee for employee in retrieve_response_data 
#                 if employee.get("position") == "customer_service"
#             ]
#         else:
#             customer_service_employees = []

#         print("Customer Service Employees:", customer_service_employees)
#         return customer_service_employees

#     except requests.exceptions.HTTPError as http_err:  
#         print(f"HTTP error occurred: {http_err}")  
#     except requests.exceptions.RequestException as req_err:  
#         print(f"Error occurred: {req_err}")  
#         print(retrieve_response.text)  # Print the raw response for debugging
    

# def update_customer_service_status(employees,id,active):
#     """Update the active status for customer service employees."""
#     customer_service_employees = [
#         employee for employee in employees 
#         if employee.get("position") == "customer_service"
#     ]

#     print("Customer Service Employees:", customer_service_employees)

#     # for employee in customer_service_employees:
#     update_data = {
#             'id': id,
#             'active': active
#          }
        
#         # Send PUT request to update employee status
#     update_response = requests.put(update_url, json=update_data)
        
#         # Check if update was successful
#     if update_response.status_code == 200:
#             print(f"Successfully updated employee {id}")
#     else:
#             print(f"Failed to update employee {id}")
#             print("Response:", update_response.text)

# # Main execution flow
# if __name__ == "__main__":
#     employees = retrieve_employees()
#     print("*****************")
#     print("employee are ")
#     print(employees)
#     if isinstance(employees, list):
#         update_customer_service_status(employees,2,'false')


# *************************************************************************************************************

import os  
import requests  
import json  
from PIL import Image  
from bs4 import BeautifulSoup  

# Function to load employees' images and save them in a list  
def read_images_from_folders(base_folder):  
    images = []  # List to store images and their details  
    for folder_name in os.listdir(base_folder):  
        folder_path = os.path.join(base_folder, folder_name)  
        if os.path.isdir(folder_path):  # Ensure it's a directory  
            for file_name in os.listdir(folder_path):  
                file_path = os.path.join(folder_path, file_name)  
                if file_name.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp')):  
                    try:  
                        img = Image.open(file_path)  
                        images.append((folder_name, file_name, img, file_path))  # Save folder name, file name, image, and path  
                        print(f"Loaded image: {file_path}")  
                    except Exception as e:  
                        print(f"Could not load image {file_path}: {e}")  
    return images  


# # Function to get customer service employee data from the database  
# def retrieve_employees():  
#     """Retrieve employee data from the API."""  
#     base_url = 'http://127.0.0.1:8000/api/admin/employees/get_all_employees'  

#     try:  
#         # Perform a GET request to fetch employee data  
#         retrieve_response = requests.get(base_url)  
#         retrieve_response.raise_for_status()  # Ensure the request was successful  
        
#         # Clean and parse the JSON response  
#         retrieve_clean_response = BeautifulSoup(retrieve_response.text, "html.parser").get_text()  
#         retrieve_response_data = json.loads(retrieve_clean_response)  

#         print("Data retrieved successfully!")  

#         # Filter for customer service employees  
#         customer_service_employees = [  
#             employee for employee in retrieve_response_data   
#             if employee.get("position") == "customer_service"  
#         ]                       
#         print("Customer Service Employees:", customer_service_employees)  
#         return customer_service_employees  

#     except requests.exceptions.HTTPError as http_err:  
#         print(f"HTTP error occurred: {http_err}")  
#     except requests.exceptions.RequestException as req_err:  
#         print(f"Error occurred: {req_err}")  
#         print(retrieve_response.text)  # Print the raw response for debugging  



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





# # Function to connect images to employees  
# def connect_images_to_employees(base_folder):  
#     images = read_images_from_folders(base_folder)  
#     employees = retrieve_employees()  

#     # Create a mapping of employee ID to each employee's information  
#     employee_mapping = {str(employee['id']): employee for employee in employees}  # Ensure ID is a string  
#     print("employee_mapping")
#     print(employee_mapping)
#     # Match images to employee data  
#     for folder_name, file_name, img, file_path in images:  
#         # Split folder name to get employee ID  
#         parts = folder_name.split('_')  
#         if len(parts) > 0:  
#             emp_id = parts[0]  # Take the first part as the employee ID  
#             # Check if the ID exists in our employee mapping  
#             if emp_id in employee_mapping:  
#                 employee_info = employee_mapping[emp_id]  
#                 print(f"Connected Image Path: {file_path} with Employee: {employee_info['name']} (ID: {emp_id})")  
#             else:  
#                 print(f"Employee ID {emp_id} not found in employee data.")  
#     return employee_info


def connect_images_to_employees(base_folder):  
    images = read_images_from_folders(base_folder)  
    employees = retrieve_employees()  
    print("retrieve_employees:")
    print(employees)

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

# Example usage:  
if __name__ == "__main__":  
    base_folder = 'C:/Users/LENOVO/AndroidStudioProjects/faces_images'  # Replace with your actual folder path  
    connected_employees = connect_images_to_employees(base_folder)  
    print(connected_employees)  # Output the mapping of folder names to employee info

# # Example usage:  
# if __name__ == "__main__":  
#     base_folder = 'C:/Users/LENOVO/AndroidStudioProjects/faces_images'  # Replace with your actual folder path  
#     print(connect_images_to_employees(base_folder))