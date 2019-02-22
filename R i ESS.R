#######################ESS i R:   Uvod u R programiranje###############
#########################Radmila VELICKOVIC#####################################
#########################22.2.2019, Beograd #########################


# UVOD ------------------------------------------------------------

# R : 

#je digitron

#odgovara na TRUE/FALSE pitanja

2==3
2==2
2>3

# pi broj
pi

#pokazuje vreme i datum
Sys.time()
Sys.Date()

#Koju verziju R-a koristite?
sessionInfo()

#gde R trazi setove podataka (fajlove) koje cemo importirati?
getwd()
#gde su ti setovi zaista i gde zelimo da ih R trazi?
setwd("C:/Users/Rada/POSM laptop/1. STATISTICS masters material/R_Treninzi")

# Strukture i tipovi podataka -----------------------------------------------

#vektor kao karakter 
moj_prvi_vektor<-c("Allow many to come and live here","Allow some", "Allow a few", "Allow none")

print(moj_prvi_vektor)

# numericki vektor
moj_drugi_vektor<-c(400,140,130,50)
moj_drugi_vektor

#kombinacija
moji_vektori<-rbind(moj_prvi_vektor,moj_drugi_vektor)
View(moji_vektori)
t(moji_vektori)
View(t(moji_vektori))

#kako znamo da je vektor?
is.vector(moj_prvi_vektor)
is.vector()

#ali vektori se javljaju u obliku atomskih vektora i lista
is.atomic(moj_prvi_vektor)
is.list(moj_prvi_vektor)

#kog su tipa su podaci u vektorima koje smo napravili?
class(moj_prvi_vektor)
class(moj_drugi_vektor)

#liste

moja.prva.lista<-list(c("ESSround","cntry", "RIN", "intrpol","nwspol"),
                      c(8,"Germany","114","very_interested", 30))

class(moja.prva.lista)

View(moja.prva.lista)
#pretvorimo listu u data frame kako bismo mogli da je vidimo kao set podataka
moja.prva.lista<-as.data.frame(moja.prva.lista)
View(moja.prva.lista)  

#ali nazivi kolona su nerazumljivi, promenimo ih
colnames(moja.prva.lista)[1]<-"Varijable"
colnames(moja.prva.lista)[2]<-""


View(moja.prva.lista)
t(moja.prva.lista)
View(t(moja.prva.lista))



# matrice 

matrix_3by2 = matrix( 
  c(2, 4, 3, 1, 5, 7), 
  nrow=3, 
  ncol=2) 
matrix_3by2
t(matrix_3by2)

# jedinicna matrica

diag(4)
View(diag(4))


#mnozenje matrica

A=matrix( 
  c(2, 4, 3, 1, 5, 7), 
  nrow=3, 
  ncol=2) 

B= matrix( 
  c(2, 4, 3, 1, 5, 7), 
  nrow=2, 
  ncol=3) 
A
B
A%*%B
#idempotentna matrica

C=matrix(c(4,-1,12,-3),
         nrow = 2,
         ncol=2, byrow=T)
C
C%*%C

#inverzna matrica

C1=matrix(c(4,-1,12,-2),
          nrow = 2,
          ncol=2, byrow=T)

C1
solve(C1)

D<-matrix(c(-5,0,2,1,-2,3,6,-2,1),
          nrow=3,
          ncol=3, byrow=T)

D
solve(D)

#faktori

moj_prvi_vektor<-c("Allow many to come and live here","Allow some", "Allow a few", "Allow none")
is.atomic(moj_prvi_vektor)
moj_prvi_vektor<-as.factor(moj_prvi_vektor)
is.factor(moj_prvi_vektor)


#data.frame


# IMPORTOVANJE PODATAKA ---------------------------------------------------


#Iz spss-a
install.packages("foreign")   #instalirajmo prvi paket
library(foreign)              # ucitajmo paket

#Ucitavanje SPSS seta podataka. Sta vidite uz pomoc funkcije View()?
ESS<-read.spss("C:/Users/Rada/Desktop/setovi_podataka/ESS8e02_1.sav")
View(ESS)
#pretvorimo u data.frame
ESS<-as.data.frame(ESS)

#jos efikasnije
ESS1<-as.data.frame(read.spss("C:/Users/Rada/Desktop/setovi_podataka/ESS8e02_1.sav", use.value.labels = F))
View(ESS1)

#postoji jos nacina za ucitavanje .sav fajla
#haven paket 
#essurvey paket (malo kasnije)

#prikacimo nas dataset za memoriju radi jednostavnije manipulacije podacima
attach(ESS1)
#detach(ESS1)
search()


View(ESS)
dim(ESS)
str(ESS)
names(ESS)
class(ESS$cntry)
levels(ESS$cntry)

# DATA MANIPULATION -------------------------------------------------------

install.packages("foreign")
library(foreign)
library(dplyr)

ESS<-as.data.frame(read.spss("C:/Users/Rada/Desktop/setovi_podataka/ESS8e02_1.sav", use.missings = F))


View(ESS)
names(ESS)
class(ESS$nwspol)
levels(ESS$nwspol)
sum(is.na(ESS$nwspol))


#filtriranje podataka po jednom kriterujumu
ESS.DE<-filter(ESS, cntry == "Germany")
View(ESS.DE)
#filitriranje podataka po dva kriterijuma
ESS.DE<-filter(ESS, cntry== "Germany", polintr == "Not at all interested")
View(ESS.DE)
#filtriranje podataka po tri kriterijuma
ESS.DE<-filter(ESS, cntry== "Germany", polintr == "Not at all interested", nwspol > 30 )

#varijabla nwspol je prema R-u faktor a morala bi biti numericka




#filtriranje po jednom kriterijumu ali vise kategorija u okviru varijable
ESS.DE<-filter(ESS, cntry== "Germany", polintr == "Not at all interested" | polintr == "Hardly interested")
View(ESS.DE)


#izdvajanje kolona po zelji
#cntry-country/ pointr-political interest, 
#trstprl-trust in country´s parliament
#trstlgl-trust in legal system
#trstplc-trust in police
#trstplt-trust in politicians

ESSsubset<-select(ESS, cntry, polintr, 
                  trstprl, trstlgl,trstplc, trstplt )


View(ESSsubset)
str(ESSsubset)

class(ESSsubset$trstprl)

ESSsubset$trstprl<-as.numeric(ESSsubset$trstprl)
ESSsubset$trstlgl<-as.numeric(ESSsubset$trstlgl)
ESSsubset$trstplc<-as.numeric(ESSsubset$trstplc)
ESSsubset$trstplt<-as.numeric(ESSsubset$trstplt)



#mutate ()
#sluzi za kreiranje nove kolone koja je transformisana

ESSsubset<-ESSsubset %>% 
  mutate( average_trust = trstprl+trstlgl/ 2) %>% 
  head

View(ESSsubset)

#groupby () + jos jedna funkcija
#sluzi za grupisanje podataka na osnovu neke varijable
#(npr. grupisati prosecno vreme gledanja politickog sadrzaja prema zemlji) 

ESS.by.cntry<-select(ESS,cntry,nwspol)
View(ESS.by.cntry)

ESS.by.cntry$nwspol<-as.numeric(ESS.by.cntry$nwspol)

by.country <- ESS.by.cntry %>% 
  group_by(cntry) %>% 
  summarise(
    average_newspol = mean((nwspol), na.rm= T)
  )
View(by.country)

ESS.by.cntry$nwspol<-as.numeric(ESS.by.cntry$nwspol)
is.numeric(ESS.by.cntry$nwspol)



#ocisti memoriju i zatvori
rm(list=ls())
q()
