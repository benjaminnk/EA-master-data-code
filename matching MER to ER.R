---
  title: "Working with MER Output"
author: "EA Team"
date: "4/21/2020"
output: html_document
---
  


##Here are instructions for importing and working with MER data. I set my working directory above to the location where I have downloaded the MER file**
  
  
  #Step 1: Install the following packages. If they are already installed, please use the library function instead


install.packages("stringr")
install.packages("devtools")
install.packages("tydiverse")
library(stringr)
library(tidyverse)
library(dplyr)
```
#Step 2: Identify the file type you are importing. If it is a .txt, use the code below. If it is a .csv, use read.csv. The filepath should be within your working directory that you set above. Below the file is a .txt


data.MER <- read.delim("Genie_OU_IM_Global_Daily_e051c461-1abe-4fc5-b377-61a493071318.txt", header = TRUE, sep = "\t", dec = ".")
```
#You can also filter the MER dataframe for specific indicators and countries. Here for example-we are looking at PREP in Rwanda

#join the data set to ER
data.er.mer<-left_join(data.ER,data.MER, by(c="mech_code","Fiscal_Year","Operating Unit"))
data.er.mer<-%>%select(-(OperatingUnit,FundingAgency.y:mech_code.y,Fiscal_Year.y)


