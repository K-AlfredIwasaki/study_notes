# download the zip file
wget -O /home/w205/hospitalstuff.zip "https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"

# unzip it
unzip /home/w205/hospitalstuff.zip

# rename the files and remove the header in each file
tail -n+2 "Hospital General Information.csv" > hospitals.csv
tail -n+2 "Timely and Effective Care - Hospital.csv" > effective_care.csv
tail -n+2 "Readmissions and Deaths - Hospital.csv" > readmissions.csv
tail -n+2 "Measure Dates.csv" > measures.csv
tail -n+2 "hvbp_hcahps_11_10_2016.csv" > survey_responses.csv

# create directories
hdfs dfs -mkdir /user/w205/exercise_1
hdfs dfs -mkdir /user/w205/exercise_1/hospitals_compare
hdfs dfs -mkdir /user/w205/exercise_1/hospitals_compare/hospitals
hdfs dfs -mkdir /user/w205/exercise_1/hospitals_compare/effective_care
hdfs dfs -mkdir /user/w205/exercise_1/hospitals_compare/readmissions
hdfs dfs -mkdir /user/w205/exercise_1/hospitals_compare/measures
hdfs dfs -mkdir /user/w205/exercise_1/hospitals_compare/survey_responses

# load the file to the directories
hdfs dfs -put hospitals.csv /user/w205/exercise_1/hospitals_compare/hospitals
hdfs dfs -put effective_care.csv /user/w205/exercise_1/hospitals_compare/effective_care
hdfs dfs -put readmissions.csv /user/w205/exercise_1/hospitals_compare/readmissions
hdfs dfs -put measures.csv /user/w205/exercise_1/hospitals_compare/measures
hdfs dfs -put survey_responses.csv /user/w205/exercise_1/hospitals_compare/survey_responsesv

