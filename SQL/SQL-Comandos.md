<center><h1> Crear base de datos </h1></center>

```sql
CREATE DATABASE database_name;
```

<center><h1> Mostrar base de datos</center></h1> 

```sql
SHOW DATABASES;
```

<center><h1> Usar la base de datos</center></h1> 

```sql
USE database_name;
```

<center><h1> Borrar base de datos</center></h1> 

```sql
DROP DATABASE db_name;
```

<center><h1> Crear tabla</center></h1> 

```sql
-- Crea una tabla con nombre zentroa
CREATE TABLE zentroa (
	-- Columnas de la tabla
	kode_zentroa CHAR(4) NOT NULL,
	izena VARCHAR(30) NOT NULL,
	helbidea VARCHAR(30) NOT NULL,
	herria VARCHAR(20) NOT NULL,
	
	-- Declaracion clave primaria
	PRIMARY KEY (kode_zentroa)
);
```

**CHAR**                = *Carácter corto*
**VARCHAR**          = *Carácter largo*
**NOT NULL**         = *No se puede dejar vacío*
**PRIMARY KEY**   = *Clave primaria esta se usa para hacer las relaciones entre tablas*

<center><h1>Consultas</center></h1>

<h3 style="text-align: justify;">Consultar todos los elementos de una tabla</h3>

```sql
-- "*" selecciona todos los elementos de la tabla
SELECT * FROM zentroa;
```

<h3 style="text-align: justify;">Seleccionar el código de los trabajadores que tengan hijos</h3>

```sql
SELECT seme_alaba.kode_langilea FROM seme_alaba;
```

<h3 style="text-align: justify;">Seleccionar el código de planta y si repetir de los trabajadores que entraron a trabajar en 92/01/01</h3>

```sql
SELECT langilea.kode_alorra FROM langilea GROUP BY langilea.data_noiz_hasi;
```

<h3 style="text-align: justify;">Sacar el nombre de los trabajadores que no tienen teléfono</h3>

```sql
SELECT langilea.telf FROM langilea WHERE langilea.telf="";
```

<h3 style="text-align: justify;"> Selecciona el nombre de las plantas que tengan el código DIGE y FAZS</h3>

```sql
SELECT alorra.kodigo_zentroa FROM alorra WHERE alorra.kodigo_zentroa="DIGE" AND alorra.kodigo_zentroa="FAZS";
```
<h3 style="text-align: justify;">Selecciona el nombre y el sueldo de los trabajadores que ganan menos de 200000 y mas de 5000000</h3>

```sql
SELECT langilea.izena, langilea.soldata FROM langilea WHERE langilea.soldata < 2000000 OR langilea.soldata > 5000000;
```

<h3 style="text-align: justify;">Selecciona el código y nombre de los trabajadores que su código no sea 1,4,6,8 o 10</h3>

```sql
SELECT langilea.kode_langile, langilea.izena FROM langilea WHERE langilea.kodea_langile NOT IN ('1','4','6','8','10');
```

<h3 style="text-align: justify;">Selecciona el nombre y el día de nacimientos de los hijos que en su apellido contengan la palabra "LEON"</h3>

```sql
SELECT seme_alaba.izena, seme_alaba.jaiotze_data FROM seme_alaba WHERE seme_alaba.izena LIKE '%LEON%';
```

<h3 style="text-align: justify;">Selecciona el nombre y sueldo de los trabajadores que lleven en la empresa desde antes de 1985 y ganen menos de 4000000</h3>

```sql
SELECT langilea.izena, langilea.soldata FROM langilea WHERE NOT langilea.data_noiz_hasi > '%1985' AND langilea.soldata < "4000000";
```

<h3 style="text-align: justify;">Selecciona los trabajadores que su NIF acabe por D o V y también tienen que estar en la planta IN&DI y DIRGE ganando mas de 5000000 o haber sido contratado en 1994</h3>

