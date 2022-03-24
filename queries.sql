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

SELECT animal_name 
FROM visitors_view 
WHERE vet_name = 'William Tatcher' 
ORDER BY date_of_visit DESC 
LIMIT 1;

SELECT COUNT(*) 
FROM visitors_view 
WHERE vet_name = 'Stephanie Mendez';

SELECT vets.name as Vname,
species.name as Sname 
FROM vets 
LEFT JOIN specializations 
ON vets.id = specializations.vet_id 
LEFT JOIN species 
ON species.id = specializations.specie_id;

SELECT animal_name 
FROM visitors_view 
WHERE date_of_visit > '2020-04-01' 
AND date_of_visit < '2020-09-30' 
AND vet_name = 'Stephanie Mendez';

SELECT animal_name 
FROM (
	SELECT animal_name, 
	COUNT(animal_name) as animal_count 
	FROM visitors_view 
	GROUP BY animal_name 
	ORDER BY animal_count DESC 
	LIMIT 1
) AS counted;

SELECT animal_name 
FROM visitors_view 
WHERE vet_name = 'Maisy Smith' 
ORDER BY date_of_visit 
LIMIT 1;

SELECT animals.name AS animal_name, 
date_of_birth, 
neutered, 
escape_attempts, 
weight_kg, 
full_name AS owner, 
species.name AS specie, 
vets.name AS vet, 
vets.age, 
date_of_graduation, 
date_of_visit 
FROM animals 
INNER JOIN species 
ON animals.species_id = species.id 
INNER JOIN owners 
ON animals.owner_id = owners.id 
INNER JOIN visits 
ON visits.animal_id = animals.id 
INNER JOIN vets 
ON visits.vet_id = vets.id 
ORDER BY date_of_visit DESC 
LIMIT 1;

SELECT COUNT(*) 
FROM animals 
INNER JOIN visits 
ON visits.animal_id = animals.id 
INNER JOIN vets 
ON vets.id = visits.vet_id 
INNER JOIN specializations 
ON specializations.vet_id = vets.id 
WHERE vets.name <> 'Stephanie Mendez' 
AND specializations.specie_id <> animals.species_id;

SELECT name 
FROM (
	SELECT species.name, 
	COUNT(*) 
	FROM animals 
	INNER JOIN visits 
	ON visits.animal_id = animals.id 
	INNER JOIN vets 
	ON vets.id = visits.vet_id 
	INNER JOIN species 
	ON species.id = animals.species_id 
	WHERE vets.name = 'Maisy Smith' 
	GROUP BY species.name 
	ORDER BY count DESC 
	LIMIT 1
) AS foo;
