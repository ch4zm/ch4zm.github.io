#!/bin/bash
#set -x

# Use interesting-blaseball-games and blaseball-streak-finder 
# to generate some markdown files containing tables with
# blaseball stats.

ROOT_DIR=$(dirname $(readlink -f "$0"))
STREAK_FINDER="$ROOT_DIR/../vp/bin/streak-finder"
ACTIVATE_SCRIPT="$ROOT_DIR/../vp/bin/activate"

LASTSEASON=6

# Enter the virtual environment
source $ACTIVATE_SCRIPT



########################## blaseball-streak-finder #######################################


# As we go, we also want to assemble master winning streak/losing streak docs
WMASTER="$ROOT_DIR/../docs/wstreaks.md"
LMASTER="$ROOT_DIR/../docs/lstreaks.md"

cat /dev/null > $WMASTER
echo "# Blaseball Winning Streaks" >> $WMASTER
echo "" >> $WMASTER
echo "# Blaseball Losing Streaks" >> $LMASTER
echo "" >> $LMASTER


echo "############################################"
echo "# Winning Streaks:"

# All-time
echo "Creating all-time winning streaks page..."
fname="wstreaks_alltime.md"
OUT=$ROOT_DIR/../docs/$fname
echo "Working on page: $(basename $OUT)"

title="All-Time Blaseball Winning Streaks"
echo "## All Time" >> $WMASTER
echo "" >> $WMASTER
echo "[$title]($fname)" >> $WMASTER
echo "" >> $WMASTER

cat /dev/null > $OUT
echo "# $title" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
echo "## Summary" >> $OUT
$STREAK_FINDER --winning --short --markdown --min 8 | $ROOT_DIR/split_tables.py >> $OUT
echo "" >> $OUT
echo "## Details" >> $OUT
$STREAK_FINDER --winning --long --markdown --min 8 | $ROOT_DIR/split_tables.py >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season winning streaks page..."
echo "## By Season" >> $WMASTER
echo "" >> $WMASTER
for i in $(seq 1 $LASTSEASON); do 
    fname="wstreaks_season$i.md"
    OUT="$ROOT_DIR/../docs/$fname"
    echo "Working on season $i: $(basename $OUT)"

    title="Season $i Winning Streaks"
    echo "* [$title]($fname)" >> $WMASTER
    echo "" >> $WMASTER

    cat /dev/null > $OUT
    echo "# $title" >> $OUT
    echo "## Summary" >> $OUT
    $STREAK_FINDER --winning --season $i --short --markdown --min 7 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
    echo "## Details" >> $OUT
    $STREAK_FINDER --winning --season $i --long --markdown --min 7 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team winning streaks page..."
echo "## By Team" >> $WMASTER
echo "" >> $WMASTER
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    lower_team=$(echo $team | awk '{print tolower($0)}' | sed 's/ /_/g' )
    fname="wstreaks_team_${lower_team}.md"
    OUT="$ROOT_DIR/../docs/$fname"
    echo "Working on team $team: $(basename $OUT)"

    title="$team Winning Streaks"
    echo "* [$title]($fname)" >> $WMASTER
    echo "" >> $WMASTER

    cat /dev/null > $OUT
    echo "# $title" >> $OUT
    echo "(Through season $LASTSEASON)" >> $OUT
    echo "## Summary" >> $OUT
    $STREAK_FINDER --winning --team "$team" --short --markdown --min 4 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
    echo "## Details" >> $OUT
    $STREAK_FINDER --winning --team "$team" --long --markdown --min 4 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
done



echo "############################################"
echo "# Losing Streaks:"

# All-time
echo "Creating all-time losing streaks page..."
fname="lstreaks_alltime.md"
OUT="$ROOT_DIR/../docs/$fname"
echo "Working on page: $(basename $OUT)"

title="All-Time Blaseball Losing Streaks"
echo "## All Time" >> $LMASTER
echo "" >> $LMASTER
echo "[$title]($fname)" >> $LMASTER
echo "" >> $LMASTER

cat /dev/null > $OUT
echo "# $title" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
echo "## Summary" >> $OUT
$STREAK_FINDER --losing --short --markdown --min 8 | $ROOT_DIR/split_tables.py >> $OUT
echo "" >> $OUT
echo "## Details" >> $OUT
$STREAK_FINDER --losing --long --markdown --min 8 | $ROOT_DIR/split_tables.py >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season losing streaks page..."
echo "## By Season" >> $LMASTER
echo "" >> $LMASTER
for i in $(seq 1 $LASTSEASON); do 
    fname="lstreaks_season$i.md"
    OUT="$ROOT_DIR/../docs/$fname"
    echo "Working on season $i: $(basename $OUT)"

    title="Season $i Losing Streaks"
    echo "* [$title]($fname)" >> $LMASTER
    echo "" >> $LMASTER

    cat /dev/null > $OUT
    echo "# $title" >> $OUT
    echo "## Summary" >> $OUT
    $STREAK_FINDER --losing --season $i --short --markdown --min 7 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
    echo "## Details" >> $OUT
    $STREAK_FINDER --losing --season $i --long --markdown --min 7 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team losing streaks page..."
echo "## By Team" >> $LMASTER
echo "" >> $LMASTER
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    lower_team=$(echo $team | awk '{print tolower($0)}' | sed 's/ /_/g' )
    fname="lstreaks_team_${lower_team}.md"
    OUT="$ROOT_DIR/../docs/$fname"
    echo "Working on team $team: $(basename $OUT)"

    title="$team Losing Streaks"
    echo "* [$title]($fname)" >> $LMASTER
    echo "" >> $LMASTER

    cat /dev/null > $OUT
    echo "(Through season $LASTSEASON)" >> $OUT
    echo "## Summary" >> $OUT
    $STREAK_FINDER --losing --team "$team" --short --markdown --min 4 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
    echo "## Details" >> $OUT
    $STREAK_FINDER --losing --team "$team" --long --markdown --min 4 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
done
echo "Done."

