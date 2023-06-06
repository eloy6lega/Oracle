-- 2 --
CREATE OR REPLACE TYPE tFamilia AS OBJECT (
    idFamilia int(10),
    familia varchar(200)  
);

-- 3 --
CREATE TABLE FAMILIA OF tFamilia;
ALTER TABLE FAMILIA ADD PRIMARY KEY (idFamilia);

-- 4 --
INSERT INTO familia VALUES (1, 'Aves');
INSERT INTO familia VALUES (2, 'Mamíferos');
INSERT INTO familia VALUES (3, 'Peces');

-- 5 --
CREATE TYPE tNombres AS VARRAY (20) OF VARCHAR(50);

-- 6 --
CREATE OR REPLACE TYPE tAnimal AS OBJECT (
    idAnimal int(10),
    idFamilia int(10),
    animal varchar(100),
    nombres tNombres,
    MEMBER FUNCTION ejemplares RETURN varchar
);

CREATE OR REPLACE TYPE BODY tAnimal AS
    MEMBER FUNCTION ejemplares RETURN varchar IS
    numEj NUMBER := self.nombres.COUNT;
    especie VARCHAR(50) := self.animal;
    BEGIN
        RETURN 'Hay '||numEj||' animales de la especie '||especie;
    END;
END;

-- 7 --
CREATE TABLE ANIMAL OF tAnimal;

-- 8 --
ALTER TABLE ANIMAL ADD PRIMARY KEY (idAnimal);
ALTER TABLE ANIMAL ADD FOREIGN KEY (idFamilia) REFERENCES FAMILIA;

-- 9 --
-- Aves
INSERT INTO Animal VALUES (1, 1, 'Garza Real', tNombres('Calíope', 'Izaro'));
INSERT INTO Animal VALUES (2, 1, 'Cigüeña Blanca', tNombres('Perica', 'Clara', 'Miranda'));
INSERT INTO Animal VALUES (3, 1, 'Gorrión', tNombres('Coco', 'Roco', 'Loco', 'Peco', 'Rico'));

-- Mamíferos
INSERT INTO animal VALUES (4, 2, 'Zorro', tNombres('Lucas', 'Mario'));
INSERT INTO animal VALUES (5, 2, 'Lobo', tNombres('Pedro', 'Pablo'));
INSERT INTO animal VALUES (6, 2, 'Gorrión', tNombres('Bravo', 'Listo', 'Rojo', 'Astuto'));

-- Peces
INSERT INTO animal VALUES (7, 3, 'Pez Globo', tNombres('Allam'));
INSERT INTO animal VALUES (8, 3, 'Pez Payaso', tNombres('Diego'));
INSERT INTO animal VALUES (9, 3, 'Ángel Llama', tNombres('Carla'));

-- 10 --
SELECT a.animal, f.familia, a.ejemplares() FROM Animal a, Familia f WHERE a.idFamilia = f.idFamilia;


