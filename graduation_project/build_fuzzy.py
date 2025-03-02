



# import sys  
# import json  

# def process_data(data):  
#     results = {}  
#     for employee_id, records in data.items():  
#         total_points = sum(r['points_count'] for r in records)  
#         score = min(100, max(0, total_points * 2))  # Example logic  
#         results[employee_id] = {  
#             'employee_id': employee_id,  
#             'evaluation': f"Processed {len(records)} records. Total: {total_points}"  
#         }  
#     return results  

# if __name__ == "__main__":  
#     try:  
#         # Read from the file  
#         with open(sys.argv[1], 'r') as f:  
#             input_data = json.load(f)  

#         # Process the data  
#         results = process_data(input_data)  

#         # Create an output dictionary to send back as JSON  
#         output = {  
#             "input": input_data,  # Log input for visibility  
#             "results": results  
#         }  
        
#         # Print JSON output  
#         print(json.dumps(output))  # Return final combined JSON  

#     except Exception as e:  
#         print(json.dumps({"error": str(e)}))  
#         sys.exit(1)  




# import numpy as np
# import skfuzzy as fuzz
# from skfuzzy import control as ctrl




# discover = ctrl.Antecedent(np.arange(0, 3.05, 0.05), 'discover')
# Go = ctrl.Antecedent(np.arange(0, 5.05, 0.05), 'Go')
# fitting_room = ctrl.Antecedent(np.arange(0, 8.05, 0.05), 'fitting_room')
# cashier = ctrl.Antecedent(np.arange(0, 4.05, 0.05), 'cashier')

# E = ctrl.Consequent(np.arange(0, 1.05, 0.05), 'Evaluation')


# Go['B'] = fuzz.trimf(Go.universe, [0 , 0 , 2])
# Go['M'] = fuzz.trimf(Go.universe, [1.5, 2.5 , 3.5])
# Go['G'] = fuzz.trimf(Go.universe, [3, 5, 5])



# discover['B'] = fuzz.trimf(discover.universe, [0 , 0 , 1.5])
# discover['M'] = fuzz.trimf(discover.universe, [1, 1.75 , 2.5])
# discover['G'] = fuzz.trimf(discover.universe, [2, 3, 3])


# fitting_room['B'] = fuzz.trimf(fitting_room.universe, [0 , 0 , 3])
# fitting_room['M'] = fuzz.trimf(fitting_room.universe, [2, 3.5 , 5])
# fitting_room['G'] = fuzz.trimf(fitting_room.universe, [4, 8, 8])


# cashier['B'] = fuzz.trimf(cashier.universe, [0 , 0 , 2])
# cashier['M'] = fuzz.trimf(cashier.universe, [1.5, 2.25 , 3])
# cashier['G'] = fuzz.trimf(cashier.universe, [2.5,4 , 4])


# E['B'] = fuzz.trimf(E.universe, [0 , 0 , 0.3])
# E['M'] = fuzz.trimf(E.universe, [0.2, 0.4 , 0.6])
# E['G'] = fuzz.trimf(E.universe, [0.5,0.7 , 0.9])
# E['VG'] = fuzz.trimf(E.universe, [0.8,1 , 1])

# # E.view()

# print("done")
# # Go.view()
# # discover.view()
# # cashier.view()
# # fitting_room.view()

# # Base 1
# r1 = ctrl.Rule(Go['B'] & fitting_room['G'] & cashier['B'], E['B'])
# r2 = ctrl.Rule(cashier['G'], E['G'])
# r3 = ctrl.Rule(Go['B'], E['B'])
# r4 = ctrl.Rule(discover['B'], E['B'])
# r5 = ctrl.Rule(Go['G'] & fitting_room['G'] & cashier['G'] & discover['G'], E['VG'])


# Spare_Management = ctrl.ControlSystem([r1,r2,r3,r4,r5])

# SM = ctrl.ControlSystemSimulation(Spare_Management)

# # from Admin
# SM.input['Go'] = 5 # max 5
# SM.input['fitting_room'] = 8 # max 8
# SM.input['cashier'] = 4 # max 4
# SM.input['discover'] = 3 # max 3

