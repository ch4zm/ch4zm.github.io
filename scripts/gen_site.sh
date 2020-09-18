#!/bin/bash
#set -x

# Use interesting-blaseball-games and blaseball-streak-finder 
# to generate some markdown files containing tables with
# blaseball stats.

ROOT_DIR=$(dirname $(readlink -f "$0"))
STREAK_FINDER="$ROOT_DIR/../vp/bin/streak-finder"
INTERESTING="$ROOT_DIR/../vp/bin/interesting-blaseball-games"
ACTIVATE_SCRIPT="$ROOT_DIR/../vp/bin/activate"

LASTSEASON=6

# Enter the virtual environment
source $ACTIVATE_SCRIPT



########################## blaseball-streak-finder #######################################



echo "############################################"
echo "# Winning Streaks:"

# All-time
echo "Creating all-time winning streaks page..."
OUT=$ROOT_DIR/../docs/wstreaks_alltime.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# All-Time Blaseball Winning Streaks" >> $OUT
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
for i in $(seq 1 $LASTSEASON); do 
    OUT=$ROOT_DIR/../docs/wstreaks_season$i.md
    echo "Working on season $i: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "# Season $i Winning Streaks" >> $OUT
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
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    lower_team=$(echo $team | awk '{print tolower($0)}' | sed 's/ /_/g' )
    OUT=$ROOT_DIR/../docs/wstreaks_team_${lower_team}.md
    echo "Working on team $team: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "# $team Winning Streaks" >> $OUT
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
OUT=$ROOT_DIR/../docs/lstreaks_alltime.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# All-Time Blaseball Losing Streaks" >> $OUT
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
for i in $(seq 1 $LASTSEASON); do 
    OUT=$ROOT_DIR/../docs/lstreaks_season$i.md
    echo "Working on season $i: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "# Season $i Losing Streaks" >> $OUT
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
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    lower_team=$(echo $team | awk '{print tolower($0)}' | sed 's/ /_/g' )
    OUT=$ROOT_DIR/../docs/lstreaks_team_${lower_team}.md
    echo "Working on team $team: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "# $team Losing Streaks" >> $OUT
    echo "(Through season $LASTSEASON)" >> $OUT
    echo "## Summary" >> $OUT
    $STREAK_FINDER --losing --team "$team" --short --markdown --min 4 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
    echo "## Details" >> $OUT
    $STREAK_FINDER --losing --team "$team" --long --markdown --min 4 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
done
echo "Done."



########################## interesting-games-finder #######################################



echo "############################################"
echo "# Shutouts:"

# All-time
echo "Creating all-time shutouts page..."
OUT=$ROOT_DIR/../docs/shutouts_alltime.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# All-Time Blaseball Shutouts" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
$INTERESTING --reason shutout --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season shutouts page..."
for i in $(seq 1 $LASTSEASON); do 
    OUT=$ROOT_DIR/../docs/shutouts_season$i.md
    echo "Working on season $i: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## Season $i Shutouts" >> $OUT
    $INTERESTING --season $i --reason shutout --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team shutouts page..."
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    lower_team=$(echo $team | awk '{print tolower($0)}' | sed 's/ /_/g' )
    OUT=$ROOT_DIR/../docs/shutouts_team_${lower_team}.md
    echo "Working on team $team: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## $team Shutout Summary" >> $OUT
    $INTERESTING --team "$team" --reason shutout --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# Postseason
echo "Creating postseason shutouts page..."
OUT=$ROOT_DIR/../docs/shutouts_postseason.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# Blaseball Postseason Shutouts" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
$INTERESTING --reason shutout --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."



echo "############################################"
echo "# Blowouts:"
 
# All-time
echo "Creating all-time blowouts page..."
OUT=$ROOT_DIR/../docs/blowouts_alltime.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# All-Time Blaseball Blowouts" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
$INTERESTING --reason blowout --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season blowouts page..."
for i in $(seq 1 $LASTSEASON); do 
    OUT=$ROOT_DIR/../docs/blowouts_season$i.md
    echo "Working on season $i: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## Season $i Blowouts" >> $OUT
    $INTERESTING --season $i --reason blowout --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team blowouts page..."
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    lower_team=$(echo $team | awk '{print tolower($0)}' | sed 's/ /_/g' )
    OUT=$ROOT_DIR/../docs/blowouts_team_${lower_team}.md
    echo "Working on team $team: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## $team Blowout Summary" >> $OUT
    $INTERESTING --team "$team" --reason blowout --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# Postseason
echo "Creating postseason blowouts page..."
OUT=$ROOT_DIR/../docs/blowouts_postseason.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# Blaseball Postseason Blowouts" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
$INTERESTING --reason blowout --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."



echo "############################################"
echo "# Underdog Wins:"

# All-time
echo "Creating all-time underdog page..."
OUT=$ROOT_DIR/../docs/underdog_alltime.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# All-Time Blaseball Underdog Wins" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
$INTERESTING --reason underdog --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season underdog page..."
for i in $(seq 1 $LASTSEASON); do 
    OUT=$ROOT_DIR/../docs/underdog_season$i.md
    echo "Working on season $i: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## Season $i Underdog Wins" >> $OUT
    $INTERESTING --season $i --reason underdog --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team underdog page..."
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    lower_team=$(echo $team | awk '{print tolower($0)}' | sed 's/ /_/g' )
    OUT=$ROOT_DIR/../docs/underdog_team_${lower_team}.md
    echo "Working on team $team: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## $team Underdog Win Summary" >> $OUT
    $INTERESTING --team "$team" --reason underdog --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# Postseason
echo "Creating postseason underdog page..."
OUT=$ROOT_DIR/../docs/underdog_postseason.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# Blaseball Postseason Underdog Wins" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
$INTERESTING --reason underdog --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."



echo "############################################"
echo "# Shame Wins:"

# All-time
echo "Creating all-time shame page..."
OUT=$ROOT_DIR/../docs/shame_alltime.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# All-Time Blaseball Shame Games" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
$INTERESTING --reason shame --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season shame page..."
for i in $(seq 1 $LASTSEASON); do 
    OUT=$ROOT_DIR/../docs/shame_season$i.md
    echo "Working on season $i: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## Season $i Shame Games" >> $OUT
    $INTERESTING --season $i --reason shame --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team shame page..."
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    lower_team=$(echo $team | awk '{print tolower($0)}' | sed 's/ /_/g' )
    OUT=$ROOT_DIR/../docs/shame_team_${lower_team}.md
    echo "Working on team $team: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## $team shame Win Summary" >> $OUT
    $INTERESTING --team "$team" --reason shame --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# Postseason
echo "Creating postseason shame page..."
OUT=$ROOT_DIR/../docs/shame_postseason.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# Blaseball Postseason Shame Games" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
$INTERESTING --reason shame --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."
