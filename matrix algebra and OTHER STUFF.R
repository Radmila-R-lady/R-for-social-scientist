#############################BernR:Matrix algebra and other useful stuff####################
#############################Radmila Velichkovich###########################################
#############################11.3.2019######################################################



#Building a matrix

matrix_3by2 <- matrix( 
  c(2, 4, 3, 1, 5, 7), 
  nrow=3)


matrix_3by2 = matrix( 
  c(2, 4, 3, 1, 5, 7), 
  nrow=3, 
  ncol=2) 

matrix_3by2

matrix_3by2 <- matrix( 
  c(2, 4, 3, 1, 5, 7), 
  nrow=3, byrow = T)

matrix_3by2 <- matrix( 
  c(2, 4, 3, 1, 5, 7), 
  nrow=3)

#naming rows and columns

matrix_3by2 <- matrix( 
  c(2, 4, 3, 1, 5, 7), 
  nrow=3,
  dimnames = list(c("row1","row2","row3"),
                  c("column1","column2")))

matrix_3by2

#letters

matrix(LETTERS[(1:6)], ncol = 2, byrow=T)




#transposing the matrix

t(matrix_3by2)

# identity matrix

diag(4)
View(diag(4))


#Matrix multiplication

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


#idempotent matrix

C=matrix(c(4,-1,12,-3),
         nrow = 2,
         ncol=2, byrow=T)
C
C%*%C

#inverse matrix
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


#R has a number of matrix specific operations like:

nrow(matrix_3by2)
ncol(matrix_3by2)
qr(matrix_3by2)
svd(matrix_3by2)
var(matrix_3by2)


#other stuff I find useful

#package ESSURVEY
# INSTALL AND LOAD THE PACKAGES -------------------------------------------


library(essurvey)  

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

#fivenum(x)

fivenum(Germany$nwspol, na.rm = T)



