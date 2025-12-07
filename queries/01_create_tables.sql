CREATE DATABASE coworking_space;
USE coworking_space;

-- Membership options (Day Pass, Monthly, etc.)
CREATE TABLE MembershipPlans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    duration_days INT NOT NULL
);

-- Workspaces available for booking
CREATE TABLE Spaces (
    space_id INT AUTO_INCREMENT PRIMARY KEY,
    space_name VARCHAR(50) NOT NULL,
    space_type VARCHAR(50) NOT NULL,
    is_maintenance BOOLEAN DEFAULT 0 -- 0 = Active, 1 = Under Maintenance
);

-- Dates when the office is closed
CREATE TABLE OfficeHolidays (
    holiday_date DATE PRIMARY KEY,
    holiday_name VARCHAR(50) NOT NULL
);

-- Registered members with valid access dates
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    membership_start_date DATE NOT NULL,
    membership_expiry_date DATE NOT NULL
);

-- Financial transactions linked to plans
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    plan_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method ENUM('Card', 'Cash', 'Bank Transfer') NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES MembershipPlans(plan_id)
);

-- Space reservations
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    space_id INT NOT NULL,
    booking_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_cancelled BOOLEAN DEFAULT 0, -- 0 = Active, 1 = Cancelled
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (space_id) REFERENCES Spaces(space_id)
);

-- Audit log for triggers (automatically populated)
CREATE TABLE BookingLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    action VARCHAR(50),
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);