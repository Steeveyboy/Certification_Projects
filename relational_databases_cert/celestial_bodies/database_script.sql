-- BEGIN TRANSACTION;

DROP TABLE IF EXISTS moon;
DROP TABLE IF EXISTS planet;
DROP TABLE IF EXISTS star;
DROP TABLE IF EXISTS surface_description;
DROP TABLE IF EXISTS galaxy;

CREATE TABLE galaxy(
  galaxy_id SERIAL PRIMARY KEY NOT NULL, 
  name VARCHAR(30) NOT NULL UNIQUE,
  description text,
  mass int,
  cosmic_distance numeric
);

CREATE TABLE surface_description(
  surface_description_id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(30) NOT NULL UNIQUE,
  description TEXT
);


CREATE TABLE star(
  star_id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(30) NOT NULL UNIQUE,
  galaxy_id SERIAL,
  CONSTRAINT parent_galaxy_id FOREIGN KEY(galaxy_id) REFERENCES galaxy(galaxy_id),
  mass int,
  dying boolean
);


CREATE TABLE planet(
  planet_id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(40) NOT NULL UNIQUE,
  star_id SERIAL,
  CONSTRAINT parent_star_id FOREIGN KEY(star_id) REFERENCES star(star_id),
  supports_life BOOLEAN,
  known_population int
);


CREATE TABLE moon(
  moon_id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(30) NOT NULL UNIQUE,
  planet_id SERIAL,
  surface_description_id SERIAL, 
  CONSTRAINT parent_planet_id FOREIGN KEY(planet_id) REFERENCES planet(planet_id),
  CONSTRAINT corr_descriptor_id FOREIGN KEY(surface_description_id) REFERENCES surface_description(surface_description_id),
  known_population INT
);

INSERT INTO GALAXY(name, description, mass, cosmic_distance) 
VALUES ('Supermega', 'The most populus and vastus galaxy there ever was', 1000000, 10000), 
('The Crypt', 'The oldest galaxy', 300000, 4000),
('BORG SYNDICATE', 'The most high tech galaxy', 440000, 3000),
('Here and There', 'A galaxy split between multiple dimensions', 3141, 271),
('The Abyss', 'A galaxy that we do not hear from often', 42, 10000),
('Vanguard', 'A new galaxy that has recently been acquired by a private equity firm', 51000, 25000);

INSERT INTO SURFACE_DESCRIPTION(name, description)
VALUES ('Bog', 'A wet and damp terrain full of vegetation overgrowth'),
('Barren', 'A vast space desert with nothing to block your view... As far as you can tell'),
('Metropolis', 'A sprawling cityscape filled with various life forms, makes a good environment for business'),
('Water', 'A vast ocean filled with anything you can imagine');


INSERT INTO STAR(name, galaxy_id, mass, dying)
VALUES('Metroid 1', 1, 1000, FALSE)
,('XYZ', 2, 300, TRUE)
,('POWER', 3, 1000, FALSE)
,('Half and Half', 4, 350, FALSE)
,('?', 5, 20, TRUE)
,('EXXON Renewables Corp. Asset 1', 6, 880, FALSE)
;

INSERT INTO PLANET(name, star_id, supports_life, known_population)
VALUES('Megopolus', 1, TRUE, 1000000000),
('Ursa Mining', 1, TRUE, 30000000),
('Pop Rocks', 1, TRUE, 7654321),
('Elden',2, TRUE, 500000000),
('Mainframe 101A', 3, FALSE, 0),
('Mainframe 101B', 3, FALSE, 27),
('!', 4, TRUE, 0),
('And Back Again', 4, TRUE, 46000500),
('Nothing', 5, FALSE, 1),
('Pandora Real Estate Investments', 6, TRUE, 555555),
('Vanguard Industrial Venture 1', 6, TRUE, 15000000),
('Vanguard Deversified Labor Trust 2', 6, TRUE, 1700000)
;

INSERT INTO MOON(name, planet_id, surface_description_id, known_population)
VALUES('Reese Vacation Homes', 1, 3, 10000), 
('Water Source X100', 2, 4, 0),
('VanEck Ski Lodges', 3, 3, 88080),
('Midland Launch Site', 3, 2, 43),
('Accounts Receivables', 3, 1, 1000),
('The Graveyard', 4, 2, 1),
('Liquid Coolant Source 1', 5, 4, 4040),
('Liquid Coolant Source 2', 6, 4, 4040),
('Not Sure', 7, 2, 0),
('Not Much', 7, 2, 1),
('Not Leaving', 7, 3, 10),
('Not Stoppin', 8, 3, 404),
('Not Nothing', 9, 3, 505),
('Vangrd Real-Est Developement', 10, 1, 1234),
('Vangrd Properties Planet F100', 10, 3, 5432),
('Offworld water source', 10, 4, 0),
('X10X9', 11, 2, 487),
('X10V10', 11, 2, 879888),
('Uncharted Forest', 11, 1, 7777),
('Administative Trade Zone X10', 12, 3, 54004)
;

-- END;

