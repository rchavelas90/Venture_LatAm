
##R# Read the information (header = country code ISO 3166-1 alpha-2)
market_cap <- read.csv("market_cap_data_no_names.csv",header=T,skip=1)
##R# Get variables to be evaluated
n <- market_cap[[1]]
##R# transpose the data frame without the variables
market_cap2 <- as.data.frame(t(market_cap[,-1]))
##R# paste the variables on the column names
colnames(market_cap2) <- n
##R# Get country names as factors and add it to DF
market_cap2$Country <- factor(row.names(market_cap2))
##R# remove row names as country names are allready included
rownames(market_cap2) <- NULL
##R# rearange DF
market_cap2 <- data.frame(Country=market_cap2$Country,market_cap2[,-ncol(market_cap2)])
str(market_cap2)

##R# Plotting GvisGeoChart
##R# Google dev site https://developers.google.com/chart/interactive/docs/gallery/geochart
##R# googleVis site https://code.google.com/p/google-motion-charts-with-r/
##R# Region specified by the specs by google 
##R# https://google-developers.appspot.com/chart/interactive/docs/gallery/geochart#Continent_Hierarchy
library(googleVis)
colax <-"{ minValue : 50, maxValue : 100, colors : ['E5BB00','#66B203','#05800A']}"
bgcless <- '#E8E8E8'
##R#Kavrayskiy vii projection (world)
eu <- gvisGeoChart(market_cap2, locationvar="Country", colorvar="Overall_score",
                  options=list(region="150",
                               colorAxis=colax,
                               projection="kavrayskiy-vii"
                               ,width=660, height=320,legend="none",
                               datalessRegionColor=bgcless))

sa <- gvisGeoChart(market_cap2, locationvar="Country", colorvar="Overall_score",
                      options=list(region="005",
                                   colorAxis=colax,
                                   projection="kavrayskiy-vii"
                                   ,width=660, height=320,
                                   datalessRegionColor=bgcless))

ca <- gvisGeoChart(market_cap2, locationvar="Country", colorvar="Overall_score",
                   options=list(region="013",
                                colorAxis=colax,
                                projection="kavrayskiy-vii"
                                ,width=660, height=320,legend="none",
                                datalessRegionColor=bgcless))

tb <- gvisTable(market_cap2[1:7],options=list(alternatigRowSytle=F, height=520,sortColumn=1,sortAscending=F))

america <- gvisMerge(ca,sa,horizontal=FALSE,tableOptions ="cellspacing=0")
eutb <- gvisMerge(eu,tb,horizontal=FALSE,tableOptions ="cellspacing=0")
all <- gvisMerge(america,tb,horizontal=T,tableOptions ="cellpadding=0",chartid="Venture_capital_Latin_America")
plot(all)


##R# Por hacer
##R#  - GeoChart
##R#  - Verificar valores
##R#  - Sitio


##R# Dudas
##R#  - Ver en Ipad?
##R#  - Aplicación Shiny o comparativo?


