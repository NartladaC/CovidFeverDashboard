################################################################################
# global.R
################################################################################

##### Load packages #####
library(tidyverse)
library(lubridate)
library(sf)
library(ggsci)

shapefile_folder <- "./Maps/"
source('./function.R')

#############
# Data Load #
#############
githubURL <- "https://github.com/NartladaC/CovidFeverData/raw/main/Data/CFDashboard.RData"
load(url(githubURL))
# load('C:/Projects/CovidFever/R/CovidFeverData/Data/CFDashboard.RData')

##########
# Colors #
##########
color_scr <- '#a1caf1'
color_age <- '#a1caf1'
color_gender <- c('#a1caf1', '#d8bfd8', '#ebe6e5')
color_eli <- '#a1caf1'
color_enr <- '#ace1af'
color_pos <- '#b78f62'
color_qual <- c('#ffcba4',
                '#b78f62',
                '#f8de7e',
                '#d8bfd8',
                '#a1caf1',
                '#ace1af',
                '#ebe6e5')
color_posneg <- c('#b78f62','#a1caf1','#ebe6e5')
color_scale1 <- c('#81613c','#b78f62','#ebe6e5','#a1caf1','#1a67af')
color_scale2 <- c('#e0edfa','#c0dcf6','#a1caf1','#5e99d0','#1a67af')

###############
# Study sites #
###############
world        <- st_read(paste0(shapefile_folder, "World_Countries.shp"),
                        stringsAsFactors = FALSE)
th_province  <- st_read(paste0(shapefile_folder, "ThailandProvince.shp"),
                        stringsAsFactors = FALSE)
th_district  <- st_read(paste0(shapefile_folder, "Amphoe77.shp"), 
                        stringsAsFactors = FALSE)

world <- world %>%
  mutate(
    my_nudge_x = case_when(ISO == 'MM' ~ 1.7,
                           ISO == 'MY' ~ -0.1,
                           TRUE ~ 0),
    my_nudge_y = case_when(ISO == 'MM' ~ 1,
                           ISO == 'MY' ~ 1.59,
                           TRUE ~ 0),
    COUNTRY = ifelse(ISO == 'TH', NA, COUNTRY)
  )
tak_district <- th_district %>% filter(ProvID == 63)
np_district  <- th_district %>% filter(ProvID == 48)

cf_province  <- th_province %>% filter(ProvNum %in% c(48, 63))
cf_tak       <- tak_district %>% filter(AmphoeID %in% c("05", "06", "08"))
cf_np        <- np_district %>% filter(AmphoeID %in% c("01", "05", "08"))

map_cf_province <- ggplot() +
  geom_sf(data = world,
          fill = "gray95",
          size = 0.5) +
  geom_sf(data = th_province,
          fill = "grey80",
          size = 0.5) +
  geom_sf(data = cf_province,
          fill = "#dd4b39") +
  geom_sf_text(data = world,
               aes(label = COUNTRY),
               nudge_x=world$my_nudge_x,nudge_y=world$my_nudge_y,
               size = 4) +
  geom_sf_text(data = cf_province, 
               aes(label = ProvName),
               size = 4) +
  coord_sf(xlim = c(97, 106),
           ylim = c(6, 20),
           expand = TRUE) + 
  theme_void()

map_cf_tak <- ggplot() +
  geom_sf(data = tak_district, 
          fill = "grey95") +
  geom_sf(data = cf_tak, aes(fill = AmphoeE)) +
  geom_sf_text(data = cf_tak,
            aes(label = AmphoeE),
            size = 4) +
  coord_sf(xlim = c(371000, 544000),
           ylim = c(1688000, 1965000)) +
  scale_fill_manual(values = c("#f8de7e", "pink", "#a1caf1")) +
  theme_void() +
  theme(legend.position = "none")

map_cf_np <- ggplot() +
  geom_sf(data = np_district, 
          fill = "grey95") +
  geom_sf(data = cf_np, aes(fill = AmphoeE)) +
  geom_sf_text(data = cf_np,
            aes(label = AmphoeE),
            size = 4) +
  coord_sf(xlim = c(1026500, 1123500),
           ylim = c(1870000, 1995000)) +
  scale_fill_manual(values = c('#ffcba4', '#d8bfd8', '#ace1af')) +
  theme_void() +
  theme(legend.position = "none")
