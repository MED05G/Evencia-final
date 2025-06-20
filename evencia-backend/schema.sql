DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS feedback CASCADE;
DROP TABLE IF EXISTS favorites CASCADE;
DROP TABLE IF EXISTS registrations CASCADE;
DROP TABLE IF EXISTS schedules CASCADE;
DROP TABLE IF EXISTS events CASCADE;
DROP TABLE IF EXISTS venues CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    clerk_id VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    photo VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE venues (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    latitude VARCHAR(255),
    longitude VARCHAR(255),
    capacity INTEGER NOT NULL,
    description TEXT,
    amenities TEXT,
    contact_info VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    image_url VARCHAR(255) NOT NULL,
    start_date_time TIMESTAMP NOT NULL,
    end_date_time TIMESTAMP NOT NULL,
    price VARCHAR(50),
    is_free BOOLEAN DEFAULT FALSE,
    url VARCHAR(255),
    category_id INTEGER REFERENCES categories(id),
    organizer_id INTEGER REFERENCES users(id)
);

CREATE TABLE schedules (
    id SERIAL PRIMARY KEY,
    event_id INTEGER REFERENCES events(id) NOT NULL,
    venue_id INTEGER REFERENCES venues(id) NOT NULL,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    available_seats INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE registrations (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) NOT NULL,
    schedule_id INTEGER REFERENCES schedules(id) NOT NULL,
    registration_date TIMESTAMP DEFAULT NOW(),
    number_of_seats INTEGER NOT NULL DEFAULT 1,
    status VARCHAR(50) NOT NULL DEFAULT 'confirmed',
    total_amount DECIMAL(10,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    registration_id INTEGER REFERENCES registrations(id) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(50) NOT NULL DEFAULT 'pending',
    payment_date TIMESTAMP DEFAULT NOW(),
    stripe_payment_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE feedback (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) NOT NULL,
    event_id INTEGER REFERENCES events(id) NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT,
    feedback_date TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE favorites (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) NOT NULL,
    event_id INTEGER REFERENCES events(id) NOT NULL,
    added_date TIMESTAMP DEFAULT NOW()
);


INSERT INTO categories (name) VALUES ('General');
INSERT INTO users (clerk_id, email, username, first_name, last_name, photo)
VALUES ('clerk_123', 'test@example.com', 'testuser', 'Test', 'User', 'https://example.com/photo.jpg');
