-- =====================================================
-- AUTOWASH PRO — DATABASE SCHEMA & DỮ LIỆU MẪU
-- =====================================================
-- Tác giả: AutoWash Pro Development Team
-- Mục đích: Tạo toàn bộ cơ sở dữ liệu cho hệ thống 
--           quản lý rửa xe với chương trình loyalty.
-- Hướng dẫn: Chạy file này trên SQL Server Management 
--            Studio (SSMS) để khởi tạo database.
-- =====================================================

-- Bước 1: Tạo Database mới (nếu chưa tồn tại)
-- Nếu đã có database cùng tên, xóa và tạo lại
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'AutoWashProDB')
BEGIN
    ALTER DATABASE AutoWashProDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AutoWashProDB;
END
GO

CREATE DATABASE AutoWashProDB;
GO

USE AutoWashProDB;
GO

-- =====================================================
-- BẢNG 1: Tiers (Hạng thẻ thành viên)
-- =====================================================
-- Vai trò: Cấu hình các mức hạng thẻ loyalty.
-- Mỗi hạng có điều kiện nâng hạng riêng (số lần rửa 
-- hoặc tổng chi tiêu) và hệ số nhân điểm thưởng.
-- =====================================================
CREATE TABLE Tiers (
    TierId      VARCHAR(20)     PRIMARY KEY,           -- Mã hạng (MEMBER, SILVER, GOLD, PLATINUM)
    TierName    NVARCHAR(50)    NOT NULL,              -- Tên hiển thị cho khách hàng
    MinWashes   INT             NOT NULL DEFAULT 0,    -- Số lần rửa tối thiểu để đạt hạng này
    MinSpent    DECIMAL(15,2)   NOT NULL DEFAULT 0,    -- Tổng chi tiêu tối thiểu (VNĐ) để đạt hạng
    Multiplier  FLOAT           NOT NULL DEFAULT 1.0,  -- Hệ số nhân tích điểm (1.0 = cơ bản)
    BookingDays INT             NOT NULL DEFAULT 7      -- Số ngày tối đa được đặt trước
);
GO

-- =====================================================
-- BẢNG 2: Users (Người dùng hệ thống)
-- =====================================================
-- Vai trò: Lưu trữ thông tin tất cả người dùng bao gồm
-- Khách hàng (CUSTOMER), Nhân viên (STAFF), và Quản trị 
-- viên (ADMIN). Mỗi user có ví điểm thưởng riêng.
-- =====================================================
CREATE TABLE Users (
    UserId          INT IDENTITY(1,1)   PRIMARY KEY,           -- ID tự tăng
    PhoneNumber     VARCHAR(15)         NOT NULL UNIQUE,       -- Số điện thoại (dùng để đăng nhập)
    Password        VARCHAR(255)        NOT NULL,              -- Mật khẩu (nên mã hóa khi deploy thực tế)
    FullName        NVARCHAR(100)       NOT NULL,              -- Họ tên đầy đủ
    Role            VARCHAR(20)         NOT NULL DEFAULT 'CUSTOMER', -- Vai trò: CUSTOMER, STAFF, ADMIN
    CurrentTierId   VARCHAR(20)         DEFAULT 'MEMBER',      -- Hạng thẻ hiện tại (FK → Tiers)
    PointsBalance   INT                 DEFAULT 0,             -- Số điểm thưởng hiện có trong ví
    TotalSpent      DECIMAL(15,2)       DEFAULT 0,             -- Tổng tiền đã chi tiêu (VNĐ)
    TotalWashes     INT                 DEFAULT 0,             -- Tổng số lần rửa xe đã hoàn thành
    CreatedAt       DATETIME            DEFAULT GETDATE(),     -- Thời điểm tạo tài khoản

    -- Ràng buộc: Hạng thẻ phải tồn tại trong bảng Tiers
    CONSTRAINT FK_Users_Tiers FOREIGN KEY (CurrentTierId) REFERENCES Tiers(TierId),
    -- Ràng buộc: Role chỉ được phép 3 giá trị
    CONSTRAINT CK_Users_Role CHECK (Role IN ('CUSTOMER', 'STAFF', 'ADMIN'))
);
GO

