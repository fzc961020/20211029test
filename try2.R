#The room is too shiny....
library(tidyverse)
library(here)
library(sf)
library(janitor)

mycsv <- read_csv('Gender Inequality Index (GII)_only2.csv',na = c("..", "NA"))
class(mycsv)

myshape <- st_read(here::here("World_Countries_(Generalized)","World_Countries__Generalized_.shp"))
filcsv <- mycsv%>%
  clean_names()%>%
  filter(x2019 !="..")
filcsv2 <- mycsv%>%
  filter(x2010!="..")
diffcsv <- filcsv2%>%
  mutate(diff = x2019-x2010)

library(maptools)
library(RColorBrewer)
library(classInt)
library(sp)
library(rgeos)
library(tmap)
library(tmaptools)
library(sf)
library(rgdal)
library(geojsonio)


#EW is the data we read in straight from the web
worldmap <- myshape %>%
  clean_names()%>%
# the . here just means use the data already loaded
  merge(.,
        diffcsv, 
        by.x="country", 
        by.y="Country",
        no.dups = TRUE)
tmap_mode('plot')
worldmap%>%
  qtm(.,fil='diff')

library(usethis)
use_github()
