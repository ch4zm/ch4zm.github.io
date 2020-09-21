#!/bin/bash
#
# This generates a simple text list of all
# deceased blaseball players, as a starting
# point for adding incineration season/day
# information.
#
# Output file: data/deceased

mkdir -p data
curl -X GET "https://api.blaseball-reference.com/v1/deceased" -H  "accept: application/json" | jq -r '.[] | .player_name' | sort > data/deceased
