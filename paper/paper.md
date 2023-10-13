---
title: 'Can you predict the future? A tutorial for the National Ecological Observatory Network Ecological Forecasting Challenge'
tags:
  - R
  - tutorial
  - forecasting
  - NEON
authors:
  - name: Freya Olsson
    orcid: 0000-0002-0483-4489
    affiliation: 1
  - name: Carl Boettiger
    orcid: 0000-0002-1642-628X
    affiliation: 2
  - name: Cayelan C. Carey
    orcid: 0000-0001-8835-4476
    affiliation: 1  
  - name: Mary E. Lofton
    orcid: 0000-0003-3270-1330
    affiliation: 1
  - name: R. Quinn Thomas
    orcid: 0000-0003-1282-7825
    affiliation: 1, 3
affiliations:
 - name: Department of Biological Sciences, Virginia Tech, Blacksburg, Virginia, USA
   index: 1
 - name: Department of Environmental Science, Policy, and Management, University of California, Berkeley, Berkeley, California, USA
   index: 2
 - name: Department of Forest Resources and Environmental Conservation, Virginia Tech, Blacksburg, Virginia, USA
   index: 3
date: 12 October 2023
bibliography: paper.bib
---

# Summary

This tutorial introduces participants to key concepts in ecological forecasting and provides hands-on materials for submitting forecasts to the Ecological Forecasting Initiative (EFI) - National Ecological Observatory Network (NEON) Forecasting Challenge (hereafter, Challenge). The tutorial has been developed and used with more than 300 participants in both classrooms and workshops and provides the ecological understanding, workflows, and tools to enable ecologists with minimal forecasting experience to participate in the Challenge via a hands-on code-based tutorial. This R-based tutorial introduces participants to a near-term, iterative forecasting workflow that includes obtaining observations from NEON, developing a simple forecasting model, generating a forecast, and submitting the forecast to the Challenge, as well as analysing forecast performance once new observations become available for evaluation. The overarching aim of this tutorial is to lower the barrier to ecological forecasting and empower participants to continue to innovate and develop their own ecological forecasts for the Challenge into the future.

# Statement of need

Ecological forecasting is an emerging field which aims to improve natural resource management and ecological understanding by providing future predictions of the state of ecosystems [@Lewis2022], enabling preemptive management action [@Dietze2018]. Generating ecological forecasts requires a suite of quantitative and computational skills, including accessing real-time data, building ecological models, quantifying uncertainty associated with predictions, generating forecasts, and updating models with new observations as they become available [@Dietze2017]. While resources to educate ecologists on these skills individually are available [@Ernest2023], there are few hands-on demonstrations of how to implement a full workflow to generate near-term forecasts. In response to this gap, we developed a tutorial that aims to lower the barrier to forecasting. The tutorial was designed for ecologists who are interested in learning about ecological forecasting through hands-on instruction but may not have prior experience with forecasting. For this group, the tutorial provides an entry point to learn about ecological forecasting concepts by engaging participants in forecasting using real data with a broader purpose. It is also designed for individuals that are interested in submitting forecasts to the Challenge but may not know how to start generating forecasts. For this group this tutorial provides a framework which can be modified and extended to generate forecasts with new modelling approaches that are submitted to the Challenge These new forecasts increase participation in the Challenge, thereby expanding our understanding of environmental predictability by enabling more forecasts to be submitted, resulting in greater possible synthesis across forecast models.

# Background and development

The NEON Forecasting Challenge, hosted by the Ecological Forecasting Initiative Research Coordination Network (EFI-RCN), aims to create a community of practice that builds capacity for ecological forecasting by leveraging recently-available NEON data [@Thomas2023]. The Challenge revolves around five themes (Aquatics, Terrestrial, Phenology, Beetles, Ticks) that span aquatic and terrestrial systems, and population, community, and ecosystem processes across 81 NEON sites spanning the U.S. The motivation of the Challenge is for teams and individuals to forecast the conditions at NEON sites before the data are collected. Forecasts submitted to the Challenge are automatically evaluated against observations when they become available from NEON. By collating forecasts from many different models and sites, the Challenge organisers and participants aim to quantify how ecological predictability varies over space and time.

This tutorial was initially developed for the 2022 Global Lakes Ecological Observatory Network (GLEON) All-Hands' conference, a lake-focused group of undergraduates, graduate students, postdoctoral researchers, and faculty with a range of forecasting and coding experience. The tutorial, which has since been taught in eight workshop/classroom settings (Table 1), has a duration of \~90 minutes. The GLEON workshop was given on the first day of the five-day conference. This timing enabled forecasts that were submitted at the workshop to be evaluated throughout the conference, for participants to see how their forecasts fared in near-real time against newly collected data, and for a "winner" declared on the final day.

