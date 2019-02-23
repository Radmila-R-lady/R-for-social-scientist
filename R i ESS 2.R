#######################ESS8e02_1 i R:   Uvod u R programiranje###############
#########################Radmila VELICKOVIC###########################
#########################23.2.2019, Beograd #########################

# DATA MANIPULATION -------------------------------------------------------

#Posto smo instalirali paket koji nam nije bio od koristi
#zelimo da ga sklonimo iz memorije, deinstalirajmo ga
getwd()
setwd()

ESS8e02_1 <- read_sav("C:/Users/Rada/POSM laptop/1. STATISTICS masters material/R_Treninzi/R kurs Institut za socioloska istrazivanja/ESS8e02_1.sav")
View(ESS8e02_1)
remove.packages("foreign") #OVAJ KOD IZVSITI SAMO JEDNOM

install.packages("dplyr")
install.packages("essurvey")
install.packages("srvyr")   
remove.pac kages("srvyr") 

library(dplyr)
library(essurvey)
library(haven)


View(ESS8e02_1)


#filtriranje podataka po jednom kriterujumu
ESS8e02_1.DE<-filter(ESS8e02_1, cntry == "DE")
View(ESS8e02_1.DE$pw)

#Da li Varijabla nwspol ima nedostajuce vrednosti? Ako ima, na kojoj poziciji se nalazi/nalaze?
sum(is.na(ESS8e02_1.DE$nwspol))
which(is.na(ESS8e02_1.DE$nwspol))
#gde se nalazi taj red?
ESS8e02_1.DE[434, ]
mean(nwspol) #racunanje srednje vrednosti kada imamo missing value
mean(ESS8e02_1.DE$nwspol, na.rm=T)


#filitriranje podataka po dva kriterijuma
ESS8e02_1.DE<-filter(ESS8e02_1, cntry== "DE", polintr == "4")
View(ESS8e02_1.DE)
table(ESS8e02_1.DE$polintr)



#filtriranje podataka po tri kriterijuma
ESS8e02_1.DE<-filter(ESS8e02_1, cntry== "DE", polintr == "4", nwspol > 30 )
View(ESS8e02_1.DE)

#filtriranje po jednom kriterijumu ali vise kategorija u okviru varijable
ESS8e02_1.DE<-filter(ESS8e02_1, cntry== "DE", polintr == "4"& polintr == "3")
View(ESS8e02_1.DE)


#izdvajanje kolona po zelji
#cntry-country/ pointr-political interest, 
#trstprl-trust in country´s parliament
#trstlgl-trust in legal system
#trstplc-trust in police
#trstplt-trust in politicians

ESSsubset.DE<-select(ESS8e02_1.DE, cntry, polintr, 
                  trstprl, trstlgl,trstplc, trstplt )


View(ESSsubset)

class(ESSsubset$trstprl)

#mutate ()
#sluzi za kreiranje nove kolone koja je transformisana

ESSsubset.DE<-ESSsubset.DE %>% 
  mutate( average_trust = trstprl+trstlgl/ 2) %>% 
  head

View(ESSsubset.DE)

#groupby () + jos jedna funkcija
#sluzi za grupisanje podataka na osnovu neke varijable
#(npr. grupisati prosecno vreme gledanja politickog sadrzaja prema zemlji) 

ESS8e02_1.by.cntry<-select(ESS8e02_1,cntry,nwspol)
View(ESS8e02_1.by.cntry)


by.country <- ESS8e02_1 %>% 
  group_by(cntry) %>% 
  summarise(
    average_newspol = mean((nwspol), na.rm= T)
  )
View(by.country)



# essurvey package --------------------------------------------------------

show_countries()

show_country_rounds("Greece")
show_country_rounds("Serbia")

set_email("radmila.velichkovich@gmail.com")

Greece<-import_country("Greece", 5, format = "spss")
View(Greece)

Bulgaria<-import_all_cntrounds("Bulgaria", format = "spss")
Bulgaria1<-Bulgaria[[1]]
View(Bulgaria1)
Bulgaria2<-Bulgaria[[2]]
View(Bulgaria2)


#https://ropensci.github.io/essurvey/


#Regresija

View(ESS8e02_1.DE)

#SCALE THE VARIABLES
trust<-select(ESS8e02_1.DE, lrscale, imsmetn, imdfetn ,impcntr, imbgeco, imueclt, imwbcnt, pweight)

View(trust)
summary(trust)



m_1 <- glm(lrscale~imsmetn + imdfetn + impcntr + imbgeco + imueclt + imwbcnt)



#fitted values
fitted(m_1)

#residuals
residuals(m_1)

par(mfrow=c(2,2))
plot(m_1)

#model2
m_2 <- glm(lrscale~ imdfetn + impcntr + imbgeco + imueclt + imwbcnt, design = pweight, data = trust)
summary(m_2)

par(mfrow=c(2,2))
plot(m_2)


#ocisti memoriju i zatvori
rm(list=ls())
q()
