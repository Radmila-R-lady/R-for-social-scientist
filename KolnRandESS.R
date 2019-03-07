##################################Working with ESS data in R ####################
####################################Radmila_R_Lady################################
####################################07.3.2019, Cologne, Germany ##################
getwd()          
setwd("C:/Users/Rada/Desktop/Nemacka Keln")
# INSTALL AND LOAD THE PACKAGES -------------------------------------------


library(essurvey)          
library(dplyr)
library(ggplot2)


# ESSURVEY FUNCTIONS ----------------------------------------------------

#Which countries are part of European Social Survey?
show_countries()
          
#In which round(s) did each country participate? 
show_country_rounds("Germany")
show_country_rounds("Serbia")
show_country_rounds("Turkey")  

#in order to access the data use the e-mail you registered at 
#https://www.europeansocialsurvey.org/user/login

set_email("radmila.velichkovich@gmail.com")

#importing data for a specific country          
Germany<-import_country("Germany",8,format = "spss")
View(Germany)

#selecting a round which does not exist, 
Germany<-import_country("Germany",9,format = "spss")

#selecting all rounds of a particular country
Germany_all<-import_all_cntrounds("Germany", format = "spss" )
View(Germany_all)
Germany1<-Germany_all[[1]]
View(Germany1)
Germany2<-Germany_all[[2]]
View(Germany2)
          
#downloading more rounds at once
Germany1_3<-download_country("Germany",  rounds = c(2, 4), output_dir = getwd())

#show themes

show_themes()
show_theme_rounds("Media and social trust")

show_theme_rounds("Immigration")

# ESS DATA WRANGLING ------------------------------------------------------

#cntry-country/ pointr-political interest, 
#trstprl-trust in country´s parliament
#trstlgl-trust in legal system
#trstplc-trust in police
#trstplt-trust in politicians
#nwspol-how many minutes did you spend on average watching political content a day?

Germany1<-select(Germany, cntry, polintr, nwspol,
                     trstprl, trstlgl,trstplc, trstplt )
#missings
sum(is.na(Germany1))
sum(is.na(Germany1$nwspol))
which(is.na(Germany1$nwspol))
View(Germany1[434, ])

#descriptive statistics

summary(Germany1$nwspol)

#removing missing values
Germany1<-slice(Germany1, -434)

#some visualisation
ggplot(data = Germany1) + 
  geom_point(mapping = aes(x = trstlgl, y = trstplt)) 

ggplot(data = Germany1) + 
  geom_bar(mapping = aes(x = trstlgl))




