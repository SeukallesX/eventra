# Eventra

## Event and Vendor Management Database System

Eventra is a MySQL relational database project designed to organize and manage information involved in event planning and vendor coordination.

The database manages clients, events, venues, vendors, services, bookings, payments, and staff.

## Project Features

Eventra allows users to:

- Manage clients and their events
- Manage event and venue information
- Manage vendors and their services
- Track vendor bookings
- Track event costs and payments
- Identify unpaid or incomplete payments
- Assign staff to events
- View upcoming events
- View vendors and services associated with an event

## Database Structure

Eventra contains the following tables:

- Client
- Event
- Venue
- Vendor
- Service
- Booking
- Payment
- Staff
- Booking_Service
- Event_Staff

The `Booking_Service` and `Event_Staff` tables are associative tables used to represent many-to-many relationships.

## Project Files

### create.sql

Creates the Eventra database, tables, primary keys, foreign keys, and constraints.

### insert.sql

Inserts sample data into the Eventra database for testing.

### queries.sql

Contains labeled SQL queries that demonstrate Eventra's major use cases and database functionality.

### Eventra Report.pdf

Contains the complete database design documentation, including:

- Requirements specification
- Entity and attribute identification
- Relationship identification
- Final EER diagram
- Relational schema mapping
- Normalization
- Data dictionary
- Conclusion
- Works Cited
- Appendix

## Software

- MySQL
- MySQL Workbench

## Running the Database

Run the SQL files in the following order:

1. `create.sql`
2. `insert.sql`
3. `queries.sql`

`create.sql` must be executed first because it creates the database structure required by the other files.

## Author

Mariel Bravo

CPSC 332 – File Structures and Database Systems  
California State University, Fullerton  
2026