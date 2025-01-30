

import requests
import json
from bs4 import BeautifulSoup

# Define the URL where the Laravel API is hosted
url = 'http://127.0.0.1:8000/api/employees/send_notification'

# Data to be sent to the Laravel API
data = {
        "user_id": 2,
        "title": "AI Notification",
        "body": "This is a notification from AI",
        "url": "http://example.com",
    }


# Send the data as a POST request
response = requests.post(url, json=data)

# Log and inspect the received response
print("Response received from server:")
print(response.text)

# Check the response from the Laravel API
try:
    response.raise_for_status()  # Ensure the request was successful

    # Parse and clean response from any unexpected HTML content
    clean_response = BeautifulSoup(response.text, "html.parser").get_text()
    response_data = json.loads(clean_response)  # Parse the cleaned JSON response

    print("Data sent successfully!")
    print("Response message:", response_data['message'])
    print("Data received by Laravel:", response_data['data'])
except requests.exceptions.HTTPError as http_err:
    print(f"HTTP error occurred: {http_err}")
except requests.exceptions.RequestException as req_err:
    print(f"Error occurred: {req_err}")
except json.JSONDecodeError as json_err:
    print("Failed to decode JSON response from server. Response text:")
    print(response.text)
