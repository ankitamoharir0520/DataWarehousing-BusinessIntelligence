--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Chinook_Dimensional_Model.DM1
--
-- Date Created : Sunday, September 22, 2019 23:44:05
-- Target DBMS : Oracle 12c
--

-- 
-- TABLE: Dim_Album 
--

CREATE TABLE Dim_Album(
    AlbumID      NUMBER(38, 0)     NOT NULL,
    Title        NVARCHAR2(160),
    Artist_Id    NUMBER(38, 0)     NOT NULL,
    CONSTRAINT PK29 PRIMARY KEY (AlbumID)
)
;



-- 
-- TABLE: Dim_Artist 
--

CREATE TABLE Dim_Artist(
    Artist_Id     NUMBER(38, 0)     NOT NULL,
    ArtistName    NVARCHAR2(120),
    CONSTRAINT PK31 PRIMARY KEY (Artist_Id)
)
;



-- 
-- TABLE: Dim_Customer 
--

CREATE TABLE Dim_Customer(
    CustomerID     NUMBER(38, 0)    NOT NULL,
    FirstName      NVARCHAR2(40),
    LastName       NVARCHAR2(20),
    Company        NVARCHAR2(80),
    Phone          NVARCHAR2(24),
    Email          NVARCHAR2(60),
    GeographyID    NUMBER(38, 0)    NOT NULL,
    EmployeeID     NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK22 PRIMARY KEY (CustomerID)
)
;



-- 
-- TABLE: Dim_Date 
--

CREATE TABLE Dim_Date(
    FullDate    TIMESTAMP(6)    NOT NULL,
    CONSTRAINT PK23 PRIMARY KEY (FullDate)
)
;



-- 
-- TABLE: Dim_Employee 
--

CREATE TABLE Dim_Employee(
    EmployeeID     NUMBER(38, 0)    NOT NULL,
    ReportsTo      NUMBER(38, 0)    NOT NULL,
    FirstName      NVARCHAR2(20),
    LastName       NVARCHAR2(20),
    Title          NVARCHAR2(30),
    Birthdate      TIMESTAMP(6),
    Hiredate       TIMESTAMP(6),
    Address        NVARCHAR2(70),
    Phone          NVARCHAR2(24),
    Fax            NVARCHAR2(24),
    Email          NVARCHAR2(60),
    GeographyID    NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK24 PRIMARY KEY (EmployeeID)
)
;



-- 
-- TABLE: Dim_Genre 
--

CREATE TABLE Dim_Genre(
    GenreID    NUMBER(38, 0)     NOT NULL,
    Name       NVARCHAR2(120),
    CONSTRAINT PK26 PRIMARY KEY (GenreID)
)
;



-- 
-- TABLE: Dim_Geography 
--

CREATE TABLE Dim_Geography(
    GeographyID    NUMBER(38, 0)    NOT NULL,
    City           NVARCHAR2(40),
    State          NVARCHAR2(40),
    Country        NVARCHAR2(40),
    PostalCode     NVARCHAR2(10),
    CONSTRAINT PK35 PRIMARY KEY (GeographyID)
)
;



-- 
-- TABLE: Dim_InvoiceLine 
--

CREATE TABLE Dim_InvoiceLine(
    InvoiceLineID    NUMBER(38, 0)    NOT NULL,
    UnitePrice       NUMBER(10, 2),
    Quantity         NUMBER(38, 0),
    CONSTRAINT PK13 PRIMARY KEY (InvoiceLineID)
)
;



-- 
-- TABLE: Dim_MediaType 
--

CREATE TABLE Dim_MediaType(
    MediaTypeID    NUMBER(38, 0)     NOT NULL,
    Name           NVARCHAR2(120),
    CONSTRAINT PK14 PRIMARY KEY (MediaTypeID)
)
;



-- 
-- TABLE: Dim_Playlist 
--

CREATE TABLE Dim_Playlist(
    PlaylistID    NUMBER(38, 0)     NOT NULL,
    Name          NVARCHAR2(120),
    CONSTRAINT PK12 PRIMARY KEY (PlaylistID)
)
;



-- 
-- TABLE: Dim_PlaylistTrack 
--

CREATE TABLE Dim_PlaylistTrack(
    PlaylistID    NUMBER(38, 0)    NOT NULL,
    TrackID       NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK34 PRIMARY KEY (PlaylistID, TrackID)
)
;



-- 
-- TABLE: Fact_Invoice 
--

CREATE TABLE Fact_Invoice(
    InvoiceID            NUMBER(38, 0)    NOT NULL,
    InvoiceDate          TIMESTAMP(6),
    BillingAddress       NVARCHAR2(70),
    BillingCity          NVARCHAR2(40),
    BillingCountry       NVARCHAR2(40),
    BillingPostalCode    NVARCHAR2(10),
    Total                NUMBER(10, 2),
    InvoiceLineID        NUMBER(38, 0)    NOT NULL,
    CustomerID           NUMBER(38, 0)    NOT NULL,
    FullDate             TIMESTAMP(6)     NOT NULL,
    CONSTRAINT PK21 PRIMARY KEY (InvoiceID)
)
;



-- 
-- TABLE: Fact_Track 
--

CREATE TABLE Fact_Track(
    TrackID          NUMBER(38, 0)     NOT NULL,
    Name             NVARCHAR2(200),
    Composer         NVARCHAR2(220),
    Millisecond      NUMBER(38, 0),
    Bytes            NUMBER(38, 0),
    UniteProce       NUMBER(10, 2),
    MediaTypeID      NUMBER(38, 0)     NOT NULL,
    GenreID          NUMBER(38, 0)     NOT NULL,
    AlbumID          NUMBER(38, 0)     NOT NULL,
    InvoiceLineID    NUMBER(38, 0)     NOT NULL,
    CONSTRAINT PK32 PRIMARY KEY (TrackID)
)
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


