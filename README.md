# researchmetrics
R Code to download Scopus Data

This repositoy includes the R code required to download publications by the list of authors specified in the file "ResearchMetrics.xlsx". In order to execute the file, you need to be on a network that subscribes to Scopus (e.g., many if not most university networks). The list of authors in the Excel file can be extended and the code simply loops through all the authors. The output from Scopus is very comprehensive but gets restricted at line 29 in the R code. It is suggested to look at the output after the loop and determine, which variables are of interest. 
