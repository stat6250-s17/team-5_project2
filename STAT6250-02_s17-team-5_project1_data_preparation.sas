*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
[Dataset 1 Name] StaffAssign14
[Dataset Description] This table contains the structure for the staff assignment record. This file contains specific assignment data for all K-12 California public education certificated teachers, administrators, and pupil services personnel.

[Experimental Unit Description] Schools within California  
[Number of Observations]1142660               [Number of Features] 13
[Data Source]http://www3.cde.ca.gov/download/dq/StaffAssign14.zip
[Data Dictionary] http://www.cde.ca.gov/ds/sd/df/fsstaffassign12.asp
[Unique ID Schema] “DistrictCode, Schoolcode, ClassID, Coursecode” are all form a Primary key, a unique ID.

--
[Dataset 2 Name] CourseEnrollment14
[Dataset Description] The table contains the file structure for the Class Section Enrollment record. A record is created for every class, class section, grade, and gender category that has student enrolled on Information Day.

[Experimental Unit Description] Schools within California 
[Number of Observations]2981687                [Number of Features] 23
[Data Source]http://www3.cde.ca.gov/download/dq/CourseEnroll14.zip
[Data Dictionary]http://www.cde.ca.gov/ds/sd/df/fsclassectionenr12.asp
[Unique ID Schema] “DistrictCode, Schoolcode, ClassID, CourseCode, ClassCourseID” are all form a Primary key, a unique ID.

--
[Dataset 3 Name] ClassEnrollment14
[Dataset Description] The table contains the file structure for the Class Enrollment record. A record is created for every class, gender and ethnicity in a school that has students enrolled on Information Day and includes unduplicated count of students in a class.
[Experimental Unit Description] Schools within California 
[Number of Observations]1638659              [Number of Features] 23
[Data Source]http://www3.cde.ca.gov/download/dq/ClassEnrollment14.zip

[Data Dictionary]http://www.cde.ca.gov/ds/sd/df/fsclassenroll.asp
[Unique ID Schema] “DistrictCode, Schoolcode, ClassID, Coursecode, ClassCourseID” are all form a Primary key, a unique ID.
;


* setup environmental parameters;
