#!/bin/bash
url="https://forecast.weather.gov/MapClick.php?lat=39.9522&lon=-75.1622#.Y9fwF-zMJH0"
filename="scrape.txt"
curl -s $url | pandoc -f html -t plain > $filename
firstLine=$(grep -n "Extended Forecast" $filename | cut -d : -f 1)
lastLine=$(($firstLine + 12)) 
nextLastLine=$(($lastLine + 1)) 
comm="${firstLine},${lastLine}p;${nextLastLine}q"

msg=$(sed -n $comm $filename)
echo $msg

curl -X POST https://textbelt.com/text --data-urlencode phone=$1 --data-urlencode message=$msg -d key=textbelt