import numpy as np
import skfuzzy as fuzz
import matplotlib.pyplot as plt

# Define the universe of discourse for the temperature
x_temperature = np.arange(-10, 51, 1)

# Define the membership functions for temperature
temperature_very_low = fuzz.trimf(x_temperature, [-10, -10, 0])
temperature_low = fuzz.trimf(x_temperature, [-10, 0, 15])
temperature_medium = fuzz.trimf(x_temperature, [10, 20, 30])
temperature_high = fuzz.trimf(x_temperature, [25, 35, 40])
temperature_very_high = fuzz.trimf(x_temperature, [35, 50, 50])

# Plot the membership functions
# plt.figure()
# plt.plot(x_temperature, temperature_very_low, 'b', label='Very Low')
# plt.plot(x_temperature, temperature_low, 'g', label='Low')
# plt.plot(x_temperature, temperature_medium, 'r', label='Medium')
# plt.plot(x_temperature, temperature_high, 'c', label='High')
# plt.plot(x_temperature, temperature_very_high, 'm', label='Very High')
# plt.title('Temperature Membership Functions')
# plt.xlabel('Temperature (°C)')
# plt.ylabel('Membership Degree')
# plt.legend()
# plt.show()

# Function to classify temperature
def classify_temperature(temp_value):
    very_low_degree = fuzz.interp_membership(x_temperature, temperature_very_low, temp_value)
    low_degree = fuzz.interp_membership(x_temperature, temperature_low, temp_value)
    medium_degree = fuzz.interp_membership(x_temperature, temperature_medium, temp_value)
    high_degree = fuzz.interp_membership(x_temperature, temperature_high, temp_value)
    very_high_degree = fuzz.interp_membership(x_temperature, temperature_very_high, temp_value)

    # Find the maximum membership degree and corresponding classification
    degrees = {
        'Very Low': very_low_degree,
        'Low': low_degree,
        'Medium': medium_degree,
        'High': high_degree,
        'Very High': very_high_degree
    }

    classification = max(degrees, key=degrees.get)
    print(f"The classification based on the temperature {temp_value}°C is: {classification}")

# Example: Evaluate a specific temperature
temp_value = float(input("Enter the temperature (°C): "))
classify_temperature(temp_value)
