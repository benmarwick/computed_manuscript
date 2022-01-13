# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/geospatial:4.0.3

# required
MAINTAINER Ben Marwick <bmarwick@uw.edu>

COPY . /computed_manuscript

## Run an install.R script, if it exists.
RUN if [ -f computed_manuscript/install.R ]; then R --quiet -f computed_manuscript/install.R; fi

# go into the repo directory
RUN . /etc/environment \
  # render the manuscript into a docx
  && R -e "rmarkdown::render('/computed_manuscript/SN_templates.Rmd')"
