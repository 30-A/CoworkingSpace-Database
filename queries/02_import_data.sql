USE coworking_space;

-- Enable local file loading
SET GLOBAL local_infile = 1;

-- Import Membership Plans
LOAD DATA LOCAL INFILE '/Downloads/coworking_space/data/membership_plans.csv'
INTO TABLE MembershipPlans
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(plan_id, plan_name, price, duration_days);

-- Import Spaces
LOAD DATA LOCAL INFILE '/Downloads/coworking_space/data/spaces.csv'
INTO TABLE Spaces
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(space_id, space_name, space_type, is_maintenance);

-- Import Holidays
LOAD DATA LOCAL INFILE '/Downloads/coworking_space/data/office_holidays.csv'
INTO TABLE OfficeHolidays
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(holiday_date, holiday_name);

-- Import Members
LOAD DATA LOCAL INFILE '/Downloads/coworking_space/data/members.csv'
INTO TABLE Members
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(member_id, first_name, last_name, email, membership_start_date, membership_expiry_date);

-- Import Payments
LOAD DATA LOCAL INFILE '/Downloads/coworking_space/data/payments.csv'
INTO TABLE Payments
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(payment_id, member_id, plan_id, amount, payment_date, payment_method);

-- Import Bookings
LOAD DATA LOCAL INFILE '/Downloads/coworking_space/data/bookings.csv'
INTO TABLE Bookings
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(booking_id, member_id, space_id, booking_date, start_time, end_time, is_cancelled);