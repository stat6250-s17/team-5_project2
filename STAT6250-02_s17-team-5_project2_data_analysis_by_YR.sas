*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding graduation numbers and rates for various California High
Schools
Dataset Name: (############) created in external file
STAT6250-02_s17-team-5_project2_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset (############);
%include '.\STAT6250-02_s17-team-5_project2_data_preparation.sas';


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: What are the top ten schools have most people selected Multi-course Mathematics. 
(Rationale: This would help to know which schools has better education and learning
motivation in math in California.)
Note:
Methodology: 
Limitations: 
Followup Steps: 
*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question:  Does ethnic affects what class they pick?
(Rationale: This would help people or state education department to know which ethnic group 
student more into what kind of classes and want they want to be in the future maybe.)
Note:
Methodology: 
Limitations: 
Followup Steps: 
*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: What are the top five districts that have most teachers in school?
(Rationale:  This would help us to know which districts have bigger teaching force and more 
teacher selections in a class.)
Note:
Methodology: 
Limitations: 
Followup Steps: 
