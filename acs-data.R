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
# install.packages(c("extrafont")) 
library(extrafont) 
extrafont::font_import(pattern = 'Graphik')
extrafont::loadfonts()
library(dplyr)

install.packages("showtext", "sysfonts")
library(sysfonts)
library(showtext)
font_add(family = "National", 
         regular = "National-Regular.ttf",
         italic = "National-LightItalic.ttf",
         bold = "National-Bold.ttf")
font_add(family = "Graphik", 
         regular = "Graphik-Regular.ttf",
         italic = "Graphik-LightItalic.ttf",
         bold = "Graphik-Bold.ttf")


#     
#   3) Read in the data. You can read the .xlsx file in the /Data folder
#   to start. Eventually, though, the data will be pulled using the
#   tidycensus package to more easily update this analysis in the future.
#   https://docs.google.com/document/d/1NEdTzGqZns5OQQMBMvk4qRK73WzihDkRBYgJ6LJtkqI/edit#heading=h.ahnz5pws0xur
# 
# Reading in "Vacancy Rates Comparison
# install.packages("readxl")
library(readxl)
vacancy_rates_1year <- na.omit(read_excel("Data/Vacancy Rates Comparison.xlsx", sheet = 1))
vacancy_rates_5year <- read_excel("Data/Vacancy Rates Comparison.xlsx", sheet = 2)

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

plot_save_include <- function(filename, p = ggplot2::last_plot(), height = 6, width = 10) {
  ggplot2::ggsave(filename, height = height, width = width, dpi = 72)
  knitr::include_graphics(filename)
}


#   6) Add theme_hsl_base to the plots!
# Figure 1. 5 year vacancy rates, 2017-2022
ggplot(vacancy_rates_5year_20172022, aes(x = Year, y = Rate)) +
  geom_line(size = 1.25,
            color = "#1F687E")  + 
  geom_point(color = "#1F687E",
             size = 3) +
  geom_errorbar(ymin = vacancy_rates_5year_20172022$Lower_bound,
                ymax = vacancy_rates_5year_20172022$Upper_bound,
                width = 0.1,
                size = 1.25,
                color = "#1F687E") + 
  scale_y_continuous(labels = scales::percent,
                     limits = c(0, .12),
                     expand = c(0,0)) +
  scale_x_continuous(breaks = c(2017, 2022)) +
  labs(title = "Five-Year Rental Vacancy Rate\nRoanoke, Virginia (2017-2022)",
       y = "",
       x = "",
       caption = "Source: American Community Survey 5-year estimates (2017-2022)") +
  theme_hsl_base(base_family = "Graphik") +
  theme(axis.text.y = element_text(hjust = -0.5,
                                   size = 12),
        axis.text.x = element_text(vjust = -5,
                                   size = 12),
        plot.title = element_text(vjust = 5,
                                  lineheight = 1.4))

plot_save_include('vacancy_fig_1.png')

# Figure 2. 1 year vacancy rates, 2013-2022
vacancy_rates_1year <- vacancy_rates_1year %>%
  filter(Year >= 2013) %>%
  add_row(Span = "1-year", Year = 2020) %>%
  arrange(Year)

vac_1_year_filtered <- vacancy_rates_1year %>%
  filter(Year != 2020)

vac_1_year_filtered %>%
  ggplot(aes(x = Year, y = as.numeric(Rate),
             group = 1)) +
  geom_line(size = 1.25,
            color = "#1F687E",
            na.rm = TRUE)  + 
  geom_point(color = "#1F687E",
             size = 3) +
  geom_errorbar(ymin = vac_1_year_filtered$`Lower bound`,
                ymax = vac_1_year_filtered$`Upper bound`,
                width = 0.2,
                size = 1.25,
                color = "#1F687E") + 
  theme_hsl_base()+ 
  scale_y_continuous(labels = scales::percent,
                     limits = c(0, .16),
                     expand = c(0,0)) +
  scale_x_continuous(breaks = vacancy_rates_1year$Year) +
    labs(title = "One-Year Rental Vacancy Rate\nRoanoke, Virginia (2013-2022)",
         y = "",
         x = "",
         caption = "Source: American Community Survey 1-year estimates (2013-2022)") +
    theme_hsl_base(base_family = "Graphik") +
    theme(axis.text.y = element_text(hjust = -0.05,
                                     size = 12),
          axis.text.x = element_text(vjust = -0.1,
                                     size = 12,
                                     angle = 30),
          plot.title = element_text(vjust = 5,
                                    lineheight = 1.4))

plot_save_include('vacancy_fig_2.png')

#   7) Troubleshoot anything that looks bad