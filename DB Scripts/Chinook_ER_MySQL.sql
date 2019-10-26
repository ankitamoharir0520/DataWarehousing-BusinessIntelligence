--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Chinook_ER.DM1
--
-- Date Created : Sunday, September 22, 2019 23:49:22
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: Album 
--

CREATE TABLE Album(
    AlbumId     INT                      NOT NULL,
    Title       NATIONAL VARCHAR(160)    NOT NULL,
    ArtistId    INT                      NOT NULL,
    PRIMARY KEY (AlbumId)
)ENGINE=MYISAM
;



-- 
-- TABLE: Artist 
--

CREATE TABLE Artist(
    ArtistId    INT                      NOT NULL,
    Name        NATIONAL VARCHAR(120),
    PRIMARY KEY (ArtistId)
)ENGINE=MYISAM
;



-- 
-- TABLE: Customer 
--

CREATE TABLE Customer(
    CustomerId      INT                     NOT NULL,
    FirstName       NATIONAL VARCHAR(40)    NOT NULL,
    LastName        NATIONAL VARCHAR(20)    NOT NULL,
    Company         NATIONAL VARCHAR(80),
    Address         NATIONAL VARCHAR(70),
    City            NATIONAL VARCHAR(40),
    State           NATIONAL VARCHAR(40),
    Country         NATIONAL VARCHAR(40),
    PostalCode      NATIONAL VARCHAR(10),
    Phone           NATIONAL VARCHAR(24),
    Fax             NATIONAL VARCHAR(24),
    Email           NATIONAL VARCHAR(60)    NOT NULL,
    SupportRepId    INT,
    PRIMARY KEY (CustomerId)
)ENGINE=MYISAM
;



-- 
-- TABLE: Employee 
--

CREATE TABLE Employee(
    EmployeeId    INT                     NOT NULL,
    LastName      NATIONAL VARCHAR(20)    NOT NULL,
    FirstName     NATIONAL VARCHAR(20)    NOT NULL,
    Title         NATIONAL VARCHAR(30),
    ReportsTo     INT,
    BirthDate     DATETIME,
    HireDate      DATETIME,
    Address       NATIONAL VARCHAR(70),
    City          NATIONAL VARCHAR(40),
    State         NATIONAL VARCHAR(40),
    Country       NATIONAL VARCHAR(40),
    PostalCode    NATIONAL VARCHAR(10),
    Phone         NATIONAL VARCHAR(24),
    Fax           NATIONAL VARCHAR(24),
    Email         NATIONAL VARCHAR(60),
    PRIMARY KEY (EmployeeId)
)ENGINE=MYISAM
;



-- 
-- TABLE: Genre 
--

CREATE TABLE Genre(
    GenreId    INT                      NOT NULL,
    Name       NATIONAL VARCHAR(120),
    PRIMARY KEY (GenreId)
)ENGINE=MYISAM
;



-- 
-- TABLE: Invoice 
--

CREATE TABLE Invoice(
    InvoiceId            INT                     NOT NULL,
    CustomerId           INT                     NOT NULL,
    InvoiceDate          DATETIME                NOT NULL,
    BillingAddress       NATIONAL VARCHAR(70),
    BillingCity          NATIONAL VARCHAR(40),
    BillingState         NATIONAL VARCHAR(40),
    BillingCountry       NATIONAL VARCHAR(40),
    BillingPostalCode    NATIONAL VARCHAR(10),
    Total                DECIMAL(10, 2)          NOT NULL,
    PRIMARY KEY (InvoiceId)
)ENGINE=MYISAM
;



-- 
-- TABLE: InvoiceLine 
--

CREATE TABLE InvoiceLine(
    InvoiceLineId    INT               NOT NULL,
    InvoiceId        INT               NOT NULL,
    TrackId          INT               NOT NULL,
    UnitPrice        DECIMAL(10, 2)    NOT NULL,
    Quantity         INT               NOT NULL,
    PRIMARY KEY (InvoiceLineId)
)ENGINE=MYISAM
;



-- 
-- TABLE: MediaType 
--

CREATE TABLE MediaType(
    MediaTypeId    INT                      NOT NULL,
    Name           NATIONAL VARCHAR(120),
    PRIMARY KEY (MediaTypeId)
)ENGINE=MYISAM
;



-- 
-- TABLE: Playlist 
--

CREATE TABLE Playlist(
    PlaylistId    INT                      NOT NULL,
    Name          NATIONAL VARCHAR(120),
    PRIMARY KEY (PlaylistId)
)ENGINE=MYISAM
;



-- 
-- TABLE: PlaylistTrack 
--

CREATE TABLE PlaylistTrack(
    PlaylistId    INT    NOT NULL,
    TrackId       INT    NOT NULL,
    PRIMARY KEY (PlaylistId, TrackId)
)ENGINE=MYISAM
;



-- 
-- TABLE: sysdiagrams 
--

CREATE TABLE sysdiagrams(
    name            CHAR(10)           NOT NULL,
    principal_id    INT                NOT NULL,
    diagram_id      INT                AUTO_INCREMENT,
    version         INT,
    definition      VARBINARY(4000),
    PRIMARY KEY (diagram_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: Track 
--

CREATE TABLE Track(
    TrackId         INT                      NOT NULL,
    Name            NATIONAL VARCHAR(200)    NOT NULL,
    AlbumId         INT,
    MediaTypeId     INT                      NOT NULL,
    GenreId         INT,
    Composer        NATIONAL VARCHAR(220),
    Milliseconds    INT                      NOT NULL,
    Bytes           INT,
    UnitPrice       DECIMAL(10, 2)           NOT NULL,
    PRIMARY KEY (TrackId)
)ENGINE=MYISAM
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


