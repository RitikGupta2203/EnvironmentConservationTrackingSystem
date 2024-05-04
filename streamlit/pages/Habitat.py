# Habitat page

#----------------------------------------------------------------------------------------------------------
# Importing libraries
import streamlit as st
import random
import os
from PIL import Image
import sqlite3
import pandas as pd
import base64

#----------------------------------------------------------------------------------------------------------
#setting background 
def set_background():
    bin_file = "./data/habitat.png"
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
# Function to fetch data from the HABITAT table
def fetch_habitat_data(habitat_type):
    conn = sqlite3.connect("./sql/wildlife.db")
    query = f"SELECT * FROM HABITAT WHERE Habitat_Type = '{habitat_type}'"
    habitat_data = pd.read_sql_query(query, conn)
    conn.close()
    return habitat_data

#----------------------------------------------------------------------------------------------------------
# Function to fetch flora data based on the habitat type
def fetch_flora_data(habitat_type):
    conn = sqlite3.connect("./sql/wildlife.db")
    query = f"SELECT * FROM FLORA WHERE Habitat_Type = '{habitat_type}'"
    flora_data = pd.read_sql_query(query, conn)
    conn.close()
    return flora_data

#----------------------------------------------------------------------------------------------------------
# Function to fetch wildlife data based on the habitat type
def fetch_wildlife_data(habitat_type):
    conn = sqlite3.connect("./sql/wildlife.db")
    query = f"SELECT * FROM WILDLIFE WHERE Habitat_Type = '{habitat_type}'"
    wildlife_data = pd.read_sql_query(query, conn)
    conn.close()
    return wildlife_data

#----------------------------------------------------------------------------------------------------------
# Funtionality of the whole page
def habitat_page():
    st.title("Habitat Page")
    set_background()
    habitat_type_options = ["Select Habitat Type", "Wetland", "Rainforest", "High Altitude Plateau"]
    habitat_type = st.selectbox("Select Habitat Type", habitat_type_options)
    if habitat_type == "Select Habitat Type":
        st.warning("Please select a habitat type.")
        return

    # Fetching the climatic conditions for the selected habitat type
    habitat_data = fetch_habitat_data(habitat_type)
    st.subheader("Climatic Conditions")
    st.write(f"pH Level: {habitat_data['PH_Level'].values[0]}, "
             f"Temperature: {habitat_data['Temperature'].values[0]}°C, "
             f"Humidity: {habitat_data['Humidity'].values[0]}%, "
             f"Air Purity: {habitat_data['Air_Purity'].values[0]}%, "
             f"Soil Fertility: {habitat_data['Soil_Fertility'].values[0]}")

    # Option to choose between flora and fauna
    category = st.radio("Select Category", ["Flora", "Wildlife"])

    # Display flora or wildlife data based on the selected category and habitat type
    if category == "Flora":
        st.subheader(f"{habitat_type} Flora Species")
        flora_data = fetch_flora_data(habitat_type)
        for index, row in flora_data.iterrows():
            st.write(f"Species: {row['Species']}")
    else:
        st.subheader(f"{habitat_type} Wildlife Species")
        wildlife_data = fetch_wildlife_data(habitat_type)
        for index, row in wildlife_data.iterrows():
            st.write(f"Species: {row['Species']}, Type: {row['Wildlife_Type']}, Population: {row['Population']}")


if __name__ == "__main__":
    habitat_page()
