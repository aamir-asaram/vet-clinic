/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

ALTER TABLE animals
ADD COLUMN species VARCHAR;

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR NOT NULL,
    age INT,
    PRIMARY KEY (id);
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR NOT NULL,
    PRIMARY KEY (id);
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id);

CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR NOT NULL,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id);
);

CREATE TABLE specializations(
    vet_id INT NOT NULL,
    species_id INT NOT NULL,
);

ALTER TABLE specializations
ADD CONSTRAINT fk_vet
FOREIGN KEY (vet_id)
REFERENCES vets(id);

ALTER TABLE specializations
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id);

CREATE TABLE visits(
    vet_id INT NOT NULL,
    animal_id INT NOT NULL,
)

ALTER TABLE visits
ADD CONSTRAINT fk_vet
FOREIGN KEY (vet_id)
REFERENCES vets(id);

ALTER TABLE visits
ADD CONSTRAINT fk_animal
FOREIGN KEY (animal_id)
REFERENCES animals(id);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';