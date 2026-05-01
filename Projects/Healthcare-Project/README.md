# Healthcare Analytics Project: Predicting Hospital Readmissions

## Overview
This project analyzes hospital readmissions among diabetic patients using the [UCI Diabetes 130-US hospitals dataset]. Hospital readmissions, especially within 30 days, are costly and often reflect gaps in patient care.
In this project, I analyzed a diabetes readmission dataset (100k+ hospital encounters) to uncover key drivers of readmissions and identify actionable insights for healthcare providers.


## Objectives
	1. Predict likelihood of patient readmission within 30 days.
	2. Identify patient groups most at risk.
	3. Provide recommendations for reducing readmission rates.

## Tools & Methods
	• Python (Pandas, NumPy, Scikit-learn, Matplotlib, Seaborn)
	• Logistic Regression & Random Forest for prediction
	• EDA (Exploratory Data Analysis) for patterns & insights

## Key Insights
1. Readmission Rates by Age
	• Patients 65+ showed the highest likelihood of readmission.
	• Younger groups (under 30) had significantly lower risk.
Implication: Elderly patients may need closer follow-up care and targeted interventions.

2. Readmission by Number of Diagnoses
	• Patients with >6 diagnoses had much higher readmission rates.
	• Multi-morbidity is a strong predictor of hospital return.
Implication: Care coordination programs should focus on patients with multiple chronic conditions.

3. Readmission by Primary Diagnosis
Top 10 most common diagnoses in dataset included:
Circulatory (390–459, 785), Diabetes (250), Respiratory (460–519, 786), Hypertension (401), Kidney Disease (585), etc.
	• Circulatory system issues and diabetes-related admissions had highest readmission rates.
	• Certain conditions (e.g., respiratory diseases) showed moderate readmission levels.
Implication: Hospitals should prioritize disease-specific management programs, especially for diabetes and cardiac patients.

4. Predictive Modeling Results
	• Logistic Regression: ~62% accuracy, limited predictive power.
	• Random Forest: ~75% accuracy, better at capturing complex interactions.
Implication: Ensemble methods like Random Forest can be used in risk stratification tools to flag high-risk patients in real time.

## Conclusions & Recommendations
	1. Target elderly patients for proactive follow-ups and discharge planning.
	2. Flag patients with multiple diagnoses as high risk for readmission.
	3. Prioritize chronic disease programs (diabetes, circulatory, kidney).
	4. Deploy predictive models in hospital systems to guide clinicians on intervention needs.


## 📂 Project Structure
This project demonstrates my ability to use data science in healthcare for real-world impact—blending data cleaning, exploratory analysis, predictive modeling, and business insights.Project structure was as follows:
├── diabetes_readmission.ipynb # Main notebook with code & visuals
├── README.md # Project description
├── requirements.txt # Python dependencies
├── data
