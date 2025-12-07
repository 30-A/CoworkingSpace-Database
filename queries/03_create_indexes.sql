-- 1. Availability Index (Composite)
CREATE INDEX idx_availability ON Bookings(space_id, booking_date);

-- 2. Financial Reporting Index
CREATE INDEX idx_payment_date ON Payments(payment_date);

-- Verify the indexes were created
SHOW INDEX FROM Bookings;
SHOW INDEX FROM Payments;