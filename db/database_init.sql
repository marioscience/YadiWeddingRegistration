-- CREATE DATABASE yadidb
--     WITH
--     OWNER = postgres
--     ENCODING = 'UTF8'
--     LC_COLLATE = 'English_United States.1252'
--     LC_CTYPE = 'English_United States.1252'
--     TABLESPACE = pg_default
--     CONNECTION LIMIT = -1
--     IS_TEMPLATE = False;

-- For development move to teardown.sql  later TESTING d
DROP TABLE selections;
DROP TABLE users;
DROP TABLE gifts;

CREATE TABLE IF NOT EXISTS users (
    userid SERIAL PRIMARY KEY,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    phone BIGINT NOT NULL UNIQUE,
    email VARCHAR(40) NOT NULL UNIQUE,
    invitation_sent BOOLEAN NOT NULL DEFAULT FALSE,
    is_admin BOOLEAN NOT NULL DEFAULT FALSE,
    password_hash VARCHAR(40) NOT NULL,
    salt VARCHAR(40) NOT NULL,
    last_seen TIMESTAMP DEFAULT now(),
    UNIQUE(first_name, last_name, phone, email)
);

CREATE TABLE IF NOT EXISTS gifts(
    giftid SERIAL PRIMARY KEY,
    picture VARCHAR(40) NOT NULL,
    name VARCHAR(40) NOT NULL UNIQUE,
    description VARCHAR(160) NOT NULL
);
    
CREATE TABLE IF NOT EXISTS selections (
    id SERIAL NOT NULL,
    userid BIGINT REFERENCES users(userid),
    giftid BIGINT REFERENCES gifts(giftid),
    date_selected TIMESTAMP DEFAULT now(),
    note VARCHAR(360)
);

-- CREATE FUNCTION rand_userid() RETURNS BIGINT AS $$
-- $$ LANGUAGE plpgsql;

-- CLEAR DATABASE <- for teardown
-- DROP DATABASE IF EXISTS yadidb;




 