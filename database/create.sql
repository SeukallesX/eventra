-- =====================================================
-- Eventra
-- Event and Vendor Management Database System
-- CPSC 332
-- File: create.sql
-- =====================================================

DROP DATABASE IF EXISTS eventra;
CREATE DATABASE eventra;
USE eventra;


-- =====================================================
-- 1. CLIENT
-- Stores information about clients who organize events.
-- =====================================================

CREATE TABLE Client (
    client_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),

    CONSTRAINT pk_client
        PRIMARY KEY (client_id),

    CONSTRAINT uq_client_email
        UNIQUE (email)
);


-- =====================================================
-- 2. VENUE
-- Stores information about locations where events occur.
-- =====================================================

CREATE TABLE Venue (
    venue_id INT AUTO_INCREMENT,
    venue_name VARCHAR(100) NOT NULL,
    address VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    venue_type VARCHAR(50),

    CONSTRAINT pk_venue
        PRIMARY KEY (venue_id),

    CONSTRAINT chk_venue_capacity
        CHECK (capacity > 0)
);


-- =====================================================
-- 3. VENDOR
-- Stores businesses that provide event services.
-- =====================================================

CREATE TABLE Vendor (
    vendor_id INT AUTO_INCREMENT,
    vendor_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    business_type VARCHAR(50),
    vendor_status VARCHAR(20) NOT NULL DEFAULT 'Active',

    CONSTRAINT pk_vendor
        PRIMARY KEY (vendor_id),

    CONSTRAINT uq_vendor_email
        UNIQUE (email),

    CONSTRAINT chk_vendor_status
        CHECK (vendor_status IN ('Active', 'Inactive'))
);


-- =====================================================
-- 4. STAFF
-- Stores Eventra staff information.
-- =====================================================

CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(50) NOT NULL,

    CONSTRAINT pk_staff
        PRIMARY KEY (staff_id),

    CONSTRAINT uq_staff_email
        UNIQUE (email)
);


-- =====================================================
-- 5. EVENT
-- Each event belongs to one client and one venue.
-- =====================================================

CREATE TABLE Event (
    event_id INT AUTO_INCREMENT,
    client_id INT NOT NULL,
    venue_id INT NOT NULL,
    event_name VARCHAR(100) NOT NULL,
    event_type VARCHAR(50),
    event_date DATE NOT NULL,
    start_time TIME,
    guest_count INT NOT NULL,
    event_status VARCHAR(20) NOT NULL DEFAULT 'Planned',

    CONSTRAINT pk_event
        PRIMARY KEY (event_id),

    CONSTRAINT fk_event_client
        FOREIGN KEY (client_id)
        REFERENCES Client(client_id),

    CONSTRAINT fk_event_venue
        FOREIGN KEY (venue_id)
        REFERENCES Venue(venue_id),

    CONSTRAINT chk_event_guest_count
        CHECK (guest_count > 0),

    CONSTRAINT chk_event_status
        CHECK (
            event_status IN (
                'Planned',
                'Confirmed',
                'Completed',
                'Cancelled'
            )
        )
);


-- =====================================================
-- 6. SERVICE
-- Stores services offered by vendors.
-- Each service belongs to one vendor.
-- =====================================================

CREATE TABLE Service (
    service_id INT AUTO_INCREMENT,
    vendor_id INT NOT NULL,
    service_name VARCHAR(100) NOT NULL,
    service_description VARCHAR(255),
    service_category VARCHAR(50),
    base_price DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_service
        PRIMARY KEY (service_id),

    CONSTRAINT fk_service_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES Vendor(vendor_id),

    CONSTRAINT chk_service_price
        CHECK (base_price >= 0)
);


-- =====================================================
-- 7. BOOKING
-- Connects an event with a vendor.
-- =====================================================

CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT,
    event_id INT NOT NULL,
    vendor_id INT NOT NULL,
    booking_date DATE NOT NULL,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    agreed_price DECIMAL(10,2) NOT NULL,
    notes VARCHAR(255),

    CONSTRAINT pk_booking
        PRIMARY KEY (booking_id),

    CONSTRAINT fk_booking_event
        FOREIGN KEY (event_id)
        REFERENCES Event(event_id),

    CONSTRAINT fk_booking_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES Vendor(vendor_id),

    CONSTRAINT chk_booking_price
        CHECK (agreed_price >= 0),

    CONSTRAINT chk_booking_status
        CHECK (
            booking_status IN (
                'Pending',
                'Confirmed',
                'Completed',
                'Cancelled'
            )
        )
);


-- =====================================================
-- 8. PAYMENT
-- Stores payments made toward bookings.
-- One booking may have multiple payments.
-- =====================================================

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20) NOT NULL DEFAULT 'Pending',

    CONSTRAINT pk_payment
        PRIMARY KEY (payment_id),

    CONSTRAINT fk_payment_booking
        FOREIGN KEY (booking_id)
        REFERENCES Booking(booking_id),

    CONSTRAINT chk_payment_amount
        CHECK (amount > 0),

    CONSTRAINT chk_payment_status
        CHECK (
            payment_status IN (
                'Pending',
                'Completed',
                'Failed',
                'Refunded'
            )
        )
);


-- =====================================================
-- 9. BOOKING_SERVICE
-- Resolves the M:N relationship between
-- Booking and Service.
-- =====================================================

CREATE TABLE Booking_Service (
    booking_id INT NOT NULL,
    service_id INT NOT NULL,

    CONSTRAINT pk_booking_service
        PRIMARY KEY (booking_id, service_id),

    CONSTRAINT fk_booking_service_booking
        FOREIGN KEY (booking_id)
        REFERENCES Booking(booking_id),

    CONSTRAINT fk_booking_service_service
        FOREIGN KEY (service_id)
        REFERENCES Service(service_id)
);


-- =====================================================
-- 10. EVENT_STAFF
-- Resolves the M:N relationship between
-- Event and Staff.
-- =====================================================

CREATE TABLE Event_Staff (
    event_id INT NOT NULL,
    staff_id INT NOT NULL,
    assignment_role VARCHAR(50),

    CONSTRAINT pk_event_staff
        PRIMARY KEY (event_id, staff_id),

    CONSTRAINT fk_event_staff_event
        FOREIGN KEY (event_id)
        REFERENCES Event(event_id),

    CONSTRAINT fk_event_staff_staff
        FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
);