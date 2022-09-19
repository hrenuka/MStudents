# MStudents
Student Profile Management System
 
Table 1: students
StId, StName, Course, Skills, FeePayment, CreditsEarned, IntakeYear
Table 2: College
DeptId, DeptName, DeanName, CoursesOffered  
Table 3: On Campus employment
JobId, Location, Skills Req, Salary, Duration, PostingDate, Deadline
Table 4: internships/co op
JobId, Location, Skills Req, Salary, Duration, PostingDate, Deadline, Duration
Table 5: events
EId, ELocation, EPurpose

Conceptual Idea:

The main objective of this project is to keep track of students' profiles like their personal details, school details and the skills that they will gain throughout the course, etc. Events purpose and the information of students who attend some events will be stored in the Events database. In addition to that, we will also manage their profile and help them fetch better career opportunities both on-campus and full time jobs. Datasheets of students will be fetched from Kaggle and other web sources. For career opportunities, data scraping will be done with the help of Indeed. All the data will be stored in MS Excel.  After collecting the appropriate data, data filtration will be done in order to extract to SQL tables.
