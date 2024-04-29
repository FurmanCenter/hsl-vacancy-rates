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
#     
#   3) Read in the data. You can read the .xlsx file in the /Data folder
#   to start. Eventually, though, the data will be pulled using the
#   tidycensus package to more easily update this analysis in the future.
#   https://docs.google.com/document/d/1NEdTzGqZns5OQQMBMvk4qRK73WzihDkRBYgJ6LJtkqI/edit#heading=h.ahnz5pws0xur
# 
# Reading in "Vacancy Rates Comparison"
install.packages("tidycensus")
install.packages("readxl")
vacancy_rates_1year <- na.omit(read_excel("C:/Users/nbc9285/Documents/GitHub/hsl-vacancy-rates/Data/Vacancy Rates Comparison.xlsx", sheet = 1))
vacancy_rates_5year <- read_excel("C:/Users/nbc9285/Documents/GitHub/hsl-vacancy-rates/Data/Vacancy Rates Comparison.xlsx", sheet = 2)
#   4) Generate line graphs
# 
# Figure 1. Roanoke Rental Vacancy Rates, 2017-2022
library(ggplot2)
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
  ylim(0, 0.12)+ 
  scale_y_continuous(labels = scales::percent)

# Figure 2. Roanoke Rental Vacancy Rates, 2013-2022
ggplot(vacancy_rates_1year, aes(x = Year, y = Rate, group = 1)) +
    geom_line()
#   5) Incorporate margins of error into the graphs
# 
#   6) Add theme_hsl_base to the plots!
#   
#   7) Troubleshoot anything that looks bad