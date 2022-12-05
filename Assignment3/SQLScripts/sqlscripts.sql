# Assignment3

show tables;
show columns from InternshipsAndCoop;

use mastersstudents;

CREATE TABLE STUDENT (StudentID INT NOT NULL PRIMARY KEY, FirstName VARCHAR(50), LastName VARCHAR(50), Gender VARCHAR(5), DeptName VARCHAR (100), College VARCHAR(70), DeptID INT NOT NULL, FeePayment VARCHAR(5), CreditsEarned INT, IntakeSemester VARCHAR(10), IntakeYear INT);
INSERT INTO STUDENT (StudentID, FirstName, LastName, Gender, DeptName, College, DeptID, FeePayment, CreditsEarned, IntakeSemester, IntakeYear) VALUES(1951, "Joshua", "Lewis","M","Information Systems", "College of engineering", 201, "Yes",8, "Fall", 2022);
select * from STUDENT WHERE FirstName = "Joshua";
select * from Student;

ALTER TABLE Student ADD CONSTRAINT FOREIGN KEY (DeptID) REFERENCES COLLEGE (DeptID);

ALTER TABLE Student 
RENAME COLUMN Course TO DeptName;

CREATE TABLE COLLEGE (CollegeName varchar(100) NOT NULL, DeptName varchar(100) NOT NULL, DeptID INT NOT NULL PRIMARY KEY, DeanName varchar(100)NOT NULL);
SELECT * FROM COLLEGE;

CREATE TABLE OnCampusEmployment (JobID int NOT NULL PRIMARY KEY, 
Employer VARCHAR(100) NOT NULL, Location VARCHAR(100) NOT NULL, 
SkillsRequired VARCHAR(100) NOT NULL, SalaryInUSD INT NOT NULL, 
DurationInMonths VARCHAR(100), PostingDate DATETIME, Deadline DATETIME, Vacancy INT);
SELECT * from OnCampusEmployment;
 
CREATE TABLE InternshipsAndCoop 
(JobID INT NOT NULL PRIMARY KEY, JobTitle varchar(500), 
SalaryEstimateLower INT, SalaryEstimateUpper INT, JobDescription varchar(1000), 
Rating FLOAT, CompanyName VARCHAR(500), Location VARCHAR(500), HeadQuaters VARCHAR(500), 
Size varchar(100), FoundedYear INT, TypeofOwnership VARCHAR(500), Industry VARCHAR(500), 
Sector VARCHAR(500), Revenue VARCHAR(500), Competitor VARCHAR(100));

SELECT * FROM InternshipsAndCoop where JobID=2048;

CREATE TABLE EventDetails (EID Int NOT NULL PRIMARY KEY, EName varchar(100), EventHeadID INT NOT NULL, Location varchar(50), Purpose varchar(1000), Dateandtime datetime, FareinUSD int);
SELECT * FROM EventDetails;

ALTER TABLE EventDetails ADD CONSTRAINT FOREIGN KEY (EventHeadID) REFERENCES Student (StudentID);

Create TABLE StudentClub (ClubID int NOT NULL primary KEY, ClubName Varchar(100), StudentID INT NOT NULL, Contacts Varchar(100), Motive varchar(1000));
select * fROM StudentClub;

ALTER TABLE StudentClub ADD CONSTRAINT FOREIGN KEY (StudentID) REFERENCES Student (StudentID);

CREATE TABLE StudentOnCampus(StudentID INT NOT NULL, JobID INT);
SELECT * FROM StudentOnCampus;

ALTER TABLE StudentOnCampus ADD CONSTRAINT FOREIGN KEY (StudentID) REFERENCES Student (StudentID);


CREATE TABLE StudentJob (StudentID INT NOT NULL, JobID int NOT NULL);
select * from StudentJob;

ALTER TABLE StudentJob ADD CONSTRAINT FOREIGN KEY (StudentID) REFERENCES Student (StudentID);
#ALTER TABLE StudentJob ADD CONSTRAINT FOREIGN KEY (JobID) REFERENCES InternshipsAndCoop (JobID);


# Assignment3 Questions

#1 Display count of students in each department
SELECT s.DeptName, Count(FirstName) FROM Student s INNER JOIN College c ON s.DeptID=c.DeptID 
GROUP BY s.DeptID, c.DeptID ORDER BY Count(FirstName);

#2 Which college has more number of student head?
SELECT College,Count(College) AS NumberOfStudentHeads FROM Student s INNER JOIN StudentClub sc ON s.StudentID=sc.StudentID 
GROUP BY s.College ORDER BY College;

# Example for question 2
SELECT College, s.StudentID FROM Student s INNER JOIN StudentClub sc ON s.StudentID=sc.StudentID WHERE s.College="School of Law";

#3 Number of students who got coop
SELECT sj.JobID, COUNT(s.StudentID) AS NumberOfStudents FROM Student s INNER JOIN StudentJob sj ON s.StudentID=sj.StudentID 
GROUP BY sj.JobID ORDER BY JobID;

#4 Which department got maximum placements?
SELECT s.DeptID, s.DeptName, COUNT(sj.JobID) AS NumberOfStudents FROM Student s INNER JOIN StudentJob sj ON s.StudentID=sj.StudentID 
GROUP BY s.DeptID ORDER BY COUNT(sj.JobID) DESC;

#5 Average salary offered to students in each department
SELECT s.DeptName, s.DeptID, AVG(i.SalaryEstimateUpper) AS Average 
FROM Student s INNER JOIN StudentJob sj ON s.StudentID = sj.StudentID 
INNER JOIN InternshipsAndCoop i on sj.JobID = i.JobID GROUP BY s.deptname;

#6 Maximum number of JobOpenings
SELECT JobID, JobTitle, MAX(mycount) AS Maximum_Number_Of_Job_Openings FROM
(SELECT COUNT(JobTitle) mycount, JobTitle, JobID FROM InternshipsAndCoop GROUP BY JobTitle) as sample;

#7 Job Count for each intake
SELECT s.IntakeSemester, s.IntakeYear, COUNT(sj.StudentID) FROM Student s INNER JOIN StudentJob sj ON s.StudentID=sj.StudentID 
GROUP BY s.IntakeSemester, s.IntakeYear;

#8 Booming Industry
SELECT ic.Industry, COUNT(ic.Industry) BoomingIndustry FROM InternshipsAndCoop ic INNER JOIN StudentJob sj ON ic.JobID=sj.JobID 
GROUP BY ic.Industry ORDER BY COUNT(ic.Industry) DESC;

#9 Which Second Highest Salary
SELECT MAX(SalaryEstimateUpper) AS Second_Highest_Salary from InternshipsAndCoop  WHERE SalaryEstimateUpper < (SELECT Max(SalaryEstimateUpper) FROM InternshipsAndCoop);

#10 Students who got internship and oncampus
SELECT sj.StudentID FROM StudentOnCampus soc INNER JOIN StudentJob sj ON soc.StudentID=sj.StudentID;
