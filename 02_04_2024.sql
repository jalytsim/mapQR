CREATE TABLE IF NOT EXISTS district (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    region VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS farmergroup (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT
);

CREATE TABLE IF NOT EXISTS produceCategory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    grade INT
);

CREATE TABLE IF NOT EXISTS soilData (
    id INT AUTO_INCREMENT PRIMARY KEY,
    district_id INT,
    internal_id INT,
    device VARCHAR(255),
    owner VARCHAR(255),
    nitrogen FLOAT,
    phosphorus FLOAT,
    potassium FLOAT,
    ph FLOAT,
    temperature FLOAT,
    humidity FLOAT,
    conductivity FLOAT,
    signal_level FLOAT,
    date DATE,
    FOREIGN KEY (district_id) REFERENCES district(id)
);

CREATE TABLE IF NOT EXISTS crop (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    weight FLOAT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES produceCategory(id)
);


CREATE TABLE IF NOT EXISTS farm (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    subcounty VARCHAR(255),
    farmergroup_id INT,
    district_id INT,
    geolocation VARCHAR(255),
    FOREIGN KEY (district_id) REFERENCES district(id),
    FOREIGN KEY (farmergroup_id) REFERENCES farmergroup(id)
);

CREATE TABLE IF NOT EXISTS farmData (
    id INT AUTO_INCREMENT PRIMARY KEY,
    farm_id INT,
    crop_id INT,
    tilled_land_size FLOAT,
    planting_date DATE,
    season INT,
    quality VARCHAR(255),
    quantity INT,
    harvest_date DATE,
    expected_yield FLOAT,
    actual_yield FLOAT,
    timestamp TIMESTAMP,
    FOREIGN KEY (farm_id) REFERENCES farm(id),
    FOREIGN KEY (crop_id) REFERENCES crop(id)
);

INSERT INTO district (name, region) VALUES
('Kabarole', 'Western'),
('Lira', 'Northern'),
('Jinja', 'Eastern'),
('Arua', 'Northern'),
('Iganga', 'Eastern'),
('Kasese', 'Western'),
('Masindi', 'Western'),
('Mukono', 'Central'),
('Arua', 'Northern'),
('Kisoro', 'Western'),
('Moroto', 'Northern'),
('Ntungamo', 'Western'),
('Pallisa', 'Eastern'),
('Rukungiri', 'Western'),
('Soroti', 'Eastern'),
('Tororo', 'Eastern'),
('Adjumani', 'Northern'),
('Kotido', 'Northern'),
('Kumi', 'Eastern'),
('Kyenjojo', 'Western');

INSERT INTO produceCategory (name, grade) VALUES
('Maize', 1),
('Beans', 2),
('Coffee', 3),
('Cassava', 1),
('Rice', 2),
('Bananas', 3);

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

ALTER TABLE farmData
ADD COLUMN channel_partner VARCHAR(255),
ADD COLUMN destination_country VARCHAR(255),
ADD COLUMN customer_name VARCHAR(255);

UPDATE farmData
SET 
    channel_partner = 'Agro Supplies Ltd',
    destination_country = 'Uganda',
    customer_name = 'Jinja Farms Ltd'
WHERE id = 1;

-- Mettre à jour l'enregistrement 2
UPDATE farmData
SET 
    channel_partner = 'Uganda AgriTech Solutions',
    destination_country = 'Uganda',
    customer_name = 'Kampala Agro Farms'
WHERE id = 2;

-- Mettre à jour l'enregistrement 3
UPDATE farmData
SET 
    channel_partner = 'Kampala Agri Solutions',
    destination_country = 'Uganda',
    customer_name = 'Mbale Farms Co.'
WHERE id = 3;

-- Mettre à jour l'enregistrement 4
UPDATE farmData
SET 
    channel_partner = 'Uganda Organic Harvest',
    destination_country = 'Uganda',
    customer_name = 'Masaka Agro Enterprises'
WHERE id = 4;

-- Mettre à jour l'enregistrement 5
UPDATE farmData
SET 
    channel_partner = 'Jinja Farms Ltd',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agro Coop'
WHERE id = 5;

-- Mettre à jour l'enregistrement 6
UPDATE farmData
SET 
    channel_partner = 'Uganda Green Fields',
    destination_country = 'Uganda',
    customer_name = 'Lira Organic Farmers'
WHERE id = 6;

-- Mettre à jour l'enregistrement 7
UPDATE farmData
SET 
    channel_partner = 'Kasese AgriPro',
    destination_country = 'Uganda',
    customer_name = 'Entebbe Produce Group'
WHERE id = 7;

-- Mettre à jour l'enregistrement 8
UPDATE farmData
SET 
    channel_partner = 'Uganda Harvesters',
    destination_country = 'Uganda',
    customer_name = 'Soroti Agri Enterprise'
