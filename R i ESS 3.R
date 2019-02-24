#######################ESS8e02_1 i R:   Uvod u R programiranje###############
#########################Radmila VELICKOVIC###########################
#########################24.2.2019, Beograd #########################


library(psych)
library(Hmisc)
library(dplyr)
library(ggplot2)
library(soc.ca)


# DESKRIPTIVNA STATISTIKA -------------------------------------------------

mean(x)
median(x)
max(x)
min(x)
diff(range(x))
fivenum(x)
var(x)
sd(x)
mad(x)

describeBy(ESS8e02_1$nwspol, 
           group = ESS8e02_1$cntry,
           digits= 4)

#K.Manderscheid: Sozialwissenschaftliche Datenanalyse mit R
#strana 79-82: sve o base R funkcijama za frekvencije, apsolutne i relativne

frequency<-table(ESS8e02_1$nwspol) 
View(frequency)


# IMPUTACIJA PODATAKA -----------------------------------------------------



ESS8e02_1.DE<-filter(ESS8e02_1, cntry == "DE")

#Da li Varijabla nwspol ima nedostajuce vrednosti? Ako ima, na kojoj poziciji se nalazi/nalaze?
sum(is.na(ESS8e02_1.DE$nwspol))
which(is.na(ESS8e02_1.DE$nwspol))
#gde se nalazi red 434?
View(ESS8e02_1.DE[434, ])
mean(ESS8e02_1.DE$nwspol, na.rm=T)

ESS8e02_1.DE$nwspol<-impute(ESS8e02_1.DE$nwspol, mean) #impute () iz Hmisc-a

mean(ESS8e02_1.DE$nwspol)


#alternativno:
#ESS8e02_1.DE$nwspol<-impute(ESS8e02_1.DE$nwspol, median)
#ESS8e02_1.DE$nwspol<-impute(ESS8e02_1.DE$nwspol, 67.178)


# UKLANJANJE REDOVA I KOLONA ----------------------------------------------

#uklanjanje redova 
ESS8e02_1.DE<-slice(ESS8e02_1.DE, -434)

#uklanjanje kolone
ESS8e02_1.DE<-select(ESS8e02_1.DE, -nwspol) #NOT RUN


# GGPLOT2 -----------------------------------------------------------------


range(ESS8e02_1.DE$nwspol, na.rm = T)
boxplot(ESS8e02_1.DE$nwspol)


ggplot(ESS8e02_1.DE, aes(x="min", y=nwspol)) +
        
geom_boxplot(outlier.colour = "red")



ggplot(data = mpg) #nije od znacaja ali omogucava stavljanje slojeva (layers)

View(mpg)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))   #napravili smo dijagram rasprsenosti

#kojoj klasi pripada koji automobil

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# dodavanje facet-a za razdvajanje grafikona
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 3 )

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

#dijagram frekvencija
View(diamonds)
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

#statisticki testovi


View(table(ESS8e02_1.DE$polintr, ESS8e02_1.DE$nwspol))
chisq.test(ESS8e02_1.DE$nwspol, ESS8e02_1.DE$polintr)

#https://www.youtube.com/watch?v=POiHEJqmiC0


#korelacija izmedju dve variabli sa NA
cor(ESS8e02_1.DE$polintr, ESS8e02_1.DE$nwspol) 
cor.test()

# Analiza korespondencije -------------------------------------------------


#selecting active variables to represent the structure


ESS.mca<-select(ESS8e02_1.DE, nwspol, polintr, actrolga )
View(ESS.mca)
#selecting active variables to represent the structure
mca1<-soc.mca(ESS.mca[, c(1,2)])
mca1

#ukupan broj dimenzija
mca1$nd
#eigenvrednosti
mca1$eigen
#dodatne informacije
mca1$adj.inertia
#scree plot
plot(mca1$adj.inertia,type="o")

#...

#obavezno ukloniti sve iz environmneta
 rm(list = ls())


# KRAJ --------------------------------------------------------------------


