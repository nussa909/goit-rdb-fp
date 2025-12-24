use pandemic;

INSERT INTO countries (name, abbreviation)
SELECT DISTINCT Entity, Code 
FROM infectious_cases;

INSERT INTO diseases (name)
SELECT REGEXP_REPLACE(COLUMN_NAME, 'Number_|cases_|_cases', '')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'infectious_cases' AND (COLUMN_NAME LIKE 'Number_%' OR COLUMN_NAME LIKE 'cases_%' OR COLUMN_NAME LIKE '%_cases');

INSERT INTO infectious_cases_per_country_year (country_id, year)
SELECT countries.id, Year 
FROM infectious_cases
INNER JOIN countries ON Entity = countries.name;


-- TRUNCATE TABLE infectious_case_number;
INSERT INTO infectious_case_number (icpcy_id, disease_id, case_number)
SELECT infectious_cases_per_country_year.id, diseases.id AS disease_id, infectious_cases.Number_yaws
FROM infectious_cases_per_country_year
INNER JOIN diseases ON diseases.name = 'yaws'
INNER JOIN countries ON country_id = countries.id
INNER JOIN infectious_cases ON countries.name = infectious_cases.Entity AND infectious_cases_per_country_year.year = infectious_cases.Year
WHERE infectious_cases.Number_yaws != ''
UNION ALL
SELECT infectious_cases_per_country_year.id, diseases.id AS disease_id, infectious_cases.polio_cases
FROM infectious_cases_per_country_year
INNER JOIN diseases ON diseases.name = 'polio'
INNER JOIN countries ON country_id = countries.id
INNER JOIN infectious_cases ON countries.name = infectious_cases.Entity AND infectious_cases_per_country_year.year = infectious_cases.Year
WHERE infectious_cases.polio_cases != ''
UNION ALL
SELECT infectious_cases_per_country_year.id, diseases.id AS disease_id, infectious_cases.cases_guinea_worm
FROM infectious_cases_per_country_year
INNER JOIN diseases ON diseases.name = 'cases_guinea'
INNER JOIN countries ON country_id = countries.id
INNER JOIN infectious_cases ON countries.name = infectious_cases.Entity AND infectious_cases_per_country_year.year = infectious_cases.Year
WHERE infectious_cases.cases_guinea_worm != ''
UNION ALL
SELECT infectious_cases_per_country_year.id, diseases.id AS disease_id, infectious_cases.Number_rabies
FROM infectious_cases_per_country_year
INNER JOIN diseases ON diseases.name = 'rabies'
INNER JOIN countries ON country_id = countries.id
INNER JOIN infectious_cases ON countries.name = infectious_cases.Entity AND infectious_cases_per_country_year.year = infectious_cases.Year
WHERE infectious_cases.Number_rabies != ''
UNION ALL
SELECT infectious_cases_per_country_year.id, diseases.id AS disease_id, infectious_cases.Number_malaria
FROM infectious_cases_per_country_year
INNER JOIN diseases ON diseases.name = 'malaria'
INNER JOIN countries ON country_id = countries.id
INNER JOIN infectious_cases ON countries.name = infectious_cases.Entity AND infectious_cases_per_country_year.year = infectious_cases.Year
WHERE infectious_cases.Number_malaria != ''
UNION ALL
SELECT infectious_cases_per_country_year.id, diseases.id AS disease_id, infectious_cases.Number_hiv
FROM infectious_cases_per_country_year
INNER JOIN diseases ON diseases.name = 'hiv'
INNER JOIN countries ON country_id = countries.id
INNER JOIN infectious_cases ON countries.name = infectious_cases.Entity AND infectious_cases_per_country_year.year = infectious_cases.Year
WHERE infectious_cases.Number_hiv != ''
UNION ALL
SELECT infectious_cases_per_country_year.id, diseases.id AS disease_id, infectious_cases.Number_tuberculosis
FROM infectious_cases_per_country_year
INNER JOIN diseases ON diseases.name = 'tuberculosis'
INNER JOIN countries ON country_id = countries.id
INNER JOIN infectious_cases ON countries.name = infectious_cases.Entity AND infectious_cases_per_country_year.year = infectious_cases.Year
WHERE infectious_cases.Number_tuberculosis != ''
UNION ALL
SELECT infectious_cases_per_country_year.id, diseases.id AS disease_id, infectious_cases.Number_smallpox
FROM infectious_cases_per_country_year
INNER JOIN diseases ON diseases.name = 'smallpox'
INNER JOIN countries ON country_id = countries.id
INNER JOIN infectious_cases ON countries.name = infectious_cases.Entity AND infectious_cases_per_country_year.year = infectious_cases.Year
WHERE infectious_cases.Number_smallpox != ''
UNION ALL
SELECT infectious_cases_per_country_year.id, diseases.id AS disease_id, infectious_cases.Number_cholera_cases
FROM infectious_cases_per_country_year
INNER JOIN diseases ON diseases.name = 'cholera'
INNER JOIN countries ON country_id = countries.id
INNER JOIN infectious_cases ON countries.name = infectious_cases.Entity AND infectious_cases_per_country_year.year = infectious_cases.Year
WHERE infectious_cases.Number_cholera_cases != '';