# SM.compute()
# print(SM.output['Evaluation'])

# print("done")








import sys  
import json  
import numpy as np  
import skfuzzy as fuzz  
from skfuzzy import control as ctrl  

def safe_float(value):  
        if isinstance(value, list) and len(value) > 0:  
            return float(value[0])  # Return first item if it's a list  
        elif isinstance(value, (int, float)):  
            return float(value)  # Direct conversion for int/float  
        return 0.0  # Default to 0.0 if not convertible  


# # Define fuzzy variables  
# discover = ctrl.Antecedent(np.arange(0, 3.05, 0.05), 'discover')  
# Go = ctrl.Antecedent(np.arange(0, 5.05, 0.05), 'Go')  
# fitting_room = ctrl.Antecedent(np.arange(0, 8.05, 0.05), 'fitting_room')  
# cashier = ctrl.Antecedent(np.arange(0, 4.05, 0.05), 'cashier')  
# E = ctrl.Consequent(np.arange(0, 1.05, 0.05), 'Evaluation')  

# # Define fuzzy membership functions  
# Go['B'] = fuzz.trimf(Go.universe, [0, 0, 2])  
# Go['M'] = fuzz.trimf(Go.universe, [1.5, 2.5, 3.5])  
# Go['G'] = fuzz.trimf(Go.universe, [3, 5, 5])  

# discover['B'] = fuzz.trimf(discover.universe, [0, 0, 1.5])  
# discover['M'] = fuzz.trimf(discover.universe, [1, 1.75, 2.5])  
# discover['G'] = fuzz.trimf(discover.universe, [2, 3, 3])  

# fitting_room['B'] = fuzz.trimf(fitting_room.universe, [0, 0, 3])  
# fitting_room['M'] = fuzz.trimf(fitting_room.universe, [2, 3.5, 5])  
# fitting_room['G'] = fuzz.trimf(fitting_room.universe, [4, 8, 8])  

# cashier['B'] = fuzz.trimf(cashier.universe, [0, 0, 2])  
# cashier['M'] = fuzz.trimf(cashier.universe, [1.5, 2.25, 3])  
# cashier['G'] = fuzz.trimf(cashier.universe, [2.5, 4, 4])  

# E['B'] = fuzz.trimf(E.universe, [0, 0, 0.3])  
# E['M'] = fuzz.trimf(E.universe, [0.2, 0.4, 0.6])  
# E['G'] = fuzz.trimf(E.universe, [0.5, 0.7, 0.9])  
# E['VG'] = fuzz.trimf(E.universe, [0.8, 1, 1])  

# # Define fuzzy rules  
# r1 = ctrl.Rule(Go['B'] & fitting_room['G'] & cashier['B'], E['B'])  
# r2 = ctrl.Rule(cashier['G'], E['G'])  
# r3 = ctrl.Rule(Go['B'], E['B'])  
# r4 = ctrl.Rule(discover['B'], E['B'])  
# r5 = ctrl.Rule(Go['G'] & fitting_room['G'] & cashier['G'] & discover['G'], E['VG']) 


# Spare_Management = ctrl.ControlSystem([r1, r2, r3, r4, r5])  







# *****************************************************************************************


discover = ctrl.Antecedent(np.arange(0, 3.01, 0.01), 'discover')
Go = ctrl.Antecedent(np.arange(0, 5.01, 0.01), 'Go')
fitting_room = ctrl.Antecedent(np.arange(0, 8.01, 0.01), 'fitting_room')
cashier = ctrl.Antecedent(np.arange(0, 4.01, 0.01), 'cashier')

E = ctrl.Consequent(np.arange(0, 1.01, 0.01), 'Evaluation')


Go['B'] = fuzz.trimf(Go.universe, [0 , 0 , 1.5])
Go['M'] = fuzz.trimf(Go.universe, [1, 2.5 , 4])
Go['G'] = fuzz.trimf(Go.universe, [3, 5, 5])

