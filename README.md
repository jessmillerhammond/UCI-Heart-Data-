# UCI-Heart-Data-

This contains data from UCI Machine Learning Repository related to heart-disease diagnosis.

  Four datasets from the following four following locationswere concatenated into one file.

     1. Cleveland Clinic Foundation (cleveland.data)
     2. Hungarian Institute of Cardiology, Budapest (hungarian.data)
     3. V.A. Medical Center, Long Beach, CA (long-beach-va.data)
     4. University Hospital, Zurich, Switzerland (switzerland.data)
     

Attribute Information:


age: age in years 
Gender: sex (1 = male; 0 = female) 
cp: chest pain type 
-- Value 1: typical angina 
-- Value 2: atypical angina 
-- Value 3: non-anginal pain 
-- Value 4: asymptomatic 
trestbps: resting blood pressure (in mm Hg on admission to the hospital) 
chol: serum cholestoral in mg/dl 
fbs: (fasting blood sugar > 120 mg/dl) (1 = true; 0 = false) 
restecg: resting electrocardiographic results 
-- Value 0: normal 
-- Value 1: having ST-T wave abnormality (T wave inversions and/or ST elevation or depression of > 0.05 mV) 
-- Value 2: showing probable or definite left ventricular hypertrophy by Estes' criteria 
thalach: maximum heart rate achieved 
exang: exercise induced angina (1 = yes; 0 = no) 
oldpeak = ST depression induced by exercise relative to rest 
slope: the slope of the peak exercise ST segment 
-- Value 1: upsloping 
-- Value 2: flat 
-- Value 3: downsloping 
ca: number of major vessels (0-3) colored by flourosopy 
thal: 3 = normal; 6 = fixed defect; 7 = reversable defect 
num: diagnosis of heart disease (angiographic disease status) 
-- Value 0: < 50% diameter narrowing 
-- Value 1: > 50% diameter narrowing 
(in any major vessel: attributes 59 through 68 are vessels) 


   Each database has the same instance format.  While the databases have 76
   raw attributes, only 14 of them are actually used.  The continuous variables Age, Cholesterol, Resting Blood Pressure, and Maximum Heart Rate were also binned into classes as well as a binary high/low feature.  A binary Heart Disease variable was created from the num: diagnosis of heart disease column, with any value greater than or equal to 1 grouped as having heard disease.

   The authors of the databases have requested:

      ...that any publications resulting from the use of the data include the 
      names of the principal investigator responsible for the data collection
      at each institution.  They would be:

       1. Hungarian Institute of Cardiology. Budapest: Andras Janosi, M.D.
       2. University Hospital, Zurich, Switzerland: William Steinbrunn, M.D.
       3. University Hospital, Basel, Switzerland: Matthias Pfisterer, M.D.
       4. V.A. Medical Center, Long Beach and Cleveland Clinic Foundation:
	  Robert Detrano, M.D., Ph.D.
