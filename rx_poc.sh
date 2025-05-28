#! /bin/bash

#assign city name
city=Casablanca

#Download the raw weather data
#obtain the weather information
curl -s wttr.in/$city?T --output weather_report

#Extract and load the required data
#to extract current temperature
obs_temp=$(curl -s wttr.in/$city?T | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]].*')
echo "The current Temperature of $city: $obs_temp" #prints the current temperature in the console

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

#This file is for POC weather report log file, or a text file which contains a growing history of the daily weather data you will scrape
#After completing this script, created a cron job to run script on everyday at noon local time
#crontab -e
#0 8 * * * /home/project/rx_poc.sh

