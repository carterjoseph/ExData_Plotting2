#6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California 

#Reading data

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#Loading packages

library(dplyr)
library(ggplot2)

#Filtering data 

Motordata <- filter(NEI, type == "ON-ROAD" & (fips == "24510" | fips == "06037"))

#Grouping data by the year and fips. Finding the sum of emissions for each group.

Motordata_year_group<- group_by(Motordata, year, fips)
Motordata_year_group_sum <- summarise(Motordata_year_group, Sum = sum(Emissions))

#Renaming entries and columns in data frame. 

Motordata_year_group_sum[Motordata_year_group_sum == '24510'] <- 'Baltimore City, Maryland'
Motordata_year_group_sum[Motordata_year_group_sum == '06037'] <- 'Los Angeles, California'

Motordata_year_group_sum <-  rename(Motordata_year_group_sum, City = fips)

#Plot line graph.

png("plot6.png", width=480, height=480)

ggplot(Motordata_year_group_sum, aes(year, Sum, color = City)) +
  geom_point(size = 3) + 
  geom_line() +
  labs(title = "PM2.5 Motor emissions in US Cities", hjust = "0.5") +
  labs(x = "Year", y = "PM2.5 Motor emissions (tons)") +
  ylim(0, 5000) +
  theme_classic(base_family = "Arial") +
  theme(plot.title = element_text(hjust = 0.5))

dev.off()