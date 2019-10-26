/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      Chinook_Dimensional_Model.DM1
 *
 * Date Created : Sunday, September 22, 2019 23:41:37
 * Target DBMS : Microsoft SQL Server 2017
 */

/* 
 * TABLE: Dim_Album 
 */

CREATE TABLE Dim_Album(
    AlbumID      int              NOT NULL,
    Title        nvarchar(160)    NULL,
    Artist_Id    int              NOT NULL,
    CONSTRAINT PK29 PRIMARY KEY NONCLUSTERED (AlbumID)
)
go



IF OBJECT_ID('Dim_Album') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Album >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Album >>>'
go

/* 
 * TABLE: Dim_Artist 
 */

CREATE TABLE Dim_Artist(
    Artist_Id     int              NOT NULL,
    ArtistName    nvarchar(120)    NULL,
    CONSTRAINT PK31 PRIMARY KEY NONCLUSTERED (Artist_Id)
)
go



IF OBJECT_ID('Dim_Artist') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Artist >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Artist >>>'
go

/* 
 * TABLE: Dim_Customer 
 */

CREATE TABLE Dim_Customer(
    CustomerID     int             NOT NULL,
    FirstName      nvarchar(40)    NULL,
    LastName       nvarchar(20)    NULL,
    Company        nvarchar(80)    NULL,
    Phone          nvarchar(24)    NULL,
    Email          nvarchar(60)    NULL,
    GeographyID    int             NOT NULL,
    EmployeeID     int             NOT NULL,
    CONSTRAINT PK22 PRIMARY KEY NONCLUSTERED (CustomerID)
)
go



IF OBJECT_ID('Dim_Customer') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Customer >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Customer >>>'
go

/* 
 * TABLE: Dim_Date 
 */

CREATE TABLE Dim_Date(
    FullDate    datetime    NOT NULL,
    CONSTRAINT PK23 PRIMARY KEY NONCLUSTERED (FullDate)
)
go



IF OBJECT_ID('Dim_Date') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Date >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Date >>>'
go

/* 
 * TABLE: Dim_Employee 
 */

CREATE TABLE Dim_Employee(
    EmployeeID     int             NOT NULL,
    ReportsTo      int             NOT NULL,
    FirstName      nvarchar(20)    NULL,
    LastName       nvarchar(20)    NULL,
    Title          nvarchar(30)    NULL,
    Birthdate      datetime        NULL,
    Hiredate       datetime        NULL,
    Address        nvarchar(70)    NULL,
    Phone          nvarchar(24)    NULL,
    Fax            nvarchar(24)    NULL,
    Email          nvarchar(60)    NULL,
    GeographyID    int             NOT NULL,
    CONSTRAINT PK24 PRIMARY KEY NONCLUSTERED (EmployeeID)
)
go



IF OBJECT_ID('Dim_Employee') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Employee >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Employee >>>'
go

/* 
 * TABLE: Dim_Genre 
 */

CREATE TABLE Dim_Genre(
    GenreID    int              NOT NULL,
    Name       nvarchar(120)    NULL,
    CONSTRAINT PK26 PRIMARY KEY NONCLUSTERED (GenreID)
)
go



IF OBJECT_ID('Dim_Genre') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Genre >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Genre >>>'
go

/* 
 * TABLE: Dim_Geography 
 */

CREATE TABLE Dim_Geography(
    GeographyID    int             NOT NULL,
    City           nvarchar(40)    NULL,
    State          nvarchar(40)    NULL,
    Country        nvarchar(40)    NULL,
    PostalCode     nvarchar(10)    NULL,
    CONSTRAINT PK35 PRIMARY KEY NONCLUSTERED (GeographyID)
)
go



IF OBJECT_ID('Dim_Geography') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Geography >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Geography >>>'
go

/* 
 * TABLE: Dim_InvoiceLine 
 */

CREATE TABLE Dim_InvoiceLine(
    InvoiceLineID    int               NOT NULL,
    UnitePrice       numeric(10, 2)    NULL,
    Quantity         int               NULL,
    CONSTRAINT PK13 PRIMARY KEY NONCLUSTERED (InvoiceLineID)
)
go



IF OBJECT_ID('Dim_InvoiceLine') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_InvoiceLine >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_InvoiceLine >>>'
go

/* 
 * TABLE: Dim_MediaType 
 */

CREATE TABLE Dim_MediaType(
    MediaTypeID    int              NOT NULL,
    Name           nvarchar(120)    NULL,
    CONSTRAINT PK14 PRIMARY KEY NONCLUSTERED (MediaTypeID)
)
go



IF OBJECT_ID('Dim_MediaType') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_MediaType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_MediaType >>>'
go

/* 
 * TABLE: Dim_Playlist 
 */

CREATE TABLE Dim_Playlist(
    PlaylistID    int              NOT NULL,
    Name          nvarchar(120)    NULL,
    CONSTRAINT PK12 PRIMARY KEY NONCLUSTERED (PlaylistID)
)
go



IF OBJECT_ID('Dim_Playlist') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Playlist >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Playlist >>>'
go

/* 
 * TABLE: Dim_PlaylistTrack 
 */