```sql
SELECT langilea.izena, langilea.nif FROM langilea WHERE YEAR (langilea.data_noiz_hasi = '1994') OR ((langilea.nif = '%D' AND langilea.nif = "%V") AND (langilea.kode_alorra = 'IN&DI' AND langilea.kode_alorra = 'DIRGE') AND langilea.soldata >= 5000000 );
```

<h3 style="text-align: justify;"> Selecciona el nombre, código y las cuentas de la planta y ordena de mayor a menor</h3>

```sql
SELECT alorra.izena, alorra.kode_alorra, alorra.aurrekontua FROM alorra ORDER BY alorra.aurrekontua DESC;
```

<h3 style="text-align: justify;"> Extraer el código, nombre, presupuesto y centro de las áreas con presupuesto superior a 14000000. Clasifique la información por centro y si es la misma de mayor a menor según presupuesto. </h3>

```sql
SELECT alorra.izena, alorra.kode_alorra, alorra.aurrekontua, zentroa.izena FROM alorra INNER JOIN zentroa ON alorra.kode_langilea = zentroa.kode_langilea WHERE alorra.aurrekontua > 14000000 ORDER BY (zentroa.izena OR alorra.aurrekontua ASC); 
```

<h3 style="text-align: justify;">Crea un punto de vista con el nombre de trebetasuna2. Este enfoque tendrá todos los campos de la tabla de trebetasuna pero sólo con registros cuyo código de trebetasuna sea superior a M.</h3>

```sql
CREATE VIEW trebetasunak2 AS SELECT * FROM trebetasunak WHERE trebetasunak.kodea > 'M';
```

<h3 style="text-align: justify;">Insertar en el el punto devista trebetasuna2 los siguientes datos ('INF', 'INFORMATIKA') y ('Zuz', 'ZUZENDARITZA')</h3>

```sql
INSERT INTO trebetasunak2 (kodea, azalpena) VALUES ('INF', 'INFORMATIKA'), ('ZUZ', 'ZUZENDARITZA');
```

<h3 style="text-align: justify;">Comprueba si los datos que has introducido en el ejercicio anterior se ven a través del punto de vista trebetasuna2.</h3>

```sql
SELECT * FROM trebetasunak2;
```

<h3 style="text-align: justify;">Utilizando el punto de vista anterior, cambia el código de trebetasuna en ambos casos: INF-->INFO y zuz-->ZUZE.</h3>

```sql
UPDATE trebetasunak2 SET azalpena = 'INFO', azalpena = 'ZUZE' WHERE azalpena = 'INF' OR azalpena = "ZUZ";
```

<h3 style="text-align: justify;">Comprobar si se han realizado las modificaciones anteriores.</h3>

```sql
SELECT trebetasunak2.azalpena FROM trebetasunak2;
```

<h3 style="text-align: justify;">Utilizando el punto de vista Trebetasunak2, eliminar los datos que hemos introducido (INFO Y ZUZE). ¿Se han eliminado ambas?, ¿por qué?</h3>

```sql
DELETE FROM trebetasunak2 WHERE trebetasunak2.azalpena = 'INFO' OR trebetasunak2.azalpena = 'ZUZE';
```

<h3 style="text-align: justify;">Borra el punto de vista trebetasunak2. </h3>

```sql
DROP VIEW trebetasunak2;
```

<h3 style="text-align: justify;"> Crea un nuevo punto de vista  con el nombre de directores. Comprende los siguientes campos: código (código del director), nombre (nombre del director), área (nombre del área), dinero (salario) y localidad (lugar del trabajo), pero sólo incluiremos al personal que sea director de áreas o director de centros. (o ambos) </h3>

```sql
CREATE VIEW zuzendariak (kodea, izena, alorra, dirua, herria) AS SELECT langilea.kode_langilea, langilea.langilea_izena, alorra.izena, langilea.soldata, zentroa.herria FROM ((langilea INNER JOIN alorra ON langilea.kode_alorra = alorra.kode_alorra)(alorra INNER JOIN zentroa ON alorra.kode_zentroa = zentroa.kode_zentroa)) WHERE (alorra.kode_langilea = langilea.kode_alorra) OR (zentroa.kode_langilea = langilea.kode_langilea);
```

