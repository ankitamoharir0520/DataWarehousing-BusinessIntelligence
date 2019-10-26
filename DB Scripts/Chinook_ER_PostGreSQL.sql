--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Chinook_ER.DM1
--
-- Date Created : Sunday, September 22, 2019 23:51:09
-- Target DBMS : PostgreSQL 9.x
--

-- 
-- TABLE: "Album" 
--

CREATE TABLE "Album"(
    "AlbumId"   int4            NOT NULL,
    "Title"     varchar(160)    NOT NULL,
    "ArtistId"  int4            NOT NULL,
    CONSTRAINT "PK_Album" PRIMARY KEY ("AlbumId")
)
;



-- 
-- TABLE: "Artist" 
--

CREATE TABLE "Artist"(
    "ArtistId"  int4            NOT NULL,
    "Name"      varchar(120),
    CONSTRAINT "PK_Artist" PRIMARY KEY ("ArtistId")
)
;



-- 
-- TABLE: "Customer" 
--

CREATE TABLE "Customer"(
    "CustomerId"    int4           NOT NULL,
    "FirstName"     varchar(40)    NOT NULL,
    "LastName"      varchar(20)    NOT NULL,
    "Company"       varchar(80),
    "Address"       varchar(70),
    "City"          varchar(40),
    "State"         varchar(40),
    "Country"       varchar(40),
    "PostalCode"    varchar(10),
    "Phone"         varchar(24),
    "Fax"           varchar(24),
    "Email"         varchar(60)    NOT NULL,
    "SupportRepId"  int4,
    CONSTRAINT "PK_Customer" PRIMARY KEY ("CustomerId")
)
;



-- 
-- TABLE: "Employee" 
--

CREATE TABLE "Employee"(
    "EmployeeId"  int4           NOT NULL,
    "LastName"    varchar(20)    NOT NULL,
    "FirstName"   varchar(20)    NOT NULL,
    "Title"       varchar(30),
    "ReportsTo"   int4,
    "BirthDate"   timestamp,
    "HireDate"    timestamp,
    "Address"     varchar(70),
    "City"        varchar(40),
    "State"       varchar(40),
    "Country"     varchar(40),
    "PostalCode"  varchar(10),
    "Phone"       varchar(24),
    "Fax"         varchar(24),
    "Email"       varchar(60),
    CONSTRAINT "PK_Employee" PRIMARY KEY ("EmployeeId")
)
;



-- 
-- TABLE: "Genre" 
--

CREATE TABLE "Genre"(
    "GenreId"  int4            NOT NULL,
    "Name"     varchar(120),
    CONSTRAINT "PK_Genre" PRIMARY KEY ("GenreId")
)
;



-- 
-- TABLE: "Invoice" 
--

CREATE TABLE "Invoice"(
    "InvoiceId"          int4              NOT NULL,
    "CustomerId"         int4              NOT NULL,
    "InvoiceDate"        timestamp         NOT NULL,
    "BillingAddress"     varchar(70),
    "BillingCity"        varchar(40),
    "BillingState"       varchar(40),
    "BillingCountry"     varchar(40),
    "BillingPostalCode"  varchar(10),
    "Total"              numeric(10, 2)    NOT NULL,
    CONSTRAINT "PK_Invoice" PRIMARY KEY ("InvoiceId")
)
;



-- 
-- TABLE: "InvoiceLine" 
--

CREATE TABLE "InvoiceLine"(
    "InvoiceLineId"  int4              NOT NULL,
    "InvoiceId"      int4              NOT NULL,
    "TrackId"        int4              NOT NULL,
    "UnitPrice"      numeric(10, 2)    NOT NULL,
    "Quantity"       int4              NOT NULL,
    CONSTRAINT "PK_InvoiceLine" PRIMARY KEY ("InvoiceLineId")
)
;



-- 
-- TABLE: "MediaType" 
--

CREATE TABLE "MediaType"(
    "MediaTypeId"  int4            NOT NULL,
    "Name"         varchar(120),
    CONSTRAINT "PK_MediaType" PRIMARY KEY ("MediaTypeId")
)
;



-- 
-- TABLE: "Playlist" 
--

