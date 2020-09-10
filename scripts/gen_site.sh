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
$STREAK_FINDER --winning --short --markdown --min 8 | $ROOT_DIR/split_tables.py >> $OUT
echo "" >> $OUT
echo "## Details" >> $OUT
$STREAK_FINDER --winning --long --markdown --min 8 | $ROOT_DIR/split_tables.py >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season winning streaks page..."
OUT=$ROOT_DIR/../docs/wstreaks_season.md
cat /dev/null > $OUT
echo "# Blaseball Winning Streaks by Season" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
for i in $(seq 1 $LASTSEASON); do 
    echo "Working on season $i"
    echo "## Season $i Winning Streaks Summary" >> $OUT
    echo "" >> $OUT
    $STREAK_FINDER --winning --season $i --short --markdown --min 7 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
    echo "## Season $i Winning Streaks Details" >> $OUT
    echo "" >> $OUT
    $STREAK_FINDER --winning --season $i --long --markdown --min 7 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team winning streaks page..."
OUT=$ROOT_DIR/../docs/wstreaks_team.md
echo "# Blaseball Winning Streaks by Team" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
cat /dev/null > $OUT
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    echo "Working on team $team"
    echo "## $team Winning Streaks Summary" >> $OUT
    echo "" >> $OUT
    $STREAK_FINDER --winning --team "$team" --short --markdown --min 4 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
    echo "## $team Winning Streaks Details" >> $OUT
    echo "" >> $OUT
    $STREAK_FINDER --winning --team "$team" --long --markdown --min 4 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
done

echo "############################################"
echo "# Losing Streaks:"

# All-time
echo "Creating all-time losing streaks page..."
OUT=$ROOT_DIR/../docs/lstreaks_alltime.md
cat /dev/null > $OUT
echo "# All-Time Blaseball Losing Streaks" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
echo "" >> $OUT
$STREAK_FINDER --losing --short --markdown --min 8 | $ROOT_DIR/split_tables.py >> $OUT
echo "" >> $OUT
echo "## Details" >> $OUT
$STREAK_FINDER --losing --long --markdown --min 8 | $ROOT_DIR/split_tables.py >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season losing streaks page..."
OUT=$ROOT_DIR/../docs/lstreaks_season.md
cat /dev/null > $OUT
echo "# Blaseball Losing Streaks by Season" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
END=5
for i in $(seq 1 $LASTSEASON); do 
    echo "Working on season $i"
    echo "## Season $i Summary" >> $OUT
    echo "" >> $OUT
    $STREAK_FINDER --losing --season $i --short --markdown --min 7 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
    echo "## Season $i Details" >> $OUT
    echo "" >> $OUT
    $STREAK_FINDER --losing --season $i --long --markdown --min 7 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team losing streaks page..."
OUT=$ROOT_DIR/../docs/lstreaks_team.md
echo "# Blaseball Losing Streaks by Team" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
cat /dev/null > $OUT
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    echo "Working on team $team"
    echo "## $team Losing Streaks Summary" >> $OUT
    echo "" >> $OUT
    $STREAK_FINDER --losing --team "$team" --short --markdown --min 4 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
    echo "## $team Losing Streaks Details" >> $OUT
    echo "" >> $OUT
    $STREAK_FINDER --losing --team "$team" --long --markdown --min 4 | $ROOT_DIR/split_tables.py >> $OUT
    echo "" >> $OUT
done
echo "Done."

exit 1;

########################## interesting-games-finder #######################################

echo "############################################"
echo "# Shutouts:"

# All-time
echo "Creating all-time shutouts page..."
OUT=$ROOT_DIR/../docs/shutouts_alltime.md
cat /dev/null > $OUT
echo "# All-Time Blaseball Shutouts" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
echo "" >> $OUT
$INTERESTING --reason shutout --name-style long --markdown >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season shutouts page..."
OUT=$ROOT_DIR/../docs/shutouts_season.md
cat /dev/null > $OUT
echo "# Blaseball Shutouts by Season" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
END=5
for i in $(seq 1 $LASTSEASON); do 
    echo "Working on season $i"
    echo "## Season $i Shutouts" >> $OUT
    echo "" >> $OUT
    $INTERESTING --season $i --reason shutout --name-style long --markdown >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team shutouts page..."
OUT=$ROOT_DIR/../docs/shutouts_team.md
echo "# Blaseball Shutouts by Team" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
cat /dev/null > $OUT
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    echo "Working on team $team"
    echo "## $team Shutout Summary" >> $OUT
    echo "" >> $OUT
    $INTERESTING --team "$team" --reason shutout --name-style long --markdown >> $OUT
    echo "" >> $OUT
done
echo "Done."

