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
#   4) Generate line graphs
# 
#   5) Incorporate margins of error into the graphs
# 
#   6) Add theme_hsl_base to the plots!
#   
#   7) Troubleshoot anything that looks bad