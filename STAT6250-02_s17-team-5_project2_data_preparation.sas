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

[Unique ID Schema] DistrictCode, SchoolCode, ClassID, and CourseCode� form a Primary 
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


* setup environmental parameters;

%let inputDataset1URL =

https://github.com/stat6250/team-5_project2/blob/master/data/ClassEnrollment14F12.csv?raw=true
;
%let inputDataset1Type = CSV;
%let inputDataset1DSN = ClassEnroll14F12;

%let inputDataset2URL =

https://github.com/stat6250/team-5_project2/blob/master/data/ClassEnrollment14M12.csv?raw=true
;
%let inputDataset2Type = CSV;
%let inputDataset2DSN = ClassEnroll14M12;

%let inputDataset3URL =

https://github.com/stat6250/team-5_project2/blob/master/data/AssignmentCodes.csv?raw=true
;
%let inputDataset3Type = CSV;
%let inputDataset3DSN = AssignmentCodes;

%let inputDataset4URL =

https://github.com/stat6250/team-5_project2/blob/master/data/CoursesTaught14_NCLB.csv?raw=true
;
%let inputDataset4Type = CSV;
%let inputDataset4DSN = CoursesTaught14_NCLB;


* load raw datasets over the wire;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;

        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile "%sysfunc(getoption(work))/tempfile";
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import out=&dsn.
                file=tempfile
                dbms=&filetype. replace;
				getnames=yes;
 				guessingrows=1000;
            run;

            filename tempfile clear;
        %end;

%mend;
options spool;

%loadDataIfNotAlreadyAvailable(
    &inputDataset1DSN.,
    &inputDataset1URL.,
    &inputDataset1Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset2DSN.,
    &inputDataset2URL.,
    &inputDataset2Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset3DSN.,
    &inputDataset3URL.,
    &inputDataset3Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset4DSN.,
    &inputDataset4URL.,
    &inputDataset4Type.
)


* sort and check raw datasets for duplicates with respect to their unique ids,
  removing blank rows, if needed;

proc sort
        nodupkey
        data=ClassEnroll14F12
        dupout=ClassEnroll14F12_dups
        out=ClassEnroll14F12_sorted
    ;
    by
		DistrictCode
		SchoolCode
		ClassID
		CourseCode;
run;
proc sort
        nodupkey
        data=ClassEnroll14M12
        dupout=ClassEnroll14M12_dups
        out=ClassEnroll14M12_sorted
    ;
    by	
		DistrictCode
		SchoolCode
		ClassID
		CourseCode;
run;
proc sort
        nodupkey
        data=AssignmentCodes
        dupout=AssignmentCodes_dups
        out=AssignmentCodes_sorted
    ;
    by
		AssignmentCode;
run;
proc sort
        nodupkey
        data=CoursesTaught14_NCLB
        dupout=CoursesTaught14_NCLB_dups
        out=CoursesTaught14_NCLB_sorted
    ;
    by
        ClassID;
run;

data ClassEnroll14F12_raw;
    set ClassEnroll14F12_sorted;
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

data ClassEnroll14M12_raw;
    set ClassEnroll14M12_sorted;
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

data AssignmentCodes_raw;
    set AssignmentCodes_sorted;
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

data CoursesTaught14_NCLB_raw;
    set CoursesTaught14_NCLB_sorted;
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

* Concatenate male and female student enrollment files;

 data all_student_enrollment;
	length
		DistrictName $39.
		SchoolName	$52.
		ClassID	$19.
    ;
	format
		DistrictName $39.
		SchoolName	$52.
		ClassID	$19.
    ;

	set ClassEnroll14M12_raw ClassEnroll14F12_raw;
 run;
 
proc sort data=Assignmentcodes_raw;
	by AssignmentCode;
run;

proc sort data=Coursestaught14_nclb_raw;
	by CourseCode;
run;

data Course_Teacher_Info;
	merge Coursestaught14_nclb_raw AssignmentCodes_raw(rename=(AssignmentCode=CourseCode));
	by CourseCode;
