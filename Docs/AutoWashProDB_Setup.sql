-- ============================================================
-- AutoWash Pro - Database Setup Script
-- Chạy script này để tạo mới hoàn toàn database AutoWashProDB
-- Phiên bản: Workshop 1
-- ============================================================

USE master;
GO

-- Bước 1: Xóa DB cũ nếu tồn tại (để chạy lại sạch)
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'AutoWashProDB')
BEGIN
    ALTER DATABASE AutoWashProDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AutoWashProDB;
    PRINT 'Đã xóa database cũ AutoWashProDB.';
END
GO

-- Bước 2: Tạo mới database
CREATE DATABASE AutoWashProDB;
GO

USE AutoWashProDB;
GO

PRINT 'Bắt đầu tạo bảng...';
GO

-- ============================================================
-- BẢNG 1: Tiers (Thông tin các hạng thành viên)
-- ============================================================
CREATE TABLE Tiers (
    TierId      VARCHAR(20)     NOT NULL,
    TierName    NVARCHAR(50)    NOT NULL,
    MinWashes   INT             NOT NULL DEFAULT 0,
    MinSpent    DECIMAL(18,2)   NOT NULL DEFAULT 0,
    Multiplier  FLOAT           NOT NULL DEFAULT 1.0,
    BookingDays INT             NOT NULL DEFAULT 7,
    CONSTRAINT PK_Tiers PRIMARY KEY (TierId)
);
GO

-- ============================================================
-- BẢNG 2: Users (Tài khoản khách hàng và nhân viên)
-- ============================================================
CREATE TABLE Users (
    UserId          INT             IDENTITY(1,1) NOT NULL,
    PhoneNumber     VARCHAR(15)     NOT NULL,
    Password        VARCHAR(255)    NOT NULL,
    FullName        NVARCHAR(100)   NOT NULL,
    Role            VARCHAR(20)     NOT NULL DEFAULT 'CUSTOMER',
    CurrentTierId   VARCHAR(20)     NOT NULL DEFAULT 'MEMBER',
    PointsBalance   INT             NOT NULL DEFAULT 0,
    TotalSpent      DECIMAL(18,2)   NOT NULL DEFAULT 0,
    TotalWashes     INT             NOT NULL DEFAULT 0,
    CreatedAt       DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Users PRIMARY KEY (UserId),
    CONSTRAINT UQ_Users_PhoneNumber UNIQUE (PhoneNumber),
    CONSTRAINT FK_Users_Tiers FOREIGN KEY (CurrentTierId) REFERENCES Tiers(TierId),
    CONSTRAINT CHK_Users_Role CHECK (Role IN ('ADMIN', 'STAFF', 'CUSTOMER'))
);
GO

