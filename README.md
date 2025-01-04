# Categorizing Tucson Homes for Equitable Energy Retrofits

This repository provides documentation for a method used to assign all single-family homes in Tucson into categories (based on construction year and exterior wall type) and determine the percentage of each category that sit within Low-Income and Disadvantaged Communities (LIDAC) according to the Climate and Economic Justice Screening Tool.

The method was originally applied to a pilot study completed Fall 2024 for SBE580: Research Methods under the instruction of Dr. Philip Stoker. The complete report can be found here: [INSERT LINK HERE].

Please note that all scripts were run through R Studio, not the GitHub CLI.

## Organization

### `./data`
This folder contains all the public data needed to perform the analysis. Many of the files are quite large - they can be accessed via a Google Drive link or downloaded elsewhere (instructions provided in the folder).

### `./scripts`
This folder contains two R scripts - one used to prepare the data for analysis in ArcGIS, and one used to analyze the ArcGIS output.

## Process

#### 1. Download the following files from `./data`. Alternatively, follow the instructions below to download more recent data from misc. sources.
  * `1.0-shapefile-codebook.zip` - To download this from the official source, visit the downloads page of the Climate and Economic Justice Screening Tool [here](https://screeningtool.geoplatform.gov/en/downloads#3/33.47/-97.5). Download the most recent Shapefile.
  * `Mas25.csv` - To download this from the official source, visit the downloads page of the [Pima County Tax Assessor website](https://www.asr.pima.gov/Download?tab=RealProp). Click on the 'Real Property' tab and select the most recently available tax year (2025 for this project). Expand 'Notice of Value Data' and select `Mas25.ZIP` to download the file.
  * `Parcels_-_Regional.zip` - To download this from the official source, visit the GIS Open Data Portal for Pima County (https://gisopendata.pima.gov/datasets/parcels-regional/explore).
#### 2. Run the `datacleaning_residentialtaxassessor.R` script. Be sure to update the file path for the `Mas25.csv` file, which you will have to extract if you downloaded it yourself. This will assign every parcel with a single-family home in Pima County to a category (called a 'segment') based on construction year and exterior wall type.
#### 3. Start a new ArcGIS project and open the `Parcels_-_Regional.shp` file. Open the cleaned tax assessor dataset and join it with the parcels shapefile. Discard all parcels which are not included in the tax assessor dataset. Then, use a Tucson boundary file to restrict the analysis to parcels within the city.
#### 4. Add the Climate and Economic Justice Screening Tool dataset to ArcGIS. Use a spatial join to create a new layer for each parcel indicating whether or not it is identified as within a LIDAC.
#### 5. If you would like to run the chi-square tests used for this study, export the ArcGIS file to a .csv and run the statisticalanalysis_arcisexport.R file with an updated file path.
