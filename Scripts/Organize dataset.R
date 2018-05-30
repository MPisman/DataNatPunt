#Load packages
library(tidyverse)

#Load raw dataset
DataNatPun<-read.csv("D:\\OneDrive - UGent\\PhD wild pollinators\\Project Bijenindicator Natuurpunt\\Dataset kleurvallen plus transects.csv")
#Check dataset levels
levels(DataNatPun$Genus)
levels(DataNatPun$Species)
levels(DataNatPun$Soortnaam)

#Group species
#Group all lucorum, terrestris and cryptarum sightings to terrestrisgroup
Bombusgroup<-"terrestris|cryptarum|lucorum|terrestris audax|terrestris/lucorum"
DataNatPun$Species <- as.factor(gsub(Bombusgroup, "terrestris agg", DataNatPun$Species))
DataNatPun$Soortnaam <- as.factor(gsub(Bombusgroup,"terrestris agg", DataNatPun$Soortnaam))
#Check new levels
levels(DataNatPun$Species)
levels(DataNatPun$Soortnaam)

#Change non-species level entries to NA in "Species" and "Soortnaam"


DataNatPunSpec <- filter(DataNatPun,grepl("/|-", DataNatPun$Soortnaam))

levels(DataNatPunSpec$Soortnaam)
