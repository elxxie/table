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


--
  
--4 tables
Use LOGITpv24baas;

--Category (idCategory, Category_Name)
CREATE Table Category(
idCategoty int PRIMARY KEY identity(1,1),
Category_Name varchar(10));
Insert into Category
values ('mööbel')
select * from Category;
ALTER TABLE Category ADD CONSTRAIT Category_Name UNIQUE (Category_Name);
Drop table category;

--Product
Create table Product(
idProduct int primary key identity(1,1), 
Name varchar(10), 
idCategory int, foreign key (idCategory) references Category (idCategory),
Price money)
drop table Product

--täidame tabeli
Insert into Product
values ('vood', 1, 3, 70) 
select * from Product;

--table sale
create table Sale(
idSale int primary key identity(1,1), 
idProduct int,  
idCustomer int,
foreign key (idProduct) references Product (idProduct),
Count int, 
Date_of_sale date)
drop table sale 

--table customer
create table Customer(
idCustomer int primary key identity (1,1),
Name varchar(15),
Contact varchar(15))
drop table Customer

--lisame piirang foreign key
ALTER TABLE sale ADD CONSTRAINT fk_sale
FOREIGN KEY (idCustomer) References Customer (idCustomer);

--täidame sale
insert into Sale 
values (2, 3, 7, '105-308')
select * from Sale;

--täidame customer
insert into Customer
values ('Liis', '477 988')
select * from Customer