# Postseason
echo "Creating postseason shutouts page..."
OUT=$ROOT_DIR/../docs/shutouts_postseason.md
echo "# Blaseball Postseason Shutouts" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
$INTERESTING --reason shutout --name-style long --markdown >> $OUT
echo "" >> $OUT
echo "Done."

echo "############################################"
echo "# Blowouts:"

# All-time
OUT=$ROOT_DIR/../docs/blowouts_alltime.md
cat /dev/null > $OUT
echo "# All-Time Blaseball Blowouts" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
echo "" >> $OUT
$INTERESTING --reason blowout --name-style long --markdown >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season blowouts page..."
OUT=$ROOT_DIR/../docs/blowouts_season.md
cat /dev/null > $OUT
echo "# Blaseball Blowouts by Season" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
END=5
for i in $(seq 1 $LASTSEASON); do 
    echo "Working on season $i"
    echo "## Season $i Blowouts" >> $OUT
    echo "" >> $OUT
    $INTERESTING --season $i --reason blowout --name-style long --markdown >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team blowouts page..."
OUT=$ROOT_DIR/../docs/blowouts_team.md
echo "# Blaseball Blowouts by Team" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
cat /dev/null > $OUT
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    echo "Working on team $team"
    echo "## $team Blowout Summary" >> $OUT
    echo "" >> $OUT
    $INTERESTING --team "$team" --reason blowout --name-style long --markdown >> $OUT
    echo "" >> $OUT
done
echo "Done."

# Postseason
echo "Creating postseason blowouts page..."
OUT=$ROOT_DIR/../docs/blowouts_postseason.md
echo "# Blaseball Postseason Blowouts" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
$INTERESTING --reason blowout --name-style long --markdown >> $OUT
echo "" >> $OUT
echo "Done."

echo "############################################"
echo "# Underdog Wins:"

# All-time
OUT=$ROOT_DIR/../docs/underdog_alltime.md
cat /dev/null > $OUT
echo "# All-Time Blaseball Underdog Wins" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
echo "" >> $OUT
$INTERESTING --reason underdog --name-style long --markdown >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season underdog wins page..."
OUT=$ROOT_DIR/../docs/underdog_season.md
cat /dev/null > $OUT
echo "# Blaseball Underdog Wins by Season" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
END=5
for i in $(seq 1 $LASTSEASON); do 
    echo "Working on season $i"
    echo "## Season $i Underdog Wins" >> $OUT
    echo "" >> $OUT
    $INTERESTING --season $i --reason underdog --name-style long --markdown >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team underdog wins page..."
OUT=$ROOT_DIR/../docs/underdog_team.md
echo "# Blaseball Underdog Wins by Team" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
cat /dev/null > $OUT
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    echo "## $team Underdog Wins Summary" >> $OUT
    echo "" >> $OUT
    $INTERESTING --team "$team" --reason underdog --name-style long --markdown >> $OUT
    echo "" >> $OUT
done
echo "Done."

# Postseason
echo "Creating postseason underdog wins page..."
OUT=$ROOT_DIR/../docs/underdog_postseason.md
echo "# Blaseball Postseason Underdog Wins" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
$INTERESTING --reason underdog --name-style long --markdown >> $OUT
echo "" >> $OUT
echo "Done."

echo "############################################"
echo "# Shame Wins:"

# All-time
OUT=$ROOT_DIR/../docs/shame_alltime.md
cat /dev/null > $OUT
echo "# All-Time Blaseball Shame Wins" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
echo "" >> $OUT
$INTERESTING --reason shame --name-style long --markdown >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season shame wins page..."
OUT=$ROOT_DIR/../docs/shame_season.md
cat /dev/null > $OUT
echo "# Blaseball Shame Wins by Season" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
END=5
for i in $(seq 1 $LASTSEASON); do 
    echo "Working on season $i"
    echo "## Season $i Shame Wins" >> $OUT
    echo "" >> $OUT
    $INTERESTING --reason shame --name-style long --markdown >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team shame wins page..."
OUT=$ROOT_DIR/../docs/shame_team.md
echo "# Blaseball Shame Wins by Team" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
cat /dev/null > $OUT
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    echo "Working on team $team"
    echo "## $team Shame Wins Summary" >> $OUT
    echo "" >> $OUT
    $INTERESTING --team "$team" --reason shame --name-style long --markdown >> $OUT
    echo "" >> $OUT
done
echo "Done."

# Postseason
echo "Creating postseason shame wins page..."
OUT=$ROOT_DIR/../docs/shame_postseason.md
echo "# Blaseball Postseason Shame Wins" >> $OUT
echo "" >> $OUT
echo "(Through Season $LASTSEASON)" >> $OUT
echo "" >> $OUT
$INTERESTING --reason shame --name-style long --markdown >> $OUT
echo "" >> $OUT
echo "Done."
