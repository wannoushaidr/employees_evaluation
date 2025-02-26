import sys  
import json  

def evaluate_points(data):  
    results = []  
    
    # Example processing: Calculate total points for each employee  
    for employee_id, employee_data in data.items():  
        total_points = sum(point['points_count'] for point in employee_data)  
        results.append({'employee_id': employee_id, 'result': total_points})  

    return results  

if __name__ == '__main__':  
    # Read and parse input from stdin  
    input_data = sys.stdin.read()  
    
    try:  
        points_data = json.loads(input_data)  # Load the JSON input  
        evaluation_results = evaluate_points(points_data)  # Process the data  

        # Print the output in JSON format  
        print(json.dumps(evaluation_results))  # Output the JSON results  

    except json.JSONDecodeError:  
        print(json.dumps({'error': 'Invalid JSON input'}), file=sys.stderr)  
        sys.exit(1)  