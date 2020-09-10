#!/bin/bash
#set -x

# Use interesting-blaseball-games and blaseball-streak-finder 
# to generate some markdown files containing tables with
# blaseball stats.

ROOT_DIR=$(dirname $(readlink -f "$0"))
STREAK_FINDER="$ROOT_DIR/../vp/bin/streak-finder"
INTERESTING="$ROOT_DIR/../vp/bin/interesting-blaseball-games"
ACTIVATE_SCRIPT="$ROOT_DIR/../vp/bin/activate"

LASTSEASON=5

# Enter the virtual environment
source $ACTIVATE_SCRIPT

########################## blaseball-streak-finder #######################################

echo "############################################"
echo "# Winning Streaks:"

# All-time
echo "Creating all-time winning streaks page..."
OUT=$ROOT_DIR/../docs/wstreaks_alltime.md
cat /dev/null > $OUT
echo "# All-Time Blaseball Winning Streaks" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
echo "" >> $OUT
$STREAK_FINDER --winning --short --markdown --min 8 >> $OUT
echo "" >> $OUT
echo "## Details" >> $OUT
$STREAK_FINDER --winning --long --markdown --min 8 | sed 's+\n\n+\n<br/>\n+' >> $OUT
echo "" >> $OUT
echo "Done."

