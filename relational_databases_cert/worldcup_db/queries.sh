#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals+opponent_goals) as total FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) as mean FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) as round_mean FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals+opponent_goals) as both_mean FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) as max_goal FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT count(winner_id) as winner_two FROM games where winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name as winner_2018 FROM games 
        join teams on teams.team_id = games.winner_id
        where year = 2018 and round = 'Final'
        ORDER BY name;")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "
      with temptable(idss) as ((select winner_id, year,round from games) union (select opponent_id, year, round from games))
      select name from temptable join teams on team_id = idss
      where round = 'Eighth-Final' and year = 2014
      order by name;")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT name FROM games
        join teams on team_id = winner_id
        order by name;")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT DISTINCT year, name FROM games
        join teams on team_id = winner_id
        where round = 'Final';")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name from teams
      where name like 'Co%';")"
