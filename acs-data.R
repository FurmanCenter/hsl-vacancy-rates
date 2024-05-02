# Interpreting Vacancy Rates graphs

# This script generates the graphs for the LHS piece on 
# interpreting vacancy rates. The text of the piece can be found here:
# https://docs.google.com/document/d/1IKmX7--DEdvW1GevJMufmS0OJOcKYeXykLtsnkZYTzw/edit
# The two figures included will be recreated in R for publication purposes.
# 
# The output for this project should be two graphs showing how 
# ACS 5-year and ACS 1-year vacancy rate estimates have changed over time for
# Roanoke, VA. The instructions for completing this task are as follows:
#   
#   1) Install Github for Desktop if you haven't already and clone the 
#   hsl-vacancy-rates repository to your local Github folder
#   https://docs.google.com/document/d/1zMxQlManaq5Z3O6Iz0GlLq5Gm-Rg4Uj8ZmbmuLUWtd0/edit#heading=h.p3tkmvhrulld
#   
#   2) If you haven't already, install the fcthemes package:
#   https://docs.google.com/document/d/1eDEKDMkVxyaZecLQEONHDBreNLB2F-W6X2-OpgBVWJ4/edit#heading=h.ipr8ahqg0jam
#   Be sure to download the Lab Graphik font!

library(fcthemes)
install.packages(c("extrafont")) 
library(extrafont) 
extrafont::font_import(pattern = 'Graphik')
extrafont::loadfonts()

#     
#   3) Read in the data. You can read the .xlsx file in the /Data folder
#   to start. Eventually, though, the data will be pulled using the
#   tidycensus package to more easily update this analysis in the future.
#   https://docs.google.com/document/d/1NEdTzGqZns5OQQMBMvk4qRK73WzihDkRBYgJ6LJtkqI/edit#heading=h.ahnz5pws0xur
# 
# Reading in "Vacancy Rates Comparison
install.packages("readxl")
library(readxl)
vacancy_rates_1year <- na.omit(read_excel("C:/Users/nbc9285/Documents/GitHub/hsl-vacancy-rates/Data/Vacancy Rates Comparison.xlsx", sheet = 1))
vacancy_rates_5year <- read_excel("C:/Users/nbc9285/Documents/GitHub/hsl-vacancy-rates/Data/Vacancy Rates Comparison.xlsx", sheet = 2)

#   4) Generate line graphs
# 
# Figure 1. Roanoke Rental Vacancy Rates, 2017-2022
library(ggplot2)
## Creating data frame for fig 1 to exclude years between 2017 and 2020
vacancy_rates_5year_20172022 <- data.frame(
  Span = c("5-year, 5-year") ,
  Year = c(2017, 2022) ,
  Rate = c(0.081, 0.090) , 
  Margin_error = c(0.015, 0.017),
  Lower_bound = c(0.066, 0.073) ,
  Upper_bound = c(0.096, 0.107)
)

ggplot(vacancy_rates_5year_20172022, aes(x = Year, y = Rate)) +
  geom_line() +
  ylim(0, 0.12)


# Figure 2. Roanoke Rental Vacancy Rates, 2013-2022
ggplot(vacancy_rates_1year, aes(x = Year, y = Rate, group = 1)) +
    geom_line()
#   5) Incorporate margins of error into the graphs
# 
# Figure 1. Roanoke Rental Vacancy Rates, 2017-2022
ggplot(vacancy_rates_5year_20172022, aes(x = Year, y = Rate)) +
  geom_line() +
  ylim(0, 0.12) + 
  geom_point() +
  geom_errorbar(ymin = vacancy_rates_5year_20172022$Lower_bound, ymax = vacancy_rates_5year_20172022$Upper_bound, width=1)

# Figure 2. Roanoke Rental Vacancy Rates, 2013-2022
ggplot(vacancy_rates_1year, aes(x = Year, y = Rate, group = 1)) +
  geom_line() +
  geom_point() +
  geom_errorbar(aes(ymin = `Lower bound`, ymax = `Upper bound`), width=1) 

#   6) Add theme_hsl_base to the plots!
# Figure 1. Roanoke Rental Vacancy Rates, 2017-2022
ggplot(vacancy_rates_5year_20172022, aes(x = Year, y = Rate)) +
  geom_line()  + 
  geom_point() +
  geom_errorbar(ymin = vacancy_rates_5year_20172022$Lower_bound, ymax = vacancy_rates_5year_20172022$Upper_bound, width=1) + 
  theme_hsl_base()+ 
  ylim(0, 0.12) +
  ylab("Rental Vacancy Rate") + 
  ggtitle("Roanoke Rental Vacancy Rates, ACS 5-year  estimates (2012-2016 to 2017-2021)")


# Figure 2. Roanoke Rental Vacancy Rates, 2013-2022
ggplot(vacancy_rates_1year, aes(x = Year, y = as.numeric(Rate), group = 1)) +
  geom_line() +
  geom_point() +
  geom_errorbar(aes(ymin = `Lower bound`, ymax = `Upper bound`, width=0.5)) + 
  theme_hsl_base()+ 
  scale_y_continuous(labels = scales::percent) +
  ylab("Rental Vacancy Rate") +
  ggtitle ("Roanoke Rental Vacancy Rates, ACS 1-year  estimates (2013 - 2021)")

#   7) Troubleshoot anything that looks bad