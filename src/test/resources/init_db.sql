DROP ALL OBJECTS;
CREATE SCHEMA IF NOT EXISTS test_db;

-- DROP TABLE IF EXISTS placement_history;
-- DROP TABLE IF EXISTS user_leaderboard;
-- DROP TABLE IF EXISTS user_games;
-- DROP TABLE IF EXISTS game_stat;
-- DROP TABLE IF EXISTS civilization;
-- DROP TABLE IF EXISTS game;
-- DROP TABLE IF EXISTS leaderboard;
-- DROP TABLE IF EXISTS app_user;


-- Create tables for each entity
CREATE TABLE civilization
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    civilization VARCHAR(50)  NOT NULL, --enum value
    leader       VARCHAR(255) NOT NULL
);

CREATE TABLE leaderboard
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(35) NOT NULL,
    description VARCHAR(100)
);

CREATE TABLE game
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    title           VARCHAR(20) NOT NULL,
    description     VARCHAR(50),
    finishing_round INT         NOT NULL
);

CREATE TABLE app_user
(
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    username           VARCHAR(255) UNIQUE NOT NULL,
    password           VARCHAR(255)        NOT NULL,
    role               VARCHAR(255)        NOT NULL, -- Assuming Role is an ENUM in Java
    total_games_played INT DEFAULT 0
);

-- User Table
CREATE TABLE game_stat
(
    id                       INT AUTO_INCREMENT PRIMARY KEY,
    user_id                  INT         NOT NULL,
    civilization_id INT         NOT NULL,
    placement                VARCHAR(25) NOT NULL,
    victory_points           INT         NOT NULL,
    military_points          INT         NOT NULL,
    science_points           INT         NOT NULL,
    culture_points           INT         NOT NULL,
    gold                     INT         NOT NULL,
    religious_points         INT         NOT NULL,
    diplomatic_points        INT         NOT NULL,
    game_id                  INT         NOT NULL,
    FOREIGN KEY (game_id) REFERENCES Game (id) ON DELETE CASCADE,
    FOREIGN KEY (civilization_id) REFERENCES Civilization (id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) references app_user (id) ON DELETE CASCADE
);

-- Placement History Table
CREATE TABLE placement_history
(
    app_user_id INT, -- Foreign Key referencing the User
    placement   INT,
    FOREIGN KEY (app_user_id) REFERENCES app_user (id) ON DELETE CASCADE
);

-- Join Table for Many-to-Many relationship between User and Leaderboard
CREATE TABLE leaderboard_users
(
    user_id        INT, -- Foreign Key referencing the User
    leaderboard_id INT, -- Foreign Key referencing the Leaderboard
    PRIMARY KEY (user_id, leaderboard_id),
    FOREIGN KEY (user_id) REFERENCES app_user (id) ON DELETE CASCADE,
    FOREIGN KEY (leaderboard_id) REFERENCES leaderboard (id) ON DELETE CASCADE
);