WHERE id = 8;

-- Mettre à jour l'enregistrement 9
UPDATE farmData
SET 
    channel_partner = 'Kabale Farm Solutions',
    destination_country = 'Uganda',
    customer_name = 'Gulu Farmers Coop'
WHERE id = 9;

-- Mettre à jour l'enregistrement 10
UPDATE farmData
SET 
    channel_partner = 'Mbale Agri Ltd',
    destination_country = 'Uganda',
    customer_name = 'Hoima Organic'
WHERE id = 10;

-- Mettre à jour l'enregistrement 11
UPDATE farmData
SET 
    channel_partner = 'Uganda Agro Services',
    destination_country = 'Uganda',
    customer_name = 'Mityana Produce Group'
WHERE id = 11;

-- Mettre à jour l'enregistrement 12
UPDATE farmData
SET 
    channel_partner = 'Jinja Fields',
    destination_country = 'Uganda',
    customer_name = 'Kasese Agri Coop'
WHERE id = 12;

-- Mettre à jour l'enregistrement 13
UPDATE farmData
SET 
    channel_partner = 'Uganda Harvest Group',
    destination_country = 'Uganda',
    customer_name = 'Kabale Farms'
WHERE id = 13;

-- Mettre à jour l'enregistrement 14
UPDATE farmData
SET 
    channel_partner = 'Gulu Agri Solutions',
    destination_country = 'Uganda',
    customer_name = 'Mbale Organic'
WHERE id = 14;

-- Mettre à jour l'enregistrement 15
UPDATE farmData
SET 
    channel_partner = 'Lira Farms',
    destination_country = 'Uganda',
    customer_name = 'Masaka Agri Coop'
WHERE id = 15;

-- Mettre à jour l'enregistrement 16
UPDATE farmData
SET 
    channel_partner = 'Kabale AgriPro',
    destination_country = 'Uganda',
    customer_name = 'Jinja Organic'
WHERE id = 16;

-- Mettre à jour l'enregistrement 17
UPDATE farmData
SET 
    channel_partner = 'Uganda Green Harvest',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agri Enterprise'
WHERE id = 17;

-- Mettre à jour l'enregistrement 18
UPDATE farmData
SET 
    channel_partner = 'Hoima Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Kasese Farmers Coop'
WHERE id = 18;

-- Mettre à jour l'enregistrement 19
UPDATE farmData
SET 
    channel_partner = 'Entebbe Agri Ltd',
    destination_country = 'Uganda',
    customer_name = 'Masindi Harvesters'
WHERE id = 19;

-- Mettre à jour l'enregistrement 20
UPDATE farmData
SET 
    channel_partner = 'Gulu Fields',
    destination_country = 'Uganda',
    customer_name = 'Mbale Agro Coop'
WHERE id = 20;

-- Mettre à jour l'enregistrement 21
UPDATE farmData
SET 
    channel_partner = 'Mityana Farms',
    destination_country = 'Uganda',
    customer_name = 'Kabale Agri Group'
WHERE id = 21;

-- Mettre à jour l'enregistrement 22
UPDATE farmData
SET 
    channel_partner = 'Kasese AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Gulu Organic Farmers'
WHERE id = 22;

-- Mettre à jour l'enregistrement 23
UPDATE farmData
SET 
    channel_partner = 'Mbale Harvest Group',
    destination_country = 'Uganda',
    customer_name = 'Mityana Agri Enterprise'
WHERE id = 23;

-- Mettre à jour l'enregistrement 24
UPDATE farmData
SET 
    channel_partner = 'Masaka Agri Solutions',
    destination_country = 'Uganda',
    customer_name = 'Masindi Agri Coop'
WHERE id = 24;

-- Mettre à jour l'enregistrement 25
UPDATE farmData
SET 
    channel_partner = 'Kabale Green Fields',
    destination_country = 'Uganda',
    customer_name = 'Lira Harvest Group'
WHERE id = 25;

-- Mettre à jour l'enregistrement 26
UPDATE farmData
SET 
    channel_partner = 'Mbarara AgriPro',
    destination_country = 'Uganda',
    customer_name = 'Entebbe Agri Coop'
WHERE id = 26;

-- Mettre à jour l'enregistrement 27
UPDATE farmData
SET 
    channel_partner = 'Gulu Harvesters',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Harvesters'
WHERE id = 27;

-- Mettre à jour l'enregistrement 28
UPDATE farmData
SET 
    channel_partner = 'Masaka Fields',
    destination_country = 'Uganda',
    customer_name = 'Hoima Agri Enterprise'
WHERE id = 28;

-- Mettre à jour l'enregistrement 29
UPDATE farmData
SET 
    channel_partner = 'Mbale AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Masindi Agri Solutions'
