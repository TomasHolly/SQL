DROP TABLE IF EXISTS public."Customer" CASCADE;

CREATE TABLE IF NOT EXISTS public."Customer"
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
    CONSTRAINT "pk_Customer" PRIMARY KEY  ("CustomerId")
);

INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (1, N'Luís', N'Gonçalves', N'Embraer - Empresa Brasileira de Aeronáutica S.A.', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', N'+55 (12) 3923-5555', N'+55 (12) 3923-5566', N'luisg@embraer.com.br', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (2, N'Leonie', N'Köhler', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', N'+49 0711 2842222', N'leonekohler@surfeu.de', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (3, N'François', N'Tremblay', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', N'+1 (514) 721-4711', N'ftremblay@gmail.com', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (4, N'Bjørn', N'Hansen', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', N'+47 22 44 22 22', N'bjorn.hansen@yahoo.no', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (5, N'Frantiek', N'Wichterlová', N'JetBrains s.r.o.', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', N'+420 2 4172 5555', N'+420 2 4172 5555', N'frantisekw@jetbrains.com', 4);

-- UPDATE 
-- C.R.U.D (Create Read Update Delete)

SELECT *
FROM "Customer" ;

-- Zmena názvu tabuľky pomocou RENAME TO 
ALTER TABLE "Customer"
RENAME TO customer;

-- Zmena názvu stľpca 
ALTER TABLE customer  -- (mále c (customer) už sme menili názov tabuľky )
RENAME COLUMN "CustomerId" TO customer_id
ALTER TABLE customer 
RENAME COLUMN "FirstName" TO first_name;

SELECT *
FROM customer;

-- čo ak chceme zmeniť Meno a Priezvisko zakazníka, kde customer_id = 2 
UPDATE customer
SET "FirstName" = 'Lionel',
	"LastName" = 'Messi'
WHERE customer_id = 2;

UPDATE customer
SET "FirstName" = 'Lionel',
	"LastName" = 'Messi'
WHERE customer_id <= 2;

-- ako zisiť všetky názvy stľpcov 
SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'customer';

-- ako pridať stľpec
ALTER TABLE customer 
ADD COLUMN test_column VARCHAR(256);

-- čo ak pridať stľpec s nejakým Constraintom 

ALTER TABLE customer 
ADD COLUMN test_column_not_null VARCHAR(256)

UPDATE customer 
SET test_column_not_null = 'x'

ALTER TABLE customer
ALTER column test_column_not_null SET NOT NULL;

