#Homepage
#----------------------------------------------------------------------------------------------------------
# Importing libraries
import streamlit as st 
import base64
from pages import EmployeeLogin, Habitat, OutreachProgram, TouristLogin

#----------------------------------------------------------------------------------------------------------
# Function to set up the background image
def set_background():
    bin_file = "./data/main.png"
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
# Function to set up the Home page
def home():
    set_background()
    st.write("# Welcome 👋")

#----------------------------------------------------------------------------------------------------------
# Function to handle different pages
def main():
    set_background()
    current_page = st.experimental_get_query_params().get("page", ["Home"])[0]

    pages = {
        "Home": home,
        "EmployeeLogin": EmployeeLogin.employee_login,
        "Habitat": Habitat.habitat_page,
        "OutreachProgram": OutreachProgram.outreach_programs_page,
        "TouristLogin": TouristLogin.tourist_login_page,
    }

    if current_page in pages:
        pages[current_page]()
    else:
        default_page = "Home"
        st.experimental_set_query_params(page=default_page)
        pages[default_page]()

if __name__ == "__main__":
    main()
