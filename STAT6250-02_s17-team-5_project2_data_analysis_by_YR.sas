*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding graduation numbers and rates for various California High
Schools
Dataset Name: ClassEnroll14F12_raw,ClassEnroll14M12_raw,CoursesTaught14_raw created in external file
STAT6250-02_s17-team-5_project2_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset ClassEnroll14F12_raw,ClassEnroll14M12_raw,CoursesTaught14_raw ;
%include '.\STAT6250-02_s17-team-5_project2_data_preparation.sas';


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: What are the top ten schools have most people selected Multi-course Mathematics?
(Rationale: This would help to know which schools has better education and learning
motivation in math in California.)
Note: Hispanic or Latino students has a big percentages in this data, mostly over 90% are Hispanic or Latino students.

Methodology: Use PROC PRINT to print out the first 10 observations, for the course code column in the dataset created in the data prep file. 
which are Classenrollment14f12 and Classenrollment14m12, then compare which had course code between 2400 to 2433.

Limitations: There might be classes close to mathematics but not listed in the AssignmentCode file.

Followup Steps: 

proc print 
        data= ClassEnroll14F12_raw (obs=10)
    ;
    id 
        SchoolCode
    ;
    var 
        CorseCode
    ;
run;

proc print 
        data= ClassEnroll14F12_raw (obs=10)
    ;
    id 
        SchoolCode
    ;
    var 
        CorseCode
    ;
run;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question:  Does ethnic affects what class they pick?
(Rationale: This would help people or state education department to know which ethnic group 
student more into what kind of classes and want they want to be in the future maybe.)

Methodology: Use proc means to find the sum for the columnsD9, D10, D11, and 
D12 in the Graduates_analytic_file file created in data.
preparation. Then see which one has the highest number.

Limitations: The limition must be Hispanic or Latino students has a big percentages in this data, mostly over 90% are Hispanic or Latino students.
Followup Steps: 

proc means 
        data= ClassEnroll14F12_raw
        sum
    ;
    id
        SchoolCode
    ;
    var
    EnrollNoEthRptd	EnrollAmInd	EnrollAsian	EnrollPacIsl	EnrollFilipino	EnrollHispanic	EnrollAfrAm	EnrollWhite	EnrollTwoOrMore	EnrollTotal	EnrollEL  
    ;
run;

proc means 
        data= ClassEnroll14M12_raw
        sum
    ;
    id
        SchoolCode
    ;
    var
    EnrollNoEthRptd	EnrollAmInd	EnrollAsian	EnrollPacIsl	EnrollFilipino	EnrollHispanic	EnrollAfrAm	EnrollWhite	EnrollTwoOrMore	EnrollTotal	EnrollEL  
    ;
run;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: What are the top five districts that have most teachers in school?
(Rationale:  This would help us to know which districts have bigger teaching force and more 
teacher selections in a class.)
note: Teacher does have different types in different school.
Methodology: Use PROC PRINT to print out the first 5 observations, for the column Enrollment in the dataset created in the data prep file.
Limitations: Different type teachers teachs different kinds of class or even dont teach, so its may or may not affect the result.
Followup Steps: 

proc print 
        data= CoursesTaught14_raw (obs=5)
    ;
    id 
        SchoolCode
    ;
    var 
        Enrollment
    ;
run;





