#1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

#Reading data 

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#Loading packages

library(dplyr)

#Grouping data by year. Finding the sum of emissions for each group. 

NEI_year_group<- group_by(NEI, year)
NEI_year_group_sum <- summarise(NEI_year_group, Sum = sum(Emissions))

#Plot barplot 

png("plot1.png", width=480, height=480)

bp <- with(NEI_year_group_sum, 
     barplot(Sum/1000000, 
             names.arg = year, 
             ylim = c(0,8),
             main = "PM2.5 emissions in the United States",
             xlab = "Year",
             ylab = "PM2.5 emissions (megatons)",
             col = "aquamarine3"
             
             ))

text(bp, round(NEI_year_group_sum$Sum/1000000,3), label = round(NEI_year_group_sum$Sum/1000000,3), pos = 3, cex = 1.2)

dev.off()