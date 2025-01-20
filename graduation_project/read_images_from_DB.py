import mysql.connector
from PIL import Image
import matplotlib.pyplot as plt

def read_file_paths():
    # Connect to your database
    db_connection = mysql.connector.connect(
        host="127.0.0.1",  # Use localhost if XAMPP is on the same machine
        user="root",       # Change this to your MySQL username
        password="",       # Change this to your MySQL password
        database="clothes_store"  # Change this to your database name
    )

    cursor = db_connection.cursor()

    # Write your SQL query
    query = "SELECT image FROM accessories"  # change file_path_column and your_table_name

    cursor.execute(query)
    file_paths = cursor.fetchall()

    # Close the cursor and connection
    cursor.close()
    db_connection.close()

    # Return the list of file paths
    return [file_path[0] for file_path in file_paths]

def display_images(file_paths):
    for path in file_paths:
        try:
            # Open image
            image = Image.open(path)
            # Display image
            plt.imshow(image)
            plt.axis('off')  # Hide axes
            plt.show()
        except Exception as e:
            print(f"Error loading image {path}: {e}")

if __name__ == "__main__":
    paths = read_file_paths()
    display_images(paths)
