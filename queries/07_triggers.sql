USE coworking_space;

-- Trigger 1: Log every new booking automatically
DROP TRIGGER IF EXISTS trg_booking_insert;

DELIMITER //

CREATE TRIGGER trg_booking_insert
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN
    INSERT INTO BookingLog (booking_id, action)
    VALUES (NEW.booking_id, 'NEW_BOOKING');
END //

DELIMITER ;


-- Trigger 2: Log cancellations automatically
DROP TRIGGER IF EXISTS trg_booking_cancel;

DELIMITER //

CREATE TRIGGER trg_booking_cancel
AFTER UPDATE ON Bookings
FOR EACH ROW
BEGIN
    -- Only log if the status actually changed to Cancelled (1)
    IF NEW.is_cancelled = 1 AND OLD.is_cancelled = 0 THEN
        INSERT INTO BookingLog (booking_id, action)
        VALUES (NEW.booking_id, 'BOOKING_CANCELLED');
    END IF;
END //

DELIMITER ;


-- TEST THE TRIGGERS ------------------------
-- 1. Create a new booking (trigger 1 should run)
INSERT INTO Bookings (member_id, space_id, booking_date, start_time, end_time)
VALUES (1, 1, '2025-12-01', '10:00:00', '11:00:00');

-- 2. Cancel that booking (Trigger 2 should fire)
UPDATE Bookings
SET is_cancelled = 1
WHERE booking_id = LAST_INSERT_ID();

-- 3. Check the log to prove it worked
SELECT * FROM BookingLog ORDER BY log_id DESC LIMIT 2;