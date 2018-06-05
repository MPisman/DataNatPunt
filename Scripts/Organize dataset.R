#Load packages
library(tidyverse)

##Dataset bees pantraps and transects

#Load raw dataset
DataNatPun<-read.csv("D:\\OneDrive - UGent\\PhD wild pollinators\\Project Bijenindicator Natuurpunt\\Dataset kleurvallen plus transects.csv")
#Check dataset levels
levels(DataNatPun$Genus) #25 lvls
levels(DataNatPun$Species) #152 lvls
levels(DataNatPun$Soortnaam) #165 lvls

#Group species and remove incomplete determination

#Group all lucorum, terrestris and cryptarum sightings to terrestrisgroup
Bombusgroup<-"terrestris|cryptarum|lucorum|terrestris audax|terrestris/lucorum"
DataNatPun$Species <- as.factor(gsub(Bombusgroup, "terrestris agg", DataNatPun$Species)) #-3 lvls => 149
DataNatPun$Soortnaam <- as.factor(gsub(Bombusgroup,"terrestris agg", DataNatPun$Soortnaam)) #-4 lvls => 161

#Change non-species level entries to NA in "Species" and "Soortnaam" (35 entries to NA)
DataNatPun$Species<-as.factor(gsub(".*spec.*", NA, DataNatPun$Species)) #-1 lvl => 148
DataNatPun$Soortnaam<-as.factor(gsub(".*spec.*",NA,DataNatPun$Soortnaam)) #-8 lvls => 153

#Remove or group other determinations
#Andrena minutula group (minutula:6, minutula gr:2, minutula/subopaca:4, subopaca:23 => merge all to minutula agg (35 ind.))
minutulaAgg<-".*minutula.*|.*subopaca.*"
DataNatPun$Species<-as.factor(gsub(minutulaAgg, "minutula agg", DataNatPun$Species)) #-3 lvls => 145
DataNatPun$Soortnaam<-as.factor(gsub(minutulaAgg, "Andrena minutula agg", DataNatPun$Soortnaam)) #-3 lvls => 150
#Andrena ovatula group (lathyri:1, similis:0, wilkella:10, ovatula:1, ovatula gr.:10 => merge all to ovatula agg (22 ind.))
ovatulaAgg<-".*lathyri.*|.*wilkella.*|.*ovatula.*"
DataNatPun$Species<-as.factor(gsub(ovatulaAgg, "ovatula agg", DataNatPun$Species)) #-3 lvls => 142
DataNatPun$Soortnaam<-as.factor(gsub(ovatulaAgg, "Andrena ovatula agg", DataNatPun$Soortnaam)) #-3 lvls => 147

#Andrena flavipes/gravida (Flavipes:319, Gravida:22, Flavipes/Gravida:2 => Flavipes/Gravida to NA)
#Colletes daviesanus/fodiens/similis (daviesanus:23, similis:1, daviesanus/fodiens/similis:1 => daviesanus/fodiens/similis to NA)
#Lasioglossum leucozonium/zonulum (leucozonium: 30, zonulum: 40, leucozonium/zonulum:5 => leucozonium/zonulum to NA)
#Nomada fucata/bifasciata (fucata:22, bifasciata:6, fucata/bifasciata:2 => fucata/bifasciata to NA)

#Species to NA (10 entries to NA, 45 in total at the end)
SpeciesToNA<-".*flavipes/gravida.*|.*daviesanus/fodiens/similis.*|.*leucozonium/zonulum.*|.*fucata/bifasciata.*"
DataNatPun$Species<-as.factor(gsub(SpeciesToNA, NA, DataNatPun$Species)) #-4 lvls => 138
DataNatPun$Soortnaam<-as.factor(gsub(SpeciesToNA, NA, DataNatPun$Soortnaam)) #-4 lvls => 143

#Change Chalicodoma to Megachile
DataNatPun$Genus<-as.factor(gsub("Chalicodoma", "Megachile", DataNatPun$Genus)) #-1 lvl => 24
DataNatPun$Soortnaam<-as.factor(gsub("Chalicodoma", "Megachile", DataNatPun$Soortnaam)) #-1 lvl => 142
#Change Hoplitis to Osmia
DataNatPun$Genus<-as.factor(gsub("Hoplitis", "Osmia", DataNatPun$Genus)) #-1 lvl => 23
DataNatPun$Soortnaam<-as.factor(gsub("Hoplitis", "Osmia", DataNatPun$Soortnaam)) #-1 lvl => 141

#Check number of individuals per species and soortnaam
DataNatPunSpec<- DataNatPun %>%
  group_by(Species) %>%
  summarise(Aantal=sum(Aantal))

DataNatPunSoort<- DataNatPun %>%
  group_by(Soortnaam) %>%
  summarise(Aantal=sum(Aantal))

#Dataset checked: difference in Species and Soortnaam levels caused by fucata, gibbus and hyalinatus belonging to 2 genera


#Dataset plantencomposition per location

#Load raw dataset
DataNatPunPlant<-read.csv("D:\\OneDrive - UGent\\PhD wild pollinators\\Project Bijenindicator Natuurpunt\\Dataset plantensoorten per locatie per tijdstip.csv")

#Change column locations to rows
DataNatPunPlant<-gather(data=DataNatPunPlant, key="Location", value="Abundance",select=5:83)
#Delete columns with NA values
DataNatPunPlant<-filter(DataNatPunPlant, !is.na(Abundance)) %>%
  #Seperate location and period into 2 columns
  separate(Location, c("Lokatie","Periode"), "_") %>%
  select(Lokatie, Periode, Familie, Genus, Latijnse.soortsnaam, Nederlandse.soortsnaam, Abundance)
#Set Location and Period as factor
DataNatPunPlant$Lokatie<-as.factor(DataNatPunPlant$Lokatie)
DataNatPunPlant$Periode<-as.factor(DataNatPunPlant$Periode)


#Dataset GIS analyse

#Load raw dataset
DataNatPunGIS<-read.csv("D:\\OneDrive - UGent\\PhD wild pollinators\\Project Bijenindicator Natuurpunt\\Landschapsanalyse locaties.csv")

#Select relevant columns
DataNatPunGIS<-select(DataNatPunGIS, Lokatie, Habitat, Afstand, PercSNPos, PercAkker)
