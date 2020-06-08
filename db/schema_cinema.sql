DROP TABLE IF EXISTS halls;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (id SERIAL PRIMARY KEY, name TEXT, phone INTEGER);
CREATE TABLE halls (id SERIAL PRIMARY KEY, row INTEGER , place INTEGER, price INTEGER, busy bool, accounts_id INTEGER);
INSERT INTO halls(row, place, price, busy) VALUES (1, 1, 500, false );
INSERT INTO halls(row, place, price, busy) VALUES (1, 2, 500, false );
INSERT INTO halls(row, place, price, busy) VALUES (1, 3, 500, false );
INSERT INTO halls(row, place, price, busy) VALUES (2, 1, 300, false );
INSERT INTO halls(row, place, price, busy) VALUES (2, 2, 300, true );
INSERT INTO halls(row, place, price, busy) VALUES (2, 3, 300, false );
INSERT INTO halls(row, place, price, busy) VALUES (3, 1, 300, false );
INSERT INTO halls(row, place, price, busy) VALUES (3, 2, 300, true);
INSERT INTO halls(row, place, price, busy) VALUES (3, 3, 300, false );



