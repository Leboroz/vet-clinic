/* Populate database with sample data. */

INSERT INTO animals
VALUES (0, 'Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals
VALUES (1, 'Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO animals
VALUES (2, 'Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals
VALUES (3, 'Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals
 VALUES ('Charmander', '2020-02-08', 0, true, -11),
 ('Plantmon', '2021-11-15', 2, true, -5.7),
 ('Squirtle', '1993-04-02', 3, fase, -12.13),
 ('Angemon', '2005-06-12', 1, true, -45),
 ('Boardmon', '2005-06-07', 7, true, 20.4),
 ('Blossom', '1998-10-13', 3, true, 17),
 ('Ditto', '2022-05-14', 4, true, 22);

INSERT INTO owners(full_name, age)
 VALUES ('Sam Smith',34),
 ('Jennifer Orwell', 19),
 ('Bob', 45),
 ('Melody Pond', 77),
 ('Dean Winchester', 14),
 ('Jodie Whittaker', 38);

INSERT INTO species(name)
 values ('Pokemon'),
 ('Digimon');

UPDATE animals SET species_id = 2 WHERE name ~ 'mon$';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;
UPDATE animals SET owner_id =(SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id =(SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Pikachu' OR name = 'Gabumon';
UPDATE animals SET owner_id =(SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id =(SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Squirtle' OR name = 'Charmander' OR name = 'Blossom';
UPDATE animals SET owner_id =(SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';

