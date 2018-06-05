
#Create dataset bee species diversity per location
#All species
DataNatPunLoc<- DataNatPun %>%
  group_by(Lokatie, Habitat, Periode) %>%
  summarise(Aantal=n_distinct(Soortnaam))

#Only bumble bees
DataNatPunBum<-filter(DataNatPun, Genus=="Bombus")
DataNatPunBumLoc<- DataNatPunBum %>%
  group_by(Lokatie, Habitat, Periode) %>%
  summarise(AantalBum=n_distinct(Soortnaam))

#Only solitary bees
DataNatPunSol<-filter(DataNatPun, Genus!="Bombus") %>%
  filter(Genus!="Apis")

DataNatPunSolLoc<- DataNatPunSol %>%
  group_by(Lokatie, Habitat, Periode) %>%
  summarise(AantalSol=n_distinct(Soortnaam))


###
#DataNatPunNoPar<-filter(DataNatPunSol, Genus!="Nomada") %>% 
#  filter(Genus!="Sphecodes") %>%
#  filter(Genus!="Coelioxys")

#levels(DataNatPun$Genus)
#levels(DataNatPunNoPar$Genus)
###


#Create dataset plant species diversity
DataNatPunPlantLoc<- DataNatPunPlant %>%
  group_by(Lokatie, Periode) %>%
  summarise(AantalPlant=n_distinct(Latijnse.soortsnaam))

#Merge datasets bees, plants and GIS
DataNatPunDiv<-left_join(DataNatPunSolLoc,DataNatPunPlantLoc, by=c("Lokatie"="Lokatie", "Periode"="Periode"))
DataNatPunDiv<-left_join(DataNatPunDiv, DataNatPunBumLoc, by=c("Lokatie"="Lokatie","Periode"="Periode", "Habitat"="Habitat"))
DataNatPunDivGIS<-left_join(DataNatPunDiv,DataNatPunGIS, by=c("Lokatie"="Lokatie","Habitat"="Habitat"))
#Replace NA with zero for AantalBum and AantalSol
DataNatPunDivGIS$AantalBum <- replace_na(DataNatPunDivGIS$AantalBum, 0)



                         