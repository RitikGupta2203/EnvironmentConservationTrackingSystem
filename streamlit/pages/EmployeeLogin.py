#Employee_login page
#----------------------------------------------------------------------------------------------------------
# Importing libraries 
import streamlit as st
import pandas as pd
import sqlite3
import os
import base64
#----------------------------------------------------------------------------------------------------------
# Setting background
def set_background():
    bin_file = "data/employee.png"
    with open(bin_file, 'rb') as f:
        data = f.read()
    bin_str = base64.b64encode(data).decode()
    page_bg_img = '''
        <style>
        .stApp {
            background-image: url("data:image/png;base64,%s");
            background-size: cover;
        }
        </style>
    ''' % bin_str
    st.markdown(page_bg_img, unsafe_allow_html=True)

#----------------------------------------------------------------------------------------------------------
# Function to create a SQLite connection
def create_connection():
    conn = sqlite3.connect("./sql/wildlife.db")  # path to  database
    return conn

#----------------------------------------------------------------------------------------------------------
# Function to authenticate users
def authenticate(username, password, role):
    # For simplicity, let's assume there's a dictionary of role-specific usernames and passwords
    role_credentials = {
        "admin": {"admin": "admin"} ,
        "sanctuary staff": {"staff1": "password1", "staff2": "password2"},
        "vets": {"vet1": "password1", "vet2": "password2"},
        "guides": {"guide1": "password1", "guide2": "password2"},
        "coaches": {"coach1": "password1", "coach2": "password2"},
        "caretakers": {"caretaker1": "password1", "caretaker2": "password2"},
    }
    return username in role_credentials[role] and password == role_credentials[role][username]

#----------------------------------------------------------------------------------------------------------
# Function to fetch data from the database
def fetch_data(conn, query):
    return pd.read_sql_query(query, conn)

#----------------------------------------------------------------------------------------------------------
# Function to show the Employee Dashboard
def show_employee_dashboard(conn, role):
    st.title(f"{role.capitalize()} Dashboard")

    if role == "caretakers":
        show_caretaker_dashboard(conn)
    elif role == "guides":
        show_guide_dashboard(conn)
    elif role == "coaches":
        show_coach_dashboard(conn)
    elif role == "vets":
        show_vet_dashboard(conn)
    elif role == "sanctuary staff":
        show_sanctuary_staff_dashboard(conn)

#----------------------------------------------------------------------------------------------------------
# Function to show the Caretaker Dashboard
def show_caretaker_dashboard(conn):
    st.title("Caretaker Dashboard - Flora Table")
    flora_query = "SELECT * FROM FLORA;"
    flora_df = fetch_data(conn, flora_query)
    st.dataframe(flora_df)

#----------------------------------------------------------------------------------------------------------
# Function to show the Guide Dashboard
def show_guide_dashboard(conn):
    st.title("Guide Dashboard - Tourist Table, Feedback Table")
    tourist_query = "SELECT * FROM TOURIST;"
    tourist_df = fetch_data(conn, tourist_query)
    feedback_query = "SELECT * FROM VISITS;"
    feedback_df = fetch_data(conn, feedback_query)
    st.dataframe(tourist_df)
    st.dataframe(feedback_df)

#----------------------------------------------------------------------------------------------------------
# Function to show the Coach Dashboard
def show_coach_dashboard(conn):
    st.title("Coach Dashboard - Volunteer and Outreach Program Tables")
    st.header("Volunteer Table")
    volunteer_query = "SELECT * FROM VOLUNTEER;"
    volunteer_df = fetch_data(conn, volunteer_query)
    st.dataframe(volunteer_df)
    st.header("Outreach Program Table")
    program_query = "SELECT * FROM OUTREACH_PROGRAM;"
    program_df = fetch_data(conn, program_query)
    st.dataframe(program_df)


#----------------------------------------------------------------------------------------------------------
# Function to show the Vet Dashboard
def show_vet_dashboard(conn):
    st.title("Vet Dashboard - Wildlife Table")
    wildlife_query = "SELECT * FROM WILDLIFE;"
    wildlife_df = fetch_data(conn, wildlife_query)
    st.dataframe(wildlife_df)

#----------------------------------------------------------------------------------------------------------
# Function to show the Sanctuary Staff Dashboard
def show_sanctuary_staff_dashboard(conn):
    st.title("Sanctuary Staff Dashboard - Habitat Table")
    habitat_query = "SELECT * FROM HABITAT;"
    habitat_df = fetch_data(conn, habitat_query)
    st.dataframe(habitat_df)

