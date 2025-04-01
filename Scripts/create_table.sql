CREATE TABLE Person (
    person_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL CHECK (full_name ~ '^[А-Яа-яЁё ]+$'),
    number VARCHAR(20) NOT NULL CHECK (LENGTH(number) = 11 and number ~ '^[0-9]+$'),
    have_premium BOOLEAN DEFAULT FALSE,
    email VARCHAR(100) CHECK (email LIKE '%@%'),
    rating DECIMAL(10,2) DEFAULT 5 CHECK (rating >= 0 and 5 >= rating)
);

CREATE TABLE Driver (
    driver_id SERIAL PRIMARY KEY,
    car_number VARCHAR(20) NOT NULL,
    rating DECIMAL(10,2) DEFAULT 5 CHECK (rating BETWEEN 0 AND 5),
    license VARCHAR(50) NOT NULL CHECK (license ~ '^[0-9]+$'),
    full_name VARCHAR(100) NOT NULL CHECK (full_name ~ '^[А-Яа-яЁё ]+$'),
    experience_years INTEGER DEFAULT 0 CHECK (experience_years >= 0)
);

CREATE TABLE Drive (
    drive_id SERIAL PRIMARY KEY,
    person_id INTEGER REFERENCES Person(person_id),
    driver_id INTEGER REFERENCES Driver(driver_id),
    start_location VARCHAR(255) NOT NULL,
    final_location VARCHAR(255) NOT NULL,
    from_pas_to_driver INTEGER CHECK (from_pas_to_driver >= 0 and 5 >= from_pas_to_driver),
    from_driver_to_pas INTEGER CHECK (from_driver_to_pas >= 0 and 5 >= from_driver_to_pas),
    comment VARCHAR(150)
);

CREATE TABLE Payment (
    payment_id SERIAL PRIMARY KEY,
    drive_id INTEGER REFERENCES Drive(drive_id),
    fare DECIMAL(10,2) NOT NULL CHECK (fare > 0),
    tip DECIMAL(10,2) CHECK (tip >= 0)
);

CREATE TABLE Driver_Rating_History (
    update_id SERIAL PRIMARY KEY,
    driver_id INTEGER REFERENCES Driver(driver_id),
    rating DECIMAL(10,2) DEFAULT 5 CHECK (rating >= 0 and 5 >= rating),
    rating_from INTEGER REFERENCES Person(person_id),
    date TIMESTAMP CHECK (date < CURRENT_TIMESTAMP)
);

CREATE TABLE Person_Rating_History (
    update_id SERIAL PRIMARY KEY,
    person_id INTEGER REFERENCES Person(person_id),
    rating DECIMAL(10,2) DEFAULT 5 CHECK (rating >= 0 and 5 >= rating),
    rating_from INTEGER REFERENCES Driver(driver_id),
    date TIMESTAMP CHECK (date < CURRENT_TIMESTAMP)
);
