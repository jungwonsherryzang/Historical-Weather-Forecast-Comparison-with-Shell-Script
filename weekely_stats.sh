#!/bin/bash

#download the synthetic historical forecasting accuracy dataset
#wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMSkillsNetwork-LX0117EN-Coursera/labs/synthetic_historical_fc_accuracy.tsv
#saved in synthetic_historical_fc_accuracy.tsv

#extract last 7 data from tsv file
echo $(tail -7 synthetic_historical_fc_accuracy.tsv  | cut -f6) > scratch.txt

week_fc=($(echo $(cat scratch.txt)))

#validate the result
for i in {0..6}; do
    echo ${week_fc[$i]}
done

#display min and max absolute forecasting errors for the week
minimum=${week_fc[1]}
maximum=${week_fc[1]}

for item in ${week_fc[@]}; do
    if [[ $minimum > $ item ]]
    then
        minimum=$item
    fi
    if [[ $maximum < $item ]]
    then
        maximum=$item
    fi
done

echo "minimum ebsolute error = $minimum"
echo "maximum absolute error = $maximum"
