#!/bin/bash
set -e

# Use game-finder and game-summary
# to generate game summaries of each
# game where a player was incinerated

# Manual steps:
# - generate a list of deceased blaseball players in data/deceased using gen_deceased_data.sh
# - copy it to data/incinerations
# - create CSV file of incineration season, day, and player name

ROOT_DIR=$(dirname $(readlink -f "$0"))
GAMEFINDER="$ROOT_DIR/../vp/bin/game-finder"
GAMESUMMARY="$ROOT_DIR/../vp/bin/game-summary"
ACTIVATE_SCRIPT="$ROOT_DIR/../vp/bin/activate"

### # Enter the virtual environment
### source $ACTIVATE_SCRIPT

OUT="$ROOT_DIR/../docs/incinerations.md"

cat /dev/null > $OUT
echo "# Blaseball Incinerations" >> $OUT
echo "" >> $OUT


########################
# CHRONOLOGICAL

echo "Creating chronological list..."

echo "## Chronological" >> $OUT
echo "" >> $OUT

tmp=".tmp.chronsort"
rm -f $tmp
cat $ROOT_DIR/data/incinerations | sort --field-separator=',' --key={1,2,3} > $tmp
while read row; do
    season=$(echo $row | cut -d',' -f1)
    day=$(echo $row | cut -d',' -f2)
    team=$(echo $row | cut -d',' -f3)
    name=$(echo $row | cut -d',' -f4)
    lower_name=$(echo $name | awk '{print tolower($0)}' | sed 's/ /_/g' )
    mdfilename="incineration_${lower_name}.md"
    mdfile="$ROOT_DIR/../docs/${mdfilename}"

    echo "Creating page for ${name}"
    echo $team

    # Add game summary to mdfile
    if test -f "$mdfile"; then
        echo "File ${mdfilename} for incineration of ${name} already exists. Skipping..."
    else
        cat /dev/null > $mdfile
        echo "# Game Summary for Incineration of $name" >> $mdfile
        if [[ "$($GAMEFINDER --season ${season} --day ${day} --team "${team}")" == "" ]]; then
            echo "Could not find a game ID for ${name} - Team ${team} Season ${season} Day ${day}"
            exit 1
        fi
        $GAMEFINDER --season ${season} --day ${day} --team "${team}" | xargs $GAMESUMMARY --markdown >> $mdfile
    fi

    # Add page to TOC
    echo "* [Season $season, Day $day - Incineration of $name]($mdfilename)" >> $OUT

done < $tmp
rm -f $tmp
echo "" >> $OUT

echo "Done."


########################
# ALPHABETICAL

echo "## Alphabetical" >> $OUT
echo "" >> $OUT

echo "Creating alphabetical list..."

tmp=".tmp.alphasort"
rm -f $tmp
cat $ROOT_DIR/data/incinerations | sort --field-separator=',' --key={3,1,2} > $tmp
while read row; do
    season=$(echo $row | cut -d',' -f1)
    day=$(echo $row | cut -d',' -f2)
    team=$(echo $row | cut -d',' -f3)
    name=$(echo $row | cut -d',' -f4)
    lower_name=$(echo $name | awk '{print tolower($0)}' | sed 's/ /_/g' )
    mdfilename="incineration_${lower_name}.md"
    mdfile="$ROOT_DIR/../docs/${mdfilename}"

    # Add page to TOC
    echo "* [Incineration of $name - Season $season, Day $day]($mdfilename)" >> $OUT

done < $tmp
rm -f $tmp

echo "Done."

