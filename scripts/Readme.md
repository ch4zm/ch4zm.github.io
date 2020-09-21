# `gen_interesting.sh`

This script uses the [interesting-blaseball-games](https://github.com/ch4zm/interesting-blaseball-games)
command line tool to generate markdown pages with tables
of interesting games. The markdown files go into the `docs/`
dir in the root of this repo.


# `gen_streaks.sh`

This script uses the [blaseball-streak-finder](https://github.com/ch4zm/blaseball-streak-finder)
command line tool to generate markdown pages with tables
of win/loss streaks. The mardown files go into the `docs/`
dir in the root of this repo.

# `gen_incinerations.sh`

This script uses the incineration data in `data/incinerations`
to generate markdown files containing game summaries of games
where players were incinerated.

Incineration game summaries are listed by player and chronologically.


# `gen_deceased_data.sh`

This script will call the [blaseball-reference.com API](https://api.blaseball-reference.com/docs#/Players/get_deceased)
to get a list of all deceasedd blaseball players. This list is used
as a starting point for compiling incineration information.

