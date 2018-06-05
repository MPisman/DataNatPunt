#Load packages
library(ggplot2)
library(lme4)
library(MASS)
library(lsmeans)
library(car)
library(multcomp)
#Analysis 200m
DataNatPun200m<-filter(DataNatPunDivGIS, Afstand==200)

#Graslanden
DataNatPun200mGras<-filter(DataNatPun200m, Habitat=="Grasland")


glm1<-glm.nb(AantalSol~AantalPlant*PercAkker*Periode, data=DataNatPun200mGras)
summary(glm1)
Anova(glm1,type="3")

#Remove 3way interaction
glm2<-glm.nb(AantalSol~AantalPlant*PercAkker+PercAkker*Periode+AantalPlant*Periode, data=DataNatPun200mGras)
summary(glm2)
Anova(glm2,type="3")

#Remove PercAkker*Periode
glm3<-glm.nb(AantalSol~AantalPlant*PercAkker+AantalPlant*Periode, data=DataNatPun200mGras)
summary(glm3)
Anova(glm3,type="3")

#Remove AantalPlant*Periode
glm4<-glm.nb(AantalSol~AantalPlant*PercAkker+Periode, data=DataNatPun200mGras)
summary(glm4)
Anova(glm4,type="3")

#Remove AantalPlant*PercAkker
glm5<-glm.nb(AantalSol~AantalPlant+PercAkker+Periode, data=DataNatPun200mGras)
summary(glm5)
Anova(glm5,type="3")
lsmeans(glm5,~Periode)
summary(glht(glm5,mcp(Periode="Tukey")))

#Scatterplot

DataNatPunGras<-filter(DataNatPunDivGIS, Habitat.x=="Grasland")
DataNatPunGras<-filter(DataNatPunGras, Periode=="C")
DataNatPunGras<-filter(DataNatPunGras, Afstand=="200")
ggplot(DataNatPunGras, aes(x=Aantal.y,y=Aantal.x,color=Periode))+
  geom_point()


glm1<-glm.nb(Aantal.x~Aantal.y*PercAkker, data=DataNatPunGras)
summary(glm1)



