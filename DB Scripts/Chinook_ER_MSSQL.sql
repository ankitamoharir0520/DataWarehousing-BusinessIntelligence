/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      Chinook_ER.DM1
 *
 * Date Created : Sunday, September 22, 2019 23:48:24
 * Target DBMS : Microsoft SQL Server 2017
 */

/* 
 * TABLE: Album 
 */

CREATE TABLE Album(
    AlbumId     int              NOT NULL,
    Title       nvarchar(160)    NOT NULL,
    ArtistId    int              NOT NULL,
    CONSTRAINT PK_Album PRIMARY KEY NONCLUSTERED (AlbumId)
)
go



IF OBJECT_ID('Album') IS NOT NULL
    PRINT '<<< CREATED TABLE Album >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Album >>>'
go

/* 
 * TABLE: Artist 
 */

CREATE TABLE Artist(
    ArtistId    int              NOT NULL,
    Name        nvarchar(120)    NULL,
    CONSTRAINT PK_Artist PRIMARY KEY NONCLUSTERED (ArtistId)
)
go



IF OBJECT_ID('Artist') IS NOT NULL
    PRINT '<<< CREATED TABLE Artist >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Artist >>>'
go

/* 
 * TABLE: Customer 
 */

CREATE TABLE Customer(
    CustomerId      int             NOT NULL,
    FirstName       nvarchar(40)    NOT NULL,
    LastName        nvarchar(20)    NOT NULL,
    Company         nvarchar(80)    NULL,
    Address         nvarchar(70)    NULL,
    City            nvarchar(40)    NULL,
    State           nvarchar(40)    NULL,
    Country         nvarchar(40)    NULL,
    PostalCode      nvarchar(10)    NULL,
    Phone           nvarchar(24)    NULL,
    Fax             nvarchar(24)    NULL,
    Email           nvarchar(60)    NOT NULL,
    SupportRepId    int             NULL,
    CONSTRAINT PK_Customer PRIMARY KEY NONCLUSTERED (CustomerId)
)
go



IF OBJECT_ID('Customer') IS NOT NULL
    PRINT '<<< CREATED TABLE Customer >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Customer >>>'
go

/* 
 * TABLE: Employee 
 */

CREATE TABLE Employee(
    EmployeeId    int             NOT NULL,
    LastName      nvarchar(20)    NOT NULL,
    FirstName     nvarchar(20)    NOT NULL,
    Title         nvarchar(30)    NULL,
    ReportsTo     int             NULL,
    BirthDate     datetime        NULL,
    HireDate      datetime        NULL,
    Address       nvarchar(70)    NULL,
    City          nvarchar(40)    NULL,
    State         nvarchar(40)    NULL,
    Country       nvarchar(40)    NULL,
    PostalCode    nvarchar(10)    NULL,
    Phone         nvarchar(24)    NULL,
    Fax           nvarchar(24)    NULL,
    Email         nvarchar(60)    NULL,
    CONSTRAINT PK_Employee PRIMARY KEY NONCLUSTERED (EmployeeId)
)
go



IF OBJECT_ID('Employee') IS NOT NULL
    PRINT '<<< CREATED TABLE Employee >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Employee >>>'
go

/* 
 * TABLE: Genre 
 */

CREATE TABLE Genre(
    GenreId    int              NOT NULL,
    Name       nvarchar(120)    NULL,
    CONSTRAINT PK_Genre PRIMARY KEY NONCLUSTERED (GenreId)
)
go



IF OBJECT_ID('Genre') IS NOT NULL
    PRINT '<<< CREATED TABLE Genre >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Genre >>>'
go

/* 
 * TABLE: Invoice 
 */

CREATE TABLE Invoice(
    InvoiceId            int               NOT NULL,
    CustomerId           int               NOT NULL,
    InvoiceDate          datetime          NOT NULL,
    BillingAddress       nvarchar(70)      NULL,
    BillingCity          nvarchar(40)      NULL,
    BillingState         nvarchar(40)      NULL,
    BillingCountry       nvarchar(40)      NULL,
    BillingPostalCode    nvarchar(10)      NULL,
    Total                numeric(10, 2)    NOT NULL,
    CONSTRAINT PK_Invoice PRIMARY KEY NONCLUSTERED (InvoiceId)
)
go



IF OBJECT_ID('Invoice') IS NOT NULL
    PRINT '<<< CREATED TABLE Invoice >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Invoice >>>'
go

/* 
 * TABLE: InvoiceLine 
 */

CREATE TABLE InvoiceLine(
    InvoiceLineId    int               NOT NULL,
    InvoiceId        int               NOT NULL,
    TrackId          int               NOT NULL,
    UnitPrice        numeric(10, 2)    NOT NULL,
    Quantity         int               NOT NULL,
    CONSTRAINT PK_InvoiceLine PRIMARY KEY NONCLUSTERED (InvoiceLineId)
)
go



IF OBJECT_ID('InvoiceLine') IS NOT NULL
    PRINT '<<< CREATED TABLE InvoiceLine >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE InvoiceLine >>>'
go

/* 
 * TABLE: MediaType 
 */