WHERE id = 29;

-- Mettre à jour l'enregistrement 30
UPDATE farmData
SET 
    channel_partner = 'Mityana Harvesters',
    destination_country = 'Uganda',
    customer_name = 'Entebbe Harvest Group'
WHERE id = 30;

-- Mettre à jour l'enregistrement 31
UPDATE farmData
SET 
    channel_partner = 'Masindi AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Mityana Agri Coop'
WHERE id = 31;

-- Mettre à jour l'enregistrement 32
UPDATE farmData
SET 
    channel_partner = 'Kabale Fields',
    destination_country = 'Uganda',
    customer_name = 'Jinja Agri Solutions'
WHERE id = 32;

-- Mettre à jour l'enregistrement 33
UPDATE farmData
SET 
    channel_partner = 'Mbarara Agri Group',
    destination_country = 'Uganda',
    customer_name = 'Masaka Harvesters'
WHERE id = 33;

-- Mettre à jour l'enregistrement 34
UPDATE farmData
SET 
    channel_partner = 'Mbale Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Kabale Agri Solutions'
WHERE id = 34;

-- Mettre à jour l'enregistrement 35
UPDATE farmData
SET 
    channel_partner = 'Masindi Harvest Group',
    destination_country = 'Uganda',
    customer_name = 'Kasese Agri Coop'
WHERE id = 35;

-- Mettre à jour l'enregistrement 36
UPDATE farmData
SET 
    channel_partner = 'Mityana AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Lira Harvesters'
WHERE id = 36;

-- Mettre à jour l'enregistrement 37
UPDATE farmData
SET 
    channel_partner = 'Mbarara Agro Group',
    destination_country = 'Uganda',
    customer_name = 'Mbale Agri Coop'
WHERE id = 37;

-- Mettre à jour l'enregistrement 38
UPDATE farmData
SET 
    channel_partner = 'Jinja Agri Solutions',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agri Coop'
WHERE id = 38;

-- Mettre à jour l'enregistrement 39
UPDATE farmData
SET 
    channel_partner = 'Masaka AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Masindi Harvesters'
WHERE id = 39;

-- Mettre à jour l'enregistrement 40
UPDATE farmData
SET 
    channel_partner = 'Kabale Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Kasese Agri Group'
WHERE id = 40;

-- Mettre à jour l'enregistrement 41
UPDATE farmData
SET 
    channel_partner = 'Mityana Agri Group',
    destination_country = 'Uganda',
    customer_name = 'Gulu Agri Solutions'
WHERE id = 41;

-- Mettre à jour l'enregistrement 42
UPDATE farmData
SET 
    channel_partner = 'Masindi Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Mbale Harvesters'
WHERE id = 42;

-- Mettre à jour l'enregistrement 43
UPDATE farmData
SET 
    channel_partner = 'Kasese Agro Group',
    destination_country = 'Uganda',
    customer_name = 'Entebbe Harvest Group'
WHERE id = 43;

-- Mettre à jour l'enregistrement 44
UPDATE farmData
SET 
    channel_partner = 'Mbarara Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Jinja Agri Coop'
WHERE id = 44;

-- Mettre à jour l'enregistrement 45
UPDATE farmData
SET 
    channel_partner = 'Mbale Agro Group',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Harvesters'
WHERE id = 45;

-- Mettre à jour l'enregistrement 46
UPDATE farmData
SET 
    channel_partner = 'Mityana Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Masaka Harvesters'
WHERE id = 46;

-- Mettre à jour l'enregistrement 47
UPDATE farmData
SET 
    channel_partner = 'Masaka Agro Group',
    destination_country = 'Uganda',
    customer_name = 'Kabale Agri Coop'
WHERE id = 47;

-- Mettre à jour l'enregistrement 48
UPDATE farmData
SET 
    channel_partner = 'Kabale Agro Group',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Harvesters'
WHERE id = 48;

-- Mettre à jour l'enregistrement 49
UPDATE farmData
SET 
    channel_partner = 'Mbarara AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Masaka Agri Solutions'
WHERE id = 49;

-- Mettre à jour l'enregistrement 50
UPDATE farmData
SET 
    channel_partner = 'Mbale Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Masindi Agri Coop'
WHERE id = 50;

-- Mettre à jour l'enregistrement 51
UPDATE farmData
SET 
    channel_partner = 'Masaka Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Harvesters'
WHERE id = 51;

-- Mettre à jour l'enregistrement 52
UPDATE farmData
SET 
    channel_partner = 'Mityana AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Kasese Agri Solutions'
WHERE id = 52;

-- Mettre à jour l'enregistrement 53
UPDATE farmData
SET 
    channel_partner = 'Masindi Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Entebbe Agri Coop'
WHERE id = 53;

