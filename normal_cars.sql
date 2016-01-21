DROP USER IF EXISTS normal_user;

CREATE USER normal_user;

DROP DATABASE IF EXISTS normal_cars;

CREATE DATABASE normal_cars;

\c normal_cars

\i scripts/denormal_data.sql;

CREATE TABLE IF NOT EXISTS car_makes
(
  "id" serial NOT NULL,
  PRIMARY KEY( "id" ),
  "brand" character varying(125) NOT NULL
);

INSERT INTO car_makes ( brand ) SELECT DISTINCT make_title FROM car_models ORDER BY make_title ASC;

SELECT * FROM car_makes;