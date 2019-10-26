--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Chinook_ER.DM1
--
-- Date Created : Sunday, September 22, 2019 23:50:18
-- Target DBMS : Oracle 12c
--

-- 
-- TABLE: Album 
--

CREATE TABLE Album(
    AlbumId     NUMBER(38, 0)     NOT NULL,
    Title       NVARCHAR2(160)    NOT NULL,
    ArtistId    NUMBER(38, 0)     NOT NULL,
    CONSTRAINT PK_Album PRIMARY KEY (AlbumId)
)
;



-- 
-- TABLE: Artist 
--

CREATE TABLE Artist(
    ArtistId    NUMBER(38, 0)     NOT NULL,
    Name        NVARCHAR2(120),
    CONSTRAINT PK_Artist PRIMARY KEY (ArtistId)
)
;



-- 
-- TABLE: Customer 
--

CREATE TABLE Customer(
    CustomerId      NUMBER(38, 0)    NOT NULL,
    FirstName       NVARCHAR2(40)    NOT NULL,
    LastName        NVARCHAR2(20)    NOT NULL,
    Company         NVARCHAR2(80),
    Address         NVARCHAR2(70),
    City            NVARCHAR2(40),
    State           NVARCHAR2(40),
    Country         NVARCHAR2(40),
    PostalCode      NVARCHAR2(10),
    Phone           NVARCHAR2(24),
    Fax             NVARCHAR2(24),
    Email           NVARCHAR2(60)    NOT NULL,
    SupportRepId    NUMBER(38, 0),
    CONSTRAINT PK_Customer PRIMARY KEY (CustomerId)
)
;



-- 
-- TABLE: Employee 
--

CREATE TABLE Employee(
    EmployeeId    NUMBER(38, 0)    NOT NULL,
    LastName      NVARCHAR2(20)    NOT NULL,
    FirstName     NVARCHAR2(20)    NOT NULL,
    Title         NVARCHAR2(30),
    ReportsTo     NUMBER(38, 0),
    BirthDate     TIMESTAMP(6),
    HireDate      TIMESTAMP(6),
    Address       NVARCHAR2(70),
    City          NVARCHAR2(40),
    State         NVARCHAR2(40),
    Country       NVARCHAR2(40),
    PostalCode    NVARCHAR2(10),
    Phone         NVARCHAR2(24),
    Fax           NVARCHAR2(24),
    Email         NVARCHAR2(60),
    CONSTRAINT PK_Employee PRIMARY KEY (EmployeeId)
)
;



-- 
-- TABLE: Genre 
--

CREATE TABLE Genre(
    GenreId    NUMBER(38, 0)     NOT NULL,
    Name       NVARCHAR2(120),
    CONSTRAINT PK_Genre PRIMARY KEY (GenreId)
)
;



-- 
-- TABLE: Invoice 
--

CREATE TABLE Invoice(
    InvoiceId            NUMBER(38, 0)    NOT NULL,
    CustomerId           NUMBER(38, 0)    NOT NULL,
    InvoiceDate          TIMESTAMP(6)     NOT NULL,
    BillingAddress       NVARCHAR2(70),
    BillingCity          NVARCHAR2(40),
    BillingState         NVARCHAR2(40),
    BillingCountry       NVARCHAR2(40),
    BillingPostalCode    NVARCHAR2(10),
    Total                NUMBER(10, 2)    NOT NULL,
    CONSTRAINT PK_Invoice PRIMARY KEY (InvoiceId)
)
;



-- 
-- TABLE: InvoiceLine 
--

CREATE TABLE InvoiceLine(
    InvoiceLineId    NUMBER(38, 0)    NOT NULL,
    InvoiceId        NUMBER(38, 0)    NOT NULL,
    TrackId          NUMBER(38, 0)    NOT NULL,
    UnitPrice        NUMBER(10, 2)    NOT NULL,
    Quantity         NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK_InvoiceLine PRIMARY KEY (InvoiceLineId)
)
;



-- 
-- TABLE: MediaType 
--

CREATE TABLE MediaType(
    MediaTypeId    NUMBER(38, 0)     NOT NULL,
    Name           NVARCHAR2(120),
    CONSTRAINT PK_MediaType PRIMARY KEY (MediaTypeId)
)
;



