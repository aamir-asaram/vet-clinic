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
