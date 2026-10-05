-- =====================================================
-- Eventra
-- Event and Vendor Management Database System
-- CPSC 332
-- File: insert.sql
-- =====================================================

USE eventra;


-- =====================================================
-- 1. CLIENT DATA
-- =====================================================

INSERT INTO Client
(first_name, last_name, email, phone)
VALUES
('Olivia', 'Martinez', 'olivia.martinez@email.com', '714-555-1001'),
('Daniel', 'Kim', 'daniel.kim@email.com', '714-555-1002'),
('Sophia', 'Johnson', 'sophia.johnson@email.com', '562-555-1003'),
('Ethan', 'Garcia', 'ethan.garcia@email.com', '949-555-1004'),
('Maya', 'Patel', 'maya.patel@email.com', '657-555-1005');


-- =====================================================
-- 2. VENUE DATA
-- =====================================================

INSERT INTO Venue
(venue_name, address, city, capacity, venue_type)
VALUES
('Garden Ballroom', '1200 Harbor Blvd', 'Anaheim', 250, 'Ballroom'),
('Sunset Terrace', '450 Ocean Ave', 'Long Beach', 150, 'Outdoor'),
('Grand Conference Center', '800 Center St', 'Anaheim', 500, 'Conference Center'),
('Willow Event Hall', '225 Main St', 'Fullerton', 200, 'Event Hall');


-- =====================================================
-- 3. VENDOR DATA
-- =====================================================

INSERT INTO Vendor
(vendor_name, email, phone, business_type, vendor_status)
VALUES
('Golden State Catering', 'contact@gscatering.com',
 '714-555-2001', 'Catering', 'Active'),

('Bright Lens Photography', 'hello@brightlens.com',
 '714-555-2002', 'Photography', 'Active'),

('Bloom Event Decor', 'info@bloomeventdecor.com',
 '562-555-2003', 'Decoration', 'Active'),

('Premier Sound Entertainment', 'booking@premiersound.com',
 '949-555-2004', 'Entertainment', 'Active'),

('Sweet Moments Bakery', 'orders@sweetmoments.com',
 '657-555-2005', 'Bakery', 'Active');


-- =====================================================
-- 4. STAFF DATA
-- =====================================================

INSERT INTO Staff
(first_name, last_name, email, phone, role)
VALUES
('Emma', 'Lopez', 'emma.lopez@eventra.com',
 '714-555-3001', 'Event Coordinator'),

('Noah', 'Wilson', 'noah.wilson@eventra.com',
 '714-555-3002', 'Event Assistant'),

('Ava', 'Nguyen', 'ava.nguyen@eventra.com',
 '714-555-3003', 'Vendor Coordinator'),

('Liam', 'Brown', 'liam.brown@eventra.com',
 '714-555-3004', 'Event Assistant');


-- =====================================================
-- 5. EVENT DATA
-- =====================================================

INSERT INTO Event
(client_id, venue_id, event_name, event_type,
 event_date, start_time, guest_count, event_status)
VALUES
(1, 1, 'Martinez Wedding', 'Wedding',
 '2026-11-14', '16:00:00', 180, 'Confirmed'),

(2, 3, 'Tech Leadership Summit', 'Corporate',
 '2026-11-21', '09:00:00', 350, 'Confirmed'),

(3, 2, 'Sophia Birthday Celebration', 'Birthday',
 '2026-12-05', '17:30:00', 80, 'Planned'),

(4, 4, 'Garcia Family Reunion', 'Family',
 '2026-12-12', '12:00:00', 120, 'Planned'),

(5, 1, 'Patel Anniversary Celebration', 'Anniversary',
 '2027-01-16', '18:00:00', 140, 'Planned');


-- =====================================================
-- 6. SERVICE DATA
-- =====================================================

INSERT INTO Service
(vendor_id, service_name, service_description,
 service_category, base_price)
VALUES
(1, 'Buffet Catering',
 'Buffet meal service for event guests',
 'Catering', 2500.00),

(1, 'Dessert Station',
 'Assorted desserts and serving station',
 'Catering', 700.00),

(2, 'Event Photography',
 'Professional event photography coverage',
 'Photography', 1800.00),

(3, 'Floral Decoration',
 'Floral arrangements and event decoration',
 'Decoration', 1200.00),

(4, 'DJ Entertainment',
 'DJ and music service for the event',
 'Entertainment', 1000.00),

(5, 'Custom Event Cake',
 'Custom-designed cake for the event',
 'Bakery', 450.00);


-- =====================================================
-- 7. BOOKING DATA
-- =====================================================

INSERT INTO Booking
(event_id, vendor_id, booking_date,
 booking_status, agreed_price, notes)
VALUES
(1, 1, '2026-09-15', 'Confirmed', 3000.00,
 'Wedding catering package'),

(1, 2, '2026-09-18', 'Confirmed', 1800.00,
 'Wedding photography'),

(1, 3, '2026-09-20', 'Confirmed', 1200.00,
 'Floral decorations'),

(2, 1, '2026-09-25', 'Confirmed', 4500.00,
 'Conference catering'),

(2, 4, '2026-09-26', 'Confirmed', 1500.00,
 'Audio and entertainment'),

(3, 5, '2026-10-01', 'Pending', 450.00,
 'Birthday cake'),

(3, 4, '2026-10-02', 'Pending', 1000.00,
 'Birthday DJ'),

(4, 1, '2026-10-03', 'Pending', 2200.00,
 'Family reunion catering'),

(5, 2, '2026-10-04', 'Pending', 1600.00,
 'Anniversary photography');


-- =====================================================
-- 8. PAYMENT DATA
-- =====================================================

INSERT INTO Payment
(booking_id, payment_date, amount,
 payment_method, payment_status)
VALUES
(1, '2026-09-16', 1500.00, 'Credit Card', 'Completed'),
(1, '2026-10-01', 1500.00, 'Credit Card', 'Completed'),

(2, '2026-09-19', 900.00, 'Credit Card', 'Completed'),

(3, '2026-09-21', 1200.00, 'Debit Card', 'Completed'),

(4, '2026-09-26', 2000.00, 'Bank Transfer', 'Completed'),

(5, '2026-09-27', 750.00, 'Credit Card', 'Completed'),

(6, '2026-10-02', 200.00, 'Debit Card', 'Completed');


-- =====================================================
-- 9. BOOKING_SERVICE DATA
-- M:N relationship between Booking and Service
-- =====================================================

INSERT INTO Booking_Service
(booking_id, service_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 1),
(4, 2),
(5, 5),
(6, 6),
(7, 5),
(8, 1),
(9, 3);


-- =====================================================
-- 10. EVENT_STAFF DATA
-- M:N relationship between Event and Staff
-- =====================================================

INSERT INTO Event_Staff
(event_id, staff_id, assignment_role)
VALUES
(1, 1, 'Lead Coordinator'),
(1, 2, 'Event Assistant'),
(1, 3, 'Vendor Coordinator'),

(2, 1, 'Lead Coordinator'),
(2, 4, 'Event Assistant'),

(3, 2, 'Event Assistant'),
(3, 3, 'Vendor Coordinator'),

(4, 1, 'Lead Coordinator'),
(4, 4, 'Event Assistant'),

(5, 1, 'Lead Coordinator'),
(5, 3, 'Vendor Coordinator');