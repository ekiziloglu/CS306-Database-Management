-- =====================================================
-- CS306 - Database Systems - Spring 2024
-- Trendyol Super League Explorer
-- Project Phase 2
-- Yusuf Eralp Kızıloğlu - 29204
-- =====================================================


-- =====================================================
-- 1. TABLES
-- =====================================================

CREATE TABLE `Teams` (
    `Team_ID`   INTEGER PRIMARY KEY,
    `Team_Name` VARCHAR(250)
);

CREATE TABLE `Players` (
    `Player_ID`       INTEGER PRIMARY KEY,
    `Player_Name`     VARCHAR(50),
    `Transfer_value`  FLOAT
);

CREATE TABLE `Plays_at` (
    `Player_ID` INTEGER,
    `Team_ID`   INTEGER,
    FOREIGN KEY (`Team_ID`)   REFERENCES `Teams`(`Team_ID`),
    FOREIGN KEY (`Player_ID`) REFERENCES `Players`(`Player_ID`)
);


-- =====================================================
-- 2. INSERT STATEMENTS
-- =====================================================

INSERT INTO Teams (Team_ID, Team_Name) VALUES
(1,  'Fenerbahçe'),
(2,  'Galatasaray'),
(3,  'Beşiktaş'),
(4,  'Trabzonspor'),
(5,  'Antalyaspor'),
(6,  'Kayserispor'),
(7,  'Adana Demirspor'),
(8,  'Kasımpaşa'),
(9,  'Samsunspor'),
(10, 'Konyaspor');

INSERT INTO Players (Player_ID, Player_Name, Transfer_value) VALUES
(100, 'Edin Dzeko',         5.5),
(101, 'Mauro Icardi',       8),
(102, 'Al Musrati',         3.5),
(103, 'Enis Bardhi',        4.5),
(104, 'Adam Buksa',         1),
(105, 'Majid Hosseini',     2),
(106, 'Mario Balotelli',    1.8),
(107, 'Haris Hajradinovic', 2.2),
(108, 'Carlo Holse',        2.75),
(109, 'Sokol Cikalleshi',   1);

INSERT INTO Plays_at (Player_ID, Team_ID) VALUES
(100, 1),
(101, 2),
(102, 3),
(103, 4),
(104, 5),
(105, 6),
(106, 7),
(107, 8),
(108, 9),
(109, 10);


-- =====================================================
-- 3. DISPLAY OF ROWS
-- =====================================================

SELECT * FROM teams;
SELECT * FROM players;
SELECT * FROM plays_at;


-- =====================================================
-- 4. JOIN
-- Query: Retrieve the list of players along with the teams they play for.
-- Relational Algebra:
--   π(Player_Name, Team_Name)(Plays_at ⨝ Players ⨝ Teams)
-- =====================================================

SELECT Players.Player_Name, Teams.Team_Name
FROM Plays_at
JOIN Players ON Plays_at.Player_ID = Players.Player_ID
JOIN Teams   ON Plays_at.Team_ID   = Teams.Team_ID;


-- =====================================================
-- 5. GROUP BY
-- Query: Find the number of players in each team.
-- =====================================================

SELECT Teams.Team_Name, COUNT(*) AS PlayerCount
FROM Plays_at
JOIN Teams ON Plays_at.Team_ID = Teams.Team_ID
GROUP BY Teams.Team_Name;


-- =====================================================
-- 6. CHECK CONSTRAINT
-- =====================================================

ALTER TABLE Players
ADD CONSTRAINT chk_transfer_value_non_negative
CHECK (Transfer_value >= 0);

-- Test query (expected to fail due to the CHECK constraint):
-- INSERT INTO Players (Player_ID, Player_Name, Transfer_value)
-- VALUES (3, 'Leonardo Bonucci', -50.0);
-- Error Code: 3819. Check constraint 'chk_transfer_value_non_negative' is violated.


-- =====================================================
-- FUNCTIONAL DEPENDENCIES & BCNF CHECK (reference only)
-- =====================================================
-- Teams:    Team_ID   -> Team_Name                      (BCNF)
-- Players:  Player_ID -> Player_Name, Transfer_value    (BCNF)
-- Plays_at: Player_ID -> Team_ID                        (BCNF)