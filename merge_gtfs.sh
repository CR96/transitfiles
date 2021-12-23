#!/bin/bash

### GTFS Merger ###
# Given two GTFS archives, attempt to merge them into a single feed for use in rendering a regional route map.
# Usage: ./merge_gtfs archive_one.gtfs archive_two.gtfs output_archive.gtfs

# This script does not validate input and may result in data loss if used incorrectly.

# Corey Rowe, December 2021

mkdir gtfs_one/
mkdir gtfs_two/

unzip $1 -d gtfs_one/
unzip $2 -d gtfs_two/

mkdir gtfs_merged/

# Remove the header line from each file in the second GTFS archive.
find gtfs_two/ -type f -exec sed -i '1d' {} \;

awk 1 gtfs_one/agency.txt gtfs_two/agency.txt > gtfs_merged/agency.txt
awk 1 gtfs_one/calendar_dates.txt gtfs_two/calendar_dates.txt > gtfs_merged/calendar_dates.txt
awk 1 gtfs_one/calendar.txt gtfs_two/calendar.txt > gtfs_merged/calendar.txt
awk 1 gtfs_one/directions.txt gtfs_two/directions.txt > gtfs_merged/directions.txt
awk 1 gtfs_one/fare_attributes.txt gtfs_two/fare_attributes.txt > gtfs_merged/fare_attributes.txt
awk 1 gtfs_one/fare_rules.txt gtfs_two/fare_rules.txt > gtfs_merged/fare_rules.txt
awk 1 gtfs_one/feed_info.txt gtfs_two/feed_info.txt > gtfs_merged/feed_info.txt
awk 1 gtfs_one/frequencies.txt gtfs_two/frequencies.txt > gtfs_merged/frequencies.txt
awk 1 gtfs_one/routes.txt gtfs_two/routes.txt > gtfs_merged/routes.txt
awk 1 gtfs_one/shapes.txt gtfs_two/shapes.txt > gtfs_merged/shapes.txt
awk 1 gtfs_one/stops.txt gtfs_two/stops.txt > gtfs_merged/stops.txt
awk 1 gtfs_one/stop_times.txt gtfs_two/stop_times.txt > gtfs_merged/stop_times.txt
awk 1 gtfs_one/timepoints.txt gtfs_two/timepoints.txt > gtfs_merged/timepoints.txt
awk 1 gtfs_one/timepoints_times.txt gtfs_two/timepoints_times.txt > gtfs_merged/timepoints_times.txt
awk 1 gtfs_one/transfers.txt gtfs_two/transfers.txt > gtfs_merged/transfers.txt
awk 1 gtfs_one/trips.txt gtfs_two/trips.txt > gtfs_merged/trips.txt

cd gtfs_merged/

# Standardize line endings before creating new archive
dos2unix *.txt

zip ../$3 *.txt

cd ../

rm -rf gtfs_one/
rm -rf gtfs_two/
rm -rf gtfs_merged/