+:-------------------------------------------------------+:---------------------------------------+:------------------------------------+:--------------------+
| **Name of meeting or group delivered to**              | **Approximate number of participants** | **Modality**                        | **Challenge theme** |
+--------------------------------------------------------+----------------------------------------+-------------------------------------+---------------------+
| GLEON\* All-Hands conference                           | 50                                     | In-person                           | Aquatics            |
+--------------------------------------------------------+----------------------------------------+-------------------------------------+---------------------+
| InventWater PhD training programme                     | 15                                     | Synchronous on-line                 | Aquatics            |
+--------------------------------------------------------+----------------------------------------+-------------------------------------+---------------------+
| GLEON All-Hands' Virtual conference                    | 70                                     | Asynchronous on-line (pre-recorded) | Aquatics            |
+--------------------------------------------------------+----------------------------------------+-------------------------------------+---------------------+
| AEMON-J\*\*/DSOS\*\*\* Hacking Limnology               | 70                                     | Synchronous on-line                 | Aquatics            |
+--------------------------------------------------------+----------------------------------------+-------------------------------------+---------------------+
| Global Change Ecology Lab,                             | 10                                     | Synchronous on-line                 | Terrestrial         |
|                                                        |                                        |                                     |                     |
| University of Edinburgh                                |                                        |                                     |                     |
+--------------------------------------------------------+----------------------------------------+-------------------------------------+---------------------+
| NEON Technical Working Group on Ecological Forecasting | 10                                     | Synchronous on-line                 | Terrestrial         |
+--------------------------------------------------------+----------------------------------------+-------------------------------------+---------------------+
| Ecological Society of America                          | 50                                     | In-person                           | Terrestrial         |
|                                                        |                                        |                                     |                     |
| Annual conference workshop                             |                                        |                                     |                     |
+--------------------------------------------------------+----------------------------------------+-------------------------------------+---------------------+
| Undergraduate environmental data science class         | 40                                     | In-person                           | Terrestrial         |
+--------------------------------------------------------+----------------------------------------+-------------------------------------+---------------------+
+--------------------------------------------------------+----------------------------------------+-------------------------------------+---------------------+
: Table 1 Implementation of the tutorial by the authors across a range of settings. The participants in these workshops covered a wide range of forecasting and coding experience.

^\*Global Lake Ecological Observatory Network; \*\*Aquatic Ecosystem MOdeling Network - Junior; \*\*\*Data Science Open Science^

# Audience

The audience for this tutorial has evolved over its development and includes individuals who 1) want to participate in the Challenge but are not sure how to start, 2) want a 'hands-on' way to learn about ecological forecasting (as a tool to learn broader concepts) and as a gateway to forecasting (e.g., a university-level class on ecological forecasting); and/or 3) are involved in the broader forecasting enterprise (e.g., researchers collecting data used for forecasting) but want to submit forecasts themselves. We also encourage instructors and individuals to modify the tutorial as they see fit to benefit other audiences, as all materials are open-source.

# Features

## Learning objectives

The overarching objectives of the tutorial are:

1.  Build an understanding of foundational ecological forecasting concepts;
2.  Apply forecasting concepts to submit a simple forecast to the EFI-NEON Forecasting Challenge;
3.  Learn about additional forecasting resources.

These objectives may be adapted depending on the context of the tutorial. If the participant/instructor's goals are geared more towards understanding forecasting concepts then the emphasis of the presentation and hands-on workshop can be modified accordingly.

## Instructional design

The tutorial is provided in a public GitHub repository that includes an introductory presentation (.pptx and .pdf format), an Rmarkdown document, a rendered version of the markdown file (.md), as well as pre-tutorial instructions for participants. The tutorial has been developed to allow for both in-person and virtual participation (see Table 1) and can be completed synchronously as part of an instructor-led workshop or course or asynchronously, in a self-paced tutorial. The tutorial is based in R, which is popular amongst scientists, especially in ecology [@Lai2019] .

## The tutorial

The tutorial is designed as a 90-minute, standalone session that includes an introductory presentation, a guided demonstration of forecast code, and open time for discussion. If a longer time period is available, the tutorial has additional activities and content that includes more advanced topics (Figure 1). In addition, the tutorial can be completed by individuals at their own pace, without a dedicated instructor.

### Pre-tutorial preparation

