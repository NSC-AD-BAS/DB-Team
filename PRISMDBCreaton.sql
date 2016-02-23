/*
This script will clear and re-create the database with dummy data.
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

INSERT INTO Organizations (OrganizationId,  OrganizationName, YearlyReveune, NumOfEmployees, 
	URL, StreetAddressLineOne, StreetAddressLineTwo, City, State, Statement, Description)
VALUES 
(1, 'Casey\'s Card Store', 12500, 5, 'www.befantastic.com', '123 Fancy Lane', null, 'Seattle', 'Washington', NULL, 'We sell cards, and hire interns - because they work for very little money, and we like money.' ),
(2, 'Anne Guitar Shop', 9000000, 1, 'www.belikeanne.com', null, null, null, null, null, 'Play guitars like me, and be rich'),
(3, 'Grants Puppy Mill', 1000, 50, null, null, null, 'Phenoix', 'Arizona', null, 'Play guitars like me, and be rich'),
(4, 'Chris\' Customer PC', 1337000, 10, 'www.pcsbetterthandell.com', null, null, 'Seattle', 'Washington', null, 'We\'re better than dell and we know it.');

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
INSERT INTO Organization_Contacts (ContactId, OrganizationId, ContactName, OfficeNumber,
    OfficeExtension, CellNumber, EmailAddress, OfficeHours) 
VALUES 
(1, 1, 'Casey Riggin', '206-111-4521', null, null, 'casey.riggin@gmail.com', '5AM-10PM'),
(2, 1, 'Douglas Riggin', '206-111-4511', null, null, 'caseys.dad@gmail.com', '5AM-9PM'),
(3, 2, 'Anne LastName', null, null, '542-112-4424',null, '5AM-9PM'),
(4, 3, 'Grant', null, null, '541-231-1514', null, '1PM-5PM'),
(5, 4, 'Chris', '412-584-1235', null, '541-232-1514', 'chrispuppies@gmail.com', '1PM-5PM');


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
INSERT INTO Internships
(IntershipId, PositionTitle, Description, OrganizationId, LocationState,
 LocationZip, DatePosted, StartDate, EndDate, SlotsAvailable, LastUpdated)
 VALUES
 (1, 'Skilled Programmer', 'Write teh best code, we epecxt you to be the best intern ever.', 1, 'WA', '98177', '2016-01-05', '2016-01-06', '2016-01-25', 5, '2016-01-25 11:15:00'),
 (2, 'Code Writter Extordinare', 'We want better product - helps us make please', 1, 'CA', '13245', '2016-03-08', '2016-05-01', '2016-10-25', 5, '2016-10-25 23:10:13'),
 (3, 'Developer', 'We want to develop the existing code base to migrate between microsfot sql to mysql', 3, 'AL', '98711', '2016-01-05', '2016-01-06', '2016-01-25', 5, '2016-01-25 11:15:00'),
 (4, 'Jr Intern', 'We want coffee, but you writting code will be useful and all, so come on down!', 4, 'WA', '98133', '2016-01-05', '2016-01-06', '2016-01-25', 5, '2016-01-25 11:15:00');


CREATE TABLE UserTypes
(
	TypeId					INT				PRIMARY KEY			AUTO_INCREMENT,
    TypeName				VARCHAR(12)		UNIQUE				NOT NULL
);
INSERT INTO UserTypes
(TypeId, TypeName)
VALUES
(1, 'Student'),
(2, 'Admin'),
(3, 'Staff');

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
INSERT INTO Users
(UserId, FullName, ContactInfo, UserName, Password, TypeId)
VALUES
(1, 'Casey D Riggin', 'Call me anytime, 206-354-4512', 'cdriggin', 'asjhdsajhdsjhdsa', 1),
(2, 'Paul Morton', NULL, 'paul.m', 'asjhdsajhdsjhdsa', 1),
(3, 'Student #3', 'email me at killzer.player@gmail.com', 'bestevar.3', 'asjhdsajhdsjhdsa', 1),
(4, 'Terry Standfield', NULL,  'terrytheman', 'asjhdsajhdsjhdsa', 1),
(5, 'Micky Mouse', NULL, 'mickymouse', 'asjhdsajhdsjhdsa', 2),
(6, 'Bruce Wayne', 'With the bag signal please!', 'batmandimeanbruce', 'asjhdsajhdsjhdsa', 2),
(7, 'Nobody Speical', NULL , 'gary', 'asjhdsajhdsjhdsa', 3);

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
