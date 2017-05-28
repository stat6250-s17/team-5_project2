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

[Unique ID Schema] ClassID, GradeLevel,and GenderCode form a Primary 
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

[Unique ID Schema] ClassID, GradeLevel,and GenderCode form a Primary 
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


* setup environmental parameters;

%let ClassEnroll14F12_Data_URL =

https://github.com/stat6250/team-5_project2/blob/master/data/ClassEnrollment14F12.csv?raw=true
;
%let ClassEnroll14M12_Data_URL =

https://github.com/stat6250/team-5_project2/blob/master/data/ClassEnrollment14M12.csv?raw=true
;
%let AssignmentCodes_Data_URL =

https://github.com/stat6250/team-5_project2/blob/master/data/AssignmentCodes.csv?raw=true
;
%let CoursesTaught14_NCLB_Data_URL =

https://github.com/stat6250/team-5_project2/blob/master/data/CoursesTaught14_NCLB.csv?raw=true
;

* load and import raw ClassEnrollment14F12 dataset (12th gr California female students in public s
chools in 2014 and matches class data to student info) over the wire;

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
data ClassEnroll14F12;
    set ClassEnroll14F12_raw;
	drop
	    FileCreated
	;
    retain
	    AcademicYear
		DistrictCode
		SchoolCode
		CountyName
		DistrictName
		SchoolName
		ClassID
		CourseCode
		GradeLevel
		GenderCode
		EnrollNoEthRptd
		EnrollAmInd
		EnrollAsian
		EnrollPacIsl
		EnrollFilipino
		EnrollHispanic
		EnrollAfrAm
		EnrollWhite
		EnrollTwoorMore
		EnrollTotal
		EnrollEL
    ;
run;


* load and import raw ClassEnrollment14M12 dataset (12th gr California male students in public s
chools in 2014 and matches class data to student info) over the wire;

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
data ClassEnroll14M12;
    set ClassEnroll14M12_raw;
	drop
	    FileCreated
	;
    retain
	    AcademicYear
		DistrictCode
		SchoolCode
		CountyName
		DistrictName
		SchoolName
		ClassID
		CourseCode
		GradeLevel
		GenderCode
		EnrollNoEthRptd
		EnrollAmInd
		EnrollAsian
		EnrollPacIsl
		EnrollFilipino
		EnrollHispanic
		EnrollAfrAm
		EnrollWhite
		EnrollTwoorMore
		EnrollTotal
		EnrollEL
    ;
run;
* load and import raw AssignmentCodes dataset (matches course codes to course names) over the wire;

filename tempfile TEMP;
proc http
    method="get"
    url="&AssignmentCodes_Data_URL."
    out=tempfile
    ;
run;
proc import
    out=AssignmentCodes_raw
	datafile=tempfile
    dbms=csv
	replace;
	delimiter=',';
	getnames=yes;
 	guessingrows=100;
run;
data AssignmentCodes;
    set AssignmentCodes_raw;
	drop
	    EffectiveStartDate
		EffectiveEndDate
	;
	retain
	    AssignmentCode
		AssignmentName
		AssignmentType
		AssignmentSubject
		AP_Course
		IB_Course
		CTE_Course
		MeetsUC_CSU_Requirements
	;
run;

* load and import raw CoursesTaught14_NCLB dataset (matches class id to course instructor info) over the wire;

filename tempfile TEMP;
proc http
    method="get"
    url="&CoursesTaught14_NCLB_Data_URL."
    out=tempfile
    ;
run;
proc import
    out=CoursesTaught14_raw
	datafile=tempfile
    dbms=csv
	replace;
	delimiter=',';
	getnames=yes;
 	guessingrows=100;
run;
data CoursesTaught14;
    set CoursesTaught14_raw;
	drop
	    MultipleTeacherCode
		CTE_FundingProvider
		SEID_Indicator
	;
	retain
	    AcademicYear
		DistrictCode
		schoolCode
		CountyName
		DistrictName
		SchoolName
		ClassID
		CourseCode
		ClassCourseID
		UC_CSU_Approved
		NCLB_Core
		NCLB_HQT
		DistanceLearning
		IndependentStudy
		Enrollment
	;
run;

* Print first 50 rows of each file;

proc print data = ClassEnroll14F12(firstobs= 1 obs= 50);
   title 'Class Enrollment of 12th grade Female Students';
run;

proc print data = ClassEnroll14M12(firstobs= 1 obs= 50);
   title 'Class Enrollment of 12th grade Male Students';
run;

proc print data = AssignmentCodes(firstobs= 1 obs= 50);
   title 'Teacher Assignments and Course Codes/Course Names';
run;

proc print data = CoursesTaught14(firstobs= 1 obs= 50);
   title 'Class Data Cross-Referenced With Teacher Info';
run;
