/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name ~ 'mon$';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name ~ 'mon$';
UPDATE ANIMALS SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT s1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO s1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts > 0;
SELECT AVG(weight_kg) FROM animals;
SELECT name FROM animals WHERE escape_attempts = (
  SELECT MAX(escape_attempts) FROM animals
);
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth > '1990-01-01' AND date_of_birth < '2000-12-31' GROUP BY species;

SELECT name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
SELECT name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT full_name, animals.name from owners LEFT JOIN animals ON owners.id = animals.owner_id;
SELECT species.name, count(animals.species_id) FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;
SELECT full_name, animals.name 
FROM animals 
INNER JOIN owners 
ON animals.owner_id = owners.id 
INNER JOIN species 
ON animals.species_id = species.id 
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
SELECT full_name, name 
FROM animals 
INNER JOIN owners 
ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;
SELECT full_name 
FROM (
	SELECT full_name, count(name) as counted 
	FROM animals 
	INNER JOIN owners 
	ON owner_id = owners.id 
	GROUP BY full_name
) AS foo 
WHERE counted = (
	SELECT max(bar.counted) 
	FROM (
		select full_name, count(name) 
		AS counted 
		FROM animals 
		INNER JOIN owners 
		ON owner_id = owners.id 
		GROUP BY owners.full_name
	) 
	as bar
);
