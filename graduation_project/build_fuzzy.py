



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