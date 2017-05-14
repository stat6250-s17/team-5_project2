

Question:which district has the highest EstimatedFTE?

Rationale: This would help we know the distribution of estimatedFTEscore in different districts.

Note: This compares the column EstimatedFTE to column district name in data set 1

Methodology: sort the column EstimatedFTE for all districts, find the observation that has the highest EstimatedFTE.

Limitations: because there is only 5 kinds of estimatedFTEscores, maybe some districts both are 100 scores. 
             there are some missing record.

Followup Steps: More carefully clean values in order to filter out any possible
illegal values, and better handle missing data. the same scores are ok for this question.

proc sort
        data=StaffAssign_file
        out=StaffAssign_file_sorted



