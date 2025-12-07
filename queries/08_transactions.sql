USE coworking_space;

-- Q11: How to safely create a booking?
-- Checks Maintenance > Holiday > Availability before saving.

DROP PROCEDURE IF EXISTS CreateSafeBooking;

DELIMITER //

CREATE PROCEDURE CreateSafeBooking(
    IN new_member_id INT,
    IN new_space_id INT,
    IN new_date DATE,
    IN new_start TIME,
    IN new_end TIME
)
BEGIN
    DECLARE maintenance_flag BOOLEAN;
    DECLARE holiday_count INT;
    DECLARE overlap_count INT;

    -- 1. Check Maintenance
    SELECT is_maintenance INTO maintenance_flag
    FROM Spaces WHERE space_id = new_space_id;

    -- 2. Check Holiday
    SELECT COUNT(*) INTO holiday_count
    FROM OfficeHolidays WHERE holiday_date = new_date;

    -- 3. Check Availability (Overlap)
    SELECT COUNT(*) INTO overlap_count
    FROM Bookings
    WHERE space_id = new_space_id
      AND booking_date = new_date
      AND is_cancelled = 0
      AND start_time < new_end
      AND end_time > new_start;

    -- 4. Process
    IF maintenance_flag = 1 THEN
        SELECT 'Error: Space under maintenance' AS status;

    ELSEIF holiday_count > 0 THEN
        SELECT 'Error: Office closed (Holiday)' AS status;

    ELSEIF overlap_count > 0 THEN
        SELECT 'Error: Time overlap' AS status;

    ELSE
        -- Save
        START TRANSACTION;
            INSERT INTO Bookings (member_id, space_id, booking_date, start_time, end_time)
            VALUES (new_member_id, new_space_id, new_date, new_start, new_end);
        COMMIT;

        SELECT 'Success: Booking Confirmed' AS status;
    END IF;

END //

DELIMITER ;


-- Test 1: Holiday Check (Christmas)
CALL CreateSafeBooking(1, 1, '2025-12-25', '10:00:00', '12:00:00');

-- Test 2: Valid Booking
CALL CreateSafeBooking(1, 15, '2025-11-20', '21:00:00', '22:00:00');

-- Test 3: Double Booking Check (Same time as above)
CALL CreateSafeBooking(2, 15, '2025-11-20', '21:00:00', '22:00:00');