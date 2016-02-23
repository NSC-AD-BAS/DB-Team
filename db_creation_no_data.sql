/*
This script will clear and re-create the database with no dummy data.
*/

DROP DATABASE IF EXISTS prism;
CREATE DATABASE prism;
USE prism;

CREATE TABLE Organizations
(
	OrganizationId			INT				PRIMARY KEY 		AUTO_INCREMENT,
    OrganizationName		VARCHAR(100)	UNIQUE				NOT NULL,
    YearlyReveune			INT				NULL,
    NumOfEmployees			INT				NULL,
	URL						VARCHAR(250)	NULL,
    StreetAddressLineOne	VARCHAR(250)	NULL,
    StreetAddressLineTwo	VARCHAR(250)	NULL,
    City					VARCHAR(250)	NULL,
    State					VARCHAR(250)	NULL,
    Statement				VARCHAR(250)	NULL,
	Description 			TEXT			NOT NULL
);


CREATE TABLE Organization_Contacts
(
	ContactId				INT				PRIMARY KEY			AUTO_INCREMENT,
    OrganizationId			INT				NOT NULL,
    ContactName				VARCHAR(100)	NOT NULL,
    OfficeNumber			VARCHAR(12),
    OfficeExtension			VARCHAR(10),
	CellNumber				VARCHAR(12),
    EmailAddress			VARCHAR(100),
    OfficeHours				VARCHAR(10), 
	CONSTRAINT Organization_Contact_fk_OrganizationId
		FOREIGN KEY (OrganizationId)
        REFERENCES Organizations(OrganizationId)
);


CREATE TABLE Internships
(
	IntershipId 			INT				PRIMARY KEY			AUTO_INCREMENT,
    PositionTitle			VARCHAR(100)	NOT NULL,
	Description				TEXT			NOT NULL,
    OrganizationId			INT				NOT NULL,
    LocationState			VARCHAR(250)	NOT NULL,
    LocationZip				VARCHAR(10)		NOT NULL,
    DatePosted				DATE			NOT NULL,
	StartDate				DATE			NOT NULL,
    EndDate					DATE			NOT NULL,
    SlotsAvailable			INT				NOT NULL,
    LastUpdated				DATETIME		NOT NULL,
	CONSTRAINT Internship_fk_OrganizationId
		FOREIGN KEY (OrganizationId)
        REFERENCES Organizations(OrganizationId)
);

CREATE TABLE UserTypes
(
	TypeId					INT				PRIMARY KEY			AUTO_INCREMENT,
    TypeName				VARCHAR(12)		UNIQUE				NOT NULL
);


CREATE TABLE Users
(
	UserId					INT				PRIMARY KEY			AUTO_INCREMENT,
    FullName				VARCHAR(250)	UNIQUE				NOT NULL,
    ContactInfo				TEXT			NULL,
    UserName				VARCHAR(250)	NOT NULL			UNIQUE,
    Password				VARCHAR(500)	NOT NULL,
    TypeId					INT				NOT NULL,
	CONSTRAINT User_fk_TypeId
		FOREIGN KEY (TypeId)
        REFERENCES UserTypes(TypeId)
);


CREATE TABLE Students
(
	StudentId				INT 			PRIMARY KEY			AUTO_INCREMENT, 
    ProgramStatus			VARCHAR(12)		NOT NULL,
	IntershipId 			INT				NULL,
	Cohort					INT				NOT NULL,
    UserId					INT				UNIQUE 				NOT NULL,
	StreetAddressLineOne	VARCHAR(250)	NULL,
    StreetAddressLineTwo	VARCHAR(250)	NULL,
    City					VARCHAR(250)	NULL,
    State					VARCHAR(250)	NULL,
	CONSTRAINT Student_fk_IntershipId
		FOREIGN KEY (StudentId)
        REFERENCES Internships(IntershipId),
	CONSTRAINT Student_fk_UserId
		FOREIGN KEY (UserId)
        REFERENCES Users(UserId)
);

CREATE TABLE Student_Interships
(
	IntershipId 			INT				NOT NULL,
	StudentId				INT 			NOT NULL,
	CONSTRAINT Student_Intership_fk_IntershipId
		FOREIGN KEY (IntershipId)
        REFERENCES Internships(IntershipId),
	CONSTRAINT Student_Intership_fk_StudentId
		FOREIGN KEY (StudentId)
        REFERENCES Students(StudentId)
);

CREATE TABLE Student_Contact_Log
(
	Student_Contact_LogId	INT 			PRIMARY KEY			AUTO_INCREMENT, 
    StudentId				INT 			NOT NULL,
    LogTime					TIMESTAMP		NOT NULL			
	DEFAULT CURRENT_TIMESTAMP  		ON UPDATE CURRENT_TIMESTAMP,
    Notes					TEXT			NOT NULL,
	UserId					INT				NOT NULL,
	CONSTRAINT Student_Contact_Log_fk_StudentId
		FOREIGN KEY (StudentId)
        REFERENCES Students(StudentId),
	CONSTRAINT Student_Contact_Log_fk_UserId
		FOREIGN KEY (UserId)
        REFERENCES Users(UserId)
);


CREATE TABLE Change_Log
(
	Change_LogId			INT 			PRIMARY KEY			AUTO_INCREMENT, 
    LogTime					TIMESTAMP		NOT NULL			
	DEFAULT CURRENT_TIMESTAMP  		ON UPDATE CURRENT_TIMESTAMP,
    UserId					INT				NOT NULL,
    Message					TEXT			NOT NULL,
	CONSTRAINT Change_Log_fk_UserId
		FOREIGN KEY (UserId)
        REFERENCES Users(UserId)
);


CREATE TABLE User_Notes
(
	User_NoteId				INT 			PRIMARY KEY			AUTO_INCREMENT, 
	UserId					INT				NOT NULL,
	Note_Type				VARCHAR(100)	NOT NULL,
    Note_Text				TEXT			NOT NULL,
	CONSTRAINT User_Note_Log_fk_UserId
		FOREIGN KEY (UserId)
        REFERENCES Users(UserId)
);
