-- SEED DATA

SELECT * FROM users;
SELECT * FROM gifts;
SELECT * FROM selections;

INSERT INTO users (first_name, last_name, phone, email, invitation_sent, is_admin, password_hash, salt)
    VALUES ('Yadeiri', 'Hernandez', 8295432686, 'yadeirilissett06@gmail.com', TRUE, TRUE, '2c2bf00079a6d49a8f7fb17cefb52fdb41a4b043', 'GFR9uT4N4Tzl3vnK'); -- update password and hash!

INSERT INTO users (first_name, last_name, phone, email, invitation_sent, password_hash, salt)
    VALUES ('Roberto', 'Alomar', 8298242686, 'robertalomr@gmail.com', FALSE, '2c2bf00079a6d49a8f7fb17cefb52fdb41a4b043', 'GFR9uT4N4Tzl3vnK'),
    ('Pedro', 'Martinez', 8292372686, 'pokomono@gmail.com', TRUE, '2c2bf00079a6d49a8f7fb17cefb52fdb41a4b043', 'GFR9uT4N4Tzl3vnK'),
    ('Sami', 'Sosa', 8294452686, 'tucoquito@gmail.com', FALSE, '2c2bf00079a6d49a8f7fb17cefb52fdb41a4b043', 'GFR9uT4N4Tzl3vnK');

-- DELETE FROM users;
-- SELECT * FROM users;

INSERT INTO gifts (picture, name, description)
    VALUES ('licuadora_thumb.png', 'Licuadora', 'Color negro. Accero inoxidable.'),
    ('tostadora_thumb.png', 'Tostadora', 'Color negro. Accero inoxidable.'),
    ('plancha_thumb.png', 'Plancha', 'Color negro. Accero inoxidable.'),
    ('microondas_thumb.png', 'Microondas', 'Color negro. Accero inoxidable.'),
    ('horno_thumb.png', 'Horno Eléctrico', 'Color negro. Accero inoxidable.'),
    ('vajillas_thumb.png', '2 Juegos de Vajillas', 'Individuales.'),
    ('tabla_planchar_thumb.png', 'Tabla de Planchar', ''),
    ('sabana_thumb.png', 'Juego de Sábana', 'Queen 60 x 74 pulgadas.'),
    ('vasos_thumb.png', 'Copas, Vasos y Cucharones', '2 Combos. Individuales.'),
    ('cubiertos_thumb.png', 'Cubeterteria', 'Cucharas, Cubiertos, Juegos de Cuchillos.'),
    ('paires_thumb.png', 'Paires','Juego de 3.'),
    ('calderos_thumb.png', 'Juego de Calderos', 'En Teflón o Accero inoxidable.'),
    ('sarten_thumb.png', 'Juego de Sartenes', 'En Teflón.'),
    ('ollas_thumb.png', 'Juego de Ollas', 'Acero inoxidable.'),
    ('olla_presion_thumb.png', 'Olla de Presión', 'Acero inoxidable.'),
    ('tanque_thumb.png', 'Tanque de Gas', '50 LB.');

-- DELETE FROM gifts;
-- SELECT * FROM gifts;

-- Helper functions for selections table insert
-- Note: This function is temporary. Only works when database is brand new and has all values sequentially starting from 0.
-- See: 
CREATE FUNCTION rand_giftid() RETURNS BIGINT AS $$
	declare gift_count INT := (SELECT COUNT(*) FROM gifts);
	BEGIN
		RETURN (SELECT giftid FROM gifts OFFSET floor(random() * gift_count) LIMIT 1);
	END;
$$ LANGUAGE plpgsql;

SELECT * FROM rand_giftid();

-- Note: This function is temporary. Only works when database is brand new and has all values sequentially starting from 0.
CREATE FUNCTION rand_userid() RETURNS BIGINT AS $$
	declare user_count INT := (SELECT COUNT(*) FROM users);
	BEGIN
		RETURN (SELECT userid FROM users OFFSET floor(random() * user_count) LIMIT 1);
	END;
$$ LANGUAGE plpgsql;

SELECT * FROM rand_userid();

DO
$do$
DECLARE 
	userid_val BIGINT;
	giftid_val BIGINT;
BEGIN
	FOR i IN 1..25 LOOP
		userid_val := (SELECT rand_userid FROM rand_userid());
		giftid_val := (SELECT rand_giftid FROM rand_giftid());		
		INSERT INTO selections (userid, giftid, note) VALUES (userid_val, giftid_val, 'Felicidades Yadi, espero que la pases muy especial en tu dia!! Es un nuevo comienzo y como siempre hay nuevos retos y nuevas metas que alcanzar. Pero como siempre ha sido y como siempre sera, Dios estara ahi a cada paso que des y te cuidara siempre! Bendiciones!');
	END LOOP;
END
$do$;

-- INSERT INTO selections () VALUES ('Felicidaes Yadi! Que tus dias sean felices por siempre. Te queremos mucho');