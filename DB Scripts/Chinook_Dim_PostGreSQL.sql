--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Chinook_Dimensional_Model.DM1
--
-- Date Created : Sunday, September 22, 2019 23:45:15
-- Target DBMS : PostgreSQL 9.x
--

-- 
-- TABLE: "Dim_Album" 
--

CREATE TABLE "Dim_Album"(
    "AlbumID"    int4            NOT NULL,
    "Title"      varchar(160),
    "Artist_Id"  int4            NOT NULL,
    CONSTRAINT "PK29" PRIMARY KEY ("AlbumID")
)
;



-- 
-- TABLE: "Dim_Artist" 
--

CREATE TABLE "Dim_Artist"(
    "Artist_Id"   int4            NOT NULL,
    "ArtistName"  varchar(120),
    CONSTRAINT "PK31" PRIMARY KEY ("Artist_Id")
)
;



-- 
-- TABLE: "Dim_Customer" 
--

CREATE TABLE "Dim_Customer"(
    "CustomerID"   int4           NOT NULL,
    "FirstName"    varchar(40),
    "LastName"     varchar(20),
    "Company"      varchar(80),
    "Phone"        varchar(24),
    "Email"        varchar(60),
    "GeographyID"  int4           NOT NULL,
    "EmployeeID"   int4           NOT NULL,
    CONSTRAINT "PK22" PRIMARY KEY ("CustomerID")
)
;



-- 
-- TABLE: "Dim_Date" 
--

CREATE TABLE "Dim_Date"(
    "FullDate"  timestamp    NOT NULL,
    CONSTRAINT "PK23" PRIMARY KEY ("FullDate")
)
;



-- 
-- TABLE: "Dim_Employee" 
--

CREATE TABLE "Dim_Employee"(
    "EmployeeID"   int4           NOT NULL,
    "ReportsTo"    int4           NOT NULL,
    "FirstName"    varchar(20),
    "LastName"     varchar(20),
    "Title"        varchar(30),
    "Birthdate"    timestamp,
    "Hiredate"     timestamp,
    "Address"      varchar(70),
    "Phone"        varchar(24),
    "Fax"          varchar(24),
    "Email"        varchar(60),
    "GeographyID"  int4           NOT NULL,
    CONSTRAINT "PK24" PRIMARY KEY ("EmployeeID")
)
;



-- 
-- TABLE: "Dim_Genre" 
--

CREATE TABLE "Dim_Genre"(
    "GenreID"  int4            NOT NULL,
    "Name"     varchar(120),
    CONSTRAINT "PK26" PRIMARY KEY ("GenreID")
)
;



-- 
-- TABLE: "Dim_Geography" 
--

CREATE TABLE "Dim_Geography"(
    "GeographyID"  int4           NOT NULL,
    "City"         varchar(40),
    "State"        varchar(40),
    "Country"      varchar(40),
    "PostalCode"   varchar(10),
    CONSTRAINT "PK35" PRIMARY KEY ("GeographyID")
)
;



-- 
-- TABLE: "Dim_InvoiceLine" 
--

CREATE TABLE "Dim_InvoiceLine"(
    "InvoiceLineID"  int4              NOT NULL,
    "UnitePrice"     numeric(10, 2),
    "Quantity"       int4,
    CONSTRAINT "PK13" PRIMARY KEY ("InvoiceLineID")
)
;



-- 
-- TABLE: "Dim_MediaType" 
--

CREATE TABLE "Dim_MediaType"(
    "MediaTypeID"  int4            NOT NULL,
    "Name"         varchar(120),
    CONSTRAINT "PK14" PRIMARY KEY ("MediaTypeID")
)
;



-- 
-- TABLE: "Dim_Playlist" 
--

CREATE TABLE "Dim_Playlist"(
    "PlaylistID"  int4            NOT NULL,
    "Name"        varchar(120),
    CONSTRAINT "PK12" PRIMARY KEY ("PlaylistID")
)
;



-- 
-- TABLE: "Dim_PlaylistTrack" 
--

CREATE TABLE "Dim_PlaylistTrack"(
    "PlaylistID"  int4    NOT NULL,
    "TrackID"     int4    NOT NULL,
    CONSTRAINT "PK34" PRIMARY KEY ("PlaylistID", "TrackID")
)
;



-- 
-- TABLE: "Fact_Invoice" 
--

