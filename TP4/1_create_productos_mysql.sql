CREATE DATABASE tp4_ej1;

USE tp4_ej1;

START TRANSACTION;

DROP TABLE IF EXISTS pc;
DROP TABLE IF EXISTS laptop;
DROP TABLE IF EXISTS printer;
DROP TABLE IF EXISTS product;

CREATE TABLE product (
    maker VARCHAR(20) NOT NULL,
    model INT NOT NULL,
    type VARCHAR(20) NOT NULL,
    CONSTRAINT product_pkey PRIMARY KEY (model)
);

CREATE TABLE pc (
    model INT NOT NULL,
    speed DECIMAL(4,2) NOT NULL,
    ram INT NOT NULL,
    hd INT NOT NULL,
    price INT NOT NULL,
    CONSTRAINT pc_pkey PRIMARY KEY (model),
    CONSTRAINT fk_pc_product
        FOREIGN KEY (model)
        REFERENCES product(model)
);

CREATE TABLE laptop (
    model INT NOT NULL,
    speed DECIMAL(4,2) NOT NULL,
    ram INT NOT NULL,
    hd INT NOT NULL,
    screen DECIMAL(4,2) NOT NULL,
    price INT NOT NULL,
    CONSTRAINT laptop_pkey PRIMARY KEY (model),
    CONSTRAINT fk_laptop_product
        FOREIGN KEY (model)
        REFERENCES product(model)
);

CREATE TABLE printer (
    model INT NOT NULL,
    color BOOLEAN NOT NULL,
    type CHAR(8) NOT NULL,
    price INT NOT NULL,
    CONSTRAINT printer_pkey PRIMARY KEY (model),
    CONSTRAINT fk_printer_product
        FOREIGN KEY (model)
        REFERENCES product(model)
);

INSERT INTO product (maker, model, type) VALUES
('A', 1001, 'pc'),
('A', 1002, 'pc'),
('A', 1003, 'pc'),
('A', 2004, 'laptop'),
('A', 2005, 'laptop'),
('A', 2006, 'laptop'),
('B', 1004, 'pc'),
('B', 1005, 'pc'),
('B', 1006, 'pc'),
('B', 2007, 'laptop'),
('C', 1007, 'pc'),
('D', 1008, 'pc'),
('D', 1009, 'pc'),
('D', 1010, 'pc'),
('D', 3004, 'printer'),
('D', 3005, 'printer'),
('E', 1011, 'pc'),
('E', 1012, 'pc'),
('E', 1013, 'pc'),
('E', 2001, 'laptop'),
('E', 2002, 'laptop'),
('E', 2003, 'laptop'),
('E', 3001, 'printer'),
('E', 3002, 'printer'),
('E', 3003, 'printer'),
('F', 2008, 'laptop'),
('F', 2009, 'laptop'),
('G', 2010, 'laptop'),
('H', 3006, 'printer'),
('H', 3007, 'printer');

INSERT INTO pc (model, speed, ram, hd, price) VALUES
(1001, 2.66, 1024, 250, 2114),
(1002, 2.10, 512, 250, 995),
(1003, 1.42, 512, 80, 478),
(1004, 2.80, 1024, 250, 649),
(1005, 3.20, 512, 250, 630),
(1006, 3.20, 1024, 320, 1049),
(1007, 2.20, 1024, 200, 510),
(1008, 2.20, 2048, 250, 770),
(1009, 2.00, 1024, 250, 650),
(1010, 2.80, 2048, 300, 770),
(1011, 1.86, 2048, 160, 959),
(1012, 2.80, 1024, 160, 649),
(1013, 3.06, 512, 80, 529);

INSERT INTO laptop (model, speed, ram, hd, screen, price) VALUES
(2001, 2.00, 2048, 240, 20.1, 3673),
(2002, 1.73, 1024, 80, 17.0, 949),
(2003, 1.80, 512, 60, 15.4, 549),
(2004, 2.00, 512, 60, 13.3, 1150),
(2005, 2.16, 1024, 120, 17.0, 2500),
(2006, 2.00, 2048, 80, 15.4, 1700),
(2007, 1.83, 1024, 120, 13.3, 1429),
(2008, 1.60, 1024, 100, 15.4, 900),
(2009, 1.60, 512, 80, 14.1, 680),
(2010, 2.00, 2048, 160, 15.4, 2300);

INSERT INTO printer (model, color, type, price) VALUES
(3001, TRUE, 'ink-jet', 99),
(3002, FALSE, 'laser', 239),
(3003, TRUE, 'laser', 899),
(3004, TRUE, 'ink-jet', 120),
(3005, FALSE, 'laser', 120),
(3006, TRUE, 'ink-jet', 100),
(3007, TRUE, 'laser', 200);

COMMIT;