CREATE TABLE Dim_PlaylistTrack(
    PlaylistID    int    NOT NULL,
    TrackID       int    NOT NULL,
    CONSTRAINT PK34 PRIMARY KEY NONCLUSTERED (PlaylistID, TrackID)
)
go



IF OBJECT_ID('Dim_PlaylistTrack') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_PlaylistTrack >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_PlaylistTrack >>>'
go

/* 
 * TABLE: Fact_Invoice 
 */

CREATE TABLE Fact_Invoice(
    InvoiceID            int               NOT NULL,
    InvoiceDate          datetime          NULL,
    BillingAddress       nvarchar(70)      NULL,
    BillingCity          nvarchar(40)      NULL,
    BillingCountry       nvarchar(40)      NULL,
    BillingPostalCode    nvarchar(10)      NULL,
    Total                numeric(10, 2)    NULL,
    InvoiceLineID        int               NOT NULL,
    CustomerID           int               NOT NULL,
    FullDate             datetime          NOT NULL,
    CONSTRAINT PK21 PRIMARY KEY NONCLUSTERED (InvoiceID)
)
go



IF OBJECT_ID('Fact_Invoice') IS NOT NULL
    PRINT '<<< CREATED TABLE Fact_Invoice >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Fact_Invoice >>>'
go

/* 
 * TABLE: Fact_Track 
 */

CREATE TABLE Fact_Track(
    TrackID          int               NOT NULL,
    Name             nvarchar(200)     NULL,
    Composer         nvarchar(220)     NULL,
    Millisecond      int               NULL,
    Bytes            int               NULL,
    UniteProce       numeric(10, 2)    NULL,
    MediaTypeID      int               NOT NULL,
    GenreID          int               NOT NULL,
    AlbumID          int               NOT NULL,
    InvoiceLineID    int               NOT NULL,
    CONSTRAINT PK32 PRIMARY KEY NONCLUSTERED (TrackID)
)
go



IF OBJECT_ID('Fact_Track') IS NOT NULL
    PRINT '<<< CREATED TABLE Fact_Track >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Fact_Track >>>'
go

/* 
 * TABLE: Dim_Album 
 */

ALTER TABLE Dim_Album ADD CONSTRAINT RefDim_Artist41 
    FOREIGN KEY (Artist_Id)
    REFERENCES Dim_Artist(Artist_Id)
go


/* 
 * TABLE: Dim_Customer 
 */

ALTER TABLE Dim_Customer ADD CONSTRAINT RefDim_Employee35 
    FOREIGN KEY (EmployeeID)
    REFERENCES Dim_Employee(EmployeeID)
go

ALTER TABLE Dim_Customer ADD CONSTRAINT RefDim_Geography49 
    FOREIGN KEY (GeographyID)
    REFERENCES Dim_Geography(GeographyID)
go


/* 
 * TABLE: Dim_Employee 
 */

ALTER TABLE Dim_Employee ADD CONSTRAINT RefDim_Geography50 
    FOREIGN KEY (GeographyID)
    REFERENCES Dim_Geography(GeographyID)
go

ALTER TABLE Dim_Employee ADD CONSTRAINT RefDim_Employee55 
    FOREIGN KEY (ReportsTo)
    REFERENCES Dim_Employee(EmployeeID)
go


/* 
 * TABLE: Dim_PlaylistTrack 
 */

ALTER TABLE Dim_PlaylistTrack ADD CONSTRAINT RefDim_Playlist43 
    FOREIGN KEY (PlaylistID)
    REFERENCES Dim_Playlist(PlaylistID)
go

ALTER TABLE Dim_PlaylistTrack ADD CONSTRAINT RefFact_Track44 
    FOREIGN KEY (TrackID)
    REFERENCES Fact_Track(TrackID)
go


/* 
 * TABLE: Fact_Invoice 
 */

ALTER TABLE Fact_Invoice ADD CONSTRAINT RefDim_Customer24 
    FOREIGN KEY (CustomerID)
    REFERENCES Dim_Customer(CustomerID)
go

ALTER TABLE Fact_Invoice ADD CONSTRAINT RefDim_InvoiceLine25 
    FOREIGN KEY (InvoiceLineID)
    REFERENCES Dim_InvoiceLine(InvoiceLineID)
go

ALTER TABLE Fact_Invoice ADD CONSTRAINT RefDim_Date26 
    FOREIGN KEY (FullDate)
    REFERENCES Dim_Date(FullDate)
go


/* 
 * TABLE: Fact_Track 
 */

ALTER TABLE Fact_Track ADD CONSTRAINT RefDim_MediaType45 
    FOREIGN KEY (MediaTypeID)
    REFERENCES Dim_MediaType(MediaTypeID)
go

ALTER TABLE Fact_Track ADD CONSTRAINT RefDim_Genre46 
    FOREIGN KEY (GenreID)
    REFERENCES Dim_Genre(GenreID)
go

ALTER TABLE Fact_Track ADD CONSTRAINT RefDim_Album47 
    FOREIGN KEY (AlbumID)
    REFERENCES Dim_Album(AlbumID)
go

ALTER TABLE Fact_Track ADD CONSTRAINT RefDim_InvoiceLine48 
    FOREIGN KEY (InvoiceLineID)
    REFERENCES Dim_InvoiceLine(InvoiceLineID)
go


