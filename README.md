# Corbetti Caldera Independent Component Analysis (ICA) study
This dataset contains the Corbetti Caldera, Sentinel-1 timeseries (processed using LiCSAR: https://comet.nerc.ac.uk/COMET-LiCS-portal/ and LiCSBAS: https://github.com/comet-licsar/LiCSBAS) and Independent Component Analysis (using LiCSAlert: https://github.com/matthew-gaddes/LiCSAlert) dataset used in Dualeh &amp; Biggs (2024). 

**Processed Sentinel-1 InSAR timeseries over Corbetti Caldera**
LiCSBAS (Morishita et al., 2020) run on Sentinel-1 interferograms processed by LiCSAR (avaliable through the COMET LiCSAR portal - https://comet.nerc.ac.uk/comet-lics-portal/) 
InSAR displacement timeseries for unfiltered (**cum.h5**) and filtered (**cum_filt.h5**) data contain among others (for full dataset you can use h5disp in matlab):
coh_avg     :   Average coherence for all interferograms used (0-1)
corner_lat  :   Latitude for clipped area corner
corner_lon  :   Longitude for clipped area corner
cum         :   Cumulative displacement in mm
hgt         :   Digital Elevation Model for clipped area
imdates     :   Dates of all epoches used
post_lat    :   Latitude spacing 
post_lon    :   Longitude spacing
refarea     :   Reference area/pixel identified by LiCSBAS
vel         :   Velocity in mm/yr
 
**Results from LiCSAlert, ICASAR package have been saved in _ICAdata.mat_, which contains**
Dates:          dates of epochs            
ICA_sources:    individual independent component sources
ICA_TC:         individual independent component timecourses
lats:           latitude information for clipped section
lons:           longitude information for clipped section
Mask:           Mask used on data
Unw_phase:      Mean for each epoch to be added back into data for reconstruction

**Structural data used on Corbetti Caldera plots**
_QGIS/Corbetti_Structures.shp contains_
1. Awassa Caldera ridge
2. Corbetti Caldera ridge
3. Cross-cutting caldera structure (Corbetti), Dambly et al., 2023
4. Cross-cutting caldera structure (Awassa), Dambly et al., 2023
5. Cross-cutting caldera structure (Corbetti), Lloyd et al., 2018

_QGIS/Corbetti_Cones.shp_
1. Location of Urji cone
2. Location of Chabi cone 

**Example script** for reconstruction of Independent Component Analysis data and plot a figure (similar to Fig. 4) can be found in - 
Load_ICA_Data.m