discover['B'] = fuzz.trimf(discover.universe, [0 , 0 , 1])
discover['M'] = fuzz.trimf(discover.universe, [0.5, 1.5 , 2.5])
discover['G'] = fuzz.trimf(discover.universe, [2, 3, 3])


fitting_room['B'] = fuzz.trimf(fitting_room.universe, [0 , 0 , 3])
fitting_room['M'] = fuzz.trimf(fitting_room.universe, [2, 4 , 6])
fitting_room['G'] = fuzz.trimf(fitting_room.universe, [5, 8, 8])


cashier['B'] = fuzz.trimf(cashier.universe, [0 , 0 , 1.5])
cashier['M'] = fuzz.trimf(cashier.universe, [1, 2 , 3])
cashier['G'] = fuzz.trimf(cashier.universe, [2.5,4 , 4])

# E['VB'] = fuzz.trapmf(E.universe, [0 , 0 ,0.05, 0.1])
E['VB'] = fuzz.trimf(E.universe, [0 , 0 , 0.1])
E['B'] = fuzz.trimf(E.universe, [0.04 , 0.24 , 0.4])
E['M'] = fuzz.trimf(E.universe, [0.3, 0.5 , 0.7])
E['G'] = fuzz.trimf(E.universe, [0.6,0.75 , 0.9])
E['VG'] = fuzz.trimf(E.universe, [0.85, 1 , 1])
# Define fuzzy rules  




r1 = ctrl.Rule(Go['B'] | fitting_room['B'] & cashier['B'] & discover['B'], E['VB'])


r2 = ctrl.Rule(Go['M'] & fitting_room['B'] & cashier['B'] & discover['B'], E['B'])

r3 = ctrl.Rule(Go['B'] & fitting_room['M'] & cashier['B'] & discover['B'], E['B'])

r4 = ctrl.Rule(Go['B'] & fitting_room['B'] & cashier['M'] & discover['B'], E['B'])

r5 = ctrl.Rule(Go['B'] & fitting_room['B'] & cashier['B'] & discover['M'], E['B'])



r6 = ctrl.Rule(Go['B'] & fitting_room['M'] & cashier['M'] & discover['M'], E['M'])

r7 = ctrl.Rule(Go['M'] & fitting_room['B'] & cashier['M'] & discover['M'], E['M'])

r8 = ctrl.Rule(Go['M'] & fitting_room['M'] & cashier['B'] & discover['M'], E['M'])

r9 = ctrl.Rule(Go['M'] & fitting_room['M'] & cashier['M'] & discover['B'], E['M'])



r10 = ctrl.Rule(Go['M'] & fitting_room['M'] & cashier['M'] & discover['M'], E['M'])



r11 = ctrl.Rule(Go['G'] & fitting_room['M'] & cashier['M'] & discover['M'], E['M'])

r12 = ctrl.Rule(Go['M'] & fitting_room['G'] & cashier['M'] & discover['M'], E['M'])

r13 = ctrl.Rule(Go['M'] & fitting_room['M'] & cashier['G'] & discover['M'], E['G'])

r14 = ctrl.Rule(Go['M'] & fitting_room['M'] & cashier['M'] & discover['G'], E['M'])



r15 = ctrl.Rule(Go['G'] & fitting_room['G'] & cashier['B'] & discover['G'], E['M'])

r16 = ctrl.Rule(Go['G'] & fitting_room['B'] & cashier['G'] & discover['B'], E['M'])

r17 = ctrl.Rule(Go['G'] & fitting_room['M'] & cashier['G'] & discover['B'], E['G'])

r18 = ctrl.Rule(Go['M'] & fitting_room['M'] & cashier['G'] & discover['B'], E['M'])

r19 = ctrl.Rule(Go['B'] & fitting_room['M'] & cashier['G'] & discover['G'], E['M'])

r20 = ctrl.Rule(Go['M'] & fitting_room['B'] & cashier['G'] & discover['B'], E['M'])

r21 = ctrl.Rule(Go['M'] & fitting_room['B'] & cashier['G'] & discover['M'], E['G'])

r22 = ctrl.Rule(Go['M'] & fitting_room['B'] & cashier['B'] & discover['G'], E['B'])

