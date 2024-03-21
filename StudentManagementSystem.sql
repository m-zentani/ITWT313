CREATE DATABASE StudentManagementSystem;

USE StudentManagementSystem;

CREATE TABLE Student (
    stud_ID INT (11) NOT NULL PRIMARY KEY,
    stfname VARCHAR(30),
    stlname VARCHAR(30),
    stcourse VARCHAR(30),
    styear INT CHECK(styear BETWEEN 1 AND 5),
    stcontact VARCHAR(10),
    stage INT CHECK (stage >= 18),
    stbirthdate DATE,
    stgender CHAR(1) CHECK (stgender IN ('M', 'F'))
);

CREATE TABLE Course (
    course_ID INT(7) NOT NULL PRIMARY KEY,
    course_desc TEXT,
    units INT CHECK (units BETWEEN 1 AND 4),
    course_remarks TEXT
);

CREATE TABLE Staff (
   staff_ID INT(11) NOT NULL PRIMARY KEY,
   fname VARCHAR(30),
   lname VARCHAR(30),
   contact VARCHAR(10),
   address VARCHAR(255),
   gender CHAR(1) CHECK (gender IN ('M', 'F'))
);

CREATE TABLE StaffDepartment (
  staff_ID INT(11) NOT NULL PRIMARY KEY, 
  FOREIGN KEY (staff_id) REFERENCES Staff(staff_id), 
  course_line TEXT
);

CREATE TABLE Reports (
  report_ID INT(11) NOT NULL PRIMARY KEY, 
  reports_name VARCHAR(30), 
  student_records TEXT, 
  transaction_reports TEXT
);

CREATE TABLE StudentRegistration (
 registration_ID INT(11) PRIMARY KEY, 
 name VARCHAR(30), 
 content VARCHAR(30), 
 registration_date DATE
);

CREATE TABLE ProjectTransactions (
 transaction_ID INT(11) NOT NULL PRIMARY KEY, 
 transaction_name VARCHAR(30), 
 stud_ID INT(11), FOREIGN KEY (stud_ID) REFERENCES Student(stud_ID),  
 staff_ID INT(11), FOREIGN KEY (staff_ID) REFERENCES Staff(staff_ID),  
 transaction_date DATE
);


INSERT INTO Student(stud_ID, stfname, stlname, stcourse, styear, stcontact, stage, stbirthdate, stgender)
VALUES (04575, 'Mohamed', 'Zentani', 'Web Technologies', 4, '0901112233', 20, '1998-12-01', 'M');

INSERT INTO Course(course_ID, course_desc, units, course_remarks)
VALUES (313, 'قواعد البيانات المتقدمة', 3, 'Basic course');

INSERT INTO Staff(staff_ID, fname, lname, contact, address, gender)
VALUES (1, 'Abdulnasser', 'Diaff', '0987654321', 'Tripoli', 'M');

INSERT INTO StaffDepartment (staff_ID, course_line)
VALUES (1, 'Web Technologies');

INSERT INTO Reports (report_ID, reports_name, student_records, transaction_reports)
VALUES (1, 'Student Report', 'All student records', 'All transactions');

INSERT INTO StudentRegistration (registration_ID, name, content, registration_date)
VALUES (1, 'Registration 1', 'Content 1', '2018-01-01');

INSERT INTO ProjectTransactions (transaction_ID, transaction_name, stud_ID, staff_ID, transaction_date)
VALUES (1, 'Transaction 1', 04575, 1, '2024-03-21');


CREATE VIEW StudentCourseReport AS
SELECT Student.stud_ID, Student.stfname, Student.stlname, Course.course_desc
FROM Student
JOIN ProjectTransactions ON Student.stud_ID = ProjectTransactions.stud_ID
JOIN Course ON Student.stcourse = Course.course_ID;


CREATE VIEW StaffDepartmentReport AS
SELECT Staff.staff_ID, Staff.fname, Staff.lname, StaffDepartment.course_line
FROM Staff
JOIN StaffDepartment ON Staff.staff_ID = StaffDepartment.staff_ID;


CREATE VIEW StudentRegistrationReport AS
SELECT Student.stud_ID, Student.stfname, Student.stlname, StudentRegistration.name, StudentRegistration.content, StudentRegistration.registration_date
FROM Student
JOIN ProjectTransactions ON Student.stud_ID = ProjectTransactions.stud_ID
JOIN StudentRegistration ON ProjectTransactions.transaction_ID = StudentRegistration.registration_ID;