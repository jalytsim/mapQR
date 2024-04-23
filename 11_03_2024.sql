CREATE TABLE IF NOT EXISTS district (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    region TEXT
);

CREATE TABLE IF NOT EXISTS soilData (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    district_id INTEGER,
    internal_id INTEGER,
    device TEXT,
    owner TEXT,
    nitrogen REAL,
    phosphorus REAL,
    potassium REAL,
    ph REAL,
    temperature REAL,
    humidity REAL,
    conductivity REAL,
    signal_level REAL,
    date DATE,
    FOREIGN KEY (district_id) REFERENCES district(id)
);

CREATE TABLE IF NOT EXISTS farm (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    subcounty TEXT,
    farmergroup_id INTEGER,
    district_id INTEGER,
    geolocation TEXT,
    FOREIGN KEY (district_id) REFERENCES district(id),
    FOREIGN KEY (farmergroup_id) REFERENCES farmergroup(id)
);

CREATE TABLE IF NOT EXISTS farmData (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    farm_id INTEGER,
    crop_id INTEGER,
    tilled_land_size REAL,
    planting_date DATE,
    season INTEGER,
    quality TEXT,
    quantity INTEGER,
    harvest_date DATE,
    expected_yield REAL,
    actual_yield REAL,
    timestamp DATE,
    FOREIGN KEY (farm_id) REFERENCES farm(id),
    FOREIGN KEY (crop_id) REFERENCES crop(id)
);

CREATE TABLE IF NOT EXISTS produceCategory (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    grade INTEGER
);


CREATE TABLE IF NOT EXISTS crop (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    weight REAL,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES produceCategory(id)
);


CREATE TABLE IF NOT EXISTS farmergroup (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    description TEXT
);
INSERT INTO farmergroup (name, description) VALUES
('Farmers Cooperative Society', 'A cooperative society of farmers'),
('Women Farmers Association', 'An association of women farmers'),
('Young Farmers Group', 'A group of young farmers');

INSERT INTO farm (name, subcounty, farmergroup_id, district_id, geolocation) VALUES
('John Doe Farm', 'Kawempe', 1, 1, '0.3163,32.5822'),
('Jane Smith Farm', 'Gulu', 2, 2, '2.7809,32.2995'),
('Peter Kato Farm', 'Mbale', 3, 3, '1.0647,34.1797'),
('Sarah Nalubega Farm', 'Makindye', 1, 1, '0.2986,32.6235'),
('David Omondi Farm', 'Nwoya', 2, 2, '2.6249,31.3952'),
('Grace Nakato Farm', 'Bubulo', 3, 3, '1.0722,34.1691'),
('Joseph Ssempala Farm', 'Rubaga', 1, 1, '0.2947,32.5521'),
('Mercy Auma Farm', 'Pader', 2, 2, '2.7687,33.2428'),
('Andrew Wabwire Farm', 'Manafwa', 3, 3, '1.1714,34.3447'),
('Harriet Namutebi Farm', 'Nakawa', 1, 1, '0.3153,32.6153'),
('Emmanuel Ojok Farm', 'Lira', 2, 2, '2.2481,32.8997'),
('Joyce Nakazibwe Farm', 'Sironko', 3, 3, '1.2236,34.3874'),
('Richard Kizza Farm', 'Nansana', 1, 1, '0.3652,32.5274'),
('Sarah Nambooze Farm', 'Kitgum', 2, 2, '3.3017,32.8737'),
('Godfrey Sserwadda Farm', 'Kapchorwa', 3, 3, '1.3962,34.4507'),
('Mary Nalule Farm', 'Wakiso', 1, 1, '0.4054,32.4594'),
('Isaac Ongom Farm', 'Amuru', 2, 2, '2.8231,31.4344'),
('Agnes Atim Farm', 'Bududa', 3, 3, '1.0614,34.3294'),
('Charles Odoi Farm', 'Kira', 1, 1, '0.3673,32.6159'),
('Florence Nakimera Farm', 'Adjumani', 2, 2, '3.3812,31.7989');

INSERT INTO produceCategory (name, grade) VALUES
('Maize', 1),
('Beans', 2),
('Coffee', 3),
('Cassava', 1),
('Rice', 2),
('Bananas', 3);

INSERT INTO crop (name, weight, category_id) VALUES
('Maize', 50.0, 1),
('Beans', 10.0, 2),
('Coffee', 25.0, 3),
('Cassava', 30.0, 4),
('Rice', 20.0, 5),
('Bananas', 15.0, 6);

