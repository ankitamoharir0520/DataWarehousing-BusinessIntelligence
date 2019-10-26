--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Chinook_Dimensional_Model.DM1
--
-- Date Created : Sunday, September 22, 2019 23:42:43
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: Dim_Album 
--

CREATE TABLE Dim_Album(
    AlbumID      INT                      NOT NULL,
    Title        NATIONAL VARCHAR(160),
    Artist_Id    INT                      NOT NULL,
    PRIMARY KEY (AlbumID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Artist 
--

CREATE TABLE Dim_Artist(
    Artist_Id     INT                      NOT NULL,
    ArtistName    NATIONAL VARCHAR(120),
    PRIMARY KEY (Artist_Id)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Customer 
--

CREATE TABLE Dim_Customer(
    CustomerID     INT                     NOT NULL,
    FirstName      NATIONAL VARCHAR(40),
    LastName       NATIONAL VARCHAR(20),
    Company        NATIONAL VARCHAR(80),
    Phone          NATIONAL VARCHAR(24),
    Email          NATIONAL VARCHAR(60),
    GeographyID    INT                     NOT NULL,
    EmployeeID     INT                     NOT NULL,
    PRIMARY KEY (CustomerID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Date 
--

CREATE TABLE Dim_Date(
    FullDate    DATETIME    NOT NULL,
    PRIMARY KEY (FullDate)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Employee 
--

CREATE TABLE Dim_Employee(
    EmployeeID     INT                     NOT NULL,
    ReportsTo      INT                     NOT NULL,
    FirstName      NATIONAL VARCHAR(20),
    LastName       NATIONAL VARCHAR(20),
    Title          NATIONAL VARCHAR(30),
    Birthdate      DATETIME,
    Hiredate       DATETIME,
    Address        NATIONAL VARCHAR(70),
    Phone          NATIONAL VARCHAR(24),
    Fax            NATIONAL VARCHAR(24),
    Email          NATIONAL VARCHAR(60),
    GeographyID    INT                     NOT NULL,
    PRIMARY KEY (EmployeeID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Genre 
--

CREATE TABLE Dim_Genre(
    GenreID    INT                      NOT NULL,
    Name       NATIONAL VARCHAR(120),
    PRIMARY KEY (GenreID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Geography 
--

CREATE TABLE Dim_Geography(
    GeographyID    INT                     NOT NULL,
    City           NATIONAL VARCHAR(40),
    State          NATIONAL VARCHAR(40),
    Country        NATIONAL VARCHAR(40),
    PostalCode     NATIONAL VARCHAR(10),
    PRIMARY KEY (GeographyID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_InvoiceLine 
--

CREATE TABLE Dim_InvoiceLine(
    InvoiceLineID    INT               NOT NULL,
    UnitePrice       DECIMAL(10, 2),
    Quantity         INT,
    PRIMARY KEY (InvoiceLineID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_MediaType 
--

CREATE TABLE Dim_MediaType(
    MediaTypeID    INT                      NOT NULL,
    Name           NATIONAL VARCHAR(120),
    PRIMARY KEY (MediaTypeID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Playlist 
--

CREATE TABLE Dim_Playlist(
    PlaylistID    INT                      NOT NULL,
    Name          NATIONAL VARCHAR(120),
    PRIMARY KEY (PlaylistID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_PlaylistTrack 
--

CREATE TABLE Dim_PlaylistTrack(
    PlaylistID    INT    NOT NULL,
    TrackID       INT    NOT NULL,
    PRIMARY KEY (PlaylistID, TrackID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Fact_Invoice 
--

CREATE TABLE Fact_Invoice(
    InvoiceID            INT                     NOT NULL,
    InvoiceDate          DATETIME,
    BillingAddress       NATIONAL VARCHAR(70),
    BillingCity          NATIONAL VARCHAR(40),
    BillingCountry       NATIONAL VARCHAR(40),
    BillingPostalCode    NATIONAL VARCHAR(10),
    Total                DECIMAL(10, 2),
    InvoiceLineID        INT                     NOT NULL,
    CustomerID           INT                     NOT NULL,
    FullDate             DATETIME                NOT NULL,
    PRIMARY KEY (InvoiceID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Fact_Track 
--

CREATE TABLE Fact_Track(
    TrackID          INT                      NOT NULL,
    Name             NATIONAL VARCHAR(200),
    Composer         NATIONAL VARCHAR(220),
    Millisecond      INT,
    Bytes            INT,
    UniteProce       DECIMAL(10, 2),
    MediaTypeID      INT                      NOT NULL,
    GenreID          INT                      NOT NULL,
    AlbumID          INT                      NOT NULL,
    InvoiceLineID    INT                      NOT NULL,
    PRIMARY KEY (TrackID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Album 
--

ALTER TABLE Dim_Album ADD CONSTRAINT RefDim_Artist41 
    FOREIGN KEY (Artist_Id)
    REFERENCES Dim_Artist(Artist_Id)
;


-- 
-- TABLE: Dim_Customer 
--

ALTER TABLE Dim_Customer ADD CONSTRAINT RefDim_Employee35 
    FOREIGN KEY (EmployeeID)
    REFERENCES Dim_Employee(EmployeeID)
;

ALTER TABLE Dim_Customer ADD CONSTRAINT RefDim_Geography49 
    FOREIGN KEY (GeographyID)
    REFERENCES Dim_Geography(GeographyID)
;


-- 
-- TABLE: Dim_Employee 
--

ALTER TABLE Dim_Employee ADD CONSTRAINT RefDim_Geography50 
    FOREIGN KEY (GeographyID)
    REFERENCES Dim_Geography(GeographyID)
;

ALTER TABLE Dim_Employee ADD CONSTRAINT RefDim_Employee55 
    FOREIGN KEY (ReportsTo)
    REFERENCES Dim_Employee(EmployeeID)
;


-- 
-- TABLE: Dim_PlaylistTrack 
--

ALTER TABLE Dim_PlaylistTrack ADD CONSTRAINT RefDim_Playlist43 
    FOREIGN KEY (PlaylistID)
    REFERENCES Dim_Playlist(PlaylistID)
;

ALTER TABLE Dim_PlaylistTrack ADD CONSTRAINT RefFact_Track44 
    FOREIGN KEY (TrackID)
    REFERENCES Fact_Track(TrackID)
;


-- 
-- TABLE: Fact_Invoice 
--

ALTER TABLE Fact_Invoice ADD CONSTRAINT RefDim_Customer24 
    FOREIGN KEY (CustomerID)
    REFERENCES Dim_Customer(CustomerID)
;

ALTER TABLE Fact_Invoice ADD CONSTRAINT RefDim_InvoiceLine25 
    FOREIGN KEY (InvoiceLineID)
    REFERENCES Dim_InvoiceLine(InvoiceLineID)
;

ALTER TABLE Fact_Invoice ADD CONSTRAINT RefDim_Date26 
    FOREIGN KEY (FullDate)
    REFERENCES Dim_Date(FullDate)
;


-- 
-- TABLE: Fact_Track 
--

ALTER TABLE Fact_Track ADD CONSTRAINT RefDim_MediaType45 
    FOREIGN KEY (MediaTypeID)
    REFERENCES Dim_MediaType(MediaTypeID)
;

ALTER TABLE Fact_Track ADD CONSTRAINT RefDim_Genre46 
    FOREIGN KEY (GenreID)
    REFERENCES Dim_Genre(GenreID)
;

ALTER TABLE Fact_Track ADD CONSTRAINT RefDim_Album47 
    FOREIGN KEY (AlbumID)
    REFERENCES Dim_Album(AlbumID)
;

ALTER TABLE Fact_Track ADD CONSTRAINT RefDim_InvoiceLine48 
    FOREIGN KEY (InvoiceLineID)
    REFERENCES Dim_InvoiceLine(InvoiceLineID)
;


