## Data

### Original Public Datasets
Due to file sizes, all publicly-available datasets can be found in [this Google folder.](https://drive.google.com/drive/folders/1bReoAVYEhUDYDKfaThQL4yO8DmL75vWn?usp=sharing) Alternatively, you can download more recent data per the instructions on the main repository README file.

* `1.0-shapefile-codebook.zip`

This file contains GIS shapefiles for every 2010 census tract in the U.S., along with a number of variables pertaining to LIDAC status.

* `Mas25.csv`

This file contains twenty-five (25) variables for all parcels which the Pima County Tax Assessor had evaluated and marked as either a single-family residence or a condominium for the 2025 tax year, as of November 2024. 

* `Parcels_-_Regional.zip`

This file contains GIS shapefiles for every parcel in Pima County as of April 2022, in addition to a number of other variables.

### Produced Data

* `parcel_year_wall_v8.csv`
This file is the export from the initial cleaning of the residental tax assessor data for Pima County. It contains the building segment for all single-family parcels.

* `arcgisexport_11.18.csv`
This file is the export from ArcGIS. It contains the LIDAC status for each parcel, along with the building segment.

* `arcgisexport_11.18`
This file contains identical information to `arcgisexport_11.18.csv`, but is viewable as a Google Sheet.

* Additionally, the ArcGIS layer used in this analysis can be found on [ArcGIS Online.](https://services1.arcgis.com/Ezk9fcjSUkeadg6u/arcgis/rest/services/Tucson_Single_Family_Home_Characteristics/FeatureServer)