-- Sample data for farmData
INSERT INTO farmData (farm_id, crop_id, tilled_land_size, planting_date, season, quality, quantity, harvest_date, expected_yield, actual_yield, timestamp) VALUES
(1, 1, 2.5, '2023-03-15', 1, 'Good', 100, '2023-07-15', 2500.0, 2300.0, '2023-07-15 12:00:00'),
(1, 2, 1.0, '2023-03-20', 1, 'Fair', 50, '2023-07-20', 500.0, 480.0, '2023-07-20 12:00:00'),
(2, 3, 0.5, '2023-04-01', 1, 'Good', 20, '2023-09-01', 500.0, 480.0, '2023-09-01 12:00:00'),
(2, 4, 1.0, '2023-04-05', 1, 'Good', 30, '2023-09-05', 900.0, 880.0, '2023-09-05 12:00:00'),
(3, 5, 0.8, '2023-04-10', 1, 'Fair', 40, '2023-09-10', 800.0, 780.0, '2023-09-10 12:00:00'),
(3, 6, 0.3, '2023-04-15', 1, 'Excellent', 15, '2023-09-15', 225.0, 220.0, '2023-09-15 12:00:00'),
(4, 1, 2.0, '2023-03-15', 1, 'Good', 80, '2023-07-15', 2000.0, 1900.0, '2023-07-15 12:00:00'),
(4, 2, 0.8, '2023-03-20', 1, 'Fair', 40, '2023-07-20', 400.0, 380.0, '2023-07-20 12:00:00'),
(5, 3, 0.4, '2023-04-01', 1, 'Good', 15, '2023-09-01', 375.0, 370.0, '2023-09-01 12:00:00'),
(5, 4, 0.7, '2023-04-05', 1, 'Good', 25, '2023-09-05', 750.0, 740.0, '2023-09-05 12:00:00'),
(6, 5, 0.6, '2023-04-10', 1, 'Fair', 30, '2023-09-10', 600.0, 580.0, '2023-09-10 12:00:00'),
(6, 6, 0.2, '2023-04-15', 1, 'Excellent', 10, '2023-09-15', 150.0, 140.0, '2023-09-15 12:00:00'),
(7, 1, 1.5, '2023-03-15', 1, 'Good', 60, '2023-07-15', 1500.0, 1400.0, '2023-07-15 12:00:00'),
(7, 2, 0.5, '2023-03-20', 1, 'Fair', 25, '2023-07-20', 250.0, 240.0, '2023-07-20 12:00:00'),
(8, 3, 0.3, '2023-04-01', 1, 'Good', 10, '2023-09-01', 250.0, 240.0, '2023-09-01 12:00:00'),
(8, 4, 0.6, '2023-04-05', 1, 'Good', 20, '2023-09-05', 600.0, 590.0, '2023-09-05 12:00:00'),
(9, 5, 0.5, '2023-04-10', 1, 'Fair', 25, '2023-09-10', 500.0, 490.0, '2023-09-10 12:00:00'),
(9, 6, 0.2, '2023-04-15', 1, 'Excellent', 10, '2023-09-15', 100.0, 90.0, '2023-09-15 12:00:00'),
(10, 1, 1.0, '2023-03-15', 1, 'Good', 40, '2023-07-15', 1000.0, 950.0, '2023-07-15 12:00:00'),
(10, 2, 0.4, '2023-03-20', 1, 'Fair', 20, '2023-07-20', 200.0, 190.0, '2023-07-20 12:00:00'),
(11, 3, 0.2, '2023-04-01', 1, 'Good', 5, '2023-09-01', 125.0, 120.0, '2023-09-01 12:00:00'),
(11, 4, 0.4, '2023-04-05', 1, 'Good', 10, '2023-09-05', 300.0, 290.0, '2023-09-05 12:00:00'),
(12, 5, 0.3, '2023-04-10', 1, 'Fair', 15, '2023-09-10', 300.0, 290.0, '2023-09-10 12:00:00'),
(12, 6, 0.1, '2023-04-15', 1, 'Excellent', 5, '2023-09-15', 50.0, 40.0, '2023-09-15 12:00:00'),
(13, 1, 0.5, '2023-03-15', 1, 'Good', 20, '2023-07-15', 500.0, 480.0, '2023-07-15 12:00:00'),
(13, 2, 0.2, '2023-03-20', 1, 'Fair', 10, '2023-07-20', 100.0, 90.0, '2023-07-20 12:00:00'),
(14, 3, 0.1, '2023-04-01', 1, 'Good', 5, '2023-09-01', 125.0, 120.0, '2023-09-01 12:00:00'),
(14, 4, 0.2, '2023-04-05', 1, 'Good', 5, '2023-09-05', 150.0, 140.0, '2023-09-05 12:00:00'),
(15, 5, 0.2, '2023-04-10', 1, 'Fair', 10, '2023-09-10', 100.0, 90.0, '2023-09-10 12:00:00'),
(15, 6, 0.1, '2023-04-15', 1, 'Excellent', 5, '2023-09-15', 50.0, 40.0, '2023-09-15 12:00:00'),
(16, 1, 0.3, '2023-03-15', 1, 'Good', 12, '2023-07-15', 300.0, 290.0, '2023-07-15 12:00:00'),
(16, 2, 0.1, '2023-03-20', 1, 'Fair', 6, '2023-07-20', 60.0, 50.0, '2023-07-20 12:00:00'),
(17, 3, 0.05, '2023-04-01', 1, 'Good', 2, '2023-09-01', 50.0, 40.0, '2023-09-01 12:00:00'),
(17, 4, 0.1, '2023-04-05', 1, 'Good', 3, '2023-09-05', 30.0, 25.0, '2023-09-05 12:00:00'),
(18, 5, 0.1, '2023-04-10', 1, 'Fair', 5, '2023-09-10', 50.0, 40.0, '2023-09-10 12:00:00'),
(18, 6, 0.05, '2023-04-15', 1, 'Excellent', 2, '2023-09-15', 20.0, 15.0, '2023-09-15 12:00:00'),
(19, 1, 0.2, '2023-03-15', 1, 'Good', 8, '2023-07-15', 200.0, 190.0, '2023-07-15 12:00:00'),
(19, 2, 0.1, '2023-03-20', 1, 'Fair', 4, '2023-07-20', 40.0, 30.0, '2023-07-20 12:00:00'),
(20, 3, 0.05, '2023-04-01', 1, 'Good', 2, '2023-09-01', 50.0, 40.0, '2023-09-01 12:00:00'),
(20, 4, 0.1, '2023-04-05', 1, 'Good', 3, '2023-09-05', 30.0, 25.0, '2023-09-05 12:00:00');