-- =====================================================
-- BẢNG 3: LicensePlates (Biển số xe)
-- =====================================================
-- Vai trò: Mỗi khách hàng có thể đăng ký nhiều xe.
-- Biển số xe là duy nhất trong toàn hệ thống.
-- =====================================================
CREATE TABLE LicensePlates (
    PlateId         INT IDENTITY(1,1)   PRIMARY KEY,
    UserId          INT                 NOT NULL,              -- Chủ xe (FK → Users)
    PlateNumber     VARCHAR(20)         NOT NULL UNIQUE,       -- Biển số xe (VD: 30A1-1234)
    VehicleModel    NVARCHAR(100),                             -- Tên/loại xe (VD: Toyota Camry 2024)
    CreatedAt       DATETIME            DEFAULT GETDATE(),

    CONSTRAINT FK_LicensePlates_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
GO

-- =====================================================
-- BẢNG 4: Bookings (Lịch đặt rửa xe)
-- =====================================================
-- Vai trò: Quản lý tất cả các lượt đặt lịch rửa xe.
-- Trạng thái chuyển đổi: PENDING → COMPLETED / CANCELLED
-- =====================================================
CREATE TABLE Bookings (
    BookingId       INT IDENTITY(1,1)   PRIMARY KEY,
    UserId          INT                 NOT NULL,              -- Khách đặt lịch (FK → Users)
    PlateId         INT                 NOT NULL,              -- Xe được rửa (FK → LicensePlates)
    BookingDate     DATE                NOT NULL,              -- Ngày hẹn rửa xe
    TimeSlot        VARCHAR(20)         NOT NULL,              -- Khung giờ (VD: "08:00-09:00")
    Status          VARCHAR(20)         NOT NULL DEFAULT 'PENDING', -- Trạng thái đặt lịch
    Notes           NVARCHAR(255),                             -- Ghi chú thêm từ khách hàng
    CreatedAt       DATETIME            DEFAULT GETDATE(),

    CONSTRAINT FK_Bookings_Users FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_Bookings_Plates FOREIGN KEY (PlateId) REFERENCES LicensePlates(PlateId),
    CONSTRAINT CK_Bookings_Status CHECK (Status IN ('PENDING', 'COMPLETED', 'CANCELLED'))
);
GO

-- =====================================================
-- BẢNG 5: LoyaltyTransactions (Lịch sử giao dịch điểm)
-- =====================================================
-- Vai trò: Ghi lại mọi giao dịch tích điểm (EARN) và 
-- đổi điểm (REDEEM) của khách hàng. Đây là bảng audit 
-- trail để truy vết lịch sử điểm thưởng.
-- =====================================================
CREATE TABLE LoyaltyTransactions (
    TransactionId       INT IDENTITY(1,1)   PRIMARY KEY,
    UserId              INT                 NOT NULL,          -- Khách hàng (FK → Users)
    Type                VARCHAR(10)         NOT NULL,          -- Loại: EARN (tích) hoặc REDEEM (đổi)
    Points              INT                 NOT NULL,          -- Số điểm giao dịch
    RelatedBillAmount   DECIMAL(15,2),                         -- Số tiền hóa đơn liên quan (nếu có)
    CreatedAt           DATETIME            DEFAULT GETDATE(),

    CONSTRAINT FK_LoyaltyTrans_Users FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT CK_LoyaltyTrans_Type CHECK (Type IN ('EARN', 'REDEEM'))
);
GO

-- =====================================================
-- BẢNG 6: Notifications (Thông báo cá nhân)
-- =====================================================
-- Vai trò: Hộp thư thông báo cho từng người dùng.
-- Hệ thống tự động tạo thông báo khi: thanh toán thành 
-- công, thăng hạng thẻ, nhắc lịch hẹn, v.v.
-- =====================================================
CREATE TABLE Notifications (
    NotificationId  INT IDENTITY(1,1)   PRIMARY KEY,
    UserId          INT                 NOT NULL,              -- Người nhận (FK → Users)
    Title           NVARCHAR(150)       NOT NULL,              -- Tiêu đề thông báo
    Content         NVARCHAR(MAX),                             -- Nội dung chi tiết
    IsRead          BIT                 DEFAULT 0,             -- 0 = Chưa đọc, 1 = Đã đọc
    CreatedAt       DATETIME            DEFAULT GETDATE(),

    CONSTRAINT FK_Notifications_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
GO

-- =====================================================
-- DỮ LIỆU CẤU HÌNH: 4 Hạng Thẻ Thành Viên
-- =====================================================
-- Giải thích Multiplier: Khi khách chi 1.000 VNĐ thì 
-- nhận được 1 điểm cơ sở × Multiplier. VD: Hạng GOLD 
-- chi 100.000 VNĐ → 100 × 1.2 = 120 điểm.
-- =====================================================
INSERT INTO Tiers (TierId, TierName, MinWashes, MinSpent, Multiplier, BookingDays) VALUES
('MEMBER',   N'Thành Viên',    0,          0,              1.0, 7),
('SILVER',   N'Bạc',           5,    2000000.00,           1.1, 10),
('GOLD',     N'Vàng',         15,    6000000.00,           1.2, 12),
('PLATINUM', N'Bạch Kim',     30,   15000000.00,           1.3, 14);
GO

-- =====================================================
-- DỮ LIỆU MẪU: Người dùng (để test ngay)
-- =====================================================
-- Mật khẩu mẫu: "123456" (plaintext cho mục đích demo)
-- Trong thực tế nên mã hóa bằng BCrypt hoặc SHA-256.
-- =====================================================

-- Admin: Quản trị hệ thống
INSERT INTO Users (PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes)
VALUES ('0901234567', '123456', N'Nguyễn Admin', 'ADMIN', 'MEMBER', 0, 0, 0);

-- Staff: Nhân viên tiếp đón & thanh toán
INSERT INTO Users (PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes)
VALUES ('0912345678', '123456', N'Trần Nhân Viên', 'STAFF', 'MEMBER', 0, 0, 0);

-- Customer 1: Khách hàng hạng GOLD (đã dùng dịch vụ nhiều)
INSERT INTO Users (PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes)
VALUES ('0923456789', '123456', N'Lê Văn Bình', 'CUSTOMER', 'GOLD', 1500, 6500000.00, 18);

-- Customer 2: Khách hàng mới (hạng MEMBER)
INSERT INTO Users (PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes)
VALUES ('0934567890', '123456', N'Phạm Thị Mai', 'CUSTOMER', 'MEMBER', 50, 150000.00, 1);
GO

-- =====================================================
-- DỮ LIỆU MẪU: Biển số xe
-- =====================================================
-- Biển số theo format Việt Nam: 30A1-1234
-- =====================================================
INSERT INTO LicensePlates (UserId, PlateNumber, VehicleModel) VALUES
(3, '30A1-99999', N'Toyota Camry 2024'),
(3, '51F1-12345', N'Honda Civic 2023'),
(4, '43C2-88888', N'Mazda 3 2025');
GO

-- =====================================================
-- DỮ LIỆU MẪU: Lịch đặt rửa xe
-- =====================================================
INSERT INTO Bookings (UserId, PlateId, BookingDate, TimeSlot, Status, Notes) VALUES
(3, 1, DATEADD(DAY, 1, CAST(GETDATE() AS DATE)), '09:00-10:00', 'PENDING', N'Rửa kỹ gầm xe'),
(3, 2, DATEADD(DAY, 3, CAST(GETDATE() AS DATE)), '14:00-15:00', 'PENDING', NULL),
(4, 3, DATEADD(DAY, 2, CAST(GETDATE() AS DATE)), '10:00-11:00', 'PENDING', N'Xe mới, rửa nhẹ nhàng');
GO

-- =====================================================
-- DỮ LIỆU MẪU: Lịch sử giao dịch điểm
-- =====================================================
INSERT INTO LoyaltyTransactions (UserId, Type, Points, RelatedBillAmount) VALUES
(3, 'EARN',   180, 150000.00),
(3, 'EARN',   240, 200000.00),
(3, 'REDEEM', 100, NULL),
(3, 'EARN',   360, 300000.00),
(4, 'EARN',    50, 50000.00);
GO

-- =====================================================
-- DỮ LIỆU MẪU: Thông báo
-- =====================================================
INSERT INTO Notifications (UserId, Title, Content, IsRead) VALUES
(3, N'Chúc mừng thăng hạng!', N'Bạn đã được nâng lên hạng Vàng (GOLD)! Từ giờ mỗi lần rửa xe bạn sẽ nhận được gấp 1.2 lần điểm thưởng.', 1),
(3, N'Đặt lịch thành công', N'Bạn đã đặt lịch rửa xe 30A1-99999 vào ngày mai lúc 09:00. Hẹn gặp bạn tại AutoWash Pro!', 0),
(3, N'Ưu đãi đặc biệt!', N'Hạng Vàng của bạn sắp được nâng lên Bạch Kim! Chỉ còn 12 lượt rửa nữa thôi. Hãy đặt lịch ngay!', 0),
(4, N'Chào mừng đến AutoWash Pro!', N'Cảm ơn bạn đã đăng ký tài khoản. Hãy thêm xe và đặt lịch rửa ngay để bắt đầu tích điểm nhé!', 0);
GO

-- =====================================================
-- XÁC MINH: Kiểm tra dữ liệu đã chèn thành công
-- =====================================================
PRINT N'=== KIỂM TRA DỮ LIỆU ===';
PRINT N'';

SELECT 'Tiers' AS TableName, COUNT(*) AS RecordCount FROM Tiers
UNION ALL
SELECT 'Users', COUNT(*) FROM Users
UNION ALL
SELECT 'LicensePlates', COUNT(*) FROM LicensePlates
UNION ALL
SELECT 'Bookings', COUNT(*) FROM Bookings
UNION ALL
SELECT 'LoyaltyTransactions', COUNT(*) FROM LoyaltyTransactions
UNION ALL
SELECT 'Notifications', COUNT(*) FROM Notifications;

PRINT N'';
PRINT N'✅ Database AutoWashProDB đã được tạo thành công!';
PRINT N'📋 Tổng cộng: 6 bảng, 4 hạng thẻ, 4 người dùng mẫu.';
PRINT N'🔑 Đăng nhập thử: SĐT 0923456789 / Mật khẩu 123456 (Khách hạng GOLD)';
GO