CREATE TABLE "Fact_Invoice"(
    "InvoiceID"          int4              NOT NULL,
    "InvoiceDate"        timestamp,
    "BillingAddress"     varchar(70),
    "BillingCity"        varchar(40),
    "BillingCountry"     varchar(40),
    "BillingPostalCode"  varchar(10),
    "Total"              numeric(10, 2),
    "InvoiceLineID"      int4              NOT NULL,
    "CustomerID"         int4              NOT NULL,
    "FullDate"           timestamp         NOT NULL,
    CONSTRAINT "PK21" PRIMARY KEY ("InvoiceID")
)
;



-- 
-- TABLE: "Fact_Track" 
--

CREATE TABLE "Fact_Track"(
    "TrackID"        int4              NOT NULL,
    "Name"           varchar(200),
    "Composer"       varchar(220),
    "Millisecond"    int4,
    "Bytes"          int4,
    "UniteProce"     numeric(10, 2),
    "MediaTypeID"    int4              NOT NULL,
    "GenreID"        int4              NOT NULL,
    "AlbumID"        int4              NOT NULL,
    "InvoiceLineID"  int4              NOT NULL,
    CONSTRAINT "PK32" PRIMARY KEY ("TrackID")
)
;



-- 
-- TABLE: "Dim_Album" 
--

ALTER TABLE "Dim_Album" ADD CONSTRAINT "RefDim_Artist41" 
    FOREIGN KEY ("Artist_Id")
    REFERENCES "Dim_Artist"("Artist_Id")
;


-- 
-- TABLE: "Dim_Customer" 
--

ALTER TABLE "Dim_Customer" ADD CONSTRAINT "RefDim_Employee35" 
    FOREIGN KEY ("EmployeeID")
    REFERENCES "Dim_Employee"("EmployeeID")
;

ALTER TABLE "Dim_Customer" ADD CONSTRAINT "RefDim_Geography49" 
    FOREIGN KEY ("GeographyID")
    REFERENCES "Dim_Geography"("GeographyID")
;


-- 
-- TABLE: "Dim_Employee" 
--

ALTER TABLE "Dim_Employee" ADD CONSTRAINT "RefDim_Geography50" 
    FOREIGN KEY ("GeographyID")
    REFERENCES "Dim_Geography"("GeographyID")
;

ALTER TABLE "Dim_Employee" ADD CONSTRAINT "RefDim_Employee55" 
    FOREIGN KEY ("ReportsTo")
    REFERENCES "Dim_Employee"("EmployeeID")
;


-- 
-- TABLE: "Dim_PlaylistTrack" 
--

ALTER TABLE "Dim_PlaylistTrack" ADD CONSTRAINT "RefDim_Playlist43" 
    FOREIGN KEY ("PlaylistID")
    REFERENCES "Dim_Playlist"("PlaylistID")
;

ALTER TABLE "Dim_PlaylistTrack" ADD CONSTRAINT "RefFact_Track44" 
    FOREIGN KEY ("TrackID")
    REFERENCES "Fact_Track"("TrackID")
;


-- 
-- TABLE: "Fact_Invoice" 
--

ALTER TABLE "Fact_Invoice" ADD CONSTRAINT "RefDim_Customer24" 
    FOREIGN KEY ("CustomerID")
    REFERENCES "Dim_Customer"("CustomerID")
;

ALTER TABLE "Fact_Invoice" ADD CONSTRAINT "RefDim_InvoiceLine25" 
    FOREIGN KEY ("InvoiceLineID")
    REFERENCES "Dim_InvoiceLine"("InvoiceLineID")
;

ALTER TABLE "Fact_Invoice" ADD CONSTRAINT "RefDim_Date26" 
    FOREIGN KEY ("FullDate")
    REFERENCES "Dim_Date"("FullDate")
;


-- 
-- TABLE: "Fact_Track" 
--

ALTER TABLE "Fact_Track" ADD CONSTRAINT "RefDim_MediaType45" 
    FOREIGN KEY ("MediaTypeID")
    REFERENCES "Dim_MediaType"("MediaTypeID")
;

ALTER TABLE "Fact_Track" ADD CONSTRAINT "RefDim_Genre46" 
    FOREIGN KEY ("GenreID")
    REFERENCES "Dim_Genre"("GenreID")
;

ALTER TABLE "Fact_Track" ADD CONSTRAINT "RefDim_Album47" 
    FOREIGN KEY ("AlbumID")
    REFERENCES "Dim_Album"("AlbumID")
;

ALTER TABLE "Fact_Track" ADD CONSTRAINT "RefDim_InvoiceLine48" 
    FOREIGN KEY ("InvoiceLineID")
    REFERENCES "Dim_InvoiceLine"("InvoiceLineID")
;