-- Mettre à jour l'enregistrement 54
UPDATE farmData
SET 
    channel_partner = 'Kasese Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Mityana Agri Coop'
WHERE id = 54;

-- Mettre à jour l'enregistrement 55
UPDATE farmData
SET 
    channel_partner = 'Mbarara Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Masaka Agri Group'
WHERE id = 55;

-- Mettre à jour l'enregistrement 56
UPDATE farmData
SET 
    channel_partner = 'Mbale AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Jinja Agri Coop'
WHERE id = 56;

-- Mettre à jour l'enregistrement 57
UPDATE farmData
SET 
    channel_partner = 'Masindi AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agri Solutions'
WHERE id = 57;

-- Mettre à jour l'enregistrement 58
UPDATE farmData
SET 
    channel_partner = 'Kasese Agro Group',
    destination_country = 'Uganda',
    customer_name = 'Masaka Agri Solutions'
WHERE id = 58;

-- Mettre à jour l'enregistrement 59
UPDATE farmData
SET 
    channel_partner = 'Mityana AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Kabale Agri Coop'
WHERE id = 59;

-- Mettre à jour l'enregistrement 60
UPDATE farmData
SET 
    channel_partner = 'Masaka AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agri Solutions'
WHERE id = 60;

-- Mettre à jour l'enregistrement 61
UPDATE farmData
SET 
    channel_partner = 'Mbarara Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Kasese Agri Group'
WHERE id = 61;

-- Mettre à jour l'enregistrement 62
UPDATE farmData
SET 
    channel_partner = 'Mbale Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Masindi Agri Coop'
WHERE id = 62;

-- Mettre à jour l'enregistrement 63
UPDATE farmData
SET 
    channel_partner = 'Masaka Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agri Group'
WHERE id = 63;

-- Mettre à jour l'enregistrement 64
UPDATE farmData
SET 
    channel_partner = 'Mityana AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Masaka Agri Coop'
WHERE id = 64;

-- Mettre à jour l'enregistrement 65
UPDATE farmData
SET 
    channel_partner = 'Masindi AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Jinja Agri Coop'
WHERE id = 65;

-- Mettre à jour l'enregistrement 66
UPDATE farmData
SET 
    channel_partner = 'Kasese Agro Group',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agri Solutions'
WHERE id = 66;

-- Mettre à jour l'enregistrement 67
UPDATE farmData
SET 
    channel_partner = 'Mbarara Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Kasese Agri Coop'
WHERE id = 67;

-- Mettre à jour l'enregistrement 68
UPDATE farmData
SET 
    channel_partner = 'Mbale Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Masaka Agri Solutions'
WHERE id = 68;

-- Mettre à jour l'enregistrement 69
UPDATE farmData
SET 
    channel_partner = 'Masaka Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agri Solutions'
WHERE id = 69;

-- Mettre à jour l'enregistrement 70
UPDATE farmData
SET 
    channel_partner = 'Mityana AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Kabale Agri Coop'
WHERE id = 70;

-- Mettre à jour l'enregistrement 71
UPDATE farmData
SET 
    channel_partner = 'Masaka AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agri Solutions'
WHERE id = 71;

-- Mettre à jour l'enregistrement 72
UPDATE farmData
SET 
    channel_partner = 'Mbarara Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Kasese Agri Group'
WHERE id = 72;

-- Mettre à jour l'enregistrement 73
UPDATE farmData
SET 
    channel_partner = 'Mbale Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Masindi Agri Coop'
WHERE id = 73;

-- Mettre à jour l'enregistrement 74
UPDATE farmData
SET 
    channel_partner = 'Masaka Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agri Group'
WHERE id = 74;

-- Mettre à jour l'enregistrement 75
UPDATE farmData
SET 
    channel_partner = 'Mityana AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Masaka Agri Coop'
WHERE id = 75;

-- Mettre à jour l'enregistrement 76
UPDATE farmData
SET 
    channel_partner = 'Masindi AgroPro',
    destination_country = 'Uganda',
    customer_name = 'Jinja Agri Coop'
WHERE id = 76;

-- Mettre à jour l'enregistrement 77
UPDATE farmData
SET 
    channel_partner = 'Kasese Agro Group',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agri Solutions'
WHERE id = 77;

-- Mettre à jour l'enregistrement 78
UPDATE farmData
SET 
    channel_partner = 'Mbarara Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Kasese Agri Coop'
WHERE id = 78;

-- Mettre à jour l'enregistrement 79
UPDATE farmData
SET 
    channel_partner = 'Mbale Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Masaka Agri Solutions'
WHERE id = 79;

-- Mettre à jour l'enregistrement 80
UPDATE farmData
SET 
    channel_partner = 'Masaka Agro Solutions',
    destination_country = 'Uganda',
    customer_name = 'Mbarara Agri Solutions'
WHERE id = 80;
