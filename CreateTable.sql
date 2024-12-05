--  Script para criar as Tabelas do modelo relacional


--    TABELAS SEM DEPENDÊNCIAS DIRETAS

CREATE TABLE IF NOT EXISTS SERVICECOST (
    unlock NUMERIC(3, 2) NOT NULL CHECK (unlock BETWEEN 0 AND 9.99) DEFAULT 1.00,
    usable NUMERIC(3, 2) NOT NULL CHECK (usable BETWEEN 0 AND 9.99) DEFAULT 0.15,
    -- Definição de chave primária para evitar registros duplicados.
    PRIMARY KEY (unlock, usable)
);

CREATE TABLE IF NOT EXISTS SCOOTERMODEL(
    number SERIAL PRIMARY KEY,
    designation VARCHAR(30) NOT NULL,
    autonomy INTEGER NOT NULL CHECK (autonomy > 0) --A autonomia é em Kilómetros
);

CREATE TABLE IF NOT EXISTS TYPEOF(
    reference CHAR(10) NOT NULL NOT NULL CHECK (reference IN ('resident', 'tourist')),
    nodays INTEGER NOT NULL CHECK (nodays > 0),
    price NUMERIC(4,2) NOT NULL CHECK (price > 0),
    PRIMARY KEY (reference)
);


CREATE TABLE IF NOT EXISTS STATION(
    id SERIAL  PRIMARY KEY,
    latitude NUMERIC(6,4) NOT NULL,
    longitude NUMERIC(6,4) NOT NULL
);

CREATE TABLE IF NOT EXISTS PERSON(
    id SERIAL PRIMARY KEY,
    email VARCHAR(40) UNIQUE CHECK (POSITION ('@' IN email) > 0),
    taxnumber INTEGER UNIQUE,
    name VARCHAR(50) NOT NULL
);

--  TABELAS COM UMA DEPENDÊNCIA

CREATE TABLE IF NOT EXISTS CLIENT(
    person INTEGER PRIMARY KEY,
    dtregister TIMESTAMP,
    -- sE um tuplo de uma pessoa for apagada o cliente correspondente também será apagado
    FOREIGN KEY (person) REFERENCES PERSON(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS EMPLOYEE(
    person INTEGER PRIMARY KEY,
    number SERIAL UNIQUE NOT NULL,
    -- sE um tuplo de uma pessoa for apagada o cliente correspondente também será apagado
    FOREIGN KEY (person) REFERENCES PERSON(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS REPLACEMENTORDER(
    dtorder TIMESTAMP,
    dtreplacement TIMESTAMP CHECK (dtreplacement IS NULL OR dtreplacement > dtorder),
    roccupation INTEGER NOT NULL CHECK (roccupation BETWEEN 0 AND 100),
    station INTEGER,
    PRIMARY KEY (dtorder, station),
    --Se um tuplo de uma estação for apagada a o replacement order corresponde tambem será apgado
    FOREIGN KEY (station) REFERENCES STATION(id) on DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS SCOOTER(
    id SERIAL PRIMARY KEY,
    weight NUMERIC(4,2) NOT NULL CHECK (weight > 0), --O valor é em gramas
    maxvelocity NUMERIC(4,2) NOT NULL CHECK (maxvelocity > 0), --O valor é em KM/H
-- Verifica bateria <= autonomia do modelo
    battery INTEGER NOT NULL CHECK (battery > 0),--(battery <= ALL (SELECT autonomy FROM SCOOTERMODEL WHERE SCOOTERMODEL.number = model)),
    model INTEGER NOT NULL,
    FOREIGN KEY (model) REFERENCES SCOOTERMODEL(number)
);

--  TABELAS COM DUAS DEPENDÊNCIAS
CREATE TABLE IF NOT EXISTS DOCK(
    number SERIAL ,
    station INTEGER,
    state VARCHAR(30) NOT NULL CHECK (state IN ('free', 'occupy', 'under maintenance')),
    scooter INTEGER,
    PRIMARY KEY(number, station),
    CONSTRAINT chk_scooter_state CHECK ((state != 'occupy') OR (scooter IS NOT NULL)),
    FOREIGN KEY (station) REFERENCES STATION(id) on DELETE CASCADE,
    FOREIGN KEY (scooter) REFERENCES SCOOTER(id) on DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS REPLACEMENT(
    number SERIAL PRIMARY KEY,
    dtreplacement TIMESTAMP NOT NULL,
    action CHAR(8) NOT NULL CHECK (action IN ('inplace', 'remove')),
    dtreporder TIMESTAMP NOT NULL,
    repstation INTEGER NOT NULL,
    employee INTEGER NOT NULL,
    FOREIGN KEY (dtreporder, repstation) REFERENCES REPLACEMENTORDER(dtorder, station) ON DELETE CASCADE,
    FOREIGN KEY (employee) REFERENCES EMPLOYEE(person) ON DELETE CASCADE,
    CHECK (dtreplacement > dtreporder)
);
CREATE table IF NOT EXISTS CARD(
    id SERIAL PRIMARY KEY,
    credit NUMERIC(4,2),
    typeof CHAR(10),
    client INTEGER,
    FOREIGN KEY (typeof) REFERENCES TYPEOF(reference) ON DELETE CASCADE ,
    FOREIGN KEY (client) REFERENCES CLIENT(person) ON DELETE CASCADE
    );
-- TABELAS COM DEPENDECIA EM UMA TABELA COM MULTIPLAS DEPENDÊNCIAS

CREATE TABLE IF NOT EXISTS TOPUP(
    dttopup TIMESTAMP ,
    card INTEGER ,
    value NUMERIC(4,2) CHECK(value > 0),
    PRIMARY KEY (dttopup, card),
    FOREIGN KEY (card) REFERENCES CARD(id)
    );
--   TABELAS COM TRÊS DEPNDÊNCIAS
CREATE TABLE IF NOT EXISTS TRAVEL(
    dtinitial TIMESTAMP,
    comment VARCHAR(100)  CHECK (comment IS NULL OR evaluation IS NOT NULL),
    evaluation INTEGER CHECK (evaluation IS NULL OR evaluation BETWEEN 1 AND 5),
    dtfinal TIMESTAMP CHECK (dtfinal IS NULL OR dtfinal > dtinitial),
    client INTEGER,
    scooter INTEGER ,
    stinitial INTEGER,
    stfinal INTEGER,
    PRIMARY KEY (dtinitial, client, scooter),
    FOREIGN KEY (client) REFERENCES CLIENT(person) ON DELETE CASCADE,
    FOREIGN KEY (scooter) REFERENCES SCOOTER(id) ON DELETE CASCADE,
    FOREIGN KEY (stinitial) REFERENCES STATION(id) ON DELETE CASCADE,
    FOREIGN KEY (stfinal) REFERENCES STATION(id) ON DELETE CASCADE
);
