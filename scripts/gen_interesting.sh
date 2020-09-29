#!/bin/bash
set -e

# Use interesting-blaseball-games and blaseball-streak-finder 
# to generate some markdown files containing tables with
# blaseball stats.

ROOT_DIR=$(dirname $(readlink -f "$0"))
INTERESTING="$ROOT_DIR/../vp/bin/interesting-blaseball-games"
ACTIVATE_SCRIPT="$ROOT_DIR/../vp/bin/activate"

LASTSEASON=7

# Enter the virtual environment
source $ACTIVATE_SCRIPT

# Loop over each type of interesting game,
# and generate all time/postseason/season/team
# pages for each interesting game type

# Lower-case labels for each type of game
lower_labels[0]="shutouts"
upper_labels[0]="Shutouts"
flag_labels[0]="shutout"

lower_labels[1]="blowouts"
upper_labels[1]="Blowouts"
flag_labels[1]="blowout"

lower_labels[2]="underdog"
upper_labels[2]="Underdog Wins"
flag_labels[2]="underdog"

lower_labels[3]="shame"
upper_labels[3]="Shame Runs"
flag_labels[3]="shame"

lower_labels[4]="maxedout"
upper_labels[4]="Maxed Out"
flag_labels[4]="maxedout"

lower_labels[5]="defensive"
upper_labels[5]="Defensive Games"
flag_labels[5]="defensive"


for ((i = 0 ; i <= 5; i++)); do

    echo "===================="

    lower_label="${lower_labels[$i]}"
    upper_label="${upper_labels[$i]}"
    flag_label="${flag_labels[$i]}"

    # Prepare the navigation document
    MASTER="$ROOT_DIR/../docs/${lower_label}.md"
    cat /dev/null > $MASTER
    echo "# $upper_label" >> $MASTER
    echo "" >> $MASTER
    
    # All-time
    echo "Creating all-time $lower_label page..."
    fname="${lower_label}_alltime.md"
    OUT="$ROOT_DIR/../docs/$fname"
    echo "Working on page: $(basename $OUT)"
    
    title="All-Time $upper_label"
    echo "## All Time" >> $MASTER
    echo "" >> $MASTER
    echo "[$title]($fname)" >> $MASTER
    echo "" >> $MASTER
    
    cat /dev/null > $OUT
    echo "# $title" >> $OUT
    echo "(Through season $LASTSEASON)" >> $OUT
    echo "" >> $OUT
    echo "## Summary" >> $OUT
    $INTERESTING --reason $flag_label --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
    echo "Done."
    
    
    # Postseason
    echo "Creating postseason $lower_label page..."
    fname="${lower_label}_postseason.md"
    OUT="$ROOT_DIR/../docs/$fname"
    echo "Working on page: $(basename $OUT)"
    
    title="Blaseball Postseason $upper_label"
    echo "## Postseason" >> $MASTER
    echo "" >> $MASTER
    echo "[$title]($fname)" >> $MASTER
    echo "" >> $MASTER
    
    cat /dev/null > $OUT
    echo "# $title" >> $OUT
    echo "(Through season $LASTSEASON)" >> $OUT
    $INTERESTING --reason $flag_label --postseason --name-style long --markdown --n-results 25 >> $OUT
    echo "" >> $OUT
    echo "Done."
    
    
    # By Season
    echo "Creating season-by-season $lower_label page..."
    echo "## By Season" >> $MASTER
    echo "" >> $MASTER
    for s in $(seq 1 $LASTSEASON); do 
        fname="${lower_label}_season${s}.md"
        OUT="$ROOT_DIR/../docs/$fname"
        echo "Working on season $s: $(basename $OUT)"
    
        title="Season $s $upper_label"
        echo "* [$title]($fname)" >> $MASTER
        echo "" >> $MASTER
    
        cat /dev/null > $OUT
        echo "# $title" >> $OUT
        $INTERESTING --season $s --reason $flag_label --name-style long --markdown --n-results 25 >> $OUT
        echo "" >> $OUT
    done
    echo "Done."
    
    
    # By Team
    echo "Creating team-by-team $lower_label page..."
    echo "## By Team" >> $MASTER
    echo "" >> $MASTER
    cat $ROOT_DIR/../list_of_teams | sort | while read team; do
        lower_team=$(echo $team | awk '{print tolower($0)}' | sed 's/ /_/g' )
        fname="${lower_label}_team_${lower_team}.md"
        OUT="$ROOT_DIR/../docs/$fname"
        echo "Working on team $team: $(basename $OUT)"
    
        title="$team $upper_label Summary"
        echo "* [$title]($fname)" >> $MASTER
        echo "" >> $MASTER
    
        cat /dev/null > $OUT
        echo "# $title" >> $OUT
        $INTERESTING --team "$team" --reason $flag_label --name-style long --markdown --n-results 25 >> $OUT
        echo "" >> $OUT
    done
    echo "Done."

done

