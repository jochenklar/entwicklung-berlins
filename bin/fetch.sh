#!/bin/bash

mkdir -p data
cd data

# get the zip files with the images
wget http://fbarc.stadt-berlin.de/FIS_Broker_Atom/Berlin_um/Berlin1650.zip
wget http://fbarc.stadt-berlin.de/FIS_Broker_Atom/Berlin_um/Berlin1690.zip
wget http://fbarc.stadt-berlin.de/FIS_Broker_Atom/Berlin_um/Berlin1750.zip
wget http://fbarc.stadt-berlin.de/FIS_Broker_Atom/Berlin_um/Berlin1800.zip

# unzip files
unzip Berlin1650.zip
unzip Berlin1690.zip
unzip Berlin1750.zip
unzip Berlin1800.zip

# fetch legends
wget http://fbinter.stadt-berlin.de/fb_daten/legenden/leg_berlin1650.gif
wget http://fbinter.stadt-berlin.de/fb_daten/legenden/leg_berlin1690.gif
wget http://fbinter.stadt-berlin.de/fb_daten/legenden/leg_berlin1750.gif
wget http://fbinter.stadt-berlin.de/fb_daten/legenden/leg_berlin1800.gif

# create tile dir
mkdir -p ../public/tiles

# gdalinfo FILENAME gives corners in pixel

# weppage give corners in EPSG:3068
# http://fbinter.stadt-berlin.de/fb/berlin/service.jsp?id=a_berlin1750@senstadt&type=FEED

# create tiles for berlin1650
gdal_translate -of VRT -a_srs EPSG:3068 \
    -gcp 0 0 23100 22600 \
    -gcp 0 3511 23100 19600 \
    -gcp 3678 0 26300 22600 \
    -gcp 3678 3511 26300 19600 \
    Berlin\ um\ 1650\ entz.tif berlin1650.vrt
gdal2tiles.py -z 10-17 -p mercator --no-kml berlin1650.vrt ../public/tiles/berlin1650

# create tiles for berlin1690
gdal_translate -of VRT -a_srs EPSG:3068 \
    -gcp 0 0 23100 22600 \
    -gcp 0 3497 23100 19600 \
    -gcp 3662 0 26300 22600 \
    -gcp 3662 3497 26300 19600 \
    Berlin\ um\ 1690\ entz.tif berlin1690.vrt

gdal2tiles.py -z 10-17 -p mercator --no-kml berlin1690.vrt ../public/tiles/berlin1690    

# create tiles for berlin1750
gdal_translate -of VRT -a_srs EPSG:3068 \
    -gcp 0 0 21600 23820 \
    -gcp 0 7905 21600 17120 \
    -gcp 8547 0 28400 23820 \
    -gcp 8547 7905 28400 17120 \
    Berlin\ um\ 1750\ entz.tif berlin1750.vrt
gdal2tiles.py -z 10-17 -p mercator --no-kml berlin1750.vrt ../public/tiles/berlin1750

# create tiles for berlin1800
gdal_translate -of VRT -a_srs EPSG:3068 \
    -gcp 0 0 21600 23820 \
    -gcp 0 7912 21600 17120 \
    -gcp 8548 0 28400 23820 \
    -gcp 8548 7912 28400 17120 \
    Berlin\ um\ 1800\ entz.tif berlin1800.vrt
gdal2tiles.py -z 10-17 -p mercator --no-kml berlin1800.vrt ../public/tiles/berlin1800
