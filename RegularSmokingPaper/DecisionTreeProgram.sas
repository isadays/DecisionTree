LIBNAME mydata "/home/u63975549/sasuser.v94" access=readonly;

* Import the CSV file into a SAS dataset in the WORK library;
PROC IMPORT DATAFILE="/home/u63975549/sasuser.v94/tree_ad.csv"
    OUT=work.tree_ad
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

* Continue with your existing code using the WORK library;
DATA new; 
    SET work.tree_ad;
RUN;

PROC SORT; 
    BY AID;
RUN;

ods graphics on;
PROC HPSPLIT SEED=15531;
    CLASS TREG1 BIO_SEX HISPANIC WHITE BLACK NAMERICAN ASIAN 
        alcevr1 marever1 cocever1 inhever1 Cigavail EXPEL1;
    MODEL TREG1 = AGE BIO_SEX HISPANIC WHITE BLACK NAMERICAN ASIAN alcevr1 ALCPROBS1 
        marever1 cocever1 inhever1 DEVIANT1 VIOL1 DEP1 ESTEEM1 PARPRES PARACTV 
        FAMCONCT schconn1 Cigavail PASSIST EXPEL1 GPA1;
    
    GROW ENTROPY;
    PRUNE COSTCOMPLEXITY;
RUN;