run;
proc sort data=all_student_enrollment;
	by CourseCode;
run;
data ap_math_students;
	merge Course_Teacher_Info all_student_enrollment;
	by CourseCode;
		if AssignmentSubject='Mathematics';
			if AP_Course='Y';

run;

data ap_math_summary_by_ethnicity
	(keep=
	American_Indian
	Asian
	Pacific_Islander
	Filipino
	Hispanic
	African_American
	White
	Two_or_More);

	set ap_math_students end=last;

	format 
	American_Indian
	Asian
	Pacific_Islander
	Filipino
	Hispanic
	African_American
	White
	Two_or_More percent8.2;
	
	EnrollAmInd_Sum+EnrollAmInd;
	EnrollAsian_Sum+EnrollAsian;
	EnrollPacIsl_Sum+EnrollPacIsl;
	EnrollFilipino_Sum+EnrollFilipino;
	EnrollHispanic_Sum+EnrollHispanic;
	EnrollAfrAm_Sum+EnrollAfrAm;
	EnrollWhite_Sum+EnrollWhite;
	EnrollTwoorMore_Sum+EnrollTwoorMore;
	EnrollTotal_Sum+EnrollTotal;

	American_Indian=EnrollAmInd_Sum/EnrollTotal_Sum;
	Asian=EnrollAsian_Sum/EnrollTotal_Sum;
	Pacific_Islander=EnrollPacIsl_Sum/EnrollTotal_Sum;
	Filipino=EnrollFilipino_Sum/EnrollTotal_Sum;
	Hispanic=EnrollHispanic_Sum/EnrollTotal_Sum;
	African_American=EnrollAfrAm_Sum/EnrollTotal_Sum;
	White=EnrollWhite_Sum/EnrollTotal_Sum;
	Two_or_More=EnrollTwoorMore_Sum/EnrollTotal_Sum;

	if last;

	run;

data ap_math_students_by_gender noobs

	(keep=
		Female_Enrollment
		Male_Enrollment);

	set ap_math_students end=last;

	format 
	Female_Enrollment
	Male_Enrollment percent8.2;

	if GenderCode='F' then
		EnrollFemale_Sum+EnrollTotal;
	else if GenderCode='M' then
		EnrollMale_Sum+EnrollTotal;

	EnrollTotal_Sum+EnrollTotal;

	Female_Enrollment=EnrollFemale_Sum/EnrollTotal_Sum;
	Male_Enrollment=EnrollMale_Sum/EnrollTotal_Sum;

	if last;

	run;
proc sort data=ap_math_students out=ap_math_students_by_district;
	by DistrictName;
run;
proc means noprint data=ap_math_students_by_district;
    var EnrollTotal;
    by DistrictName;
    output out=summary_by_district sum(EnrollTotal)=DistrictAPEnrollment;
run;
proc sort data=summary_by_district out=ap_summary_by_district;
	by descending DistrictAPEnrollment;
run;
proc freq data=ap_summary_by_district noprint;
	by descending DistrictAPEnrollment;
	tables DistrictName*DistrictAPEnrollment / out=DistrictAPTotals;
	data DistrictAPTotals;
	set DistrictAPTotals(obs=10);
run;
proc sort data=ap_math_students out=ap_math_students_by_school;
	by SchoolName;
run;
proc means noprint data=ap_math_students_by_school;
    var EnrollTotal;
    by SchoolName;
    output out=summary_by_school sum(EnrollTotal)=SchoolAPEnrollment;
run;
proc sort data=summary_by_school out=ap_summary_by_school;
	by descending SchoolAPEnrollment;
run;
proc freq data=ap_summary_by_school noprint;
	by descending SchoolAPEnrollment;
	tables SchoolName*SchoolAPEnrollment / out=SchoolAPTotals;
	data SchoolAPTotals;
	set SchoolAPTotals(obs=10);
run;


