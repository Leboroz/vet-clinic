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

CREATE TABLE owners(
  id SERIAL PRIMARY KEY NOT NULL,
  full_name text,
  age INTEGER
);

CREATE TABLE species(
  id SERIAL PRIMARY KEY NOT NULL,
  name TEXT
);

ALTER TABLE animals DROP species;
ALTER TABLE animals ADD species_id INTEGER ;
ALTER TABLE animals ADD owner_id INTEGER;
ALTER TABLE animals ADD CONSTRAINT constraint_species FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT constraint_owners FOREIGN KEY(owner_id) REFERENCES owners(id);