<h3 style="text-align: justify;">Compruebe que el resultado del ejercicio anterior es de 1,2,6,9,5,3.</h3>

```sql
SELECT * FROM zuzendariak WHERE kodea IN (1,2,6,9,5,3);
```

<h3 style="text-align: justify;"> Utilizando el punto de vista de directores, extrae el código de directores, el nombre y los nombres de sus hijos. Clasifique la información por el nombre del director y si es igual, por el nombre del hijo. </h3>

```sql
SELECT zuzendariak.kodea, zuzendariak.izena, seme_alaba.izena FROM zuzendariak JOIN seme_alaba ON zuzendariak.kodea = seme_alaba.langile_koda WHERE ORDER BY (zuzendariak.izena OR seme_alaba.izena);
```

<center><h1> Base de Datos Completa</center></h1>

```sql
CREATE TABLE bezeroa (
	BezeroarenID INT NOT NULL AUTO_INCREMENT,
	Telefono CHAR(9) NOT NULL,
	Izena VARCHAR(50) NOT NULL,
	Abizena VARCHAR(25) NOT NULL,
	Enpresaren_Izena VARCHAR(25) NOT NULL,
	Email VARCHAR(60) NOT NULL,
	Helbidea VARCHAR(255) NOT NULL,
	PRIMARY KEY (BezeroarenID)
);

INSERT INTO bezeroa 
(Telefono, Izena, Abizena, Enpresaren_Izena, Email, Helbidea) 
VALUES 
('123456789', 'Juan', 'Martinez', 'Indar', 'juanmar@indar.es', 'Laredo 3'),
('123456788', 'Pako', 'Mirlan', 'Indra', 'Pako@indra.es', 'Bilson 4');

CREATE TABLE salmentak (
	SalmentenID CHAR(4) NOT NULL,
	Faktura_Zenbakia CHAR(4) NOT NULL,
	Salmenta_Data DATE NOT NULL,
	Kantitatea INT NOT NULL,
	BezeroarenID INT NOT NULL,
	PRIMARY KEY (SalmentenID),
	FOREIGN KEY (BezeroarenID) REFERENCES bezeroa(BezeroarenID)
);

INSERT INTO salmentak
(SalmentenID, Faktura_Zenbakia, Salmenta_Data, Kantitatea, BezeroarenID)
VALUES
('AB12', '213A', '2024/02/18', 100, 1),
('AB13', '214A', '2024/03/20', 50, 2);

CREATE TABLE produktuak (
	ProduktuarenID INT NOT NULL AUTO_INCREMENT,
	Stock_Kantitatea INT NOT NULL,
	Produktuaren_Izena VARCHAR(50),
	Prezioa INT NOT NULL,
	PRIMARY KEY (ProduktuarenID)
);

INSERT INTO produktuak
(Stock_Kantitatea, Produktuaren_Izena, Prezioa)
VALUES
(200, 'Ordenagailua', 35),
(125, 'Arratoia', 23);

CREATE TABLE eduki (
	SalmentarenID CHAR(4) NOT NULL,
	ProduktuarenID INT NOT NULL,
	PRIMARY KEY (SalmentarenID, ProduktuarenID),
	FOREIGN KEY (SalmentarenID) REFERENCES salmentak(SalmentenID),
	FOREIGN KEY (ProduktuarenID) REFERENCES produktuak(ProduktuarenID)
);

INSERT INTO eduki
(SalmentarenID, ProduktuarenID) 
VALUES 
('AB12', 1),
('AB13', 2);

CREATE TABLE dendak (
	DendarenID INT NOT NULL AUTO_INCREMENT,
	Email VARCHAR(60) NOT NULL,
	Fakturazioa VARCHAR(40) NOT NULL,
	MOTAK VARCHAR(40) NOT NULL,
	PRIMARY KEY (DendarenID)
);

INSERT INTO dendak 
(Email, Fakturazioa, MOTAK)
VALUES
('iguan@proton.me', 'TOF34','FISIKO'),
('iguan@proton.me', 'TOF35','ONLINE');

CREATE TABLE hornitu (
	ProduktuarenID INT NOT NULL,
	DendarenID INT NOT NULL,
	PRIMARY KEY (ProduktuarenID, DendarenID),
	FOREIGN KEY (ProduktuarenID) REFERENCES produktuak(ProduktuarenID),
	FOREIGN KEY (DendarenID) REFERENCES dendak(DendarenID)
);

INSERT INTO hornitu
(ProduktuarenID, DendarenID)
VALUES
(1, 1),
(2, 2);

CREATE TABLE fisiko (
	DendarenID INT NOT NULL,
	Kokapena VARCHAR(30) NOT NULL,
	PRIMARY KEY (DendarenID),
	FOREIGN KEY (DendarenID) REFERENCES dendak(DendarenID)
);

INSERT INTO fisiko
(DendarenID, Kokapena)
VALUES
(1, 'Bilbo'),
(2, 'Donostia');

CREATE TABLE online (
	DendarenID INT NOT NULL,
	URL VARCHAR(255) NOT NULL,
	PRIMARY KEY (DendarenID),
	FOREIGN KEY (DendarenID) REFERENCES dendak(DendarenID)
);

INSERT INTO online
(DendarenID, URL)
VALUES
(1, 'https://local.com/'),
(2, 'https://localbi.es/');
```

