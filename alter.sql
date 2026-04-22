Create Database LOGITpv24baas;

--ab kustutamine
DROP Database veebipood2;


USE LOGITpv24baas;
CREATE TABLE tootaja(
tootajaID int PRIMARY KEY identity(1,1), --identity - automaatselt kasvav arv +1
eesnimi varchar(15) not null,
perenimi varchar(30) not null,
synniaeg date,
aadress TEXT,
koormus int CHECK (koormus>0), --   piirang, et koormus >0
aktiivne bit);

--tabeli kuvamine
SELECT * FROM tootaja;

--andmete lisamine tabelisse
INSERT INTO tootaja(perenimi, eesnimi, synniaeg)
VALUES ('Ilus', 'Liis', '2002-12-4')

INSERT INTO tootaja
VALUES ('Katja', 'Punane', '2012-10-4', 'Tartu', 120, 1),
('Petja', 'Runane', '2002-10-4', 'Narva', 200, 0);

--andmete uuendamine tabelis
UPDATE tootaja SET aadress='Tallinn', koormus=10, aktiivne=1
WHERE tootajaID=1;

--tabeli strukturi muutmine
--1. uue veeru lisamine
ALTER TABLE tootaja ADD testVeerg int;
Select * from tootaja;
--2. veeru kustutamine
ALTER TABLE tootaja DROP COLUMN testVeerg;
--3. andmetüübi muutmine veerus
ALTER TABLE tootaja ALTER COLUMN testVeerg varchar(5);
--struktuuri kontrollimine 
sp_help tootaja;

--piirangute lisamine
CREATE TABLE ryhm(
ryhmId int not null,
ryhmNimi char(10));
DROP TABLE ryhm;
--muudame tabeli ja lisame piirang - primary key
ALTER TABLE ryhm ADD CONSTRAINT pr_ryhm PRIMARY KEY (ryhmId);

INSERT INTO ryhm
VALUES (2, 'LOGITpv24');
SELECT * from ryhm;
--lisame piirang unique
ALTER TABLE ryhm ADD CONSTRAIT un_ryhm UNIQUE (ryhmNimi);

--lisame uus veerg
ALTER TABLE ryhm ADD ryhmajuhataja int;
--lisame piirand Foreign Key
ALTER TABLE ryhm ADD CONSTRAINT fk_ryhm
FOREIGN KEY (ryhmajuhataja) References tootaja(tootajaId);
--kontrollimiseks
SELECT * from tootaja;
SELECT * from ryhm;
UPDATE ryhm SET ryhmajuhataja=8 WHERE ryhmNimi='LOGITpv24'