The GitHub repository (@Olsson2023; <https://github.com/OlssonF/NEON-forecast-challenge-workshop/tree/v1.1.0>) contains information that can be shared with participants before the tutorial to ensure that their R environment is ready prior to attendance. The `README.md` contains instructions for getting started, with multiple options for `Setting up the R Environment` and `Obtaining the Code` that cater to different levels of R and Git/Github familiarity. We have found that higher engagement with participants before the tutorial results in greater engagement during the tutorial, ultimately increasing the number of participants that complete the tutorial.

### Presentation (20-30 minutes)

The introductory Microsoft PowerPoint or PDF presentation introduces the participants to concepts of forecasting, information about the Challenge, and NEON data, and tools that will be used in the R coding portion of the tutorial. This presentation could be tailored to the audience based on their expected familiarity with forecasting concepts and the data being forecasted (shown in Figure 1). The alternate modes of delivery shown in Figure 1 were developed from administering the tutorial to audiences of mixed coding and forecasting experience (Table 1). Following the presentation, participants are encouraged to ask questions, and a break can be taken before Section 2 to enable any remaining pre-tutorial software setup to occur.

### Coding walkthrough (30-40 minutes)

The second part of the tutorial walks participants through a pre-written Rmarkdown script (within the GitHub repository at `Submit_Forecast/NEON_forecast_challenge_workshop_aquatics.Rmd`). This code is written primarily using tidyverse syntax to optimise readability [@Wickham2019]. In addition, the tutorial utilises the functions from the neon4cast R package, developed by Challenge organisers to simplify the collection of weather covariate data and the submission process (see <https://github.com/eco4cast/neon4cast>). The `.Rmd` also includes descriptive text to reinforce some of the ideas introduced in the presentation and allow walk-throughs of the code asynchronously from the presentation (i.e. if a participant is following along without seeing a 'live' presentation). The code guides participants through the stages of forecast development from importing 'target' data (observations), plotting and investigating data, developing a model, generating a forecast, adjusting the format to Challenge standards, and submitting their forecast to the Challenge.

### Open time for discussion, hands-on help, and/or code modification (20-30 minutes)

For a standard 90-minute workshop, remaining time can be used for multiple purposes depending on the interest and abilities of the participants. We have used this time to debug user-specific code issues (package installation etc.), allow participants to modify the forecast model code, explore alternative forecast methods, or form forecasting teams to submit additional forecasts to the Challenge beyond the workshop session. Some potential topics and additional activities are detailed at the end of the `.Rmd`, including code for alternative forecasting methods or possible modifications to the example forecast. Engagement in this part of the tutorial has proved important for promoting continued participation with the Challenge and has been more successful during in-person compared to virtual settings.

### Optional extension with advanced concepts

To extend the tutorial beyond 90 minutes (see Fig. 1), we have provided materials that walk through how forecast submission could be automated (directory `Automate_Forecast`). Automation is a crucial step for iterative, near-term ecological forecasting, and is highly encouraged when participating in the Challenge after completing the tutorial. Finally, materials are available that introduce participants to how a forecast is evaluated and how the *scores* (evaluated forecast performance see @Thomas2023) can be analysed (directory `Analyse_Scores`). The materials could also be used in a self-paced manner after the workshop.

# Reuse, implementation, and modification

The primary tutorial uses the Aquatics theme (specifically, water temperature) as an example of how to generate a forecast, but the tools and workflows are applicable to all themes in Challenge. For example, we adapted the materials to the Terrestrial theme (see Table 1) based on the interests of the participants. Furthermore, we foresee the tutorial also being applicable to other forecasting challenges with only needing to change the targets or observations that are being forecasted.

From both workshops and classroom implementations of the tutorial (Table 1), several lessons learned have emerged that promote successful teaching of these materials. First, engagement in the Challenge after completing the tutorial is best when there is opportunity for follow-up discussion, troubleshooting, and continuation of team collaboration beyond the 90 minutes. For example, the timing of the GLEON workshop was effective as there were many subsequent opportunities for follow-up during the remaining week at the conference. Second, we found that providing installation instructions and preparatory material in advance is crucial to success for participants during synchronous workshops, especially for virtual settings where troubleshooting is more difficult for instructors. Third, the introductory presentation can be substantially adapted to meet the needs and experience level of the participants (Table 1), depending on the pre-workshop familiarity with forecasting concepts. The tutorial's flexibility lends itself to a range of possibility modalities, time allowance, and skills with additional opportunity to include more advanced topics at a later date (see Figure 1).

Finally, the tutorial requires a stable and relatively fast internet connection. We found that slow internet speeds limited access to weather forecasts that are used to generate ecological forecasts, thus causing slower progress in the tutorial. This was especially pronounced at the in-person workshops at large conference centres (i.e., Ecological Society of America annual meeting; Table 1). This issue can be addressed by either having the rendered Rmarkdown document available so that individuals can follow along even if connectivity becomes an issue or providing access to remote computational environments (i.e., students execute code in a virtual machine that performs the data access in centralised data centres with large bandwidth).

![Figure 1 Potential workshop/course structures using this tutorial. The original 90-minute workshop setup is shown as the "regular tutorial" which can be expanded and modified according to the time available, the anticipated skills and background of the participants and the goals of participation. \label{Figure_1}](Figure_1.png)

# Acknowledgments

Work on this tutorial was supported by the National Science Foundation through grants 1926050, 1926388, 1933016, and 2209866. We thank the initial design teams, contributors and participants in the EFI-RCN Challenge, and the many tutorial participants for their enthusiasm,interest, and feedback that has helped us iteratively improve the materials (like our forecasts!).

# References
