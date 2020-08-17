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
``
read

#Step 2: Identify the file type you are importing. If it is a .txt, use the code below. If it is a .csv, use read.csv. The filepath should be within your working directory that you set above. Below the file is a .txt
data.MER <- read.delim("C:/Users/STAR/Desktop/R code directory/Master Data Set/MER_Structured_Datasets_OU_IM_FY18-20_20200605_v1_1.txt", header = TRUE, sep = "\t",quote = "", dec = ".")
data.ER <- read.delim("C:/Users/STAR/Desktop/R code directory/Master Data Set/ER_Structured_Dataset.txt", header = TRUE, sep = "\t", quote = "", dec = ".")
``


##Step 3: Clean up/filter each data frame
#changing the names of each column heading for ERSD &MSD.
df_er <- data.ER%>%
  dplyr::select( - c("prime_partner_duns","subrecipient_name","subrecipient_duns","award_number")) %>% 
  dplyr::rename("Operating Unit"= "ï..operatingunit",
                "Funding Agency"= "fundingagency",
                "Partner Name"= "prime_partner_name",
                "Mechanism ID"="mech_code",
                "Mechansim Name" = "mech_name",
                "Program Area"="program",
                "Sub Program Area"="sub_program",
                "Service Delivery"="interaction_type",
                "Beneficiary"="beneficiary",
                "Sub Beneficiary"="sub_beneficiary",
                "Cost Category"="cost_category",
                "Sub Cost Category"="sub_cost_category",
                "Data Stream"="dataset",
                "Fiscal Year"="fiscal_year",
                "Amount"="value",
                "Funding Type"="funding_type")%>%
  dplyr::mutate('Data Stream'=as.character('Data Stream'))
  
  
#MER Read in/
#Switch the type of character of one of the variables in order oto be able to bind them. in this
#case "Mechanism ID"for ER did no match the MER. Character to Integer
df_mer <- data.MER %>% 
  dplyr::filter(disaggregate == "Total Numerator") %>%
  dplyr::select( - c('operatingunituid', 'pre_rgnlztn_hq_mech_code', 'prime_partner_duns',	'award_number',	
                    'categoryoptioncomboname', 'ageasentered', 'trendsfine', 'trendssemifine', 'trendscoarse',	
                    'sex', 'statushiv',	'statustb', 'statuscx', 'hiv_treatment_status', 'otherdisaggregate', 'otherdisaggregate_sub',	
                    'modality', 'source_name','numeratordenom','disaggregate','standardizeddisaggregate')) %>% 
  dplyr::rename("Operating Unit"= "operatingunit",
                "Country"= "countryname",
                "Funding Agency"= "fundingagency",
                "Partner Name"= "primepartner",
                "Mechanism ID"="mech_code",
                "Mechansim Name" = "mech_name",
                "Indicator Type"="indicatortype",
                "Indicator"="indicator",
                "Targets"="targets",
                "Quarter 1"="qtr1",
                "Quarter 2"="qtr2",
                "Quarter 3"="qtr3",
                "Quarter 4"="qtr4",
                "Results"="cumulative",
                "Fiscal Year"="fiscal_year") %>% 
  dplyr::mutate(`Data Stream` = "MER") %>% 
  dplyr::mutate(`Mechanism ID` = as.integer(`Mechanism ID`),
                'Data Stream'=as.character('Data Stream'))
  

## Step 4: now bind them together
df <- dplyr::bind_rows(df_er, df_mer)

##Step 5: write file to output folder
write_csv(data.ER, "C:/Users/STAR/Desktop/R code directory/Er_Structured_Datasets.csv")


##ADDITIONAL CODING FOR PRACTICE, DO NOT RUN CODE.##
#You can also filter the MER dataframe for specific indicators and countries. Here for example-we are looking at PREP in Rwanda

#join the data set to ER
data.er.mer<-left_join(data.ER,data.MER, by(c="mech_code","Fiscal_Year","Operating Unit"))
data.er.mer<-%>% select(-(OperatingUnit, FundingAgency.y:mech_code.y, Fiscal_Year.y))


#join data set*
data.er.mer <- data.ER %>% left_join(data.MER, by="mech_code")

