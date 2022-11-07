#5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#Reading data

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#Loading Packages

library(dplyr)

#Filtering data

Motordata <- filter(NEI, type == "ON-ROAD" & fips == "24510")

#Grouping data by year. Finding the sum of emissions for each group

Motordata_year_group<- group_by(Motordata, year)
Motordata_year_group_sum <- summarise(Motordata_year_group, Sum = sum(Emissions))

#Plot barplot

png("plot5.png", width=480, height=480)

bp <- with(Motordata_year_group_sum, 
           barplot(Sum, 
                   names.arg = year, 
                   ylim = c(0,500),
                   main = "PM2.5 Motor emissions in Baltimore City, Maryland",
                   xlab = "Year",
                   ylab = "PM2.5 Motor emissions (tons)",
                   col = "darkgreen"
           ))
text(bp, round(Motordata_year_group_sum$Sum,3), label = round(Motordata_year_group_sum$Sum,3), pos = 3, cex = 1.2)

dev.off()