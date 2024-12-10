-- SQL og Miljødata
-- Lav tabel for de forskellige miljoedata lokationer
create table hcmiljoedata (
	ID int auto_increment primary key,
    Starttid VARCHAR (14),
    co DECIMAL (2, 2) NOT NULL,
    no2 DECIMAL (2, 2) NOT NULL,
    nox DECIMAL (2, 2) NOT NULL, 
    so2 DECIMAL (2, 2),
    o3 DECIMAL (2, 2) NOT NULL, 
    pm10 DECIMAL (2, 2) NOT NULL, 
    pm25 DECIMAL (2, 2)
    
 );    

create table anholdtmiljoedata (
	ID int auto_increment primary key,
    Starttid VARCHAR (15),
    no2 DECIMAL (2, 2) NOT NULL,
    nox DECIMAL (2, 2) NOT NULL
);
CREATE TABLE aarhusmiljoedata (
	ID int auto_increment primary key,
    Starttid VARCHAR (16),
    co DECIMAL (5, 2) NOT NULL,
    no2 DECIMAL (5, 2) NOT NULL,
    nox DECIMAL (5, 2) NOT NULL, 
    pm10 DECIMAL (5, 2)
    
);
CREATE TABLE risoemiljoedata (
	ID int auto_increment primary key,
    Starttid VARCHAR (14) NOT NULL,
    co DECIMAL (2, 2), 
    no2 DECIMAL (2, 2),
    nox DECIMAL (2, 2),
    o3 DECIMAL (2, 2) NOT NULL,
    pm10 DECIMAL (2, 2) NOT NULL
);
