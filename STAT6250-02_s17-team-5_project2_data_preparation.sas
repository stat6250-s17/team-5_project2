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
                out=tempfile;
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
    out=ClassEnroll14F12_sorted;

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
    out=ClassEnroll14M12_sorted;

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
    out=AssignmentCodes_sorted;

    by
        AssignmentCode;
run;
proc sort
    nodupkey
    data=CoursesTaught14_NCLB
    dupout=CoursesTaught14_NCLB_dups
    out=CoursesTaught14_NCLB_sorted;

    by
        ClassID;
run;

* Variables in ClassEnroll14F12_raw and ClassEnroll14M12_raw relating to student 
  enrollment information and student demographics such as self-identified ethnicity 
  and gender by school and district. Set up variables in each file with keep/retain 
  statements;

data ClassEnroll14F12_raw;
    set ClassEnroll14F12_sorted;

    keep
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
        EnrollEL;

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
        EnrollEL;

run;

data ClassEnroll14M12_raw;
    set ClassEnroll14M12_sorted;

    keep
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
        EnrollEL;

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
        EnrollEL;

run;
* Variables in AssignmentCodes relating to class and course description information. 
  Set up variables in each file with keep/retain statements;

data AssignmentCodes_raw;
    set AssignmentCodes_sorted;

    keep
        AssignmentCode
        AssignmentName
        AssignmentType
        AssignmentSubject
        AP_Course
        IB_Course
        CTE_Course
        MeetsUC_CSU_Requirements;

    retain
        AssignmentCode
        AssignmentName
        AssignmentType
        AssignmentSubject
        AP_Course
        IB_Course
        CTE_Course
        MeetsUC_CSU_Requirements;

run;
* Variables in CoursesTaught14_NCLB relating to class and course description information. 
  Set up variables in each file with keep/retain statements;

data CoursesTaught14_NCLB_raw;
    set CoursesTaught14_NCLB_sorted;

    keep
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
        Enrollment;

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
        Enrollment;

run;

* Combine files vertically to add male student data (ClassEnroll14M12_raw) to female 
  student data (ClassEnroll14F12_raw) to calculate whole student population results for
  12th-grade students. Concatenate files and set length of variables with differing lengths
  in the source files to a new default length in the resulting all_student_enrollment file;

 data all_student_enrollment;
    length
        DistrictName    $39.
        SchoolName    $52.
        ClassID    $19.;

    format
        DistrictName    $39.
        SchoolName    $52.
        ClassID    $19.;

    set ClassEnroll14M12_raw ClassEnroll14F12_raw;

run;
 
* Prepare to combine files horizontally to accumulate information about course info.
  Files must be sorted on the merge variable for a one-to-one match. CourseCode/
  AssignmentCode is unique for each course offered. Sort files on 
  AssignmentCode in Assignmentcodes_raw, and CourseCode in Coursestaught14_nclb_raw 
  before merging;

proc sort data=Assignmentcodes_raw;
    by AssignmentCode;

run;

proc sort data=Coursestaught14_nclb_raw;
    by CourseCode;

run;

* Course description and teacher info in Course_Teacher_Info is merged with class 
  enrollment data for all students in all_student_enrollment to combine course information
  and teacher qualification (NCLB qualification and type - by 
  exam, by subject, by HOUSE exemption, etc.) data. The new resulting dataset 
  ap_math_students is filtered to include only students enrolled in ap-level math courses;

data Course_Teacher_Info;
    merge AssignmentCodes_raw(rename=(AssignmentCode=CourseCode)) Coursestaught14_nclb_raw;

    by CourseCode;

run;

* Sort student info master file by Course info before merging with Course_Teacher_info file;

proc sort data=all_student_enrollment;
    by CourseCode;

run;

* Select all students who are enrolled in AP Math courses and subset as ap_math_students file;

data ap_math_students;
    merge all_student_enrollment Course_Teacher_Info;

    by CourseCode;
        if AssignmentSubject='Mathematics' and AP_Course='Y';

run;

