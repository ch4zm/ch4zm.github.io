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

# CHRONOLOGICAL
tmp=".tmp.chronsort"
cat $ROOT_DIR/data/incinerations | sort --field-separator=',' --key={1,2,3} > $tmp
while read row; do
    echo $row
done < $tmp
rm -f $tmp

echo "----------------"

# THEN ALPHABETICAL
tmp=".tmp.alphasort"
cat $ROOT_DIR/data/incinerations | sort --field-separator=',' --key={3,1,2} > $tmp
while read row; do
    echo $row
done < $tmp
rm -f $tmp
