import requests  
import json  
from bs4 import BeautifulSoup  

# Define the base URL where the Laravel API is hosted  
base_url = 'http://127.0.0.1:8000/api/admin/employees/get_all_employees'  

# Step 1: Retrieve the data from the API  
try:  
    # Perform a GET request to fetch employee data  
    retrieve_response = requests.get(base_url)  

    # Check the response for fetching data  
    retrieve_response.raise_for_status()  # Ensure the request was successful  
    retrieve_clean_response = BeautifulSoup(retrieve_response.text, "html.parser").get_text()  
    retrieve_response_data = json.loads(retrieve_clean_response)  # Parse the cleaned JSON response  

    # Successfully retrieved data  
    print("Data retrieved successfully!")  
    # print("Retrieved employee data:", retrieve_response_data)  

    # Check if the response data is a list
    if isinstance(retrieve_response_data, list):
        customer_service_employees = [
            employee for employee in retrieve_response_data 
            if employee.get("position") == "customer_service"
        ]
    else:
        customer_service_employees = []

    print("Customer Service Employees:", customer_service_employees)

except requests.exceptions.HTTPError as http_err:  
    print(f"HTTP error occurred: {http_err}")  
except requests.exceptions.RequestException as req_err:  
    print(f"Error occurred: {req_err}")  
    print(retrieve_response.text)  # Print the raw response for debugging


