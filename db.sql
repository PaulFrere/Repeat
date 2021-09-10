CREATE SCHEMA `cinema` ;

CREATE TABLE `cinema`.`movies` (
                                   `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                                   `name` VARCHAR(256) NOT NULL,
                                   `duration` INT UNSIGNED NOT NULL COMMENT 'длительность фильма',
                                   PRIMARY KEY (`id`));

CREATE TABLE `cinema`.`sessions` (
                                     `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                                     `movie_id` INT UNSIGNED NOT NULL,
                                     `start_time` DATETIME NOT NULL,
                                     `price` DOUBLE UNSIGNED NOT NULL,
                                     PRIMARY KEY (`id`),
                                     INDEX `fk_sessions_movies_movie_id_idx` (`movie_id` ASC) VISIBLE,
                                     CONSTRAINT `fk_sessions_movies_movie_id`
                                         FOREIGN KEY (`movie_id`)
                                             REFERENCES `cinema`.`movies` (`id`)
                                             ON DELETE RESTRICT
                                             ON UPDATE RESTRICT);

ALTER TABLE `cinema`.`sessions`
    ADD INDEX `idx_start_time` (`start_time` ASC) VISIBLE;
;

CREATE TABLE `cinema`.`tickets` (
                                    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
                                    `session_id` INT UNSIGNED NOT NULL,
                                    PRIMARY KEY (`id`),
                                    INDEX `fk_tickets_sessions_session_id_idx` (`session_id` ASC) VISIBLE,
                                    CONSTRAINT `fk_tickets_sessions_session_id`
                                        FOREIGN KEY (`session_id`)
                                            REFERENCES `cinema`.`sessions` (`id`)
                                            ON DELETE RESTRICT
                                            ON UPDATE RESTRICT);


INSERT INTO `cinema`.`movies` (`name`, `duration`) VALUES ('Star Trek', '90');
INSERT INTO `cinema`.`movies` (`name`, `duration`) VALUES ('Star Wars', '90');
INSERT INTO `cinema`.`movies` (`name`, `duration`) VALUES ('Terminator', '60');
INSERT INTO `cinema`.`movies` (`name`, `duration`) VALUES ('Lord of the Rings', '120');
INSERT INTO `cinema`.`movies` (`name`, `duration`) VALUES ('Harry Potter', '120');

INSERT INTO `cinema`.`sessions` (`id`,`movie_id`, `start_time`, `price`) VALUES ('1', '1', '202107261000', '300');
INSERT INTO `cinema`.`sessions` (`id`,`movie_id`, `start_time`, `price`) VALUES ('2', '1', '202107261200', '300');
INSERT INTO `cinema`.`sessions` (`id`,`movie_id`, `start_time`, `price`) VALUES ('3', '2', '202107231200', '300');
INSERT INTO `cinema`.`sessions` (`id`,`movie_id`, `start_time`, `price`) VALUES ('4', '3', '202107231400', '300');
INSERT INTO `cinema`.`sessions` (`id`,`movie_id`, `start_time`, `price`) VALUES ('5', '4', '202107231500', '400');
INSERT INTO `cinema`.`sessions` (`id`,`movie_id`, `start_time`, `price`) VALUES ('6', '1', '202107231800', '500');
INSERT INTO `cinema`.`sessions` (`id`,`movie_id`, `start_time`, `price`) VALUES ('7', '2', '202107231830', '500');
INSERT INTO `cinema`.`sessions` (`id`,`movie_id`, `start_time`, `price`) VALUES ('8', '3', '202107232000', '500');
INSERT INTO `cinema`.`sessions` (`id`,`movie_id`, `start_time`, `price`) VALUES ('9', '4', '202107232100', '500');
INSERT INTO `cinema`.`sessions` (`id`,`movie_id`, `start_time`, `price`) VALUES ('10', '5', '202107232200', '400');

INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('2');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('2');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('2');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('3');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('3');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('4');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('4');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('4');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('4');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('5');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('6');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('6');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('6');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('7');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('8');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('8');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('9');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('9');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('9');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('9');
INSERT INTO `cinema`.`tickets` (`session_id`) VALUES ('9');


-- ошибки в расписании
SELECT
    a.name,
    a.start_time,
    a.duration,
    b.name,
    b.start_time,
    b.duration
FROM
    (SELECT
         s.id,
         s.start_time,
         DATE_ADD(s.start_time, INTERVAL m.duration SECOND) AS end_time,
         m.name,
         m.duration
     FROM
         sessions s
             INNER JOIN movies m ON s.movie_id = m.id) a,
    (SELECT
         s2.id, s2.start_time, m2.name, m2.duration
     FROM
         sessions s2
             INNER JOIN movies m2 ON s2.movie_id = m2.id) b
WHERE
        a.start_time <= b.start_time
  AND b.start_time < a.end_time
  AND a.id <> b.id
order by a.start_time


-- перерывы между фильмами
    with a as
(SELECT
        s.id,
		s.start_time,
		DATE_ADD(s.start_time, INTERVAL m.duration SECOND) AS end_time,
		m.name,
		m.duration
    FROM
        sessions s
    INNER JOIN movies m ON s.movie_id = m.id)
SELECT
    a1.name,
    a1.start_time,
    a1.duration,
    a2.start_time,
    TIMESTAMPDIFF(MINUTE, a1.end_time, a2.start_time) AS diff
FROM
    a AS a1,
    sessions AS a2
WHERE
    NOT EXISTS( SELECT * FROM a AS a3 WHERE a3.start_time < a1.end_time AND a3.end_time > a1.end_time)
  AND a2.start_time = (SELECT MIN(s2.start_time) FROM sessions s2 WHERE s2.start_time > a1.end_time)
HAVING diff >= 30
ORDER BY diff DESC



-- число зрителей по фильмам
    WITH a AS
(SELECT
    s.movie_id,
    s.id,
    COUNT(*) AS visitors,
    SUM(s.price) AS session_price
FROM tickets t INNER JOIN sessions s ON t.session_id = s.id
GROUP BY s.id)
SELECT
    m.name,
    SUM(a.visitors) AS total_visitors,
    AVG(a.visitors) AS avg_show_visitors,
    SUM(a.session_price) AS total_amount
FROM
    a,
    movies m
WHERE
        a.movie_id = m.id
GROUP BY a.movie_id
UNION
SELECT
    'total',
    SUM(a.visitors) AS total_visitors,
    AVG(a.visitors) AS avg_show_visitors,
    SUM(a.session_price) AS total_amount
FROM
    a
ORDER BY total_amount DESC



-- кассовые сборы
SELECT
    COUNT(*) AS count_visitor,
    SUM(s.price) AS total_amount,
    CASE
        WHEN HOUR(s.start_time) >= 9 AND HOUR(s.start_time) < 15 THEN 'с 9 до 15'
        WHEN HOUR(s.start_time) >= 15 AND HOUR(s.start_time) < 18 THEN 'с 15 до 18'
        WHEN HOUR(s.start_time) >= 18 AND HOUR(s.start_time) < 21 THEN 'с 18 до 21'
        WHEN HOUR(s.start_time) >= 21 THEN 'с 21 до 00:00'
        ELSE 'до 9'
END time_interval
FROM tickets t INNER JOIN sessions s ON t.session_id = s.id
GROUP BY time_interval