CREATE TABLE "Playlist"(
    "PlaylistId"  int4            NOT NULL,
    "Name"        varchar(120),
    CONSTRAINT "PK_Playlist" PRIMARY KEY ("PlaylistId")
)
;



-- 
-- TABLE: "PlaylistTrack" 
--

CREATE TABLE "PlaylistTrack"(
    "PlaylistId"  int4    NOT NULL,
    "TrackId"     int4    NOT NULL,
    CONSTRAINT "PK_PlaylistTrack" PRIMARY KEY ("PlaylistId", "TrackId")
)
;



-- 
-- TABLE: sysdiagrams 
--

CREATE TABLE sysdiagrams(
    name            char(10)    NOT NULL,
    principal_id    int4        NOT NULL,
    diagram_id      int4        NOT NULL,
    version         int4,
    definition      bytea,
    CONSTRAINT "PK__sysdiagr__C2B05B611843BF61" PRIMARY KEY (diagram_id)
)
;



-- 
-- TABLE: "Track" 
--

CREATE TABLE "Track"(
    "TrackId"       int4              NOT NULL,
    "Name"          varchar(200)      NOT NULL,
    "AlbumId"       int4,
    "MediaTypeId"   int4              NOT NULL,
    "GenreId"       int4,
    "Composer"      varchar(220),
    "Milliseconds"  int4              NOT NULL,
    "Bytes"         int4,
    "UnitPrice"     numeric(10, 2)    NOT NULL,
    CONSTRAINT "PK_Track" PRIMARY KEY ("TrackId")
)
;



-- 
-- TABLE: "Album" 
--

ALTER TABLE "Album" ADD CONSTRAINT "FK_AlbumArtistId" 
    FOREIGN KEY ("ArtistId")
    REFERENCES "Artist"("ArtistId")
;


-- 
-- TABLE: "Customer" 
--

ALTER TABLE "Customer" ADD CONSTRAINT "FK_CustomerSupportRepId" 
    FOREIGN KEY ("SupportRepId")
    REFERENCES "Employee"("EmployeeId")
;


-- 
-- TABLE: "Employee" 
--

ALTER TABLE "Employee" ADD CONSTRAINT "FK_EmployeeReportsTo" 
    FOREIGN KEY ("ReportsTo")
    REFERENCES "Employee"("EmployeeId")
;


-- 
-- TABLE: "Invoice" 
--

ALTER TABLE "Invoice" ADD CONSTRAINT "FK_InvoiceCustomerId" 
    FOREIGN KEY ("CustomerId")
    REFERENCES "Customer"("CustomerId")
;


-- 
-- TABLE: "InvoiceLine" 
--

ALTER TABLE "InvoiceLine" ADD CONSTRAINT "FK_InvoiceLineInvoiceId" 
    FOREIGN KEY ("InvoiceId")
    REFERENCES "Invoice"("InvoiceId")
;

ALTER TABLE "InvoiceLine" ADD CONSTRAINT "FK_InvoiceLineTrackId" 
    FOREIGN KEY ("TrackId")
    REFERENCES "Track"("TrackId")
;


-- 
-- TABLE: "PlaylistTrack" 
--

ALTER TABLE "PlaylistTrack" ADD CONSTRAINT "FK_PlaylistTrackPlaylistId" 
    FOREIGN KEY ("PlaylistId")
    REFERENCES "Playlist"("PlaylistId")
;

ALTER TABLE "PlaylistTrack" ADD CONSTRAINT "FK_PlaylistTrackTrackId" 
    FOREIGN KEY ("TrackId")
    REFERENCES "Track"("TrackId")
;


-- 
-- TABLE: "Track" 
--

ALTER TABLE "Track" ADD CONSTRAINT "FK_TrackAlbumId" 
    FOREIGN KEY ("AlbumId")
    REFERENCES "Album"("AlbumId")
;

ALTER TABLE "Track" ADD CONSTRAINT "FK_TrackGenreId" 
    FOREIGN KEY ("GenreId")
    REFERENCES "Genre"("GenreId")
;

ALTER TABLE "Track" ADD CONSTRAINT "FK_TrackMediaTypeId" 
    FOREIGN KEY ("MediaTypeId")
    REFERENCES "MediaType"("MediaTypeId")
;