<center><h1> Consultas </center></h1>

```sql
--------------------- #1 ---------------------
SELECT bezeroa.Izena, bezeroa.Abizena, salmentak.SalmentenID, salmentak.Faktura_Zenbakia, salmentak.Salmenta_Data, salmentak.Kantitatea FROM bezeroa JOIN salmentak ON bezeroa.BezeroarenID = salmentak.BezeroarenID;

--------------------- #2 ---------------------
SELECT produktuak.Produktuaren_Izena, COUNT(eduki.SalmentarenID) AS Zenbat_Salduta FROM produktuak JOIN eduki ON produktuak.ProduktuarenID = eduki.ProduktuarenID GROUP BY produktuak.Produktuaren_Izena;

--------------------- #3 ---------------------
SELECT Salmenta_Data, AVG(Kantitatea) AS Bataz_bestekoa FROM salmentak GROUP BY Salmenta_Data;

--------------------- #4 ---------------------
SELECT bezeroa.Izena, bezeroa.Abizena, COUNT(salmentak.SalmentenID) AS Totala FROM bezeroa JOIN salmentak ON bezeroa.BezeroarenID = salmentak.BezeroarenID GROUP BY bezeroa.Izena, bezeroa.Abizena HAVING COUNT(salmentak.SalmentenID) > 1;

--------------------- #5 ---------------------
SELECT Produktuaren_Izena, SUM(Stock_Kantitatea) AS Stoka FROM produktuak GROUP BY Produktuaren_Izena;
```

<center><h1>Crear usuario</center></h1>

```mysql
/* Crear usuario con contraseña */
CREATE USER pako@localhost IDENTIFIED BY 'password';

/* Dar privilegios al usuario */
GRANT SELECT, INSERT ON dbName.TableName TO pako@localhost;

/* Dar todos los privilegios al usuario */
GRANT ALL PRIVILEGES ON dbName.* TO pako@localhost;

/* Aplicar permisos */
FLUSH PRIVILEGES;

/* Quitar permisos al usuario */
REVOKE SELECT ON dbName.* TO pako@localhost;

/* Borrar usuario */
DROP USER pako@localhost;
```

<center><h1>Exportar y recuperar base de datos</center></h1>

```mysql
/* Exportar DB */
mysqldump -u root -p mi_base_de_datos > mi_base_de_datos_backup.sql

/* Importar BD */
mysql -u root -p mi_base_de_datos < mi_base_de_datos_backup.sql
```

<center><h1>Ejecutar Script SQL</center></h1>

```mysql
SOURCE C:\Users\%username%\Desktop\script.sql;
```


<center><h1>Ejercicios sueltos </center></h1>

