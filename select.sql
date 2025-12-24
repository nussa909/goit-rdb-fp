use pandemic;

SELECT * FROM infectious_cases; 

SELECT * FROM countries;

SELECT * FROM diseases;

SELECT * FROM infectious_cases_per_country_year;

SELECT * FROM infectious_case_number;

SELECT COUNT(*) FROM infectious_cases;

SELECT COUNT(*) FROM infectious_cases_per_country_year;

SELECT Entity, Code, AVG(Number_rabies) AS average_rabies, MIN(Number_rabies) AS min_rabies,  MAX(Number_rabies) AS max_rabies, SUM(Number_rabies) AS sum_rabies
FROM infectious_cases
WHERE Number_rabies != ''
GROUP BY Entity, Code
ORDER BY average_rabies DESC
LIMIT 10;


WITH PreparedData AS (
    SELECT 
        Year, 
        MAKEDATE(Year, 1) AS year_01_01, 
        CURDATE() AS today
    FROM infectious_cases
)
SELECT 
    *, 
    TIMESTAMPDIFF(YEAR, year_01_01, today) AS year_diff
FROM PreparedData;


WITH PreparedData AS (
    SELECT 
        year, 
        MAKEDATE(year, 1) AS year_01_01, 
        CURDATE() AS today
    FROM infectious_cases_per_country_year
)
SELECT 
    *, 
    TIMESTAMPDIFF(YEAR, year_01_01, today) AS year_diff
FROM PreparedData;


DROP FUNCTION IF EXISTS GetYearsPassed;
DELIMITER //

CREATE FUNCTION GetYearsPassed(year YEAR)
RETURNS INT 
NO SQL
BEGIN
    DECLARE result INT;
    SET result = TIMESTAMPDIFF(YEAR, MAKEDATE(year, 1), CURDATE());
    RETURN result;
END //

DELIMITER ;

SELECT year, CURDATE() AS today, GetYearsPassed(year)
FROM infectious_cases_per_country_year;


DROP FUNCTION IF EXISTS GetNumberOfInfectedInPeriod;
DELIMITER //

CREATE FUNCTION GetNumberOfInfectedInPeriod(numberOfInfected DOUBLE, periodDeliter INT)
RETURNS DOUBLE 
DETERMINISTIC
NO SQL
BEGIN
    DECLARE result DOUBLE;
    IF periodDeliter > 0 THEN SET result = numberOfInfected / periodDeliter;
	ELSE SET result = -1;
    END IF;
    RETURN result;
END //

DELIMITER ;

SELECT year, diseases.name, GetNumberOfInfectedInPeriod(infectious_case_number.case_number,12)
FROM infectious_cases_per_country_year
JOiN  infectious_case_number ON id = infectious_case_number.icpcy_id
JOIN  diseases ON infectious_case_number.disease_id = diseases.id;
