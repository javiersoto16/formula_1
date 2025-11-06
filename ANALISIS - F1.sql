
USE formula1_final;

Victorias por piloto
SELECT
    d.forename,
    d.surname,
    SUM(CASE WHEN rf.position = 1 THEN 1 ELSE 0 END) AS total_wins
FROM results_final rf
JOIN drivers d ON rf.driver_id = d.driver_id
GROUP BY d.driver_id
ORDER BY total_wins DESC;


Podiums por piloto
SELECT
    d.forename,
    d.surname,
    SUM(CASE WHEN rf.position <= 3 THEN 1 ELSE 0 END) AS podiums
FROM results_final rf
JOIN drivers d ON rf.driver_id = d.driver_id
GROUP BY d.driver_id
ORDER BY podiums DESC;

Pilotos con mayor consistencia
SELECT
    d.forename,
    d.surname,
    SUM(CASE WHEN rf.position <= 10 THEN 1 ELSE 0 END) AS top10_finishes
FROM results_final rf
JOIN drivers d ON rf.driver_id = d.driver_id
GROUP BY d.driver_id
ORDER BY top10_finishes DESC;


Pilotos constantes y con mayore carreras sin victorias
SELECT
    d.forename,
    d.surname,
    COUNT(*) AS races_participated
FROM results_final rf
JOIN drivers d ON rf.driver_id = d.driver_id
WHERE rf.position != 1 OR rf.position IS NULL
GROUP BY d.driver_id
ORDER BY races_participated DESC;



Piloto con más victorias por nacionalidad
SELECT
    d.nationality AS country,
    d.forename,
    d.surname,
    SUM(CASE WHEN rf.position = 1 THEN 1 ELSE 0 END) AS total_wins
FROM results_final rf
JOIN drivers d ON rf.driver_id = d.driver_id
GROUP BY d.nationality, d.driver_id
HAVING total_wins = (
    SELECT MAX(sub_wins)
    FROM (
        SELECT SUM(CASE WHEN rf2.position = 1 THEN 1 ELSE 0 END) AS sub_wins
        FROM results_final rf2
        JOIN drivers d2 ON rf2.driver_id = d2.driver_id
        WHERE d2.nationality = d.nationality
        GROUP BY d2.driver_id
    ) AS sub
)
ORDER BY total_wins DESC;



Piloto favorito por circuito
SELECT
    c.name AS circuit_name,
    d.forename,
    d.surname,
    COUNT(*) AS wins_at_circuit
FROM results_final rf
JOIN drivers d ON rf.driver_id = d.driver_id
JOIN races r ON rf.race_id = r.race_id
JOIN circuits c ON r.circuit_id = c.circuit_id
WHERE rf.position = 1
GROUP BY c.circuit_id, d.driver_id
ORDER BY wins_at_circuit DESC;


Piloto con más carreras
SELECT
    d.forename,
    d.surname,
    COUNT(DISTINCT rf.race_id) AS races_participated
FROM results_final rf
JOIN drivers d ON rf.driver_id = d.driver_id
GROUP BY d.driver_id
ORDER BY races_participated DESC;

TOP diez circuitos por número de carreras
SELECT
    c.name AS circuit_name,
    c.location,
    c.country,
    COUNT(r.race_id) AS total_races
FROM races r
JOIN circuits c ON r.circuit_id = c.circuit_id
GROUP BY c.circuit_id
ORDER BY total_races DESC
LIMIT 10;



Escuderias mas laureadas
SELECT
    c.name AS constructor_name,
    SUM(CASE WHEN rf.position = 1 THEN 1 ELSE 0 END) AS total_wins
FROM results_final rf
JOIN constructors c ON rf.constructor_id = c.constructor_id
GROUP BY c.constructor_id
ORDER BY total_wins DESC;

Escuderias con mayores podiums
SELECT
    c.name AS constructor_name,
    SUM(CASE WHEN rf.position <= 3 THEN 1 ELSE 0 END) AS total_podiums
FROM results_final rf
JOIN constructors c ON rf.constructor_id = c.constructor_id
GROUP BY c.constructor_id
ORDER BY total_podiums DESC;



Mejor combis (piloto con escuderias)
SELECT
    d.forename,
    d.surname,
    c.name AS constructor_name,
    SUM(CASE WHEN rf.position <= 3 THEN 1 ELSE 0 END) AS podiums
FROM results_final rf
JOIN drivers d ON rf.driver_id = d.driver_id
JOIN constructors c ON rf.constructor_id = c.constructor_id
GROUP BY d.driver_id, c.constructor_id
ORDER BY podiums DESC;