```sql
/* Crear base de datos */
CREATE DATABASE liburutegia;

/* Interactuar base de datos */
USE liburutegia;

/* Crear tablas */
CREATE TABLE idazleak (
    idazle_nan CHAR(8) NOT NULL,
    izena VARCHAR(50) NOT NULL,
    abizena VARCHAR(50) NOT NULL,
    helbidea VARCHAR(90) NOT NULL,
    herria VARCHAR(50) NOT NULL,
    telefono CHAR(9) NOT NULL,
    adina INT NOT NULL,
    sariak VARCHAR(150) NOT NULL,
    soldata INT NOT NULL,
    PRIMARY KEY (idazle_nan)
    );

CREATE TABLE liburuak(
    liburu_kodea INT AUTO_INCREMENT NOT NULL,
    izenburua VARCHAR(50) NOT NULL,
    prezioa INT NOT NULL,
    euzkeraz_idatzita CHAR(3) NOT NULL,
    argitalkodea char(1) NOT NULL,
    nan char(8) NOT NULL,
    PRIMARY KEY (liburu_kodea),
    FOREIGN KEY (nan) REFERENCES idazleak(idazle_nan)
    /* Actualizar en caso de cambien en la clave principal de idazleak */
    ON UPDATE CASCADE
    ON DELETE CASCADE
    );
```

```sql
CREATE TABLE PAKO (
    id INT NoT NULL,
      name CHAR(3),
      id_dos INT NOT NULL,
      PRIMARY KEY (id)
);

/* Añadir un clave foranea a una tabla */
ALTER TABLE PAKO
ADD FOREIGN KEY (id_dos) REFERENCES table_dos(id_dos);
```

```sql
/* Seleccionar todos los que nacieron en 2010 */
SELECT * FROM patients WHERE YEAR(born_date) = 2010;

/* Evitar repeticiones */
SELECT DISTINCT name FROM users;
```

```sql
/* Actualizar datos */
UPDATE tableName
SET name='pako'
WHERE name LIKE 'A%' OR 'B%';

/* Actualizar varias tablas en una consulta */
UPDATE TableName1
INNER JOIN TableName2 ON TableName1.table_id = TableName2.table_id
SET TableName1.name = 'pako', TableName2.salary = '1500'
WHERE TableName1.name Like '%X%' AND TableName2.salary = 1000; 
```

```sql
/* Añadir una columna a la tabla */
ALTER TABLE tableName
ADD newColumn varchar(21);

/* Borrar una columna a la tabla */
ALTER TABLE tableName
DROP newColumn;

/* Añadir un clave foranea a una tabla */
ALTER TABLE pako
ADD FOREIGN KEY (id_dos) REFERENCES table_dos(id_dos);

/* Modificar una tabla */
ALTER TABLE pako
MODIFY name VARCHAR(20) Not NULL;
```

```sql
/* Iniciar sesion */
mysql -u root -p 

/* Iniciar sesion desde la consola MySQL*/
system mysql -u root -p
```

```sql
/* Borrar tabla */
DROP TABLE pako;

/* Borrar base de datos */
DROP DATABASE users;
```

```sql
/* Borrar todos los datos de una tabla */
DELETE FROM TableName;

/* Borrar datos concretos */
DELETE FROM TableName WHERE name='pako';

/* Borrar de forma mas compleja */
DELETE FROM TableName WHERE name LIKE 'B%' AND height BETWEEN 100 AND 150;
```

```sql
SELECT patients.first_name, patients.last_name, admissions.diagnosis
FROM patients INNER JOIN admissions On admissions.patient_id = patients.patient_id 
WHERE admissions.diagnosis LIKE 'A%' AND ( /* Subconsultas */
  SELECT MAX(patients.weight) as max_size
  FROM patients);
```

```sql
CREATE VIEW nombre_view AS
SELECT * FROM tabla_datos
/* Si quieres puede hacer un 'WHERE' para seleccionar mas especifico */
WHERE tabla_datos.nombre LIKE 'A%' AND tabla_datos.id NOT IN (1,2,3,4,20) AND tabla_datos.sueldo BETWEEN 1000 AND 2000;
```