CREATE TABLE MediaType(
    MediaTypeId    int              NOT NULL,
    Name           nvarchar(120)    NULL,
    CONSTRAINT PK_MediaType PRIMARY KEY NONCLUSTERED (MediaTypeId)
)
go



IF OBJECT_ID('MediaType') IS NOT NULL
    PRINT '<<< CREATED TABLE MediaType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE MediaType >>>'
go

/* 
 * TABLE: Playlist 
 */

CREATE TABLE Playlist(
    PlaylistId    int              NOT NULL,
    Name          nvarchar(120)    NULL,
    CONSTRAINT PK_Playlist PRIMARY KEY NONCLUSTERED (PlaylistId)
)
go



IF OBJECT_ID('Playlist') IS NOT NULL
    PRINT '<<< CREATED TABLE Playlist >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Playlist >>>'
go

/* 
 * TABLE: PlaylistTrack 
 */

CREATE TABLE PlaylistTrack(
    PlaylistId    int    NOT NULL,
    TrackId       int    NOT NULL,
    CONSTRAINT PK_PlaylistTrack PRIMARY KEY NONCLUSTERED (PlaylistId, TrackId)
)
go



IF OBJECT_ID('PlaylistTrack') IS NOT NULL
    PRINT '<<< CREATED TABLE PlaylistTrack >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE PlaylistTrack >>>'
go

/* 
 * TABLE: sysdiagrams 
 */

CREATE TABLE sysdiagrams(
    name            char(10)          NOT NULL,
    principal_id    int               NOT NULL,
    diagram_id      int               IDENTITY(1,1),
    version         int               NULL,
    definition      varbinary(max)    NULL,
    CONSTRAINT PK__sysdiagr__C2B05B611843BF61 PRIMARY KEY NONCLUSTERED (diagram_id)
)
go



IF OBJECT_ID('sysdiagrams') IS NOT NULL
    PRINT '<<< CREATED TABLE sysdiagrams >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE sysdiagrams >>>'
go

/* 
 * TABLE: Track 
 */

CREATE TABLE Track(
    TrackId         int               NOT NULL,
    Name            nvarchar(200)     NOT NULL,
    AlbumId         int               NULL,
    MediaTypeId     int               NOT NULL,
    GenreId         int               NULL,
    Composer        nvarchar(220)     NULL,
    Milliseconds    int               NOT NULL,
    Bytes           int               NULL,
    UnitPrice       numeric(10, 2)    NOT NULL,
    CONSTRAINT PK_Track PRIMARY KEY NONCLUSTERED (TrackId)
)
go



IF OBJECT_ID('Track') IS NOT NULL
    PRINT '<<< CREATED TABLE Track >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Track >>>'
go

/* 
 * TABLE: Album 
 */

ALTER TABLE Album ADD CONSTRAINT FK_AlbumArtistId 
    FOREIGN KEY (ArtistId)
    REFERENCES Artist(ArtistId)
go


/* 
 * TABLE: Customer 
 */

ALTER TABLE Customer ADD CONSTRAINT FK_CustomerSupportRepId 
    FOREIGN KEY (SupportRepId)
    REFERENCES Employee(EmployeeId)
go


/* 
 * TABLE: Employee 
 */

ALTER TABLE Employee ADD CONSTRAINT FK_EmployeeReportsTo 
    FOREIGN KEY (ReportsTo)
    REFERENCES Employee(EmployeeId)
go


/* 
 * TABLE: Invoice 
 */

ALTER TABLE Invoice ADD CONSTRAINT FK_InvoiceCustomerId 
    FOREIGN KEY (CustomerId)
    REFERENCES Customer(CustomerId)
go


/* 
 * TABLE: InvoiceLine 
 */

ALTER TABLE InvoiceLine ADD CONSTRAINT FK_InvoiceLineInvoiceId 
    FOREIGN KEY (InvoiceId)
    REFERENCES Invoice(InvoiceId)
go

ALTER TABLE InvoiceLine ADD CONSTRAINT FK_InvoiceLineTrackId 
    FOREIGN KEY (TrackId)
    REFERENCES Track(TrackId)
go


/* 
 * TABLE: PlaylistTrack 
 */

ALTER TABLE PlaylistTrack ADD CONSTRAINT FK_PlaylistTrackPlaylistId 
    FOREIGN KEY (PlaylistId)
    REFERENCES Playlist(PlaylistId)
go

ALTER TABLE PlaylistTrack ADD CONSTRAINT FK_PlaylistTrackTrackId 
    FOREIGN KEY (TrackId)
    REFERENCES Track(TrackId)
go


/* 
 * TABLE: Track 
 */

ALTER TABLE Track ADD CONSTRAINT FK_TrackAlbumId 
    FOREIGN KEY (AlbumId)
    REFERENCES Album(AlbumId)
go

ALTER TABLE Track ADD CONSTRAINT FK_TrackGenreId 
    FOREIGN KEY (GenreId)
    REFERENCES Genre(GenreId)
go

ALTER TABLE Track ADD CONSTRAINT FK_TrackMediaTypeId 
    FOREIGN KEY (MediaTypeId)
    REFERENCES MediaType(MediaTypeId)
go


