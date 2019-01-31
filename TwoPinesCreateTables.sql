CREATE TABLE tbl_Physicians (
  EmployeeID int PRIMARY KEY NOT NULL,
  EmployeeName text NOT NULL,
  Title text NOT NULL,
); 

CREATE TABLE tbl_Departments (
  DepartmentID int PRIMARY KEY NOT NULL,
  DepartmentName text NOT NULL,
  DepartmentHead int NOT NULL FOREIGN KEY REFERENCES tbl_Physicians(EmployeeID)
);

CREATE TABLE tbl_Affiliations (
  Physician int NOT NULL FOREIGN KEY REFERENCES tbl_Physicians(EmployeeID),
  Department int NOT NULL FOREIGN KEY REFERENCES tbl_Departments(DepartmentID),
  PrimaryAffiliation bit NOT NULL,
  PRIMARY KEY(Physician, Department)
);

CREATE TABLE tbl_Procedures (
  ProcCode int PRIMARY KEY NOT NULL,
  ProcName text NOT NULL,
  ProcPrice money NOT NULL
);

CREATE TABLE tbl_HasTrainings (
  Physician int NOT NULL FOREIGN KEY REFERENCES tbl_Physicians(EmployeeID),
  Treatment int NOT NULL FOREIGN KEY REFERENCES tbl_Procedures(ProcCode),
  CertificationDate datetime NOT NULL,
  CertificationExpires datetime NOT NULL,
  PRIMARY KEY(Physician, Treatment)
);

CREATE TABLE tbl_Patients (
  PatientID int PRIMARY KEY NOT NULL,
  PatientName text NOT NULL,
  InsuranceID int NOT NULL,
  PCP int NOT NULL FOREIGN KEY REFERENCES tbl_Physicians(EmployeeID)
);

CREATE TABLE tbl_Nurses (
  EmployeeID int PRIMARY KEY NOT NULL,
  EmployeeName text NOT NULL,
  Title text NOT NULL,
);

CREATE TABLE tbl_Rooms (
  Number int PRIMARY KEY NOT NULL,
  Department int NOT NULL FOREIGN KEY REFERENCES tbl_Departments(DepartmentID),
);

CREATE TABLE tbl_Appointments (
  AppointmentID int PRIMARY KEY NOT NULL,
  Patient int NOT NULL FOREIGN KEY REFERENCES tbl_Patients(PatientID),
  AttendNurse int FOREIGN KEY REFERENCES tbl_Nurses(EmployeeID),
  AttendPhysician int NOT NULL FOREIGN KEY REFERENCES tbl_Physicians(EmployeeID),
  AppointStart datetime NOT NULL,
  AppointEnd datetime NOT NULL,
  ExaminationRoom int NOT NULL FOREIGN KEY REFERENCES tbl_Rooms(Number)
);

CREATE TABLE tbl_Medications (
  MedCode int PRIMARY KEY NOT NULL,
  MedName text NOT NULL,
  Brand text NOT NULL,
  MedDescrip text NOT NULL
);

CREATE TABLE tbl_Prescribes (
  Physician int NOT NULL FOREIGN KEY REFERENCES tbl_Physicians(EmployeeID),
  Patient int NOT NULL FOREIGN KEY REFERENCES tbl_Patients(PatientID),
  Medication int NOT NULL FOREIGN KEY REFERENCES tbl_Medications(MedCode),
  PrescribeDate datetime NOT NULL,
  Appointment int FOREIGN KEY REFERENCES tbl_Appointments(AppointmentID),
  Dose text NOT NULL,
  PRIMARY KEY(Physician, Patient, Medication, PrescribeDate)
);

CREATE TABLE tbl_OnCall (
  Nurse int NOT NULL FOREIGN KEY REFERENCES tbl_Nurses(EmployeeID),
  Room int NOT NULL FOREIGN KEY REFERENCES tbl_Rooms(Number),
  CallStart datetime NOT NULL,
  CallEnd datetime NOT NULL,
  PRIMARY KEY(Nurse, Room, CallStart, CallEnd)
);

CREATE TABLE tbl_Stays (
  StayID int PRIMARY KEY NOT NULL,
  Patient int NOT NULL FOREIGN KEY REFERENCES tbl_Patients(PatientID),
  Room int NOT NULL FOREIGN KEY REFERENCES tbl_Rooms(Number),
  StayStart datetime NOT NULL,
  StayEnd datetime NOT NULL
);

CREATE TABLE tbl_Treatments (
  Patient int NOT NULL FOREIGN KEY REFERENCES tbl_Patients(PatientID),
  PatientProc int NOT NULL FOREIGN KEY REFERENCES tbl_Procedures(ProcCode),
  Stay int NOT NULL FOREIGN KEY REFERENCES tbl_Stays(StayID),
  TreatDate datetime NOT NULL,
  Physician int NOT NULL FOREIGN KEY REFERENCES tbl_Physicians(EmployeeID),
  AttendNurse int FOREIGN KEY REFERENCES tbl_Nurses(EmployeeID),
  PRIMARY KEY(Patient, PatientProc, Stay, TreatDate)
);