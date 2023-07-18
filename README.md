# NEON Forecast Challenge Workshop materials
This is a repository for the NEON Forecasting Challenge workshop materials (updated for Hacking Limnology 2023). This workshop repository is a dynamic repository and may change in future iterations. 

The materials are split into three sections:

* `Submit_forecast` - want to get started with making and submitting forecasts to the Challenge - start here! 
* `Automate_forecasts` - you've made a model and submitted a forecast successfully? Automate your workflow to submit a new forecacst every day 
* `Analyse_scores` - interested in knowing how different forecasts are performing within the Challenge? This is a brief introduction in how to access the scored forecasts and do some simple analyses. 

As part of _Hacking Limnology 2023_ we will aim to complete the first two of these tutorials during the workshop. Below are some pre-workshop instructions to make sure you are ready to go!

__Any questions, email [freyao@vt.edu](mailto:freyao@vt.edu) before the workshop!__

## 1. Setting up your R environment

R version 4.2 is required to run the code in this workshop. You should also check that your Rtools is up to date and compatible with R 4.2, see (https://cran.r-project.org/bin/windows/Rtools/rtools42/rtools.html). 

The following packages need to be installed using the following code.

```{r}
install.packages('remotes')
install.packages('tidyverse') # collection of R packages for data manipulation, analysis, and visualisation
install.packages('lubridate') # working with dates and times
remotes::install_github('eco4cast/neon4cast') # package from NEON4cast challenge organisers to assist with forecast building and submission
```

## 2. Get the code

There are 3 options for getting the code locally so that you can run it, depending on your experience with Github/Git you can do one of the following:

1. __Fork (recommended)__ the repository to your Github and then clone the repository from your Github repository to a local RStudio project. This will allow you to modify the scripts and push it back to your Github. 

- Find the fork button in the top right of the webpage --> Create Fork. This will generate a copy of this repository in your Github.
- Then use the <> Code button to copy the HTTPS link (from you Github!). 
- In RStudio, go to New Project --> Version Control --> Git. 
- Paste the HTTPS link in the Repository URL space, and choose a suitable location for your local repository --> Create Project. 
- Open the .Rmd file

2. __Clone__ the workshop repository to a local RStudio project. Your local workspace will be set up and you can commit changes locally but they won't be pushed back to the Github repository.
- Find the fork button in the top left of the webpage --> Create Fork. 
- Then use the <> Code button to copy the HTTPS link.
- In RStudio go to New Project --> Version Control --> Git. 
- Paste the HTTPS link in the Repository URL space, and choose a suitable location for your local repository --> Create Project. 
- Open the .Rmd file

3. __Download__ the zip file of the repository code. You can save changes (without version control) locally.
- Find the <> Code button --> Download ZIP. 
- Unzip this to a location on your PC and open the `ESA2023_neon4cast_workshop.Rproj` file in RStudio. 

More information on forking and cloning in R can be found at [happygitwithr](https://happygitwithr.com/fork-and-clone.html), a great resource to get you started using version control with RStudio. 


For the workshop you can follow along via the rmarkdown document (`Submit_forecast/NEON_forecast_challenge_workshop_aquatics.Rmd`) or the md (`Submit_forecast/NEON_forecast_challenge_workshop_aquatics.md`), both of which can be downloaded here or you can fork the whole repository.
