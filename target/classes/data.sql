-- Seed data: only inserts if not already present
INSERT IGNORE INTO users (id, username, password, full_name, role) VALUES (1, 'admin', 'admin', 'System Admin', 'ADMIN');
INSERT IGNORE INTO users (id, username, password, full_name, role) VALUES (2, 'alice', 'pass', 'Alice Sharma', 'STUDENT');
INSERT IGNORE INTO users (id, username, password, full_name, role) VALUES (3, 'bob', 'pass', 'Bob Verma', 'STUDENT');
INSERT IGNORE INTO users (id, username, password, full_name, role) VALUES (4, 'charlie', 'pass', 'Charlie Singh', 'STUDENT');
INSERT IGNORE INTO users (id, username, password, full_name, role) VALUES (5, 'diana', 'pass', 'Diana Patel', 'STUDENT');
INSERT IGNORE INTO users (id, username, password, full_name, role) VALUES (6, 'eve', 'pass', 'Eve Gupta', 'STUDENT');

INSERT IGNORE INTO trips (id, creator_id, title, trip_type, destination, origin, start_date, end_date, hotel_details, activities, description, status)
VALUES (1, 2, 'Goa Weekend Getaway', 'LEISURE', 'Goa, India', 'NIET Campus, Greater Noida', '2026-06-10', '2026-06-14', 'Taj Resort & Spa, North Goa', 'Scuba Diving, Beach Party, Sunset Cruise', 'End-of-semester celebration trip with CSE batch mates. Everyone is welcome to join!', 'PLANNING');

INSERT IGNORE INTO trips (id, creator_id, title, trip_type, destination, origin, start_date, end_date, hotel_details, activities, description, status)
VALUES (2, 3, 'Daily Carpool — Noida to NIET', 'COMMUTE', 'NIET Campus, Greater Noida', 'Sector 62, Noida', '2026-05-01', '2026-05-31', NULL, NULL, 'Looking for 2-3 students to share daily cab from Noida Sector 62 to college. We can split the Uber/Ola cost equally. Morning 8 AM pickup.', 'ACTIVE');

INSERT IGNORE INTO trips (id, creator_id, title, trip_type, destination, origin, start_date, end_date, hotel_details, activities, description, status)
VALUES (3, 5, 'Manali Snow Expedition', 'WEEKEND', 'Manali, Himachal Pradesh', 'NIET Campus, Greater Noida', '2026-07-01', '2026-07-05', 'Snow Valley Resorts', 'Trekking, Paragliding, Bonfire Night', 'Adventure trip for thrill-seekers. Bus transport from campus, accommodation arranged.', 'PLANNING');

INSERT IGNORE INTO trips (id, creator_id, title, trip_type, destination, origin, start_date, end_date, hotel_details, activities, description, status)
VALUES (4, 4, 'Home to College — Lucknow Express', 'COLLEGE_TRANSPORT', 'NIET Campus, Greater Noida', 'Lucknow, UP', '2026-05-15', '2026-05-15', NULL, NULL, 'Booking a shared cab from Lucknow to college after Diwali break. DM me if you want to split the fare. Leaving at 6 AM.', 'PLANNING');

INSERT IGNORE INTO trip_participants (trip_id, user_id, status) VALUES (1, 2, 'APPROVED');
INSERT IGNORE INTO trip_participants (trip_id, user_id, status) VALUES (1, 3, 'APPROVED');
INSERT IGNORE INTO trip_participants (trip_id, user_id, status) VALUES (1, 4, 'PENDING');
INSERT IGNORE INTO trip_participants (trip_id, user_id, status) VALUES (2, 3, 'APPROVED');
INSERT IGNORE INTO trip_participants (trip_id, user_id, status) VALUES (2, 5, 'APPROVED');
INSERT IGNORE INTO trip_participants (trip_id, user_id, status) VALUES (2, 6, 'APPROVED');
INSERT IGNORE INTO trip_participants (trip_id, user_id, status) VALUES (3, 5, 'APPROVED');
INSERT IGNORE INTO trip_participants (trip_id, user_id, status) VALUES (3, 3, 'APPROVED');
INSERT IGNORE INTO trip_participants (trip_id, user_id, status) VALUES (4, 4, 'APPROVED');
INSERT IGNORE INTO trip_participants (trip_id, user_id, status) VALUES (4, 2, 'PENDING');

INSERT IGNORE INTO expenses (id, trip_id, paid_by, amount, category, description) VALUES (1, 1, 2, 5000.00, 'HOTEL', 'Advance booking for Taj Resort');
INSERT IGNORE INTO expenses (id, trip_id, paid_by, amount, category, description) VALUES (2, 1, 3, 2000.00, 'TRANSPORT', 'Train tickets for the group');
INSERT IGNORE INTO expenses (id, trip_id, paid_by, amount, category, description) VALUES (3, 1, 2, 800.00, 'FOOD', 'Dinner at beach shack');
INSERT IGNORE INTO expenses (id, trip_id, paid_by, amount, category, description) VALUES (4, 2, 3, 450.00, 'TRANSPORT', 'Ola cab - May 1');
INSERT IGNORE INTO expenses (id, trip_id, paid_by, amount, category, description) VALUES (5, 2, 5, 500.00, 'TRANSPORT', 'Uber cab - May 2');

INSERT IGNORE INTO trip_notes (id, trip_id, user_id, content) VALUES (1, 1, 2, 'I have booked the hotel. Everyone please confirm your seats by Friday.');
INSERT IGNORE INTO trip_notes (id, trip_id, user_id, content) VALUES (2, 1, 3, 'Train tickets booked! Rajdhani Express, sleeper class.');
INSERT IGNORE INTO trip_notes (id, trip_id, user_id, content) VALUES (3, 2, 3, 'Cab timing changed to 8:15 AM from tomorrow.');
