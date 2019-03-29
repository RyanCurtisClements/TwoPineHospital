USE db_TwoPinesHospital;

CREATE TABLE staff_type (
	[type_id] INT PRIMARY KEY,
	[type_name] VARCHAR(30) NOT NULL
	)

CREATE TABLE staff (
	id INT IDENTITY(1,1) PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	staff_type INT FOREIGN KEY REFERENCES staff_type([type_id]) NOT NULL,
	rank_title VARCHAR(30) NOT NULL,
	ability_stars INT NOT NULL,
	experience INT NOT NULL,
	qualifications INT NOT NULL,
	training_slot INT NOT NULL,
	salary INT NOT NULL,
	happiness INT,
	energy INT,
	feelings VARCHAR(200),
	traits VARCHAR(200)
	)

CREATE TABLE room_descrip (
	[type_id] INT PRIMARY KEY,
	[type_name] VARCHAR(30) NOT NULL,
	[room_name] VARCHAR(30) NOT NULL
	)

CREATE TABLE room (
	room_number INT IDENTITY(101,1) PRIMARY KEY,
	[type] INT FOREIGN KEY REFERENCES room_descrip([type_id]) NOT NULL,
	)

CREATE TABLE status (
	status_id INT PRIMARY KEY,
	status_desc VARCHAR(100) NOT NULL
	)

CREATE TABLE patient (
	id INT IDENTITY(1,1) PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	treatment_stage INT FOREIGN KEY REFERENCES status(status_id) NOT NULL,
	diagnosis VARCHAR(50),
	thirst INT,
	hunger INT,
	toilet INT,
	boredom INT,
	comfort INT,
	hygiene INT,
	attractiveness INT,
	temperature INT,
	feelings VARCHAR(200),
	traits VARCHAR(200)
	)

CREATE TABLE stay (
	id INT IDENTITY(1,1) PRIMARY KEY,
	room INT FOREIGN KEY REFERENCES room(room_number) NOT NULL,
	patient INT FOREIGN KEY REFERENCES patient(id) NOT NULL,
	[start_date] DATETIME NOT NULL,
	end_date DATETIME
	)

CREATE TABLE illness (
	id INT IDENTITY(1,1) PRIMARY KEY,
	[name] VARCHAR(30) NOT NULL,
	treatment_cost DECIMAL NOT NULL,
	treated_at INT FOREIGN KEY REFERENCES room_descrip([type_id]),
	treated_by INT FOREIGN KEY REFERENCES staff_type([type_id])
	)

CREATE TABLE appointment (
	id INT IDENTITY(1,1) PRIMARY KEY,
	staff_on_call INT FOREIGN KEY REFERENCES staff(id),
	patient INT FOREIGN KEY REFERENCES patient(id),
	room_used INT FOREIGN KEY REFERENCES room(room_number),
	cost DECIMAL DEFAULT 50
	)