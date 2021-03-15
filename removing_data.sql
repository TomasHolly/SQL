DROP TABLE IF EXISTS "Track" CASCADE;

CREATE TABLE "Track"
(
    "TrackId" INT NOT NULL,
    "Name" VARCHAR(200) NOT NULL,
    "AlbumId" INT,
    "MediaTypeId" INT NOT NULL,
    "GenreId" INT,
    "Composer" VARCHAR(220),
    "Milliseconds" INT NOT NULL,
    "Bytes" INT,
    "UnitPrice" NUMERIC(10,2) NOT NULL,
    CONSTRAINT "PK_Track" PRIMARY KEY  ("TrackId")
);


INSERT INTO "Track" ("TrackId", "Name", "AlbumId", "MediaTypeId", "GenreId", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (1, N'For Those About To Rock (We Salute You)', 1, 1, 1, N'Angus Young, Malcolm Young, Brian Johnson', 343719, 11170334, 0.99);
INSERT INTO "Track" ("TrackId", "Name", "AlbumId", "MediaTypeId", "GenreId", "Milliseconds", "Bytes", "UnitPrice") VALUES (2, N'Balls to the Wall', 2, 2, 1, 342562, 5510424, 0.99);
INSERT INTO "Track" ("TrackId", "Name", "AlbumId", "MediaTypeId", "GenreId", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (3, N'Fast As a Shark', 3, 2, 1, N'F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffman', 230619, 3990994, 0.99);

SELECT *
FROM "Track";

-- DELETE 
-- Ako z tabuľky vymazať záznam (konkrétny riadok)
DELETE FROM "Track"
WHERE "MediaTypeId" = 2;
-- už sa tam tie riadky nenachadzajú 

-- Niekedy je užitočné vrátiť záznamy, ktoré som vymazal:
DELETE FROM "Track"
WHERE "MediaTypeId" = 2
RETURNING *;

-- Ako vymazať obsah tabuľky: 
DELETE FROM "Track";

CREATE TABLE "Game"
(
	"GameId" SERIAL PRIMARY KEY,
	"Game" VARCHAR(256)

)
INSERT INTO "Game"("Game") VALUES ('ClashRoyale');
DELETE FROM "Game";
INSERT INTO "Game"("Game") VALUES ('BrawlStars');
-- DELETE Table vymaže tabuľku, ale zanechá hodnotu GameId a následne BrawlStars má GameId 2

-- Ako vymazať tabuľku: 
DROP TABLE "Track"

-- DELETE FROM vs TRUNCATE 
TRUNCATE TABLE "Game" RESTART IDENTITY 

SELECT *
FROM "Game"
-- TRUNCATE je oveľa rychlejší ako DELETE FROM
