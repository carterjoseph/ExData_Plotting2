#3. Which of the four sources have seen decreases in emissions from 1999–2008 for Baltimore City?

#Reading data 

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#Loading packages

library(dplyr)
library(ggplot2)

#Filtering data 

Maryland <- filter(NEI, fips == "24510")

#Grouping data by type and year. Finding the sum of emissions for each group.

Maryland_group <- group_by(Maryland, type, year)
Maryland_group_sum <- summarise(Maryland_group, Sum = sum(Emissions))

#Plot line graph 

png("plot3.png", width=480, height=480)

ggplot(Maryland_group_sum, aes(year, Sum, color = type)) +
  geom_point(size = 3) + 
  geom_line() +
  labs(title = "PM2.5 emissions per source type in Baltimore City, Maryland", hjust = "0.5") +
  labs(x = "PM2.5 emissions (tons)", y = "Year") +
  ylim(0, 2500) +
  theme_classic(base_family = "Arial") +
  theme(plot.title = element_text(hjust = 0.5))

           
dev.off()