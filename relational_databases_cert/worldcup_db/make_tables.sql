

drop table if exists teams cascade;
CREATE TABLE teams(
  team_id SERIAL PRIMARY KEY NOT NULL,
  name varchar(30) UNIQUE NOT NULL
);

drop table if exists games cascade;
CREATE TABLE games(
  game_id SERIAL PRIMARY KEY NOT NULL,
  year INT NOT NULL,
  round VARCHAR(30) NOT NULL,
  winner_id INT NOT NULL,
  CONSTRAINT winner_txt FOREIGN KEY(winner_id) REFERENCES teams(team_id),
  opponent_id INT NOT NULL,
  CONSTRAINT opponent_txt FOREIGN KEY(opponent_id) REFERENCES teams(team_id),
  winner_goals INT NOT NULL,
  opponent_goals INT NOT NULL
  );
