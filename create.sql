CREATE SCHEMA IF NOT EXISTS pandemic;
use pandemic;

CREATE TABLE countries
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    abbreviation VARCHAR(10)
);

CREATE TABLE diseases
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE infectious_cases_per_country_year
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    country_id INT NOT NULL,
	year YEAR NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries(id),
	UNIQUE(country_id, year)
);

CREATE TABLE infectious_case_number
(
	icpcy_id INT NOT NULL,
    disease_id INT NOT NULL,
    case_number DOUBLE NOT NULL,
    PRIMARY KEY (icpcy_id, disease_id),
    FOREIGN KEY (icpcy_id) REFERENCES infectious_cases_per_country_year(id),
    FOREIGN KEY (disease_id) REFERENCES diseases(id)
);
