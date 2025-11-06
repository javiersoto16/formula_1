DROP DATABASE IF EXISTS formula1_final;

CREATE SCHEMA IF NOT EXISTS formula1_final;
USE formula1_final;


CREATE TABLE drivers (
    driver_id INT AUTO_INCREMENT,
    forename VARCHAR(50) NOT NULL,
    surname VARCHAR(75) NOT NULL,
    nationality VARCHAR(50) NOT NULL,
    PRIMARY KEY (driver_id)
) ENGINE=InnoDB;


CREATE TABLE circuits (
    circuit_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    country VARCHAR(100),
    PRIMARY KEY (circuit_id)
) ENGINE=InnoDB;


CREATE TABLE races (
    race_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    year YEAR NOT NULL,
    circuit_id INT NOT NULL,
    PRIMARY KEY (race_id),
    FOREIGN KEY (circuit_id) REFERENCES circuits(circuit_id)
) ENGINE=InnoDB;


CREATE TABLE constructors (
    constructor_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    PRIMARY KEY (constructor_id)
) ENGINE=InnoDB;


CREATE TABLE results_final (
    result_id INT AUTO_INCREMENT,
    race_id INT NOT NULL,
    driver_id INT NOT NULL,
    position INT,
    positionOrder INT,
    ranking INT,
    constructor_id INT NOT NULL,
    fastest_lap_time VARCHAR(100),
    CONSTRAINT pk_results PRIMARY KEY (result_id),
    CONSTRAINT fk_results_race FOREIGN KEY (race_id) REFERENCES races (race_id),
    CONSTRAINT fk_results_driver FOREIGN KEY (driver_id) REFERENCES drivers (driver_id),
    CONSTRAINT fk_results_constructor FOREIGN KEY (constructor_id) REFERENCES constructors (constructor_id)
) ENGINE=InnoDB;


CREATE TABLE driver_standings (
    driver_standings_id INT AUTO_INCREMENT,
    driver_id INT NOT NULL,
    race_id INT NOT NULL,
    position SMALLINT UNSIGNED,
    wins INT DEFAULT 0,
    PRIMARY KEY (driver_standings_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (race_id) REFERENCES races(race_id)
) ENGINE=InnoDB;


CREATE TABLE constructor_standings (
    constructor_standings_id INT AUTO_INCREMENT,
    constructor_id INT NOT NULL,
    race_id INT NOT NULL,
    position SMALLINT UNSIGNED,
    wins INT DEFAULT 0,
    PRIMARY KEY (constructor_standings_id),
    FOREIGN KEY (constructor_id) REFERENCES constructors(constructor_id),
    FOREIGN KEY (race_id) REFERENCES races(race_id)
) ENGINE=InnoDB;

SELECT COUNT(*) 
FROM constructor_standings;




