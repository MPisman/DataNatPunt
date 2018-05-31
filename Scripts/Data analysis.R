#Load packages
library(ggplot2)


#Create dataset species diversity
DataNatPunLoc<- DataNatPun %>%
  group_by(Lokatie, Habitat, Periode) %>%
  summarise(Aantal=n_distinct(Soortnaam))

#Scatterplot

DataNatPunGras<-filter(DataNatPunLoc, Habitat=="Grasland")
ggplot(DataNatPunGras, aes(x=Lokatie,y=Aantal))+
  geom_point()

DataNatPunBum<-filter(DataNatPun, Genus=="Bombus")
DataNatPunBumLoc<- DataNatPunBum %>%
  group_by(Lokatie, Habitat) %>%
  summarise(Aantal=n_distinct(Soortnaam))




DataNatPunSol<-filter(DataNatPun, Genus!="Bombus") %>%
  filter(Genus!="Apis")

DataNatPunNoPar<-filter(DataNatPunSol, Genus!="Nomada") %>% 
  filter(Genus!="Sphecodes") %>%
  filter(Genus!="Coelioxys")

levels(DataNatPun$Genus)
levels(DataNatPunNoPar$Genus)

DataNatPunNoParLoc<- DataNatPunNoPar %>%
  group_by(Lokatie, Habitat) %>%
  summarise(Aantal=n_distinct(Soortnaam))
