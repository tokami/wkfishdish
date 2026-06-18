## Install the package
remotes::install_github("tokami/DATRASextra", ref = "dev")

require(DATRASextra)

data_dir <- "~/Documents/DATRAS/exchange/"
fig_dir <- "figs"
dir.create(fig_dir)


## years
years <- 1991:2025

## surveys with beam trawl gears and NS-IBTS GOV
surveys <- c("NS-IBTS","BTS","SNS","DYFS")


## beam trawls
gears <- c("GOV","BT4A","BT8","BT4AI","BT7","BT4S","BT3","BT6")


## download / read-in data
## dat0 <- download_datras(surveys = surveys,
##                         years = years,
##                         path = data_dir)

dat0 <- read_datras(path = data_dir,
                    surveys = surveys,
                    years = years)

table(dat0$Quarter,dat0$Gear)
table(dat0$Quarter,dat0$Survey)
table(dat0$Gear,dat0$Survey)

d <- subset(dat0,Quarter=="3") 

## Note, Turbot changed latin name!
species = c("Pleuronectes platessa", "Limanda limanda",
              "Scophthalmus rhombus","Psetta Maxmia", "Microstomus kitt", 
            "Hippoglossoides platessoides", "Platichthys flesus", "Hippoglossus hippoglossus")

## calculate swept area
d.spec <- add_swept_area(d.spec)
## add numbers at length
d.spec <- add_numbers_at_length(d.spec)

d.spec <- add_weight_at_length(d.spec, lookup_as_backup = TRUE)

d.spec <- add_total_weight_by_haul(d.spec)

table(d.spec$HaulWgt==0,d.spec$Survey)
table(d.spec$HaulWgt==0,d.spec$Gear)