* This step investigates percentages of each ethnicity of students available to determine
  if non-European ethnic students have gained more opportunity and access to tech career
  pathways through their representative enrollment in advanced math classes. 
  Accumulated percentages of students of designated ethnic groups are calculated in the
  subsetted file ap_math_summary_by_ethnicity;

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

* This step investigates percentages of each gender of students to determine
  if female students have gained more opportunity and access to tech career
  pathways through their representative enrollment in advanced math classes. 
  Accumulated percentages of students of each gender are calculated in the
  subsetted file ap_math_students_by_gender;

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

* Prepare student enrollment data to be grouped and displayed by district. 
  Sort ap_math_students file by DistrictName for use in proc means;

proc sort data=ap_math_students out=ap_math_students_by_district;
	by DistrictName;

run;

* Sum up student AP-math enrollment by district in sorted ap_math_students_by_district
  file and output results to summary_by_district, with additional new column named 
  DistrictAPEnrollment;

proc means noprint data=ap_math_students_by_district;
    var EnrollTotal;

    by DistrictName;

    output out=summary_by_district sum(EnrollTotal)=DistrictAPEnrollment;

run;

* This is to investigate which districts offer the most opportunity for 
  students in terms of classes at the AP level in math as well as 
  participation levels in terms of enrollment. This is of interest 
  to see where geographically and demographically these districts are
  located, whether in terms of more or less household income and 
  whether urban/suburban locales. 

  Create a top-10 list   of districts with the highest enrollment of students
  in AP-math. Prepare for use in proc freq for display by first sorting 
  summary_by_district file just created by descending DistrictAPEnrollment
  and output results to new file, ap_summary_by_district
  for use in creating table in proc freq;

proc sort data=summary_by_district out=ap_summary_by_district;
    by descending DistrictAPEnrollment;

run;

* Create table cross-tabulating DistrictName and DistrictAPEnrollment and 
  output as DistrictAPTotals file for printing in order of descending
  DistrictAPEnrollment;

proc freq data=ap_summary_by_district noprint;

    tables DistrictName*DistrictAPEnrollment / nopercent nocum out=DistrictAPTotals;

run;

proc sort data=DistrictAPTotals;

by descending DistrictAPEnrollment;

run;

* Limit the number of observations displayed;

 data DistrictAPTotals10;
    set DistrictAPTotals (obs=10);

run;

* Sort ap_math_students file just created by SchoolName for use proc means;

proc sort data=ap_math_students out=ap_math_students_by_school;
    by SchoolName;

run;

* Sum up student AP-math enrollment by school in sorted ap_math_students_by_school
  file and output results to summary_by_school, with additional new column named 
  SchoolAPEnrollment;

proc means noprint data=ap_math_students_by_school;
    var EnrollTotal;

    by SchoolName;

    output out=summary_by_school sum(EnrollTotal)=SchoolAPEnrollment;

run;

* This is to investigate which schools offer the most opportunity for 
  students in terms of classes at the AP level in math as well as 
  participation levels in terms of enrollment. This is of interest 
  to see where geographically and demographically these districts are
  located, whether in terms of more or less household income and 
  whether urban/suburban locales. 

  Create a top-10 list of schools with the highest enrollment of students
  in AP-math. Prepare for use in proc freq for display by first sorting 
  summary_by_school file just created by descending SchoolAPEnrollment
  and output results to new file, ap_summary_by_school
  for use in creating table in proc freq;

proc sort data=summary_by_school out=ap_summary_by_school;
    by descending SchoolAPEnrollment;

run;

* Create table cross-tabulating SchoolName and SchoolAPEnrollment and 
  output as SchoolAPTotals file for printing in order of descending
  SchoolAPEnrollment;

proc freq data=ap_summary_by_school noprint;

    tables SchoolName*SchoolAPEnrollment / nopercent nocum 
    output out=SchoolAPTotals;

run;

* Limit the number of observations displayed to create a top-10 list;

data SchoolAPTotals10;
    set SchoolAPTotals (obs=10);

run;




