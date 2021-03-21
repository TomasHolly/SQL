DROP TABLE IF EXISTS "Customer" CASCADE;
DROP TABLE IF EXISTS "Invoice" CASCADE;

CREATE TABLE "Customer"
(
    "CustomerId" INT NOT NULL,
    "FirstName" VARCHAR(40) NOT NULL,
    "LastName" VARCHAR(20) NOT NULL,
    "Company" VARCHAR(80),
    "Address" VARCHAR(70),
    "City" VARCHAR(40),
    "State" VARCHAR(40),
    "Country" VARCHAR(40),
    "PostalCode" VARCHAR(10),
    "Phone" VARCHAR(24),
    "Fax" VARCHAR(24),
    "Email" VARCHAR(60) NOT NULL,
    "SupportRepId" INT,
    CONSTRAINT "PK_Customer" PRIMARY KEY  ("CustomerId")
);

CREATE TABLE "Invoice"
(
    "InvoiceId" INT NOT NULL,
    "CustomerId" INT NOT NULL,
    "InvoiceDate" TIMESTAMP NOT NULL,
    "BillingAddress" VARCHAR(70),
    "BillingCity" VARCHAR(40),
    "BillingState" VARCHAR(40),
    "BillingCountry" VARCHAR(40),
    "BillingPostalCode" VARCHAR(10),
    "Total" NUMERIC(10,2) NOT NULL,
    CONSTRAINT "PK_Invoice" PRIMARY KEY  ("InvoiceId")
);

ALTER TABLE "Invoice" ADD CONSTRAINT "FK_InvoiceCustomer"
	FOREIGN KEY ("CustomerId") REFERENCES "Customer"("CustomerId") ON DELETE NO ACTION ON UPDATE NO ACTION;


-- Tabuľka car:
DROP TABLE IF EXISTS "Car";
CREATE TABLE IF NOT EXISTS "Car" (
	car_id INT NOT NULL,
	brand VARCHAR(128) NOT NULL,
	customer_id INT NOT NULL,
	CONSTRAINT pk_car PRIMARY KEY (car_id),
	CONSTRAINT "FK_customer" FOREIGN KEY (customer_id) REFERENCES "Customer" ("CustomerId") ON DELETE NO ACTION ON UPDATE NO ACTION
);


INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (1, N'Luís', N'Gonçalves', N'Embraer - Empresa Brasileira de Aeronáutica S.A.', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', N'+55 (12) 3923-5555', N'+55 (12) 3923-5566', N'luisg@embraer.com.br', 3);
INSERT INTO "Car" (car_id, brand, customer_id) VALUES (1, 'BMW', 1);

-- Čo ak chceme vymazať 1 zakazníka is autom ?

DELETE FROM "Customer" WHERE "CustomerId" = 1;

-- vypíše sa chyba 
-- musíme zmeniť z ON DELETE NO ACITION na ON DELETE CASCADE:
ALTER TABLE "Car"
	DROP CONSTRAINT "FK_customer",
	ADD CONSTRAINT "FK_customer2"
		FOREIGN KEY (customer_id) REFERENCES "Customer"("CustomerId") ON DELETE CASCADE;
DELETE FROM "Customer" WHERE "CustomerId" = 1;
-- Používateľ je vymazaný i s autom 

SELECT * FROM "Car";
SELECT * FROM "Customer";

-- Máme dve tabuľky (game a player) čo ak chceme playera s playerid zmeniť z 1 na dva a to isté platí pre game:

DROP TABLE IF EXISTS public."Player";
CREATE TABLE IF NOT EXISTS "Player"
(
	"PlayerId" INT NOT NULL,
	"FirstName" VARCHAR(256),
	"LastName" VARCHAR(512),
	"YearBorn" INT,
	CONSTRAINT "Pk_Player" PRIMARY KEY ("PlayerId")
);

DROP TABLE IF EXISTS "Game";
CREATE TABLE IF NOT EXISTS "Game"
(
	"GameId" INT NOT NULL,
	"PlayerId" INT,
	"GameName" VARCHAR(256),
	CONSTRAINT "PK_Game" PRIMARY KEY ("GameId"),
	CONSTRAINT "Fk_Game_Player" FOREIGN KEY ("PlayerId") REFERENCES "Player"("PlayerId") ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO "Player"("PlayerId","FirstName","LastName","YearBorn") VALUES(1,'Tomáš','Hollý',2005);
INSERT INTO "Game"("PlayerId","GameId","GameName") VALUES(1,1,'ClashRoyale');

SELECT * FROM "Player"
SELECT * FROM "Game"

UPDATE "Player"
SET "PlayerId" = 2
WHERE "PlayerId" = 1;

