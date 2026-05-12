
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Forms;
DROP TABLE IF EXISTS Playground;
DROP TABLE IF EXISTS Management;
DROP TABLE IF EXISTS Plays_at;
DROP TABLE IF EXISTS History;
DROP TABLE IF EXISTS Championships;
DROP TABLE IF EXISTS Standings;
DROP TABLE IF EXISTS Stadiums;
DROP TABLE IF EXISTS Managers;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Teams;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Teams (
    Team_ID INT NOT NULL,
    Team_Name VARCHAR(250) NOT NULL,
    PRIMARY KEY (Team_ID),
    UNIQUE (Team_Name)
);

CREATE TABLE Players (
    Player_ID INT NOT NULL,
    Player_Name VARCHAR(50) NOT NULL,
    Transfer_value DECIMAL(12,2),
    PRIMARY KEY (Player_ID),
    UNIQUE (Player_Name)
);

CREATE TABLE Managers (
    Manager_ID INT NOT NULL,
    Manager_Name VARCHAR(50) NOT NULL,
    Points_per_match DECIMAL(4,2),
    PRIMARY KEY (Manager_ID),
    UNIQUE (Manager_Name)
);

CREATE TABLE Stadiums (
    Stadium_Name VARCHAR(50) NOT NULL,
    Stadium_place VARCHAR(50),
    PRIMARY KEY (Stadium_Name)
);

CREATE TABLE Standings (
    Standing_Place INT NOT NULL,
    Standing_Points INT NOT NULL,
    PRIMARY KEY (Standing_Place)
);

CREATE TABLE Championships (
    Championship_year INT NOT NULL,
    Championship_points INT NOT NULL,
    PRIMARY KEY (Championship_year)
);

