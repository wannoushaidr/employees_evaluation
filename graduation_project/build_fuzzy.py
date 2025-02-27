


# import sys
# import json

# def validate_input(data):
#     if not isinstance(data, dict):
#         raise ValueError("Input must be a dictionary")
#     for emp_id, records in data.items():
#         if not isinstance(records, list):
#             raise ValueError(f"Records for employee {emp_id} must be a list")
#         for record in records:
#             if "points_count" not in record:
#                 raise ValueError(f"Missing 'points_count' in record for employee {emp_id}")

# def process_data(data):
#     results = {}
#     for employee_id, records in data.items():
#         total_points = sum(r['points_count'] for r in records)
#         score = min(100, max(0, total_points * 2))  # Example logic
#         results[employee_id] = {
#             'score': score,
#             'feedback': f"Processed {len(records)} records. Total: {total_points}"
#         }
#     return results

# if __name__ == "__main__":
#     try:
#         input_data = json.loads(sys.argv[1])
#         validate_input(input_data)  # Validate before processing
#         results = process_data(input_data)
#         print(json.dumps(results))
#     except Exception as e:
#         print(json.dumps({"error": str(e)}))
#         sys.exit(1)







# import sys  
# import json  

# def process_data(data):  
#     results = {}  
#     for employee_id, records in data.items():  
#         total_points = sum(r['points_count'] for r in records)  
#         score = min(100, max(0, total_points * 2))  # Example logic  
#         results[employee_id] = {  
#             'score': score,  
#             'feedback': f"Processed {len(records)} records. Total: {total_points}"  
#         }  
#     return results  

# if __name__ == "__main__":  
#     try:  
#         # Read from the file  
#         with open(sys.argv[1], 'r') as f:  
#             input_data = json.load(f)  

#         # For debugging, print the input data  
#         print("Input Data:", json.dumps(input_data))  # Log input to help debug  

#         # Process data and return basic response for testing  
#         results = {"test_employee": {"score": 50, "feedback": "Test feedback"}}  
#         print(json.dumps(results))  # Return a simple mock response for testing  

#     except Exception as e:  
#         print(json.dumps({"error": str(e)}))  # Print any errors  
#         sys.exit(1)  




import sys  
import json  

def process_data(data):  
    results = {}  
    for employee_id, records in data.items():  
        total_points = sum(r['points_count'] for r in records)  
        score = min(100, max(0, total_points * 2))  # Example logic  
        results[employee_id] = {  
            'score': score,  
            'feedback': f"Processed {len(records)} records. Total: {total_points}"  
        }  
    return results  

if __name__ == "__main__":  
    try:  
        # Read from the file  
        with open(sys.argv[1], 'r') as f:  
            input_data = json.load(f)  

        # Process the data  
        results = process_data(input_data)  

        # Create an output dictionary to send back as JSON  
        output = {  
            "input": input_data,  # Log input for visibility  
            "results": results  
        }  
        
        # Print JSON output  
        print(json.dumps(output))  # Return final combined JSON  

    except Exception as e:  
        print(json.dumps({"error": str(e)}))  
        sys.exit(1)  