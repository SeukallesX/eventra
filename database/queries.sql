-- =====================================================
-- Eventra
-- Event and Vendor Management Database System
-- CPSC 332
-- File: queries.sql
-- =====================================================

USE eventra;


-- =====================================================
-- USE CASE 1: EVENT AND VENDOR MANAGEMENT
-- View all vendors and services booked for an event.
-- =====================================================

SELECT
    e.event_id,
    e.event_name,
    v.vendor_name,
    s.service_name,
    b.booking_status,
    b.agreed_price
FROM Event e
JOIN Booking b
    ON e.event_id = b.event_id
JOIN Vendor v
    ON b.vendor_id = v.vendor_id
JOIN Booking_Service bs
    ON b.booking_id = bs.booking_id
JOIN Service s
    ON bs.service_id = s.service_id
WHERE e.event_id = 1
ORDER BY v.vendor_name;


-- =====================================================
-- USE CASE 2: EVENT COST
-- Calculate the total vendor cost for each event.
-- =====================================================

SELECT
    e.event_id,
    e.event_name,
    SUM(b.agreed_price) AS total_event_cost
FROM Event e
JOIN Booking b
    ON e.event_id = b.event_id
GROUP BY
    e.event_id,
    e.event_name
ORDER BY total_event_cost DESC;


-- =====================================================
-- USE CASE 3: PAYMENT TRACKING
-- Calculate how much has been paid toward each booking
-- and determine the remaining balance.
-- =====================================================

SELECT
    b.booking_id,
    e.event_name,
    v.vendor_name,
    b.agreed_price,
    COALESCE(SUM(
        CASE
            WHEN p.payment_status = 'Completed'
            THEN p.amount
            ELSE 0
        END
    ), 0) AS amount_paid,

    b.agreed_price -
    COALESCE(SUM(
        CASE
            WHEN p.payment_status = 'Completed'
            THEN p.amount
            ELSE 0
        END
    ), 0) AS remaining_balance

FROM Booking b

JOIN Event e
    ON b.event_id = e.event_id

JOIN Vendor v
    ON b.vendor_id = v.vendor_id

LEFT JOIN Payment p
    ON b.booking_id = p.booking_id

GROUP BY
    b.booking_id,
    e.event_name,
    v.vendor_name,
    b.agreed_price

ORDER BY b.booking_id;


-- =====================================================
-- USE CASE 4: UNPAID / PARTIALLY PAID BOOKINGS
-- Identify bookings that still have an outstanding
-- balance.
-- =====================================================

SELECT
    b.booking_id,
    e.event_name,
    v.vendor_name,
    b.agreed_price,

    COALESCE(SUM(
        CASE
            WHEN p.payment_status = 'Completed'
            THEN p.amount
            ELSE 0
        END
    ), 0) AS amount_paid,

    b.agreed_price -
    COALESCE(SUM(
        CASE
            WHEN p.payment_status = 'Completed'
            THEN p.amount
            ELSE 0
        END
    ), 0) AS amount_due

FROM Booking b

JOIN Event e
    ON b.event_id = e.event_id

JOIN Vendor v
    ON b.vendor_id = v.vendor_id

LEFT JOIN Payment p
    ON b.booking_id = p.booking_id

GROUP BY
    b.booking_id,
    e.event_name,
    v.vendor_name,
    b.agreed_price

HAVING amount_due > 0

ORDER BY amount_due DESC;


-- =====================================================
-- USE CASE 5: EVENT STAFF
-- View all staff members assigned to a specific event.
-- =====================================================

SELECT
    e.event_name,
    s.staff_id,
    s.first_name,
    s.last_name,
    s.role,
    es.assignment_role
FROM Event e

JOIN Event_Staff es
    ON e.event_id = es.event_id

JOIN Staff s
    ON es.staff_id = s.staff_id

WHERE e.event_id = 1

ORDER BY s.last_name;


-- =====================================================
-- USE CASE 6: VENUE SCHEDULE
-- View all events scheduled at a specific venue.
-- =====================================================

SELECT
    v.venue_name,
    e.event_name,
    e.event_type,
    e.event_date,
    e.start_time,
    e.guest_count,
    e.event_status
FROM Venue v

JOIN Event e
    ON v.venue_id = e.venue_id

WHERE v.venue_id = 1

ORDER BY e.event_date;


-- =====================================================
-- USE CASE 7: CLIENT EVENT HISTORY
-- View all events belonging to a specific client.
-- =====================================================

SELECT
    c.client_id,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name,
    e.event_name,
    e.event_type,
    e.event_date,
    e.event_status
FROM Client c

JOIN Event e
    ON c.client_id = e.client_id

WHERE c.client_id = 1

ORDER BY e.event_date;


-- =====================================================
-- USE CASE 8: VENDOR SERVICES
-- View all services offered by a specific vendor.
-- =====================================================

SELECT
    v.vendor_name,
    s.service_name,
    s.service_category,
    s.base_price
FROM Vendor v

JOIN Service s
    ON v.vendor_id = s.vendor_id

WHERE v.vendor_id = 1

ORDER BY s.service_name;


-- =====================================================
-- USE CASE 9: UPCOMING EVENTS
-- View upcoming planned or confirmed events.
-- =====================================================

SELECT
    e.event_id,
    e.event_name,
    e.event_type,
    e.event_date,
    e.start_time,
    v.venue_name,
    e.guest_count,
    e.event_status
FROM Event e

JOIN Venue v
    ON e.venue_id = v.venue_id

WHERE e.event_date >= CURDATE()
  AND e.event_status IN ('Planned', 'Confirmed')

ORDER BY e.event_date, e.start_time;


-- =====================================================
-- USE CASE 10: FREQUENTLY BOOKED VENDORS
-- Identify vendors that have been booked for
-- multiple events.
-- =====================================================

SELECT
    v.vendor_id,
    v.vendor_name,
    COUNT(DISTINCT b.event_id) AS number_of_events
FROM Vendor v

JOIN Booking b
    ON v.vendor_id = b.vendor_id

GROUP BY
    v.vendor_id,
    v.vendor_name

HAVING COUNT(DISTINCT b.event_id) > 1

ORDER BY number_of_events DESC;