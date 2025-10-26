#!/usr/bin/env python3
"""
MySQLServer.py
Creates a MySQL database named 'alx_book_store'.
If it already exists, the script does not fail.
"""

import mysql.connector
from mysql.connector import Error

def create_database():
    connection = None
    try:
        # Connect to MySQL server (no specific database yet)
        connection = mysql.connector.connect(
            host='localhost',
            user='root',      # change if your username is different
            password=''       # fill in your MySQL password if needed
        )

        if connection.is_connected():
            cursor = connection.cursor()
            # Create database safely without SELECT or SHOW
            cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
            print("Database 'alx_book_store' created successfully!")

    except Error as e:
        print(f"Error while connecting to MySQL: {e}")

    finally:
        # Properly close cursor and connection
        if connection and connection.is_connected():
            cursor.close()
            connection.close()
            print("MySQL connection closed.")

if __name__ == "__main__":
    create_database()
