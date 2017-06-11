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
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic datasets ClassEnrollment14F12.csv,
  ClassEnrollment14M12.csv, and CoursesTaught14_NCLB.csv;
%include ".\STAT6250-02_s17-team-5_project2_data_preparation.sas";

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
title1 justify=left
'[Research Question 1] What is the ethnic breakdown of students in AP math classes?'
;

title2 justify=left
'Rationale: This study investigates the proportions of minority student participation in advanced math classes.' 
;

footnote1 justify=left
"The data shows that AP Math classes are dominated by Whites (32%) and Asians (30%), but that representation by Hispanic students is nearly on a par, at 27%. African-American (3%), Pacific Islander (<1%), American Indian (<1%), Filipino (5%), and students self-identified as being of 2 or more ethnicities (3%) continue to be poorly represented." 
;

footnote2 justify=left
"Further investigation would be necessary to investigate proportions of each demographic in schools of high and low socioeconomic status to determine access to pathways to higher math in communities according to economic opportunity." 
;

footnote3 justify=left
"However the data indicates that Hispanic students are catching up proportionally. The question remains as to whether it is because of an overall increase in the Hispanic population overall, or an increase in opportunity in low-income commmunities or improved access to the curriculum for English language learners."
;

*
Note: This compares the accumulated values in columns EnrollNoEthRptd, 
EnrollAmInd, EnrollAsian, EnrollPacIsl, EnrollFilipino, EnrollHispanic, 
EnrollAfrAm, EnrollWhite, EnrollTwoorMore,in the merged files for male and 
female 12th-grade enrollment with accumulated values for EnrollTotal.

Methodology: Male and female enrollment files were combined to create a master
student file, then course data and teacher assignment data were combined to 
form a master file about course and teacher info. Finally, those two files were
merged and then used to investigate these research questions to subset into
relevant specific datasets.

Limitations: This methodology does not account for schools with missing data,
nor does it attempt to validate data in any way.

Followup Steps: More carefully clean values in order to filter out any possible
illegal values, and better handle missing data, e.g., by using a previous year's
data or a rolling average of previous years' data as a proxy.
;
	
proc print data=ap_math_summary_by_ethnicity noobs;
	var
	American_Indian
	Asian
	Pacific_Islander
	Filipino
	Hispanic
	African_American
	White
	Two_or_More;

run;

title;
footnote;

title1 justify=left
'[Research Question 2] What is the percentage participation of male v. female students in AP math classes?' 
;

title2 justify=left
'Rationale: This determines whether there is gender parity in access to and participation in advanced math classes.' 
;

footnote1 justify=left
"The data shows that gender parity in AP Math classes is nearly 50-50, with female representation approximately 1% greater (50.4%:49.6%)." 
;

footnote2 justify=left
"Further investigation would be necessary to investigate proportions of each demographic in regards to gender equity." 
;

footnote3 justify=left
"However the data indicates that female students are enrolling in AP Math classes overall on a par with male students." 
;

*
Note: This compares the accumulated values in the accumulated EnrollTotal 
columns respectively for male and female 12th-grade enrollment with 
accumulated values for EnrollTotal overall.

Methodology: Male and female enrollment files were combined to create a master
student file, then course data and teacher assignment data were combined to 
form a master file about course and teacher info. Finally, those two files were
merged and then used to investigate these research questions to subset into
relevant specific datasets.

Limitations: This methodology does not account for schools with missing data,
nor does it attempt to validate data in any way.

Followup Steps: More carefully clean values in order to filter out any possible
illegal values, and better handle missing data, e.g., by using a previous year's
data or a rolling average of previous years' data as a proxy.
;

proc print data=ap_math_students_by_gender noobs;
	var
	Female_Enrollment
	Male_Enrollment;

run;

title;
footnote;


title1 justify=left
'[Research Question 3] What are the top 10 districts and top 10 schools in terms of students enrolled in AP math classes?' 
;

title2 justify=left
'Rationale: This would determine access to high-quality math education socio-economic factors by district and school.' 
;

title3 'AP Math Enrollment by District'
;

*
Note: This sorts summed TotalEnroll by District and by School in descending order
and takes the top 10 performing districts and schools by AP Math enrollment.

Methodology: Male and female enrollment files were combined to create a master
student file, then course data and teacher assignment data were combined to 
form a master file about course and teacher info. Finally, those two files were
merged and then used to investigate these research questions to subset into
relevant specific datasets.

Limitations: This methodology does not account for schools with missing data,
nor does it attempt to validate data in any way.

Followup Steps: More carefully clean values in order to filter out any possible
illegal values, and better handle missing data, e.g., by using a previous year's
data or a rolling average of previous years' data as a proxy.
;
	
*
[Reason for Choice]To explore access to access and opportunity in higher math education.
;


proc print data=DistrictAPTotals;

run;

title;

title1 'AP Math Enrollment by School'
;

footnote1 justify=left
"The data shows a surprisingly high enrollment in the known low-income, majority Hispanic district of East Side Union High School District in East San Jose. The remaining districts are familiar enclaves of typically high socio-economic status." 
;

footnote2 justify=left
"Further investigation would be necessary to investigate proportions of each demographic cross-tabulated with socioeconomic status to determine access to pathways to higher math in communities according to economic opportunity." 
;

footnote3 justify=left
"However the data indicates again that Hispanic students are catching up proportionally. The question remains as to whether it is because of an overall increase in the Hispanic population overall, or an increase in opportunity in low-income commmunities or improved access to the curriculum for English language learners or perhaps because of East Side Union's proximity to opportunities in Silicon Valley." 
;

proc print data=SchoolAPTotals;

run;


title;
footnote;
