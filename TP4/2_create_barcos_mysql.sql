START TRANSACTION;

DROP TABLE IF EXISTS outcomes;
DROP TABLE IF EXISTS ships;
DROP TABLE IF EXISTS battles;
DROP TABLE IF EXISTS classes;

CREATE TABLE classes (
    classa VARCHAR(20) NOT NULL,
    typess VARCHAR(2) NOT NULL,
    country VARCHAR(20) NOT NULL,
    numguns SMALLINT NOT NULL,
    bore SMALLINT NOT NULL,
    displacement INT NOT NULL,
    CONSTRAINT classes_pkey PRIMARY KEY (classa)
);

INSERT INTO classes (classa, typess, country, numguns, bore, displacement) VALUES
('Bismarck','bb','Germany',8,15,42000),
('Iowa','bb','USA',9,16,46000),
('Kongo','bc','Japan',8,14,32000),
('North Carolina','bb','USA',9,16,37000),
('Renown','bc','Gt. Britan',6,15,23000),
('Revenge','bb','Gt. Britan',8,15,29000),
('Tennessee','bb','USA',12,14,32000),
('Yamato','bb','Japan',9,18,65000);

CREATE TABLE battles (
    bname VARCHAR(20) NOT NULL,
    date DATE NOT NULL,
    CONSTRAINT battles_pkey PRIMARY KEY (bname)
);

INSERT INTO battles (bname, date) VALUES
('Denmark Strait','1941-05-24'),
('Guadalcanal','1942-11-15'),
('North Cape','1943-12-26'),
('Surigao Strait','1944-10-25'),
('Pearl Harbor','1941-12-07');

CREATE TABLE ships (
    sname VARCHAR(20) NOT NULL,
    sclass VARCHAR(20) NOT NULL,
    launched SMALLINT NOT NULL,
    CONSTRAINT ships_pkey PRIMARY KEY (sname),
    CONSTRAINT ships_fk_1
        FOREIGN KEY (sclass)
        REFERENCES classes(classa)
);

INSERT INTO ships (sname, sclass, launched) VALUES
('California','Tennessee',1921),
('Haruna','Kongo',1915),
('Hiei','Kongo',1914),
('Iowa','Iowa',1943),
('Kirishima','Kongo',1915),
('Kongo','Kongo',1913),
('Missouri','Iowa',1944),
('Musashi','Yamato',1942),
('New Jersey','Iowa',1943),
('North Carolina','North Carolina',1941),
('Ramillies','Revenge',1917),
('Renown','Renown',1916),
('Repulse','Renown',1916),
('Resolution','Revenge',1916),
('Revenge','Revenge',1916),
('Royal Oak','Revenge',1916),
('Royal Sovereign','Revenge',1916),
('Tennessee','Tennessee',1920),
('Washington','North Carolina',1941),
('Wisconsin','Iowa',1944),
('Yamato','Yamato',1941);

CREATE TABLE outcomes (
    ship VARCHAR(20) NOT NULL,
    battle VARCHAR(20) NOT NULL,
    oresult VARCHAR(20) NOT NULL,
    CONSTRAINT outcomes_pkey PRIMARY KEY (ship, battle)
);

INSERT INTO outcomes (ship, battle, oresult) VALUES
('Arizona','Pearl Harbor','sunk'),
('Bismarck','Denmark Strait','sunk'),
('California','Surigao Strait','ok'),
('Duke of York','North Cape','ok'),
('Fuso','Surigao Strait','sunk'),
('Hood','Denmark Strait','sunk'),
('King George V','Denmark Strait','ok'),
('Kirishima','Guadalcanal','sunk'),
('Prince of Wales','Denmark Strait','damaged'),
('Rodney','Denmark Strait','ok'),
('Scharnhorst','North Cape','sunk'),
('South Dakota','Guadalcanal','damaged'),
('Tennessee','Surigao Strait','ok'),
('Washington','Guadalcanal','ok'),
('West Virginia','Surigao Strait','ok'),
('Yamashiro','Surigao Strait','sunk');

COMMIT;
