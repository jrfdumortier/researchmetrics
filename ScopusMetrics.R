#==================================================================================================
# Title:            Scopus Faculty Performance Metric
# Author:           Jerome Dumortier
# Date:             4 November 2022
#==================================================================================================
rm(list=ls())
library(openxlsx)
library(rscopus)
setwd("Path to the directory where ScousMetrics.xlsx is located")
set_api_key("number")         # API key can be requested from Scopus for free
fn                  = "ScopusMetrics.xlsx"
#--------------------------------------------------------------------------------------------------
# Journals (https://www.scimagojr.com/)
#--------------------------------------------------------------------------------------------------
scimago             = readWorkbook(fn,sheet="SCIMAGOJR2021")
#--------------------------------------------------------------------------------------------------
# Faculty Publications from Scopus
#--------------------------------------------------------------------------------------------------
authors             = readWorkbook(fn,sheet="FACULTY")
df                  = author_df(au_id=authors$scopusid[1])
df$author           = NA
df                  = df[0,]
for(i in 1:nrow(authors)){
     temp                                    = author_df(au_id=authors$scopusid[i])
     temp$author                             = authors$name[i]
     temp[setdiff(names(df),names(temp))]    = NA
     df[setdiff(names(temp), names(df))]     = NA
     df                                      = rbind(df,temp)}
scopus              = df[c("dc:title","prism:publicationName","prism:doi","citedby-count",
                           "subtypeDescription","openaccess","author","prism:coverDate")]
colnames(scopus)    = c("title","journal","doi","citation","type","openaccess","author","year")
scopus$year         = substr(scopus$year,1,4)
scopus$year         = as.numeric(scopus$year)
scopus$citation     = as.numeric(scopus$citation)
rm(df,i,temp)
#--------------------------------------------------------------------------------------------------
# Unique Journals
#--------------------------------------------------------------------------------------------------
journals            = unique(scopus[c("journal")])
journals            = merge(journals,scimago,by.x="journal",by.y="title",all.x=TRUE)
journals            = na.omit(journals)
journals            = journals[order(-journals$sjr),]
row.names(journals) = NULL
#==================================================================================================
# End of File
#==================================================================================================