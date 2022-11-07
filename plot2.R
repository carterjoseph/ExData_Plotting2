#2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland

#Reading data

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#Loading packages

library(dplyr)

#Filtering data

Maryland <- filter(NEI, fips == "24510")

#Grouping data by year. Finding the sum of emissions for each group. 

Maryland_year_group<- group_by(Maryland, year)
Maryland_year_group_sum <- summarise(Maryland_year_group, Sum = sum(Emissions))

#Plot barplot

png("plot2.png", width=480, height=480)

bp <- with(Maryland_year_group_sum, 
           barplot(Sum, 
                   names.arg = year, 
                   ylim = c(0,4000),
                   main = "PM2.5 emissions in Baltimore City, Maryland",
                   xlab = "Year",
                   ylab = "PM2.5 emissions (tons)",
                   col = "firebrick1"
                   
           ))

text(bp, round(Maryland_year_group_sum$Sum,3), label = round(Maryland_year_group_sum$Sum,3), pos = 3, cex = 1.2)

dev.off()