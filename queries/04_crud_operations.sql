USE coworking_space;

-- 1. CREATE (INSERT) -----------------------
-- Add a new member
INSERT INTO Members (first_name, last_name, email, membership_start_date, membership_expiry_date)
VALUES ('Test', 'User', 'test.user@email.com', '2025-06-01', '2025-06-02');

-- Create a reservation for Member #1 in Space #5
INSERT INTO Bookings (member_id, space_id, booking_date, start_time, end_time)
VALUES (1, 5, '2025-06-10', '09:00:00', '12:00:00');


-- 2. READ (SELECT) -------------------------
-- Q1: Which members have an active membership valid for today?
SELECT first_name, last_name, email, membership_expiry_date
FROM Members
WHERE CURRENT_DATE BETWEEN membership_start_date AND membership_expiry_date;

-- Q2: Which spaces are currently down for maintenance?
SELECT space_id, space_name, space_type
FROM Spaces
WHERE is_maintenance = 1;

-- Find all active bookings for a specific date (e.g., 2025-06-10)
SELECT * FROM Bookings
WHERE booking_date = '2025-06-10' AND is_cancelled = 0;


-- 3. UPDATE --------------------------------
-- Q3: A member changed their email address; how do we update it?
UPDATE Members
SET email = 'new.email@test.com'
WHERE email = 'test.user@email.com';

-- Cancel a booking (Soft Delete using boolean flag)
UPDATE Bookings
SET is_cancelled = 1
WHERE booking_id = 1;

-- Mark a space as "Under Maintenance" (e.g., broken chair)
UPDATE Spaces
SET is_maintenance = 1
WHERE space_id = 10;


-- 4. DELETE --------------------------------
-- Remove the test user we created
DELETE FROM Members
WHERE email = 'new.email@test.com';