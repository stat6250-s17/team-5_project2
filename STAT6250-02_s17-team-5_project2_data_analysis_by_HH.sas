*
This file uses the following analytic dataset to address several research
questions.
Dataset Name:ClassEnrollment14F12.csv created in external file
STAT6250-02_s17-team-5_project2_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic datasets ClassEnrollment14F12.csv,
  ClassEnrollment14M12.csv, and CoursesTaught14_NCLB.csv;
%include '.\STAT6250-02_s17-team-5_project2_data_preparation.sas';

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: which district has the highest EstimatedFTE?'
;
title2
'Rationale:This would help we know the distribution of estimatedFTEscore in different districts.'
;
footnote1
"As can be seen, all districts has the EstimatedFTE about the range from 0.2 to 100 "
;
footnote2
"easy to obtain that there are only a little kind of score of EstimatedFTE here"
;
footnote3
"Given this apparent correlation based on descriptive methodology, further investigation should be performed using inferential methodology to determine the level of statistical significance of the result."
;
*
Note: This compares the column EstimatedFTE to column district name in data set 1

Methodology: sort the column EstimatedFTE for all districts, find the observation that has the highest EstimatedFTE.

Limitations: because there is only 5 kinds of estimatedFTEscores, maybe some districts both are 100 scores. 
             there are some missing record.

Followup Steps: More carefully clean values in order to filter out any possible
illegal values, and better handle missing data. the same scores are ok for this question.
;

proc sort
        data=StaffAssign_file
        out=StaffAssign_file_sorted
run;

title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Can "StaffType" be used to predict the certain courses(represented by course number)?'
;

title2
'Rationale: This would help to get the relationship between StaffType between CourseCode'
;

footnote1
"As can be seen,StaffTpye has great relationship with CourseCode, actually,StaffType determain what kind of course can be teached "
;

footnote2
"Possible explanations for this correlation is that Surgery specializing in surgery"
;

footnote3
"Given this apparent correlation based on descriptive methodology, further investigation should be performed using inferential methodology to determine the level of statistical significance of the result."
;

*
Note: This compares the column "StaffTpye" to the column "CourseCode".

Methodology: Use PROC SORT to get output of Type1,Type2,Type3(represented by T, p, a),Then, define a function to calculate propritation of all courses in those 3 types.  

Limitations: the amount of those 3 types have a great difference.

Followup Steps: A possible follow-up to this approach could use an inferential
statistical technique like linear regression.
;
proc sort
        data=StaffAssign_file
        out=StaffAssign_file_sorted
def T=sort1/..........
    ;
run;

title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: what are the first ten districts that averrage EstimatedFTE is greater than 50? '
;

title2
"Rationale: This would help identify which part of districts has higher EstimatedFTE?"
;

footnote1
"different districts have different number of school "
;

footnote2
"different school has different number of Staffs which impact the EstimatedFTE?"
;

footnote3
"However, assuming there are no data issues underlying this analysis, possible explanations for such large numbers of 12th-graders completing only the SAT include lack of access to UC/CSU-preparatory coursework, as well as lack of proper counseling for students early enough in high school to complete all necessary coursework."
;

*
Note: This compares the column districts to the column EstimatedFTE.

Methodology: calculate the mean of schools' EstimatedFTE in same district,then sort them and get a output.

Limitations: This methodology does not account for schools with missing data.

Followup Steps: .
;

proc print
        data=StaffAssign_file_sort_sat(obs=10)
    ;
    id
        districname
    ;
    mean
        excess_sat_takers
    ;
run;

title;
footnote;


