#4. How have emissions from coal combustion-related sources changed from 1999–2008?
  
#Reading data

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#Loading packages 

library(dplyr)

#Filtering data 

coaldata <- filter(SCC, grepl("Coal", EI.Sector)) #Filters data by entries containing 'Coal' within the EI.Sector column of SCC
SCCCoal <- select(coaldata, SCC, EI.Sector) #Creates new dataframe showing just the SCC value and EI.Sector columns
NEICoal <- filter(NEI, SCC %in% SCCCoal$SCC) #Filters data in NEI by SCC value that match (%>%) with the SCC values in the filtered SCC dataframe.

#Grouping data by year. Finding the sum of emissions for each group. 

NEI_year_group<- group_by(NEICoal, year)
NEI_year_group_sum <- summarise(NEI_year_group, Sum = sum(Emissions))

#Plot barplot

png("plot4.png", width=480, height=480)

bp <- with(NEI_year_group_sum, 
           barplot(Sum/1000, 
                   names.arg = year, 
                   ylim = c(0,700),
                   main = "PM2.5 coal emissions in the United States",
                   xlab = "Year",
                   ylab = "PM2.5 coal emissions (kilotons)",
                   col = "grey47"
                   
           ))

text(bp, round(NEI_year_group_sum$Sum/1000,3), label = round(NEI_year_group_sum$Sum/1000,3), pos = 3, cex = 1.2)

dev.off()

