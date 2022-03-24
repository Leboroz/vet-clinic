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
CREATE TABLE vets(
  id SERIAL PRIMARY KEY NOT NULL,
  name TEXT,
  age INTEGER,
  date_of_graduation date
);

CREATE TABLE specializations(
  vet_id INTEGER,
  specie_id INTEGER,
  CONSTRAINT constraint_vet 
  FOREIGN KEY(vet_id)
  REFERENCES vets(id),
  CONSTRAINT constraint_specie 
  FOREIGN KEY(specie_id)
  REFERENCES species(id)
);

CREATE TABLE visits(
  vet_id INTEGER,
  animal_id INTEGER,
  date_of_visit DATE,
  CONSTRAINT constraint_vet 
  FOREIGN KEY(vet_id)
  REFERENCES vets(id),
  CONSTRAINT constraint_animal 
  FOREIGN KEY(animal_id)
  REFERENCES animals(id)
);

CREATE VIEW 
visitors_view as
SELECT animals.id as animal_id,
  animals.name as animal_name,
  vets.id as vet_id,
  vets.name as vet_name, 
  visits.date_of_visit
FROM animals 
INNER JOIN visits 
ON animals.id = visits.animal_id 
INNER JOIN vets 
ON vets.id = visits.vet_id;

CREATE VIEW specializations_view AS
SELECT vet_id,
  vets.name AS vet_name,
  specie_id,
  species.name AS species_name
FROM vets 
INNER JOIN specializations 
ON vets.id = specializations.vet_id
INNER JOIN species
ON species.id = specializations.specie_id;