r23 = ctrl.Rule(Go['M'] & fitting_room['G'] & cashier['B'] & discover['B'], E['B'])

r24 = ctrl.Rule(Go['M'] & fitting_room['M'] & cashier['B'] & discover['B'], E['B'])

r25 = ctrl.Rule(Go['M'] & fitting_room['B'] & cashier['B'] & discover['M'], E['B'])


r26 = ctrl.Rule(Go['M'] & fitting_room['G'] & cashier['G'] & discover['G'], E['G'])

r27 = ctrl.Rule(Go['G'] & fitting_room['M'] & cashier['G'] & discover['G'], E['G'])

r28 = ctrl.Rule(Go['G'] & fitting_room['G'] & cashier['M'] & discover['G'], E['G'])

r29 = ctrl.Rule(Go['G'] & fitting_room['G'] & cashier['G'] & discover['M'], E['G'])



r30 = ctrl.Rule(Go['G'] & fitting_room['G'] & cashier['G'] & discover['G'], E['VG'])
r31= ctrl.Rule(Go['B'] | fitting_room['B'] | cashier['B'] | discover['B'], E['M'])
r32= ctrl.Rule(Go['B'] & discover['B'] | fitting_room['B'] & cashier['B'] | discover['B'] & fitting_room['B'] |  discover['B'] & cashier['B']  , E['B'])
r33 = ctrl.Rule(Go['M'] & fitting_room['M'] & cashier['M'] & discover['M'], E['M'])






Spare_Management = ctrl.ControlSystem([r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,
                                       r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,
                                       r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31,r32,r33])

SM = ctrl.ControlSystemSimulation(Spare_Management)










# print("ss")



# Check for command-line argument  
if len(sys.argv) < 2:  
    print("Error: No input file provided. Please provide the path to the JSON file.")  
    sys.exit(1)  
# print("ss")

# Read the JSON payload from the temporary file  
temp_file_path = sys.argv[1]  
# print("ss")

try:  
    with open(temp_file_path) as f:  
        payload = json.load(f)  
except FileNotFoundError:  
    print(f"Error: File not found: {temp_file_path}")  
    sys.exit(1)  
except json.JSONDecodeError:  
    print(f"Error: Failed to decode JSON from the file: {temp_file_path}")  
    sys.exit(1)  

results = []  

# Iterate over the payload data  
for entry in payload:  
    employee_id = entry['employee_id']  
    input_data = entry['data']  

    # Assign input values for the simulation using the employee's data  
    # SM = ctrl.ControlSystemSimulation(Spare_Management)  

    # SM.input['Go'] = float(input_data.get('Go', 0)  )
    # SM.input['fitting_room'] = float(input_data.get('fitting_room', 0)  )
    # SM.input['cashier'] =  float(input_data.get('cashier', 0)  )
    # SM.input['discover'] = float(input_data.get('discover', 0)  )

    # # Assign input values for the simulation using the employee's data  
    # SM.input['Go'] = safe_float(input_data.get('Go', 0))  
    # SM.input['fitting_room'] = safe_float(input_data.get('fitting_room', 0))  
    # SM.input['cashier'] = safe_float(input_data.get('cashier', 0))  
    # SM.input['discover'] = safe_float(input_data.get('discover', 0))  
    # print(f"Inputs assigned: Go={SM.input['Go']}, fitting_room={SM.input['fitting_room']}, cashier={SM.input['cashier']}, discover={SM.input['discover']}")  # Debug output for assigned inputs  

    # from Admin
    SM.input['Go'] = 5# max 5
    SM.input['fitting_room'] = 4.0# max 8
    SM.input['cashier'] = 4 # max 4
    SM.input['discover'] = 3 # max 3

    SM.compute()
    # print(SM.output['Evaluation'])



    # Compute the fuzzy evaluation  
    # SM.compute()  

    # Store the result  
    results.append({  
        'employee_id': employee_id,  
        'evaluation': SM.output['Evaluation']  
    })  

# Print the results as a JSON string to return to the Laravel application  
print(json.dumps({'results': results}))  