#----------------------------------------------------------------------------------------------------------
# Function to fetch data from the EMPLOYEE table
def fetch_employee_data(conn):
    query = 'SELECT * FROM EMPLOYEE;'
    return pd.read_sql_query(query, conn)

#----------------------------------------------------------------------------------------------------------
# Function to add a new employee to the EMPLOYEE table
def add_employee(conn, name, experience, date_joined):
    query = f'''
    INSERT INTO EMPLOYEE (Employee_Name, Experience_Years, Date_Joined)
    VALUES ('{name}', {experience}, '{date_joined}');
    '''
    conn.execute(query)
    conn.commit()

#----------------------------------------------------------------------------------------------------------
# Function to update an employee's information in the EMPLOYEE table
def update_employee(conn, employee_id, new_name, new_experience,new_date_joined):
    query = f'''
    UPDATE EMPLOYEE
    SET Employee_Name = '{new_name}',
        Experience_Years = {new_experience},
        Date_Joined = '{new_date_joined}'
    WHERE Employee_ID = {employee_id};
    '''
    conn.execute(query)
    conn.commit()

#----------------------------------------------------------------------------------------------------------
# Function to delete an employee from the EMPLOYEE table
def delete_employee(conn, employee_id):
    query = f'DELETE FROM EMPLOYEE WHERE Employee_ID = {employee_id};'
    conn.execute(query)
    conn.commit()

#----------------------------------------------------------------------------------------------------------
# Function to show the Admin Dashboard
def show_admin_dashboard(conn):
    st.title("Admin Dashboard")

    # Fetching and displaying the initial employee data
    employee_df = fetch_employee_data(conn)
    st.title("Employee Data Table")
    st.dataframe(employee_df)

    # CRUD operations
    operation = st.selectbox("Select CRUD Operation", ["", "Add Employee", "Update Employee", "Delete Employee"])

    if operation == "Add Employee":
        st.header("Add Employee")
        name = st.text_input("Employee Name:")
        experience = st.number_input("Experience (in years):", min_value=1)
        date_joined = st.date_input("Date Joined:")
        if st.button("Add Employee"):
            add_employee(conn, name, experience, date_joined)
            st.success("Employee added successfully!")

    elif operation == "Update Employee":
        st.header("Update Employee")
        employee_id_update = st.number_input("Employee ID to Update:")
        new_name = st.text_input("Updated Employee Name:")
        new_experience = st.number_input("Updated Experience (in years):", min_value=1)
        new_date_joined = st.date_input("Updated Date Joined:")
        if st.button("Update Employee"):
            update_employee(conn, employee_id_update, new_name, new_experience, new_date_joined)
            st.success("Employee updated successfully!")

    elif operation == "Delete Employee":
        st.header("Delete Employee")
        employee_id_delete = st.number_input("Employee ID to Delete:")
        if st.button("Delete Employee"):
            delete_employee(conn, employee_id_delete)
            st.success("Employee deleted successfully!")

    # Displaying the updated employee data
    updated_employee_df = fetch_employee_data(conn)
    st.title("Updated Employee Data Table")
    st.dataframe(updated_employee_df)


#----------------------------------------------------------------------------------------------------------
# Function to handle employee and admin login
def employee_login(conn):
    st.title("Employee Login")
    set_background()

    if 'logged_in' not in st.session_state:
        st.session_state.logged_in = False

    # Admin login
    if not st.session_state.logged_in:
        role = st.selectbox("Select Role", ["Select Role", "admin", "sanctuary staff", "vets", "guides", "coaches", "caretakers"])
        username = st.text_input("Username:")
        password = st.text_input("Password:", type="password")

        if st.button("Login") and role != "Select Role":
            if authenticate(username, password, role):
                st.session_state.logged_in = True
                st.session_state.role = role
                st.success("Login Successful!")

                if role == "admin":
                    show_admin_dashboard(conn)
                else:
                    show_employee_dashboard(conn, role)
            else:
                st.error("Invalid username or password.")
    else:
        if st.session_state.role == "admin":
            show_admin_dashboard(conn)
        else:
            show_employee_dashboard(conn, st.session_state.role)

        # Logout button
    if st.button("Logout"):
            st.session_state.logged_in = False
            st.experimental_rerun() 

#----------------------------------------------------------------------------------------------------------
if __name__ == "__main__":
    conn = create_connection()
    employee_login(conn)


