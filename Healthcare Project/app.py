import streamlit as st
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# -------------------------------
# Load Data
# -------------------------------
@st.cache_data
def load_data():
    df = pd.read_csv("/Users/ikah/Desktop/Ikah Consulting/Freelance/Portfolio Projects/Healthcare Project/Data/diabetes_readmission.csv")
    df["target"] = df["readmitted"].apply(lambda x: 1 if x == "<30" else 0)
    return df

df = load_data()

# -------------------------------
# Streamlit App Layout
# -------------------------------
st.title("📊 Diabetes Readmission Dashboard")
st.markdown("Analyze readmission trends within 30 days among diabetic patients.")

# Sidebar filter
st.sidebar.header("Filter Options")
age_filter = st.sidebar.multiselect("Select Age Groups", options=df["age"].unique(), default=df["age"].unique())

df_filtered = df[df["age"].isin(age_filter)]

# -------------------------------
# KPI Section
# -------------------------------
total_patients = len(df_filtered)
readmitted_patients = df_filtered["target"].sum()
readmission_rate = round((readmitted_patients / total_patients) * 100, 2)

col1, col2, col3 = st.columns(3)
col1.metric("Total Patients", total_patients)
col2.metric("Readmitted (<30d)", readmitted_patients)
col3.metric("Readmission Rate", f"{readmission_rate}%")

# -------------------------------
# Visualization 1: Readmission by Age
# -------------------------------
st.subheader("Readmission Rate by Age Group")
fig, ax = plt.subplots(figsize=(8,5))
sns.barplot(data=df_filtered, x="age", y="target", estimator=lambda x: sum(x)/len(x), ax=ax)
plt.ylabel("Proportion Readmitted (<30 days)")
plt.xticks(rotation=45)
st.pyplot(fig)

# -------------------------------
# Visualization 2: Readmission by Gender
# -------------------------------
st.subheader("Readmission Rate by Gender")
fig, ax = plt.subplots(figsize=(6,4))
sns.barplot(data=df_filtered, x="gender", y="target", estimator=lambda x: sum(x)/len(x), ax=ax)
plt.ylabel("Proportion Readmitted (<30 days)")
st.pyplot(fig)

# -------------------------------
# Visualization 3: Readmission by Primary Diagnosis
# -------------------------------
st.subheader("Readmission Rate by Primary Diagnosis (Top 10)")
top_diags = df_filtered["diag_1"].value_counts().nlargest(10).index
df_diag = df_filtered[df_filtered["diag_1"].isin(top_diags)]

fig, ax = plt.subplots(figsize=(10,6))
sns.barplot(
    data=df_diag, x="diag_1", y="target",
    estimator=lambda x: sum(x)/len(x), order=top_diags, ax=ax
)
plt.ylabel("Proportion Readmitted (<30 days)")
plt.xlabel("Diagnosis Code")
plt.xticks(rotation=45)
st.pyplot(fig)

# -------------------------------
# Save Option
# -------------------------------
st.download_button(
    label="Download Filtered Data as CSV",
    data=df_filtered.to_csv(index=False),
    file_name="filtered_readmission_data.csv",
    mime="text/csv",
)

