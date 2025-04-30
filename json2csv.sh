# Converts json to csv

# Quick bash script to extract data from json files.
# It has been created to extract charge points information from the Open Charge Map database at https://github.com/openchargemap

# Copyright (C) 2025 Paolo Zatelli
# University of Trento
# paolo.zatelli@unitn.it

# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.

outputCSV=colonnine.csv

# header
echo "ID,Title,AddressLine1,Town,Postcode,.Latitude,Longitude,ConnectionTypeID,StatusTypeID,LevelID,Quantity,DateLastStatusUpdate"> $outputCSV

for infile in *json
do
#     cat $infile | jq '.[] | .MediaItems'

# Address
    id=`cat $infile | jq '.AddressInfo | .ID'`
    title=`cat $infile | jq '.AddressInfo | .Title'`
    addline1=`cat $infile | jq '.AddressInfo | .AddressLine1'`
    town=`cat $infile | jq '.AddressInfo | .Town'`
    post=`cat $infile | jq '.AddressInfo | .Postcode'`
    lat=`cat $infile | jq '.AddressInfo | .Latitude'`
    long=`cat $infile | jq '.AddressInfo | .Longitude'`

# Connection type
    conntype=`cat $infile | jq '.Connections| .[] | .ConnectionTypeID'`
    status=`cat $infile | jq '.Connections| .[] | .StatusTypeID'`
    level=`cat $infile | jq '.Connections| .[] | .LevelID'`
    quant=`cat $infile | jq '.Connections| .[] | .Quantity'`

# Update

    agg=`cat $infile | jq '.DateLastStatusUpdate'`

    echo "ID: "$id
    echo "$id"",""$title"",""$addline1"",""$town"",""$post"",""$lat"",""$long"","$conntype","$status","$level","$quant",""$agg" >>$outputCSV

done