CREATE TABLE History (
    Championship_year INT NOT NULL,
    Team_Name VARCHAR(250) NOT NULL,
    PRIMARY KEY (Championship_year, Team_Name),
    FOREIGN KEY (Championship_year) REFERENCES Championships(Championship_year)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Team_Name) REFERENCES Teams(Team_Name)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Plays_at (
    Player_Name VARCHAR(50) NOT NULL,
    Team_Name VARCHAR(250) NOT NULL,
    PRIMARY KEY (Player_Name, Team_Name),
    FOREIGN KEY (Player_Name) REFERENCES Players(Player_Name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Team_Name) REFERENCES Teams(Team_Name)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Management (
    Manager_Name VARCHAR(50) NOT NULL,
    Team_Name VARCHAR(250) NOT NULL,
    PRIMARY KEY (Manager_Name, Team_Name),
    FOREIGN KEY (Manager_Name) REFERENCES Managers(Manager_Name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Team_Name) REFERENCES Teams(Team_Name)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- This corresponds to the stadium-team relationship shown as Owns/Playground in the Phase 1 PDF.
CREATE TABLE Playground (
    Stadium_Name VARCHAR(50) NOT NULL,
    Team_Name VARCHAR(250) NOT NULL,
    PRIMARY KEY (Stadium_Name, Team_Name),
    FOREIGN KEY (Stadium_Name) REFERENCES Stadiums(Stadium_Name)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Team_Name) REFERENCES Teams(Team_Name)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Forms (
    Standing_Place INT NOT NULL,
    Team_Name VARCHAR(250) NOT NULL,
    PRIMARY KEY (Standing_Place, Team_Name),
    FOREIGN KEY (Standing_Place) REFERENCES Standings(Standing_Place)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Team_Name) REFERENCES Teams(Team_Name)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Teams (Team_ID, Team_Name) VALUES
(1, 'Fenerbahçe'),
(2, 'Beşiktaş'),
(3, 'Galatasaray'),
(4, 'Kayserispor'),
(5, 'Alanyaspor'),
(6, 'Trabzonspor'),
(7, 'Kasımpaşa'),
(8, 'Fatih Karagümrük'),
(9, 'Antalyaspor'),
(10, 'Ankaragücü');

INSERT INTO Players (Player_ID, Player_Name, Transfer_value) VALUES
(100, 'Sebastian Szymanski', 5000000.00),
(101, 'Mauro Icardi', 10000000.00),
(102, 'Vincent Aboubakar', 3000000.00),
(103, 'Umut Nayir', 500000.00),
(104, 'Yusuf Sarı', 800000.00),
(105, 'Ahmet Oğuz', 200000.00),
(106, 'Lazar Markovic', 400000.00),
(107, 'Adam Buksa', 1200000.00),
(108, 'Mame Thiam', 900000.00),
(109, 'Jonjo Shelvey', 2000000.00);

INSERT INTO Managers (Manager_ID, Manager_Name, Points_per_match) VALUES
(300, 'İsmail Kartal', 2.63),
(301, 'Okan Buruk', 2.60),
(302, 'Sergen Yalçın', 2.00),
(303, 'Abdullah Avcı', 2.10),
(304, 'İlhan Palut', 1.94),
(305, 'Mario Sumudica', 0.80),
(306, 'Emre Belözoğlu', 0.90),
(307, 'Fatih Tekke', 1.20),
(308, 'Çağdaş Atan', 1.50),
(309, 'Sami Uğurlu', 1.30);

INSERT INTO Stadiums (Stadium_Name, Stadium_place) VALUES
('Şükrü Saraçoğlu', 'Kadıköy/İstanbul'),
('Tüpraş Stadyumu', 'Beşiktaş/İstanbul'),
('Rams Park', 'Şişli/İstanbul'),
('Atatürk Olimpiyat', 'İkitelli/İstanbul'),
('Papara Park', 'Trabzon'),
('Kalyon Stadyumu', 'Gaziantep'),
('Eryaman Stadyumu', 'Ankara'),
('19 Mayıs Stadyumu', 'Samsun'),
('4 Eylül Stadı', 'Sivas'),
('Recep Tayyip Erdoğan Stadı', 'Beyoğlu/İstanbul');

INSERT INTO Standings (Standing_Place, Standing_Points) VALUES
(1, 75),
(2, 73),
(3, 46),
(4, 46),
(5, 40),
(6, 39),
(7, 39),
(8, 38),
(9, 38),
(10, 35);

INSERT INTO Championships (Championship_year, Championship_points) VALUES
(2001, 76),
(2002, 78),
(2003, 85),
(2004, 76),
(2005, 80),
(2006, 83),
(2007, 70),
(2008, 79),
(2009, 71),
(2010, 75);

INSERT INTO Plays_at (Player_Name, Team_Name) VALUES
('Sebastian Szymanski', 'Fenerbahçe'),
('Mauro Icardi', 'Galatasaray'),
('Vincent Aboubakar', 'Beşiktaş'),
('Umut Nayir', 'Fenerbahçe'),
('Yusuf Sarı', 'Antalyaspor'),
('Ahmet Oğuz', 'Ankaragücü'),
('Lazar Markovic', 'Trabzonspor'),
('Adam Buksa', 'Antalyaspor'),
('Mame Thiam', 'Kayserispor'),
('Jonjo Shelvey', 'Fatih Karagümrük');

INSERT INTO Management (Manager_Name, Team_Name) VALUES
('İsmail Kartal', 'Fenerbahçe'),
('Okan Buruk', 'Galatasaray'),
('Sergen Yalçın', 'Beşiktaş'),
('Abdullah Avcı', 'Trabzonspor'),
('İlhan Palut', 'Alanyaspor'),
('Mario Sumudica', 'Kayserispor'),
('Emre Belözoğlu', 'Ankaragücü'),
('Fatih Tekke', 'Fatih Karagümrük'),
('Çağdaş Atan', 'Kasımpaşa'),
('Sami Uğurlu', 'Antalyaspor');

INSERT INTO Playground (Stadium_Name, Team_Name) VALUES
('Şükrü Saraçoğlu', 'Fenerbahçe'),
('Tüpraş Stadyumu', 'Beşiktaş'),
('Rams Park', 'Galatasaray'),
('Atatürk Olimpiyat', 'Fatih Karagümrük'),
('Papara Park', 'Trabzonspor'),
('Kalyon Stadyumu', 'Alanyaspor'),
('Eryaman Stadyumu', 'Ankaragücü'),
('19 Mayıs Stadyumu', 'Kayserispor'),
('4 Eylül Stadı', 'Antalyaspor'),
('Recep Tayyip Erdoğan Stadı', 'Kasımpaşa');

INSERT INTO Forms (Standing_Place, Team_Name) VALUES
(1, 'Fenerbahçe'),
(2, 'Galatasaray'),
(3, 'Beşiktaş'),
(4, 'Trabzonspor'),
(5, 'Kayserispor'),
(6, 'Alanyaspor'),
(7, 'Kasımpaşa'),
(8, 'Fatih Karagümrük'),
(9, 'Antalyaspor'),
(10, 'Ankaragücü');

INSERT INTO History (Championship_year, Team_Name) VALUES
(2001, 'Galatasaray'),
(2002, 'Galatasaray'),
(2003, 'Beşiktaş'),
(2004, 'Fenerbahçe'),
(2005, 'Fenerbahçe'),
(2006, 'Galatasaray'),
(2007, 'Fenerbahçe'),
(2008, 'Galatasaray'),
(2009, 'Beşiktaş');