-- ============================================================
-- BẢNG 3: LicensePlates (Biển số xe của khách hàng)
-- ============================================================
CREATE TABLE LicensePlates (
    PlateId         INT             IDENTITY(1,1) NOT NULL,
    UserId          INT             NOT NULL,
    PlateNumber     VARCHAR(20)     NOT NULL,
    Brand           NVARCHAR(50)    NULL,
    Model           NVARCHAR(50)    NULL,
    Color           NVARCHAR(30)    NULL,
    CreatedAt       DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_LicensePlates PRIMARY KEY (PlateId),
    CONSTRAINT UQ_LicensePlates_PlateNumber UNIQUE (PlateNumber),
    CONSTRAINT FK_LicensePlates_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
GO

-- ============================================================
-- BẢNG 4: Bookings (Lịch đặt rửa xe)
-- ============================================================
CREATE TABLE Bookings (
    BookingId       INT             IDENTITY(1,1) NOT NULL,
    UserId          INT             NOT NULL,
    PlateId         INT             NOT NULL,
    BookingDate     DATE            NOT NULL,
    TimeSlot        VARCHAR(10)     NOT NULL,
    Status          VARCHAR(20)     NOT NULL DEFAULT 'PENDING',
    Notes           NVARCHAR(255)   NULL,
    CreatedAt       DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Bookings PRIMARY KEY (BookingId),
    CONSTRAINT FK_Bookings_Users FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_Bookings_LicensePlates FOREIGN KEY (PlateId) REFERENCES LicensePlates(PlateId),
    CONSTRAINT CHK_Bookings_Status CHECK (Status IN ('PENDING', 'COMPLETED', 'CANCELLED'))
);
GO

-- ============================================================
-- BẢNG 5: LoyaltyTransactions (Nhật ký tích/tiêu điểm)
-- ============================================================
CREATE TABLE LoyaltyTransactions (
    TransactionId       INT             IDENTITY(1,1) NOT NULL,
    UserId              INT             NOT NULL,
    Type                VARCHAR(10)     NOT NULL,
    Points              INT             NOT NULL,
    RelatedBillAmount   DECIMAL(18,2)   NOT NULL DEFAULT 0,
    CreatedAt           DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_LoyaltyTransactions PRIMARY KEY (TransactionId),
    CONSTRAINT FK_LoyaltyTransactions_Users FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT CHK_LoyaltyTransactions_Type CHECK (Type IN ('EARN', 'REDEEM'))
);
GO

-- ============================================================
-- BẢNG 6: Notifications (Thông báo nội bộ)
-- ============================================================
CREATE TABLE Notifications (
    NotificationId  INT             IDENTITY(1,1) NOT NULL,
    UserId          INT             NOT NULL,
    Title           NVARCHAR(150)   NOT NULL,
    Content         NVARCHAR(MAX)   NOT NULL,
    IsRead          BIT             NOT NULL DEFAULT 0,
    CreatedAt       DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Notifications PRIMARY KEY (NotificationId),
    CONSTRAINT FK_Notifications_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
GO

PRINT 'Tất cả bảng đã được tạo thành công!';
GO

-- ============================================================
-- DỮ LIỆU MẪU: Bảng Tiers (4 hạng thành viên)
-- ============================================================
INSERT INTO Tiers (TierId, TierName, MinWashes, MinSpent, Multiplier, BookingDays)
VALUES
    ('MEMBER',   N'Thành Viên',  0,  0,         1.0, 7),
    ('SILVER',   N'Bạc',         5,  2000000,   1.1, 10),
    ('GOLD',     N'Vàng',        15, 6000000,   1.2, 12),
    ('PLATINUM', N'Bạch Kim',    30, 15000000,  1.3, 14);
GO

-- ============================================================
-- DỮ LIỆU MẪU: Tài khoản Admin
-- Đăng nhập: 0900000000 / admin123
-- ============================================================
INSERT INTO Users (PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes)
VALUES ('0900000000', 'admin123', N'Quản Trị Viên', 'ADMIN', 'MEMBER', 0, 0, 0);
GO

-- ============================================================
-- DỮ LIỆU MẪU: Khách hàng demo
-- Đăng nhập: 0901234567 / 123456
-- Hạng: MEMBER, 0 điểm (tài khoản mới)
-- ============================================================
INSERT INTO Users (PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes)
VALUES ('0901234567', '123456', N'Nguyễn Văn Bình', 'CUSTOMER', 'MEMBER', 0, 0, 0);
GO

-- ============================================================
-- DỮ LIỆU MẪU: Khách hàng Silver (để demo tier)
-- Đăng nhập: 0909999999 / 123456
-- Hạng: SILVER, 1500 điểm, đã rửa 7 lần, tiêu 3.000.000 VNĐ
-- ============================================================
INSERT INTO Users (PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes)
VALUES ('0909999999', '123456', N'Trần Thị Lan', 'CUSTOMER', 'SILVER', 1500, 3000000, 7);
GO

-- ============================================================
-- DỮ LIỆU MẪU: Khách hàng Gold (để demo tier)
-- Đăng nhập: 0908888888 / 123456
-- Hạng: GOLD, 5200 điểm, đã rửa 18 lần, tiêu 8.500.000 VNĐ
-- ============================================================
INSERT INTO Users (PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes)
VALUES ('0908888888', '123456', N'Lê Minh Tuấn', 'CUSTOMER', 'GOLD', 5200, 8500000, 18);
GO

-- ============================================================
-- DỮ LIỆU MẪU: Xe của khách hàng demo (0901234567)
-- ============================================================
-- Lấy UserId của khách hàng demo để insert xe
DECLARE @customerId INT;
SELECT @customerId = UserId FROM Users WHERE PhoneNumber = '0901234567';

INSERT INTO LicensePlates (UserId, PlateNumber, Brand, Model, Color)
VALUES (@customerId, '30A1-1234', N'Toyota', N'Camry', N'Trắng');
GO

-- ============================================================
-- DỮ LIỆU MẪU: Xe của khách hàng Silver (0909999999)
-- ============================================================
DECLARE @silverId INT;
SELECT @silverId = UserId FROM Users WHERE PhoneNumber = '0909999999';

INSERT INTO LicensePlates (UserId, PlateNumber, Brand, Model, Color)
VALUES (@silverId, '51F1-999.99', N'Honda', N'Civic', N'Đen');

INSERT INTO LicensePlates (UserId, PlateNumber, Brand, Model, Color)
VALUES (@silverId, '51G1-12345', N'VinFast', N'VF8', N'Xanh');
GO

-- ============================================================
-- DỮ LIỆU MẪU: Xe của khách hàng Gold (0908888888)
-- ============================================================
DECLARE @goldId INT;
SELECT @goldId = UserId FROM Users WHERE PhoneNumber = '0908888888';

INSERT INTO LicensePlates (UserId, PlateNumber, Brand, Model, Color)
VALUES (@goldId, '29A1-88888', N'BMW', N'520i', N'Xám');
GO

-- ============================================================
-- THÔNG BÁO MẪU: Chào mừng khách hàng Silver
-- ============================================================
DECLARE @silverIdNotif INT;
SELECT @silverIdNotif = UserId FROM Users WHERE PhoneNumber = '0909999999';

INSERT INTO Notifications (UserId, Title, Content)
VALUES (@silverIdNotif, 
        N'🎉 Chúc mừng thăng hạng Silver!',
        N'Tài khoản của bạn đã được nâng lên hạng Bạc (Silver). Từ bây giờ bạn được tích điểm với hệ số x1.1 và đặt lịch trước tối đa 10 ngày. Cảm ơn bạn đã tin dùng AutoWash Pro!');
GO

PRINT '====================================================';
PRINT 'AutoWashProDB đã được tạo và cài đặt dữ liệu mẫu!';
PRINT '';
PRINT 'TÀI KHOẢN DEMO:';
PRINT '  Admin   : 0900000000 / admin123';
PRINT '  Member  : 0901234567 / 123456  (Nguyễn Văn Bình)';
PRINT '  Silver  : 0909999999 / 123456  (Trần Thị Lan)';
PRINT '  Gold    : 0908888888 / 123456  (Lê Minh Tuấn)';
PRINT '====================================================';
GO
