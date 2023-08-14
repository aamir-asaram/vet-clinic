/*Queries that provide answers to the questiONs from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mON';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE (escape_attempts < 3) AND neutered;
SELECT date_of_birth from animals WHERE name IN ('AgumON', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name NOT IN ('GabumON');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals
SET species = 'digimON'
WHERE name LIKE '%mON';
UPDATE animals
SET species = 'pokemON'
WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT deleted_record;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO deleted_record;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- Query Multiple Tables

SELECT name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Melody PONd';

SELECT animals.name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'PokemON';

SELECT owners.full_name, animals.name FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.id) FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell'
AND species.name = 'DigimON';

SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0;

SELECT owners.full_name FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(animals.id) DESC
LIMIT 1;

-- JOIN Table Queries

SELECT animals.name FROM visits
JOIN vets ON vet_id = vets.id
JOIN animals ON animal_id = animals.id
where vets.name = 'William Tatcher'
ORDER BY date DESC
LIMIT 1;

SELECT COUNT(date) FROM visits
JOIN vets ON vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name FROM vets
LEFT JOIN specializations ON vets.id = vet_id
LEFT JOIN species ON species.id = species_id;

SELECT animals.name FROM visits
JOIN animals ON animal_id = animals.id
JOIN vets ON vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
AND date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name FROM visits
JOIN animals ON animal_id = animals.id
GROUP BY animals.name
ORDER BY COUNT(animals.id) DESC
LIMIT 1;

SELECT animals.name FROM visits
JOIN animals ON animal_id = animals.id
JOIN vets ON vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY date
LIMIT 1;

SELECT animals.name, vets.name, date FROM visits
JOIN animals ON animal_id = animals.id
JOIN vets ON vet_id = vets.id
ORDER BY date DESC
LIMIT 1;

SELECT COUNT(*) FROM visits
JOIN animals ON animal_id = animals.id
JOIN vets ON vet_id = vets.id
JOIN specializations ON vets.id = specializations.vet_id
WHERE animals.species_id != specializations.species_id;

SELECT species.name FROM visits
JOIN animals ON animal_id = animals.id
JOIN species ON animals.species_id = species.id
JOIN vets ON vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(species.id) DESC
LIMIT 1;
