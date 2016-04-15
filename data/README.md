# Project: Movies
### Data folder

The data directory contains data used in the analysis. This is treated as read only; in paricular the R/python files are never allowed to write to the files in here. Depending on the project, these might be csv files, a database, and the directory itself may have subdirectories.

Because shinyapps.io require data to be stored in a "www"" folder, some of the data files necessary for running the Shiny app are located at lib/movieShiny/www