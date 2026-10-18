# Import pandas
import pandas as pd

# Import the dataset
df = pd.read_csv('StudentsPerformance.csv')

#Validate the dataset if loaded properly
print(df.head())
print(df.shape)
print(df.columns)
print(df.describe())
print(df.info())

# Check for NULL values and duplicated records
print(df.isna().sum())
print(df.duplicated().sum())

# ---- DATA CLEANING ---- #

# Check each value for categorical columns
print(df.columns)
print(df['gender'].unique())
print(df['race/ethnicity'].unique())
print(df['parental level of education'].unique())
print(df['lunch'].unique())
print(df['test preparation course'].unique())

# For numerical columns, since it is talking about score, make sure that the range of numbers are from 0 to 100 only
print(df[['math score', 'reading score', 'writing score']].describe())

# Since categorical values are clean per column, change some columns/values to make it simplier (e.g. race/ethinicity to ethnicity group, parental level of education to parent education level)
df.rename(columns={'race/ethnicity':'ethnicity group'}, inplace=True)
df.rename(columns={'parental level of education': 'parent education level'}, inplace=True)
print(df.columns)

# Clean the values for both columns instead of group A, just A, and high school to high school graduate, etc.
df['ethnicity group'] = df['ethnicity group'].replace(
    {'group A':'A',
     'group B': 'B',
     'group C': 'C',
     'group D': 'D',
     'group E': 'E'}
)
df['parent education level'] = df['parent education level'].replace(
    {'some high school':'high school',
     'high school':'high school graduate',
     'some college':'college'
    }
)
print(df['ethnicity group'].unique())
print(df['parent education level'].unique())

# Save the transformed dataset to another csv file for exporting to Power BI
df.to_csv('cleaned_studentsperformance.csv', index=False)