*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
[Dataset 1 Name] ClassEnrollment14F12.csv

[Dataset Description] This dataset pertains to Class Enrollment records
for 2014 forstudents by gender and ethnicity and by type of course and 
specific class. A record is created for every class, gender and ethnicity 
in a school that has students enrolled on Information Day and includes 
unduplicated count of students in a class. From this dataset, which
was too large to upload to Github, this smaller file was created in 
Escel - pertaining to class enrollment by 12th grade female students.
Some column names were shortened and rows that included multiple courses
that would make reading data problematic were deleted.

[Experimental Unit Description] Schools within California 

[Number of Observations]144,893              [Number of Features] 22

[Data Source]http://www3.cde.ca.gov/download/dq/ClassEnrollment14.zip

[Data Dictionary]http://www.cde.ca.gov/ds/sd/df/fsclassenroll.asp

[Unique ID Schema] DistrictCode, SchoolCode, ClassID, and CourseCodeù form a Primary 
key, a unique ID.

--

[Dataset 2 Name] ClassEnrollment14M12.csv

[Dataset Description] This dataset pertains to Class Enrollment records
for 2014 forstudents by gender and ethnicity and by type of course and 
specific class. A record is created for every class, gender and ethnicity 
in a school that has students enrolled on Information Day and includes 
unduplicated count of students in a class. From this dataset, which
was too large to upload to Github, this smaller file was created in 
Escel - pertaining to class enrollment by 12th grade male students.
Some column names were shortened and rows that included multiple courses
that would make reading data problematic were deleted.

[Experimental Unit Description] Schools within California 

[Number of Observations]155,153              [Number of Features] 22

[Data Source]http://www3.cde.ca.gov/download/dq/ClassEnrollment14.zip

[Data Dictionary]http://www.cde.ca.gov/ds/sd/df/fsclassenroll.asp

[Unique ID Schema] DistrictCode, SchoolCode, ClassID, and CourseCode form a Primary 
key, a unique ID.

--

[Dataset 3 Name] AssignmentCodes.csv

[Dataset Description] This dataset contains information pertaining
to staff assignment record. The original dataset contains specific 
assignment categories for all teachers, administrators, and pupil 
services personnel, such as counselors. The subset used for this
file was of school employees specifically assigned as teachers of 
academic classes. It matches unique course codes to course 
descriptions.

[Experimental Unit Description] Schools within California 

[Number of Observations]769             [Number of Features] 10

[Data Source]http://www3.cde.ca.gov/download/dq/AssignmentCodes12On.xls

[Data Dictionary]http://www.cde.ca.gov/ds/sd/df/fsassignmentcode12on.asp

[Unique ID Schema] AssignmentCode is a Primary Key and unique ID.

--
[Dataset 4 Name] CoursesTaught14_NCLB.csv

[Dataset Description] This dataset provides information about teachers
assigned to specific courses and class sections. It has been edited
to upload to Github by filtering for teachers that are NCLB-qualified
(highly qualified by legislative mandate, the "No Child Left Behind"
Act, that requires teachers meet given specifications in terms of 
education and/or teaching experience).

[Experimental Unit Description] Schools within California 

[Number of Observations]36,749                [Number of Features] 18

[Data Source]http://www3.cde.ca.gov/download/dq/CoursesTaught14.zip

[Data Dictionary]http://www.cde.ca.gov/ds/sd/df/fsclassection12.asp

[Unique ID Schema] ClassID is a Primary key, a unique ID.
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))
-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset ClassEnroll14F12_raw,
ClassEnroll14M12_raw, AssignmentCodes_raw, CoursesTaught14_raw ;
%include '.\STAT6250-02_s17-team-5_project2_data_preparation.sas';


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*

[Research Question 1] What is the greatest percentage participation by ethnicity
of students in AP math classes ranked in descending order?
(Rationale: This determines whether minority students are often excluded from 
advanced math classes) 

[Research Question 2] What is the percentage participation of male v. female
students in AP math classes? 
(Rationale: This determines whether there is gender parity in access to and
participation in advanced math classes.) 

[Research Question 3] Which schools ranked in descending order have the
greatest percentages of students in AP math classes?
(Rationale: This would determine possible socio-economic factors by location.) 

[Reason for Choice] There are many issues involving ethnicity and socio-
economic access to higher-level coursework in mathematics.
*
