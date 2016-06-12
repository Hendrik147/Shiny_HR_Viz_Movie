# Shiny_HR_Viz_Movie

For my own learning process I have been trying to replicate the Shiny gallery example "051-movie-explorer" available from the following link:
https://github.com/rstudio/shiny-examples/tree/master/051-movie-explorer

I think the "movie explorer" example is very typical for HR visualisations. Scatter plots are heavily used in HR and I would benefit from mastering those in Shiny.
The csv files are completely made up HR data, although similar to what I would be able to extract from my own SAP HCM environment.

Ideally I would like to be able to produce a shiny app which starts with one click after having dowloaded all the files onto the my PC 
with the usual command to start Shiny:   

shiny::runApp()

The scatter plots were working on my computer and were beautifully updating upon changes of the x and y axes. 
The tooltip was also working very well.

I did not succeed in making the so called text input filters to work: contract, grade and the last name initial.
I did not manage to publish on shinyapps.io, as the server appears to refuse to run my code as it goes immediately gray.
