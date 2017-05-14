*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
[Dataset 1 Name] ClassEnrollment14F12

[Dataset Description] This dataset pertains to Class Enrollment records
for 2014 forstudents by gender and ethnicity and by type of course and 
specific class. A record is created for every class, gender and ethnicity 
in a school that has students enrolled on Information Day and includes 
unduplicated count of students in a class. From this dataset, which
was too large to upload to Github, 2 smaller files were created in 
Escel - one pertaining to class enrollment by 12th grade female students
and one pertaining to class enrollment by 12th grade male students.

[Experimental Unit Description] Schools within California 

[Number of Observations]1638659              [Number of Features] 23

[Data Source]http://www3.cde.ca.gov/download/dq/ClassEnrollment14.zip

[Data Dictionary]http://www.cde.ca.gov/ds/sd/df/fsclassenroll.asp

[Unique ID Schema] ‚ÄúDistrictCode, Schoolcode, ClassID, Coursecode, 
ClassCourseIDù are all form a Primary key, a unique ID.

--

[Dataset 2 Name] ClassEnrollment14M12

[Dataset Description] This dataset pertains to Class Enrollment records
for 2014 forstudents by gender and ethnicity and by type of course and 
specific class. A record is created for every class, gender and ethnicity 
in a school that has students enrolled on Information Day and includes 
unduplicated count of students in a class. From this dataset, which
was too large to upload to Github, 2 smaller files were created in 
Escel - one pertaining to class enrollment by 12th grade female students
and one pertaining to class enrollment by 12th grade male students.

[Experimental Unit Description] Schools within California 

[Number of Observations]1638659              [Number of Features] 23

[Data Source]http://www3.cde.ca.gov/download/dq/ClassEnrollment14.zip

[Data Dictionary]http://www.cde.ca.gov/ds/sd/df/fsclassenroll.asp

[Unique ID Schema] ‚ÄúDistrictCode, Schoolcode, ClassID, Coursecode, 
ClassCourseIDù are all form a Primary key, a unique ID.

--

[Dataset 3 Name] StaffAssign14
[Dataset Description] This table contains the structure for the staff assignment 
record. This file contains specific assignment data for all K-12 California 
public education certificated teachers, administrators, and pupil services 
personnel.



--
[Dataset 4 Name] CourseEnrollment14
[Dataset Description] The table contains the file structure for the Class Section 
Enrollment record. A record is created for every class, class section, grade, 
and gender category that has student enrolled on Information Day.

[Experimental Unit Description] Schools within California 
[Number of Observations]2981687                [Number of Features] 23
[Data Source]http://www3.cde.ca.gov/download/dq/CourseEnroll14.zip
[Data Dictionary]http://www.cde.ca.gov/ds/sd/df/fsclassectionenr12.asp
[Unique ID Schema] ‚ÄúDistrictCode, Schoolcode, ClassID, CourseCode, 
ClassCourseIDù are all form a Primary key, a unique ID.

--
[Dataset 1 Name] ClassEnrollment14MF

[Dataset Description] This dataset pertains to Class Enrollment records
for 2014 forstudents by gender and ethnicity and by type of course and 
specific class. A record is created for every class, gender and ethnicity 
in a school that has students enrolled on Information Day and includes 
unduplicated count of students in a class. From this dataset, which
was too large to upload to Github, 2 smaller files were created in 
Escel - one pertaining to class enrollment by 12th grade female students
and one pertaining to class enrollment by 12th grade male students.

[Experimental Unit Description] Schools within California 

[Number of Observations]1638659              [Number of Features] 23

[Data Source]http://www3.cde.ca.gov/download/dq/ClassEnrollment14.zip

[Data Dictionary]http://www.cde.ca.gov/ds/sd/df/fsclassenroll.asp

[Unique ID Schema] ‚ÄúDistrictCode, Schoolcode, ClassID, Coursecode, 
ClassCourseIDù are all form a Primary key, a unique ID.
;


* setup environmental parameters;

%let ClassEnroll14F12_Data_URL =

https://github.com/stat6250/team-5_project2/blob/master/ClassEnrollment14F12.csv?raw=true
;
%let ClassEnroll14M12_Data_URL =

https://github.com/stat6250/team-5_project2/blob/master/ClassEnrollment14M12.csv?raw=true
;

* load and import raw ClassEnrollment14F12 dataset (12th gr California female students in public s
chools in 2014) over the wire;

filename tempfile TEMP;
proc http
    method="get"
    url="&ClassEnroll14F12_Data_URL."
    out=tempfile
    ;
run;
proc import
    out=ClassEnroll14F12_raw
	datafile=tempfile
    dbms=csv
	replace;
	delimiter=',';
	getnames=yes;
 	guessingrows=100;
run;

* load and import raw ClassEnrollment14M12 dataset (12th gr California male students in public s
chools in 2014) over the wire;

filename tempfile TEMP;
proc http
    method="get"
    url="&ClassEnroll14M12_Data_URL."
    out=tempfile
    ;
run;
proc import
    out=ClassEnroll14M12_raw
	datafile=tempfile
    dbms=csv
	replace;
	delimiter=',';
	getnames=yes;
 	guessingrows=100;
run;
* Print first 50 rows of each file;

proc print data = ClassEnroll14F12_raw(firstobs= 1 obs= 50);
   title 'Class Enrollment of 12th grade Female Students';
run;

proc print data = ClassEnroll14M12_raw(firstobs= 1 obs= 50);
   title 'Class Enrollment of 12th grade Male Students';
run;
