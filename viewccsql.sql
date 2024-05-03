CREATE VIEW ALL_WORKERS AS
SELECT last_name AS lastname,
       first_name AS firstname,
       age,
       GREATEST(first_day, start_date) AS start_date
FROM (
    SELECT * FROM WORKERS_FACTORY_1
    UNION
    SELECT worker_id AS id, first_name, last_name, age, start_date, end_date AS last_day FROM WORKERS_FACTORY_2
)
WHERE last_day IS NULL
ORDER BY start_date DESC;


CREATE VIEW ALL_WORKERS_ELAPSED AS
SELECT lastname, firstname, age, start_date,
       SYSDATE - start_date AS days_elapsed
FROM ALL_WORKERS;

CREATE VIEW BEST_SUPPLIERS AS
SELECT s.name, SUM(quantity) AS total_pieces
FROM SUPPLIERS s
JOIN SUPPLIERS_BRING_TO_FACTORY_1 sbf ON s.supplier_id = sbf.supplier_id
GROUP BY s.name
HAVING SUM(quantity) > 1000
ORDER BY total_pieces DESC;


CREATE VIEW ROBOTS_FACTORIES AS
SELECT r.id AS robot_id, r.model, f.id AS factory_id, f.main_location
FROM ROBOTS r
JOIN ROBOTS_FROM_FACTORY rf ON r.id = rf.robot_id
JOIN FACTORIES f ON rf.factory_id = f.id;

