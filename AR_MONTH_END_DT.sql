-----------------------------------AR_MONTH_END_DT_P00.SQL-------------------------------------------------
/*  
#### COPYRIGHTS			: TBD
#### FILE NAME			: AR_MONTH_END_DT_P00.SQL  
#### FILE TYPE			: SQL FILE
#### APPLICATION		: TOBI 
#### BUSINESS FUNCTION	        : THIS FILE HAS BEEN CREATED TO PERFORM INSERT INTO AR_MONTH_END_DT TABLE 
#### AUTHOR(S)			: Sadik M                                                                                       
####                            :   
#### VERSION			: 1-INITIAL VERSION 
#### DATE			: 24-NOV-2021 */ 

---------------------------------- DELETE AR_MONTH_END_DT SQL --------------------------------------

DELETE FROM %TOBI_MDM%.AR_MONTH_END_DT ;


/* --------------------------------INSERT AR_MONTH_END_DT SQL --------------------------------------- */

INSERT INTO %TOBI_MDM%.AR_MONTH_END_DT
(
MONTH_END_DT,FK_TIME_DIM_ID
)
SEL A.DT,B.PK_TIME_DIM_ID FROM
(
SELECT MIN(D.DT) AS DT,D."MONTH" AS "MONTH",D."YEAR" AS "YEAR" FROM
(SELECT DT,"MONTH","YEAR" FROM
(SELECT DISTINCT END_DT_CURRENT_PERIOD DT,DAY_ABBREV "DAY","MONTH","YEAR"
FROM %TOBI_MDM%.AR_FISCAL_PERIODS_LOOKUP_DIM A,%TOBI_MDM%.TIME_DIM B WHERE A.END_DT_CURRENT_PERIOD=B.FULL_DATE
) C
WHERE C."DAY"='Tue')D
GROUP BY "MONTH","YEAR"
)A LEFT OUTER JOIN %TOBI_MDM%.TIME_DIM B
ON A.DT=B.FULL_DATE;