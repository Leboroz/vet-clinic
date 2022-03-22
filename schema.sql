/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
  ID INT,
  NAME TEXT NOT NULL,
  DATE_OF_BIRTH DATE NOT NULL,
  ESCAPE_ATTEMPTS INT NOT NULL,
  NEUTERED BOOLEAN NOT NULL,
  WEIGHT_KG DECIMAL NOT NULL
);

ALTER TABLE animals ADD species TEXT NULL;