# import numpy as np
# import skfuzzy as fuzz
# from skfuzzy import control as ctrl



# Go = ctrl.Antecedent(np.arange(0, 5.05, 0.05), 'Go')
# S = ctrl.Antecedent(np.arange(0, 8.05, 0.05), 'service')
# out = ctrl.Antecedent(np.arange(0, 4.05, 0.05), 'out')


# E = ctrl.Consequent(np.arange(0, 1.05, 0.05), 'Evaluation')


# Go['B'] = fuzz.trimf(Go.universe, [0 , 1 , 2])
# Go['M'] = fuzz.trimf(Go.universe, [1.5, 2.5 , 3.5])
# Go['G'] = fuzz.trimf(Go.universe, [3, 4, 5])
# print("44")

# Go.view()

# print("11")

# S['B'] = fuzz.trimf(S.universe, [0 , 1.5 , 3])
# S['M'] = fuzz.trimf(S.universe, [2, 3.5 , 5])
# S['G'] = fuzz.trimf(S.universe, [4, 6, 8])

# S.view()


# print("22")

# out['B'] = fuzz.trimf(out.universe, [0 , 1 , 2])
# out['M'] = fuzz.trimf(out.universe, [1.5, 2.25 , 3])
# out['G'] = fuzz.trimf(out.universe, [2.5,3.25 , 4])

# out.view()

# print("33")

# E['B'] = fuzz.trimf(E.universe, [0 , 0.15 , 0.3])
# E['M'] = fuzz.trimf(E.universe, [0.2, 0.4 , 0.6])
# E['G'] = fuzz.trimf(E.universe, [0.5,0.7 , 0.9])
# E['VG'] = fuzz.trimf(E.universe, [0.8,0.9 , 1])

# E.view()

# print("44")

# r1 = ctrl.Rule(Go['B'] & S['G'] & out['B'], E['B'])
# r2 = ctrl.Rule(out['G'], E['G'])
# r3 = ctrl.Rule(Go['B'], E['B'])

# print("55")

# Spare_Management = ctrl.ControlSystem([r1,r2,r3])

# SM = ctrl.ControlSystemSimulation(Spare_Management)

# # from Admin
# SM.input['Go'] = 1
# SM.input['service'] = 7
# SM.input['out'] = 1

# SM.compute()


# Go.view(sim=SM)

# print("66")

# S.view(sim=SM)

# out.view(sim=SM)

# print(SM.output['Evaluation'])

# E.view(sim=SM)

# print("77")









import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl




discover = ctrl.Antecedent(np.arange(0, 3.05, 0.05), 'discover')
Go = ctrl.Antecedent(np.arange(0, 5.05, 0.05), 'Go')
fitting_room = ctrl.Antecedent(np.arange(0, 8.05, 0.05), 'fitting_room')
cashier = ctrl.Antecedent(np.arange(0, 4.05, 0.05), 'cashier')

E = ctrl.Consequent(np.arange(0, 1.05, 0.05), 'Evaluation')


Go['B'] = fuzz.trimf(Go.universe, [0 , 0 , 2])
Go['M'] = fuzz.trimf(Go.universe, [1.5, 2.5 , 3.5])
Go['G'] = fuzz.trimf(Go.universe, [3, 5, 5])

Go.view()

discover['B'] = fuzz.trimf(discover.universe, [0 , 0 , 1.5])
discover['M'] = fuzz.trimf(discover.universe, [1, 1.75 , 2.5])
discover['G'] = fuzz.trimf(discover.universe, [2, 3, 3])

discover.view()

fitting_room['B'] = fuzz.trimf(fitting_room.universe, [0 , 0 , 3])
fitting_room['M'] = fuzz.trimf(fitting_room.universe, [2, 3.5 , 5])
fitting_room['G'] = fuzz.trimf(fitting_room.universe, [4, 8, 8])

fitting_room.view()

cashier['B'] = fuzz.trimf(cashier.universe, [0 , 0 , 2])
cashier['M'] = fuzz.trimf(cashier.universe, [1.5, 2.25 , 3])
cashier['G'] = fuzz.trimf(cashier.universe, [2.5,4 , 4])

cashier.view()

E['B'] = fuzz.trimf(E.universe, [0 , 0 , 0.3])
E['M'] = fuzz.trimf(E.universe, [0.2, 0.4 , 0.6])
E['G'] = fuzz.trimf(E.universe, [0.5,0.7 , 0.9])
E['VG'] = fuzz.trimf(E.universe, [0.8,1 , 1])

E.view()


# Base 1
r1 = ctrl.Rule(Go['B'] & fitting_room['G'] & cashier['B'], E['B'])
r2 = ctrl.Rule(cashier['G'], E['G'])
r3 = ctrl.Rule(Go['B'], E['B'])
r4 = ctrl.Rule(discover['B'], E['B'])
r5 = ctrl.Rule(Go['G'] & fitting_room['G'] & cashier['G'] & discover['G'], E['G'])


Spare_Management = ctrl.ControlSystem([r1,r2,r3,r4,r5])

SM = ctrl.ControlSystemSimulation(Spare_Management)

# from Admin
SM.input['Go'] = 5
SM.input['fitting_room'] = 8
SM.input['cashier'] = 4
SM.input['discover'] = 3

SM.compute()
print("output" , SM.compute())
Go.view(sim=SM)
print("ssssss")

fitting_room.view(sim=SM)

cashier.view(sim=SM)

discover.view(sim=SM)

E.view(sim=SM)

print("ssssss")
print(SM.output['Evaluation'])