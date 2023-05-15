SET autocommit = 0;

SELECT @@autocommit;

INSERT INTO person
(person_id, fname, lname, birth_date, eye_color)
VALUES
(4, '테스트', '김', '2023-05-15', 'BR');

SELECT * FROM person;

ROLLBACK;

COMMIT;

DELETE FROM person
WHERE person_id = 4;