#! /bin/bash

#assign ciry name
city=Casablanca

#obtain the weather information
curl -s wttr.in/$city?T --output weather_report

#Extract and load the required data
#to extract current temperature
obs_temp=$(curl -s wttr.in/$city?T | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]].*')
echo "The current Temperature of $city: $obs_temp"

#to extract the forecast temperature for noon tomorrow
fc_temp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | grep '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digit:]].*')
echo "The forecasted temperature for noon tomorrow for $city: $fc_temp C"

#assign country and city to variable time zone
TZ='Morocco/Casablanca'

#to store the current day, month, and year in shell variables
day=$(TZ='Morocco/Casablanca' data -u +%d)
month=$(TZ='Morocco/Casablanca' data +%m)
year=$(TZ='Morocco/Casablanca' data +%Y)

#log the weather
record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp C")
echo $record>>rx_poc.log
