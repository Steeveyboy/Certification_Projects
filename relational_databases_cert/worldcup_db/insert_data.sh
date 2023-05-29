#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "$($PSQL "\i make_tables.sql")"

while IFS="," read -r year round winner opponent winner_goals opponent_goals
do
  COUNTRIES+="('$winner'), ('$opponent'),"
done < <(tail -n +2 games.csv)
COUNTRIES=${COUNTRIES:0:-1}
echo -e "$($PSQL "WITH all_teams(name) as (values$COUNTRIES) INSERT INTO teams(name) (SELECT DISTINCT name from all_teams);")"


while IFS="," read -r year round winner opponent winner_goals opponent_goals
do 
  echo -e "$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values('$year', '$round', (select team_id from teams where name = '$winner'), (select team_id from teams where name = '$opponent'), $winner_goals, $opponent_goals);")"
done < <(tail -n +2 games.csv)
