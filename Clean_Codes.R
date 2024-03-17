library(MASS)
require(foreign)
require(ggplot2)
require(maptools)
library(tidyverse)
library(betareg)
library(car)
library(gapminder)
library(dplyr)
library(ggplot2)
library(dplyr)
library(patchwork) # To display 2 charts together
library(hrbrthemes)
library(psych) # for descriptive analysis
library(forecast)
library(lmtest)
library(tseries)

##Descriptive
##WORLD SUMMARY

#MAP EM

worldCFR <- read.csv("E:\\ResearchProject\\Najmul Bhai\\Meta Analysis RSVI CFR\\CFR_RSVI.csv")

# COVID2022$location[COVID2022$location == 'United States'] <- 'USA'
# COVID2022$location[COVID2022$location == 'United Kingdom'] <- 'UK'
# COVID2022$location[COVID2022$location == 'Democratic Republic of Congo'] <- 'Democratic Republic of the Congo'
# COVID2022$location[COVID2022$location == 'Congo'] <- 'Republic of Congo'


library(dplyr)
library(stringr)
library(ggplot2)
library(maps)

options(scipen = 999) ## To disable scientific notation
world <- map_data("world")
View(world)
worldplot <- ggplot() +
  geom_polygon(data = world, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)
worldplot


worldgovt <- dplyr::select(worldCFR, region = Country, emlog = CFR, "CC" =  iso_code)
head(worldgovt)


## Make the HDI numeric
worldgovt$em <- as.numeric(as.character(worldgovt$emlog))
worldSubset <- inner_join(world, worldgovt, by = "region")
head(worldSubset)


## Let's ditch many of the unnecessary elements
plain <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank(),
  panel.background = element_rect(fill = "white"),
  plot.title = element_text(hjust = 0.5)
)

worldCFR <- ggplot(data = worldSubset, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) +
  geom_polygon(aes(fill = em)) +
  scale_fill_distiller(palette ="Reds", direction = 1) + # or direction=1
  ggtitle("") + labs(fill = "CFR (%)") +
  plain
x <- plot(worldCFR)
x

