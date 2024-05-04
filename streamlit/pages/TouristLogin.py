# Tourist page

#----------------------------------------------------------------------------------------------------------
# Importing libraries
import streamlit as st
import sqlite3
from datetime import datetime
import base64

#----------------------------------------------------------------------------------------------------------
#setting background 
def set_background():
    bin_file = "./data/tourist.png"
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
# Establish a connection to the SQLite database
conn = sqlite3.connect("./sql/wildlife.db")
cursor = conn.cursor()

#----------------------------------------------------------------------------------------------------------
# Function to save feedback information to the VISITS table
def save_feedback_info(tourist_name, date_of_visit, feedback):
    cursor.execute("SELECT Tourist_Id FROM TOURIST WHERE Tourist_Name = ?", (tourist_name,))
    tourist_id = cursor.fetchone()

    if tourist_id:
        tourist_id = tourist_id[0]

        cursor.execute("""
            SELECT Date_of_Visit, Feedback
            FROM VISITS
            WHERE Tourist_Id = ?
            ORDER BY Date_of_Visit DESC
            LIMIT 1
        """, (tourist_id,))
        previous_visit = cursor.fetchone()

        if previous_visit:
            st.write(f"Previous Visit Date: {previous_visit[0]}")
            st.write(f"Previous Feedback: {previous_visit[1]}")


            update_info = st.checkbox("Update Date and Feedback")

            if update_info:

                cursor.execute("""
                    UPDATE VISITS
                    SET Date_of_Visit = ?, Feedback = ?
                    WHERE Tourist_Id = ?
                """, (date_of_visit, feedback, tourist_id))
                conn.commit()
                st.success("Visit information updated successfully!")
            else:
                st.info("No changes made.")
        else:

            cursor.execute("""
                INSERT INTO VISITS (Tourist_Id, Date_of_Visit, Feedback)
                VALUES (?, ?, ?)
            """, (tourist_id, date_of_visit, feedback))
            conn.commit()
            st.success("Feedback submitted successfully!")

    else:
        st.error("Tourist not found.")

#----------------------------------------------------------------------------------------------------------
# Function to display the whole page
def tourist_login_page():
    st.title("Tourist Login Page")
    set_background()
    st.header("User Data")

    tourist_name = st.text_input("Tourist Name")


    cursor.execute("SELECT Tourist_Id FROM TOURIST WHERE Tourist_Name = ?", (tourist_name,))
    tourist_id = cursor.fetchone()

    if tourist_id:
        tourist_id = tourist_id[0]

        cursor.execute("""
            SELECT Date_of_Visit, Feedback
            FROM VISITS
            WHERE Tourist_Id = ?
            ORDER BY Date_of_Visit DESC
            LIMIT 1
        """, (tourist_id,))
        previous_visit = cursor.fetchone()

        date_of_visit_default = None
        feedback_default = None

        if previous_visit:
            date_of_visit = datetime.strptime(previous_visit[0], "%Y-%m-%d")
            feedback = previous_visit[1]

            st.write(f"Previous Visit Date: {date_of_visit.strftime('%Y-%m-%d')}")
            st.write(f"Previous Feedback: {feedback}")


        date_of_visit = st.date_input("Date of Visit", min_value=datetime(1900, 1, 1), max_value=datetime.today(), value=date_of_visit_default)
        feedback = st.text_area("Write your feedback here", value=feedback_default)

        update_info = st.button("Update Date and Feedback")

        if update_info:
            cursor.execute("""
                UPDATE VISITS
                SET Date_of_Visit = ?, Feedback = ?
                WHERE Tourist_Id = ?
            """, (date_of_visit.strftime('%Y-%m-%d'), feedback, tourist_id))
            conn.commit()
            st.success("Visit information updated successfully!")

        else:
            st.info("No changes made.")

    elif tourist_name:
        st.error("Tourist not found.")

#----------------------------------------------------------------------------------------------------------
# Run the Tourist Login page
if __name__ == "__main__":
    tourist_login_page()

conn.close()