-- 
-- TABLE: Playlist 
--

CREATE TABLE Playlist(
    PlaylistId    NUMBER(38, 0)     NOT NULL,
    Name          NVARCHAR2(120),
    CONSTRAINT PK_Playlist PRIMARY KEY (PlaylistId)
)
;



-- 
-- TABLE: PlaylistTrack 
--

CREATE TABLE PlaylistTrack(
    PlaylistId    NUMBER(38, 0)    NOT NULL,
    TrackId       NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK_PlaylistTrack PRIMARY KEY (PlaylistId, TrackId)
)
;



-- 
-- TABLE: sysdiagrams 
--

CREATE TABLE sysdiagrams(
    name            CHAR(10)         NOT NULL,
    principal_id    NUMBER(38, 0)    NOT NULL,
    diagram_id      NUMBER(38, 0)    NOT NULL,
    version         NUMBER(38, 0),
    definition      BLOB,
    CONSTRAINT PK__sysdiagr__C2B05B611843BF61 PRIMARY KEY (diagram_id)
)
;



-- 
-- TABLE: Track 
--

CREATE TABLE Track(
    TrackId         NUMBER(38, 0)     NOT NULL,
    Name            NVARCHAR2(200)    NOT NULL,
    AlbumId         NUMBER(38, 0),
    MediaTypeId     NUMBER(38, 0)     NOT NULL,
    GenreId         NUMBER(38, 0),
    Composer        NVARCHAR2(220),
    Milliseconds    NUMBER(38, 0)     NOT NULL,
    Bytes           NUMBER(38, 0),
    UnitPrice       NUMBER(10, 2)     NOT NULL,
    CONSTRAINT PK_Track PRIMARY KEY (TrackId)
)
;



-- 
-- TABLE: Album 
--

ALTER TABLE Album ADD CONSTRAINT FK_AlbumArtistId 
    FOREIGN KEY (ArtistId)
    REFERENCES Artist(ArtistId)
;


-- 
-- TABLE: Customer 
--

ALTER TABLE Customer ADD CONSTRAINT FK_CustomerSupportRepId 
    FOREIGN KEY (SupportRepId)
    REFERENCES Employee(EmployeeId)
;


-- 
-- TABLE: Employee 
--

ALTER TABLE Employee ADD CONSTRAINT FK_EmployeeReportsTo 
    FOREIGN KEY (ReportsTo)
    REFERENCES Employee(EmployeeId)
;


-- 
-- TABLE: Invoice 
--

ALTER TABLE Invoice ADD CONSTRAINT FK_InvoiceCustomerId 
    FOREIGN KEY (CustomerId)
    REFERENCES Customer(CustomerId)
;


-- 
-- TABLE: InvoiceLine 
--

ALTER TABLE InvoiceLine ADD CONSTRAINT FK_InvoiceLineInvoiceId 
    FOREIGN KEY (InvoiceId)
    REFERENCES Invoice(InvoiceId)
;

ALTER TABLE InvoiceLine ADD CONSTRAINT FK_InvoiceLineTrackId 
    FOREIGN KEY (TrackId)
    REFERENCES Track(TrackId)
;


-- 
-- TABLE: PlaylistTrack 
--

ALTER TABLE PlaylistTrack ADD CONSTRAINT FK_PlaylistTrackPlaylistId 
    FOREIGN KEY (PlaylistId)
    REFERENCES Playlist(PlaylistId)
;

ALTER TABLE PlaylistTrack ADD CONSTRAINT FK_PlaylistTrackTrackId 
    FOREIGN KEY (TrackId)
    REFERENCES Track(TrackId)
;


-- 
-- TABLE: Track 
--

ALTER TABLE Track ADD CONSTRAINT FK_TrackAlbumId 
    FOREIGN KEY (AlbumId)
    REFERENCES Album(AlbumId)
;

ALTER TABLE Track ADD CONSTRAINT FK_TrackGenreId 
    FOREIGN KEY (GenreId)
    REFERENCES Genre(GenreId)
;

ALTER TABLE Track ADD CONSTRAINT FK_TrackMediaTypeId 
    FOREIGN KEY (MediaTypeId)
    REFERENCES MediaType(MediaTypeId)
;


