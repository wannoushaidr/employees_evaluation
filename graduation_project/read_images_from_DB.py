# import mysql.connector
# from PIL import Image
# import matplotlib.pyplot as plt

# def read_file_paths():
#     # Connect to your database
#     db_connection = mysql.connector.connect(
#         host="127.0.0.1",  # Use localhost if XAMPP is on the same machine
#         user="root",       # Change this to your MySQL username
#         password="",       # Change this to your MySQL password
#         database="clothes_store"  # Change this to your database name
#     )

#     cursor = db_connection.cursor()

#     # Write your SQL query
#     query = "SELECT image FROM accessories"  # change file_path_column and your_table_name

#     cursor.execute(query)
#     file_paths = cursor.fetchall()

#     # Close the cursor and connection
#     cursor.close()
#     db_connection.close()

#     # Return the list of file paths
#     return [file_path[0] for file_path in file_paths]

# def display_images(file_paths):
#     for path in file_paths:
#         try:
#             # Open image
#             image = Image.open(path)
#             # Display image
#             plt.imshow(image)
#             plt.axis('off')  # Hide axes
#             plt.show()
#         except Exception as e:
#             print(f"Error loading image {path}: {e}")

# if __name__ == "__main__":
#     paths = read_file_paths()
#     display_images(paths)



# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# ************************************************************************************************
# # ************************************************************************************************

# import matplotlib.pyplot as plt

# import os  
# from PIL import Image  

# def read_images_from_folders(base_folder):  
#     images = []  
#     # Loop through all folders in the base directory  
#     for folder_name in os.listdir(base_folder):  
#         folder_path = os.path.join(base_folder, folder_name)  
#         if os.path.isdir(folder_path):  # Check if it's a directory  
#             # Loop through all files in the folder  
#             for file_name in os.listdir(folder_path):  
#                 file_path = os.path.join(folder_path, file_name)  
#                 # Check if the file is an image  
#                 if file_name.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp')):  
#                     try:  
#                         img = Image.open(file_path)  
#                         images.append(img)  
#                         print(f"Loaded image: {file_path}")  
#                     except Exception as e:  
#                         print(f"Could not load image {file_path}: {e}")  
#     return images  

# # Specify your base folder here  
# base_folder = 'C:/Users/LENOVO\AndroidStudioProjects/faces_images'  
# images = read_images_from_folders(base_folder)











# import matplotlib.pyplot as plt  
# import os  
# from PIL import Image  

# def read_images_from_folders(base_folder):  
#     images = []  
#     # Loop through all folders in the base directory  
#     for folder_name in os.listdir(base_folder):  
#         folder_path = os.path.join(base_folder, folder_name)  
#         if os.path.isdir(folder_path):  # Check if it's a directory  
#             # Loop through all files in the folder  
#             for file_name in os.listdir(folder_path):  
#                 file_path = os.path.join(folder_path, file_name)  
#                 # Check if the file is an image  
#                 if file_name.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp')):  
#                     try:  
#                         img = Image.open(file_path)  
#                         images.append((file_name, img))  # Store the name along with the image  
#                         print(f"Loaded image: {file_path}")  
#                     except Exception as e:  
#                         print(f"Could not load image {file_path}: {e}")  
#     return images  

# def display_images(images):  
#     plt.figure(figsize=(10, 10))  # Set the figure size  
#     for i, (file_name, img) in enumerate(images):  
#         plt.subplot(5, 5, i + 1)  # Adjust the number of rows and columns as needed  
#         plt.imshow(img)  
#         plt.axis('off')  # Turn off axis  
#         plt.title(file_name)  # Show the file name as the title  
#     plt.tight_layout()  # Adjust the layout  
#     plt.show()  

# # Specify your base folder here  
# base_folder = 'C:/Users/LENOVO/AndroidStudioProjects/faces_images'  # Use an appropriate path  
# images = read_images_from_folders(base_folder)  

# # Display the loaded images  
# display_images(images)




















import matplotlib.pyplot as plt  
import os  
from PIL import Image  

def read_images_from_folders(base_folder):  
    images = []  
    for folder_name in os.listdir(base_folder):  
        folder_path = os.path.join(base_folder, folder_name)  
        if os.path.isdir(folder_path):  
            for file_name in os.listdir(folder_path):  
                file_path = os.path.join(folder_path, file_name)  
                if file_name.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp')):  
                    try:  
                        img = Image.open(file_path)  
                        images.append((file_name, img))  
                        print(f"Loaded image: {file_path}")  
                    except Exception as e:  
                        print(f"Could not load image {file_path}: {e}")  
    return images  

def display_images(images):  
    num_images = len(images)  
    cols = 5  # number of columns  
    rows = (num_images + cols - 1) // cols  # calculate the number of rows needed  
    plt.figure(figsize=(15, 3 * rows))  # Adjust the height based on rows  
    
    for i, (file_name, img) in enumerate(images):  
        plt.subplot(rows, cols, i + 1)  # Use dynamic row and column values  
        plt.imshow(img)  
        plt.axis('off')  # Turn off axis  
        plt.title(file_name)  # Show the file name as the title  
    plt.tight_layout()  # Adjust the layout  
    plt.show()  

# Specify your base folder here  
base_folder = 'C:/Users/LENOVO/AndroidStudioProjects/faces_images'  
images = read_images_from_folders(base_folder)  

# Display the loaded images  
display_images(images)