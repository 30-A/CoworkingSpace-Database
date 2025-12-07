USE coworking_space;

-- Q9: How much revenue was generated between two dates?
DROP PROCEDURE IF EXISTS GetRevenueByDate;

DELIMITER //

CREATE PROCEDURE GetRevenueByDate(IN start_date DATE, IN end_date DATE)
BEGIN
    SELECT
        COUNT(Payments.payment_id) AS total_transactions,
        SUM(Payments.amount) AS total_revenue
    FROM Payments
    WHERE Payments.payment_date BETWEEN start_date AND end_date;
END //

DELIMITER ;


-- Q10: What is the full booking history for a member?
DROP PROCEDURE IF EXISTS GetMemberHistory;

DELIMITER //

CREATE PROCEDURE GetMemberHistory(IN target_member_id INT)
BEGIN
    SELECT
        Bookings.booking_date,
        Spaces.space_name,
        Bookings.start_time,
        Bookings.end_time,
        Bookings.is_cancelled
    FROM Bookings
    JOIN Spaces ON Bookings.space_id = Spaces.space_id
    WHERE Bookings.member_id = target_member_id
    ORDER BY Bookings.booking_date DESC;
END //

DELIMITER ;


-- Test 1: Financial Report for January 2025
CALL GetRevenueByDate('2025-01-01', '2025-01-31');

-- Test 2: History for Member #1
CALL GetMemberHistory(1);