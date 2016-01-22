\timing

DROP USER IF EXISTS normal_user;

CREATE USER normal_user;

DROP DATABASE IF EXISTS normal_cars;

CREATE DATABASE normal_cars;

\c normal_cars

\i scripts/denormal_data.sql;


---------- CREATES TABLE WITH ID NUMBER, SHORTENED MANUFACTURER CODE, AND FULL BRAND NAME
CREATE TABLE IF NOT EXISTS manufacturer_codes_and_brands
(
  "id" serial NOT NULL,
  PRIMARY KEY( "id" ),
  "manufacturer_codes" varchar(125) NOT NULL,
  "manufacturer_brand" varchar(125) NOT NULL
);

INSERT INTO manufacturer_codes_and_brands ( manufacturer_codes, manufacturer_brand )
SELECT DISTINCT make_code, make_title
FROM car_models ORDER BY make_code ASC;


---------- CREATES TABLE WITH ID NUMBER, FULL BRAND NAME, SHORTENED MODEL CODE NAME, AND FULL MODEL SPEC
CREATE TABLE IF NOT EXISTS model_codes_and_specs_by_brand
(
  "id" serial NOT NULL,
  PRIMARY KEY( "id" ),
  "manufacturer_brand" varchar(125) NOT NULL,
  "model_codes" varchar(125) NOT NULL,
  "model_specs" varchar(125) NOT NULL
);

INSERT INTO model_codes_and_specs_by_brand ( manufacturer_brand, model_codes, model_specs )
SELECT DISTINCT make_title, model_code, model_title
FROM car_models
ORDER BY make_title ASC, model_title ASC;


---------- CREATES TABLE WITH ID NUMBER AND PRODUCTION YEAR
CREATE TABLE IF NOT EXISTS production_year
(
  "id" serial NOT NULL,
  PRIMARY KEY( "id" ),
  production_year integer NOT NULL
);

INSERT INTO production_year ( production_year )
SELECT DISTINCT year
FROM car_models
ORDER BY year ASC;