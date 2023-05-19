import streamlit as st
import pandas as pd
from ydata_profiling import ProfileReport
from streamlit_pandas_profiling import st_profile_report

# Set page title and description
st.title("Data Profiling App")
st.subheader("This app lets you perform quick EDA analysis")
st.markdown("<p style='font-size: 14px;'>App created by Chijioke Iwuchukwu</p>", unsafe_allow_html=True)

# File upload
uploaded_file = st.file_uploader("Upload a file", type=["txt", "csv", "xlsx"])

if uploaded_file is not None:
    # Perform data profiling when the button is clicked
   if st.button("Analyze Data", key="analyze_button", help="Perform data profiling", 
                 button_color="primary", text_color="white"):
        st.write("Please wait, the file is currently being processed and might take a few minutes...")
        
        # Read the file
        data = pd.read_csv(uploaded_file) if uploaded_file.name.endswith(".csv") else pd.read_excel(uploaded_file)

        # Perform data profiling with pandas-profiling
        profile = data.ProfileReport(data)

        # Display the profiling report
        st.subheader("Data Profiling Report")
        st.write(profile.to_html(), unsafe_allow_html=True)
        st_profile_report(profile)
