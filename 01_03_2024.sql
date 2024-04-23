-- SQLite
CREATE TABLE district (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    region TEXT
);

CREATE TABLE soilData (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    district_id INTEGER,
    internal_id INTEGER,
    device TEXT,
    owner TEXT,
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

CREATE TABLE farm (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    subcounty TEXT,
    district_id INTEGER,
    FOREIGN KEY (district_id) REFERENCES district(id)
);

CREATE TABLE farmData (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    farm_id INTEGER,
    crop TEXT,
    tilled_land_size REAL,
    planting_date DATE,
    season INTEGER,
    harvest_date DATE,
    expected_yield REAL,
    actual_yield REAL,
    FOREIGN KEY (farm_id) REFERENCES farm(id)
);