-- Join Table for Many-to-Many relationship between User and Game
CREATE TABLE user_games
(
    user_id INT, -- Foreign Key referencing the User
    game_id INT, -- Foreign Key referencing the Game
    PRIMARY KEY (user_id, game_id),
    FOREIGN KEY (user_id) REFERENCES app_user (id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES game (id) ON DELETE CASCADE
);


-- Insert civilization data (examples)
INSERT INTO civilization (civilization, leader)
VALUES ('AMERICAN', 'Teddy Roosevelt'),
       ('AMERICAN', 'Teddy Roosevelt (Bull Moose)'),
       ('AMERICAN', 'Teddy Roosevelt (Rough Rider)'),
       ('AMERICAN', 'Abraham Lincoln'),
       ('ARABIAN', 'Saladin (Vizier)'),
       ('ARABIAN', 'Saladin (Sultan)'),
       ('AUSTRALIAN', 'John Curtin'),
       ('AZTEC', 'Montezuma'),
       ('BABYLONIAN', 'Hammurabi'),
       ('BRAZILIAN', 'Pedro II'),
       ('BYZANTINE', 'Basil II'),
       ('BYZANTINE', 'Theodora'),
       ('CANADIAN', 'Wilfrid Laurier'),
       ('CHINESE', 'Qin Shi Huang (Mandate of Heaven)'),
       ('CHINESE', 'Qin Shi Huang (Unifier)'),
       ('CHINESE', 'Kublai Khan (Chinese)'),
       ('CHINESE', 'Yongle'),
       ('CHINESE', 'Wu Zetian'),
       ('CREE', 'Poundmaker'),
       ('DUTCH', 'Wilhelmina'),
       ('EGYPTIAN', 'Cleopatra (Egyptian)'),
       ('EGYPTIAN', 'Cleopatra (Ptolemaic)'),
       ('EGYPTIAN', 'Ramses II'),
       ('ENGLISH', 'Victoria (Age of Empire)'),
       ('ENGLISH', 'Victoria (Age of Steam)'),
       ('ENGLISH', 'Eleanor of Aquitaine (English)'),
       ('ENGLISH', 'Elizabeth I'),
       ('ETHIOPIAN', 'Menelik II'),
       ('FRENCH', 'Catherine de Medici (Black Queen)'),
       ('FRENCH', 'Catherine de Medici (Magnificence)'),
       ('FRENCH', 'Eleanor of Aquitaine (French)'),
       ('GALLIC', 'Ambiorix'),
       ('GEORGIAN', 'Tamar'),
       ('GERMAN', 'Frederick Barbarossa'),
       ('GERMAN', 'Ludwig II'),
       ('GRAN_COLUMBIAN', 'Simón Bolívar'),
       ('GREEK', 'Pericles'),
       ('GREEK', 'Gorgo'),
       ('HUNGARIAN', 'Matthias Corvinus'),
       ('INCAN', 'Pachacuti'),
       ('INDIAN', 'Gandhi'),
       ('INDIAN', 'Chandragupta'),
       ('INDONESIAN', 'Gitarja'),
       ('JAPANESE', 'Hojo Tokimune'),
       ('JAPANESE', 'Tokugawa'),
       ('KHMER', 'Jayavarman VII'),
       ('KONGOLESE', 'Mvemba a Nzinga'),
       ('KONGOLESE', 'Nzinga Mbande'),
       ('KOREAN', 'Seondeok'),
       ('KOREAN', 'Sejong'),
       ('MACEDONIAN', 'Alexander'),
       ('MALIAN', 'Mansa Musa'),
       ('MALIAN', 'Sundiata Keita'),
       ('MÃORI', 'Kupe'),
       ('MAPUCHE', 'Lautaro'),
       ('MAYAN', 'Lady Six Sky'),
       ('MONGOLIAN', 'Genghis Khan'),
       ('MONGOLIAN', 'Kublai Khan (Mongolian)'),
       ('NORWEGIAN', 'Harald Hardrada (Konge)'),
       ('NORWEGIAN', 'Harald Hardrada (Varangian)'),
       ('NUBIAN', 'Amanitore'),
       ('OTTOMAN', 'Suleiman (Kanuni)'),
       ('OTTOMAN', 'Suleiman (Muhteşem)'),
       ('PERSIAN', 'Cyrus'),
       ('PERSIAN', 'Nader Shah'),
       ('PHOENICIAN', 'Dido'),
       ('POLISH', 'Jadwiga'),
       ('PORTUGUESE', 'João III'),
       ('ROMAN', 'Trajan'),
       ('ROMAN', 'Julius Caesar'),
       ('RUSSIAN', 'Peter'),
       ('SCOTTISH', 'Robert the Bruce'),
       ('SCYTHIAN', 'Tomyris'),
       ('SPANISH', 'Philip II'),
       ('SUMERIAN', 'Gilgamesh'),
       ('SWEDISH', 'Kristina'),
       ('VIETNAMESE', 'Bà Triêu'),
       ('ZULU', 'Shaka');


INSERT INTO leaderboard (name, description)
VALUES ('First Leaderboard', 'This is a test leaderboard');

INSERT INTO app_user (username, password, role)
VALUES ('Chris', '{encoded_password_for_Chris}', 'ROLE_USER'),
       ('Markus', '{encoded_password_for_Markus}', 'ROLE_USER'),
       ('Engjëll', '{encoded_password_for_Engjëll}', 'ROLE_USER'),
       ('Mikkel', '{encoded_password_for_Mikkel}', 'ROLE_USER');

INSERT INTO game (title, description, finishing_round)
VALUES ('Game 1', 'This is just a test game', 150),
       ('Game 2', 'This is just a test game', 89);


-- First GameStats
INSERT INTO game_stat (user_id, civilization_id, placement, victory_points, military_points, science_points,
                       culture_points, gold, religious_points, diplomatic_points, game_id)
VALUES (1, (SELECT id FROM civilization WHERE leader = 'Yongle'), 'FIRST', 500, 500, 500, 500, 500, 500, 500, 1),
       (2, (SELECT id FROM civilization WHERE leader = 'João III'), 'SECOND', 300, 300, 300, 300, 300, 300, 300, 1),
       (3, (SELECT id FROM civilization WHERE leader = 'Victoria (Age of Empire)'), 'THIRD', 200, 200, 200, 200, 200, 200,
        200, 1),
       (4, (SELECT id FROM civilization WHERE leader = 'Shaka'), 'FOURTH', 100, 100, 100, 100, 100, 100, 100, 1);

-- Second GameStats
INSERT INTO game_stat (user_id, civilization_id, placement, victory_points, military_points, science_points,
                       culture_points, gold, religious_points, diplomatic_points, game_id)
VALUES (1, (SELECT id FROM civilization WHERE leader = 'Yongle'), 'FIRST', 500, 500, 500, 500, 500, 500, 500, 2),
       (2, (SELECT id FROM civilization WHERE leader = 'João III'), 'SECOND', 300, 300, 300, 300, 300, 300, 300, 2),
       (3, (SELECT id FROM civilization WHERE leader = 'Victoria (Age of Empire)'), 'THIRD', 200, 200, 200, 200, 200, 200,
        200, 2),
       (4, (SELECT id FROM civilization WHERE leader = 'Shaka'), 'FOURTH', 100, 100, 100, 100, 100, 100, 100, 2);


INSERT INTO placement_history (app_user_id, placement)
VALUES ( 1, 2 ),
       ( 1, 0 ),
       ( 1, 0 ),
       ( 1, 0 ),
       ( 1, 0 ),
       ( 1, 0 ),
       ( 1, 0 ),
       ( 1, 0 ),
       ( 1, 0 ),
       ( 1, 0 ),
       ( 1, 0 ),
       ( 1, 0 ),
       ( 2, 0 ),
       ( 2, 2 ),
       ( 2, 0 ),
       ( 2, 0 ),
       ( 2, 0 ),
       ( 2, 0 ),
       ( 2, 0 ),
       ( 2, 0 ),
       ( 2, 0 ),
       ( 2, 0 ),
       ( 2, 0 ),
       ( 2, 0 ),
       ( 3, 0 ),
       ( 3, 0 ),
       ( 3, 2 ),
       ( 3, 0 ),
       ( 3, 0 ),
       ( 3, 0 ),
       ( 3, 0 ),
       ( 3, 0 ),
       ( 3, 0 ),
       ( 3, 0 ),
       ( 3, 0 ),
       ( 3, 0 ),
       ( 4, 0 ),
       ( 4, 0 ),
       ( 4, 0 ),
       ( 4, 2 ),
       ( 4, 0 ),
       ( 4, 0 ),
       ( 4, 0 ),
       ( 4, 0 ),
       ( 4, 0 ),
       ( 4, 0 ),
       ( 4, 0 ),
       ( 4, 0 );