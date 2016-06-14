# Shiny_HR_Viz_Movie

For my own learning process I have been trying to replicate the Shiny gallery example "051-movie-explorer" available from the following link:
https://github.com/rstudio/shiny-examples/tree/master/051-movie-explorer

I think the "movie explorer" example is very typical for HR visualisations. Scatter plots are heavily used in HR and I would benefit from mastering those in Shiny.
The two csv files are completely made up HR data, although similar to what I would be able to extract from my own SAP HCM environment. The data relate to absences, excess time worked by staff and flexi leave taken.

Ideally I would like to be able to produce a shiny app which starts with one click after having dowloaded all the files onto the my PC 
with the usual command to start Shiny:   

shiny::runApp()

The scatter plots were working on my computer and were beautifully updating upon changes of the x and y axes. 
The tooltip was also working well.

I did not succeed in making the so called text input filters to work: contract, grade and the last name initial.
I did not manage to publish on shinyapps.io, as the server appears to refuse to run my code as it goes immediately gray.

This the message that appears 

Warning in validateSelected(selected, choices, inputId) :
  'selected' must be the values instead of names of 'choices' for the input 'yvar'
Warning: Error in eval: could not find function "%like%"

I have no a new warning message:

Warning: Error in eval: object 'Flexileave2015' not found
and I believe it has to do with the missing link between the server file and the initial all_flexitime file.

The following stackoverflow post seems the most matching one to my problem:
http://stackoverflow.com/questions/28483389/r-shiny-error-object-input-not-found

I also found a video from Jonathan McPherson where he explains the debugging techniques:
https://www.rstudio.com/resources/webinars/shiny-developer-conference/




