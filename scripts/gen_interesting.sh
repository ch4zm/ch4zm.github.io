#!/bin/bash
#set -x

# Use interesting-blaseball-games and blaseball-streak-finder 
# to generate some markdown files containing tables with
# blaseball stats.

ROOT_DIR=$(dirname $(readlink -f "$0"))
INTERESTING="$ROOT_DIR/../vp/bin/interesting-blaseball-games"
ACTIVATE_SCRIPT="$ROOT_DIR/../vp/bin/activate"

LASTSEASON=6

# Enter the virtual environment
source $ACTIVATE_SCRIPT



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
$INTERESTING --reason shutout --postseason --name-style long --markdown --n-results 25 >> $OUT
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
$INTERESTING --reason blowout --postseason --name-style long --markdown --n-results 25 >> $OUT
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
$INTERESTING --reason underdog --postseason --name-style long --markdown --n-results 25 >> $OUT
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
$INTERESTING --reason shame --postseason --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."



echo "############################################"
echo "# Maxed Out:"

# All-time
echo "Creating all-time maxedout page..."
OUT=$ROOT_DIR/../docs/maxedout_alltime.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# All-Time Blaseball Maxed Out Games" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
$INTERESTING --reason maxedout --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season maxedout page..."
for i in $(seq 1 $LASTSEASON); do 
    OUT=$ROOT_DIR/../docs/maxedout_season$i.md
    echo "Working on season $i: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## Season $i Maxed Out Games" >> $OUT
    $INTERESTING --season $i --reason maxedout --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team maxedout page..."
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    lower_team=$(echo $team | awk '{print tolower($0)}' | sed 's/ /_/g' )
    OUT=$ROOT_DIR/../docs/maxedout_team_${lower_team}.md
    echo "Working on team $team: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## $team Maxed Out Games Summary" >> $OUT
    $INTERESTING --team "$team" --reason maxedout --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# Postseason
echo "Creating postseason maxedout page..."
OUT=$ROOT_DIR/../docs/maxedout_postseason.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# Blaseball Postseason Maxed Out Games" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
$INTERESTING --reason maxedout --postseason --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."



echo "############################################"
echo "# Defensive:"

# All-time
echo "Creating all-time defensive page..."
OUT=$ROOT_DIR/../docs/defensive_alltime.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# All-Time Blaseball Defensive Games" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
echo "" >> $OUT
echo "## Summary" >> $OUT
$INTERESTING --reason defensive --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."

# By Season
echo "Creating season-by-season defensive page..."
for i in $(seq 1 $LASTSEASON); do 
    OUT=$ROOT_DIR/../docs/defensive_season$i.md
    echo "Working on season $i: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## Season $i Defensive Games" >> $OUT
    $INTERESTING --season $i --reason defensive --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# By Team
echo "Creating team-by-team defensive page..."
cat $ROOT_DIR/../list_of_teams | sort | while read team; do
    lower_team=$(echo $team | awk '{print tolower($0)}' | sed 's/ /_/g' )
    OUT=$ROOT_DIR/../docs/defensive_team_${lower_team}.md
    echo "Working on team $team: $(basename $OUT)"

    cat /dev/null > $OUT
    echo "## $team Defensive Games Summary" >> $OUT
    $INTERESTING --team "$team" --reason defensive --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
done
echo "Done."

# Postseason
echo "Creating postseason defensive page..."
OUT=$ROOT_DIR/../docs/defensive_postseason.md
echo "Working on page: $(basename $OUT)"

cat /dev/null > $OUT
echo "# Blaseball Postseason Defensive Games" >> $OUT
echo "(Through season $LASTSEASON)" >> $OUT
$INTERESTING --reason defensive --postseason --name-style long --markdown --n-results 25 >> $OUT
echo "" >> $OUT
echo "Done."

