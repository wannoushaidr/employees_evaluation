# import requests  

# # Define a function to send points data  
# def set_new_points():  
#     try:  
#         url = 'http://127.0.0.1:8000/api/admin/points/set_new_points'  

#         # Define the data to send as JSON, matching your provided structure  
#         data = {  
#             'points_count': 100,  # Replace with your desired points count  
#             'description': 'Added points for excellent service.',  # Description  
#             'employee_id': 5  # Replace with the appropriate employee ID  
#         }  

#         # Make the POST request  
#         response = requests.post(url, json=data)  # Using 'json' to send the payload as JSON  

#         # Check for success  
#         if response.status_code == 200:  
#             # Parse the JSON response if needed  
#             response_data = response.json()  
#             print("Success:", response_data)  
#             return True  
#         else:  
#             # Handle errors  
#             print("Error:", response.status_code, response.text)  # Print status code and error message  
#             return False  

#     except Exception as e:  
#         print(f"An error occurred: {e}")  
#         return False  

# # Call the function to send the data  
# if __name__ == "__main__":  
#     upload_status = set_new_points()  
#     if upload_status:  
#         print("Points set successfully.")  
#     else:  
#         print("Failed to set points.")








# import requests  

# def test_set_points():  
#     url = 'http://127.0.0.1:8000/api/admin/points/set_new_points'  
#     data = {  
#         'points_count': 100,  
#         'description': 'Added points for excellent service.', 
#         'employee_id': 5
#     }  

#     try:  
#         response = requests.post(url, json=data)  
#         print(f"Response Code: {response.status_code}")  

#         # Print raw response body for debugging  
#         print(f"Response Body: {response.text}")  # Show the raw content of the response  

#         # Attempt to parse JSON only if status code is 200  
#         if response.status_code == 200:  
#             response_data = response.json()  
#             print("Success:", response_data)  
#             return True  
#         else:  
#             print("Error:", response.text)  # Print the error message from the server  
#             return False  

#     except requests.exceptions.RequestException as e:  
#         print(f"An error occurred: {e}")  

# # Call the function to test  
# test_set_points()









# import requests  

# def test_set_points():  
#     url = 'http://127.0.0.1:8000/api/admin/points/set_new_points'  
#     data = {  
#         'points_count': 100,  
#         'employee_id': 5  ,
#         'description': 'Added points for excellent service.',
#     }  

#     try:  
#         response = requests.post(url, json=data)  
#         print(f"Response Code: {response.status_code}")  

#         # Print raw response body for debugging  
#         print(f"Response Body: {response.text}")  # Show the raw content of the response  

#         # Check Content-Type to ascertain if it's JSON before attempting to parse  
#         content_type = response.headers.get('Content-Type', '')  
#         if 'application/json' in content_type:  
#             response_data = response.json()  # Attempt to parse as JSON  
#             print("Success:", response_data)  
#             return True  
#         else:  
#             print("Warning: Response is not JSON.")  
#             print("Raw Response Body:", response.text)  
#             return False  

#     except requests.exceptions.RequestException as e:  
#         print(f"An error occurred: {e}")  
#     except ValueError as json_err:  
#         print(f"JSON decode error: {json_err}")  

# # Call the function to test  
# test_set_points()







import requests  
import json  

def test_set_points():  
    url = 'http://127.0.0.1:8000/api/admin/points/set_new_points'  
    data = {  
        'points_count': 100,  
        'description': 'Added points for excellent service.',
        'employee_id': 5  
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

# Call the function to test  
test_set_points()