```sql
/* Cargar datos desde un TXT o CSV */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/langilea.txt'
INTO TABLE langilea
LINES TERMINATED BY '\r\n';
```

```sql
/* Insertar datos en una tabla */
INSERT INTO nombre_tabla (columna1, columna2) 
VALUE (valor1, valor2), (valor1, valor2);
```

```sql
/* Consulta usando un poco de todo */
SELECT patients.first_name, patients.last_name, admissions.diagnosis, patients.weight
FROM patients
INNER JOIN admissions ON admissions.patient_id = patients.patient_id
WHERE admissions.diagnosis LIKE 'A%' AND patients.weight BETWEEN 90 AnD 100
GROUP BY ( patients.first_name)
ORDER BY ( patients.weight ) DESC;
```

```sql

CREATE DATABASES liburutegia;

USE liburutegia;

CREATE TABLE idazleak (
idazle_nan CHAR(8) NOT NULL, 
izena VARCHAR(50) NOT NULL, 
abizena VARCHAR(50) NOT NULL, 
helbidea VARCHAR(80) NOT NULL, 
herria VARCHAR(35) NOT NULL, 
telefonoa VARCHAR(9) NOT NULL, 
adina INT NOT NULL, 
sariak VARCHAR(60) NOT NULL, 
soldata INT NOT NULL,
PRIMARY KEY (idazle_nan));

CREATE TABLE liburuak (
liburu_kodea INT AUTO_INCREMENT NOT NULL,
izenburua VARCHAR(80) NOT NULL,
prezioa INT NOT NULL,
euskeraz_idatzita CHAR(3) NOT NULL,
argital_kodea CHAR(2) NOT NULL,
nan CHAR(8) NOT NULL,
PRIMARY KEY (liburu_kodea),
FOREIGN KEY (nan) REFERENCES idazleak(idazle_nan));

INSERT INTO idazleak (izena, abizena, helbidea, herria, telefonoa, adina, sariak, soldata) VALUES
('724353216', 'Bernardo', 'Atxaga', 'Nagusia 6, 3.A', 'Tolosa', '943671520', 45, 'Donostiko saria', 2400),
('78453235', 'Graharn', 'Greene', 'Man street 15', 'Londres', '917564378', 67, 'Londreseko saria', 3100);

INSER INTO liburuak (izenburua, prezioa, euskeraz_idatzita, argital_kodea, nan) VALUES
('Ababakoak', 18, 'BAI', '1', '724353216'),
('El tren de estambul', 12, 'EZ', '2', '78453235'),
('El factor humano', 18, 'EZ', '2', '78453235'),
('Soinujolearen semea', 9, 'BAI', '1', '724353216');

-- Coge el sueldo mas alto que la media

SELECT * FROM idazleak WHERE soldata > (
SELECT AVG(soldata) FROM idazleak);

-- Coge la media de edad de todos los escritores

SELECT AVG(adina) AS media_de_edad FROM idazleak;

-- Selecciona la cantidad de libros por precios

SELECT prezioa, COUNT(*) AS Liburuak FROM liburuak GROUP BY (prezioa);

-- Borra todos los libros que no esten escritos en euskera

DELETE * FROM liburuak WHERE euskeraz_idatzia = 'EZ';

-- Coge informacion de los autores y los libros que ha escrito

SELECT idazleak.*, liburuak.izenburua 
FROM idazleak INNER JOIN liburuak ON idazleak.idazle_nan = liburuak.nan;

-- Crear dos usuarios con diferentes permisos

CREATE USER koldo@localhost IDENTIFIED BY 'koldo';

GRANT ALL PRIVILEGES ON *.* TO koldo@localhost;

FLUSH PRIVILEGES;

CREATE USER miren@localhost IDENTIFIED BY 'miren';

GRANT DELETE, UPDATE ON *.* TO miren@localhost;

FLUSH PRIVILEGES;

-- Crea un punto de vista en el que aparezca informacion del escritor

CREATE VIEW kon_ikuspegia_idazleak AS
SELECT idazle_nan, izena, abizena 
FROM idazleak; 
```
