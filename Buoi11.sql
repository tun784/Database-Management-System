CREATE DATABASE Buoi11
ON PRIMARY 
(
    NAME = 'QLTV_PRIMARY',
    FILENAME = 'C:\LuuDuLieuSinhVien\Buoi11_PRIMARY.mdf',
    SIZE = 20MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 10MB
)
LOG ON
(
    NAME = 'QLTV_LOG',
    FILENAME = 'C:\LuuDuLieuSinhVien\Buoi11_LOG.ldf',
    SIZE = 5MB,
    MAXSIZE = 15MB,
    FILEGROWTH = 5MB
);
GO
USE Buoi11;
GO

--Bài 4.5
-- t1: Full Backup vào lúc 5pm thứ 7
BACKUP DATABASE QLDH 
TO DISK = 'C:\LuuDuLieuSinhVien\Backup\QLDH_Full_t1.bak'
WITH FORMAT;

-- t2: Log Backup vào lúc 12am thứ 2
BACKUP LOG QLDH 
TO DISK = 'C:\LuuDuLieuSinhVien\Backup\QLDH_Log_t2.bak';

-- t3: Differential Backup vào lúc 5pm thứ 3
BACKUP DATABASE QLDH 
TO DISK = 'C:\LuuDuLieuSinhVien\Backup\QLDH_Diff_t3.bak' 
WITH DIFFERENTIAL;

-- t4: Log Backup vào lúc 12am thứ 4
BACKUP LOG QLDH 
TO DISK = 'C:\LuuDuLieuSinhVien\Backup\QLDH_Log_t4.bak';

-- Khôi phục từ bản Full Backup
RESTORE DATABASE QLDH 
FROM DISK = 'C:\LuuDuLieuSinhVien\Backup\QLDH_Full_t1.bak'
WITH NORECOVERY;

-- Khôi phục từ bản Differential Backup
RESTORE DATABASE QLDH 
FROM DISK = 'C:\LuuDuLieuSinhVien\Backup\QLDH_Diff_t3.bak'
WITH NORECOVERY;

-- Khôi phục các Log Backup
RESTORE LOG QLDH 
FROM DISK = 'C:\LuuDuLieuSinhVien\Backup\QLDH_Log_t2.bak'
WITH NORECOVERY;

RESTORE LOG QLDH 
FROM DISK = 'C:\LuuDuLieuSinhVien\Backup\QLDH_Log_t4.bak'
WITH RECOVERY;

--Bài 4.6
-- Tạo tài khoản
CREATE LOGIN nguoiquantri1 WITH PASSWORD = 'YourPassword123';

-- Cấp quyền trên QLHV
USE QLHV;
CREATE USER nguoiquantri1 FOR LOGIN nguoiquantri1;
EXEC sp_addrolemember 'db_owner', 'nguoiquantri1';

-- Cấp quyền chỉ xem trên QLBH
GO
USE QLBH;
CREATE USER nguoiquantri1 FOR LOGIN nguoiquantri1;
EXEC sp_addrolemember 'db_datareader', 'nguoiquantri1';
GO
USE QLHV;
INSERT INTO HOCVIEN (MAHV, HOTENHV) VALUES ('HV01', 'Nguyen Van A');
INSERT INTO HOCVIEN (MAHV, HOTENHV) VALUES ('HV02', 'Tran Thi B');
-- Tạo tài khoản
CREATE LOGIN nguoidung1 WITH PASSWORD = 'AnotherPassword123';

-- Cấp quyền public trên QLHV
GO
USE QLHV;
CREATE USER nguoidung1 FOR LOGIN nguoidung1;
EXEC sp_addrolemember 'public', 'nguoidung1';

-- Cấp quyền đọc và ghi cho nguoidung1
GRANT SELECT, INSERT, UPDATE, DELETE ON DATABASE::QLHV TO nguoidung1;

--Bài 4.8
-- Tạo role BanGiamDoc
GO
USE QLBH;
CREATE ROLE BanGiamDoc;

-- Cấp quyền xem và chuyển tiếp
GRANT SELECT ON NHASX TO BanGiamDoc WITH GRANT OPTION;
GRANT SELECT ON NHACC TO BanGiamDoc WITH GRANT OPTION;
GRANT SELECT ON DONGIA TO BanGiamDoc WITH GRANT OPTION;

-- Thêm người dùng vào role
CREATE USER Binh FOR LOGIN Binh;
CREATE USER Thanh FOR LOGIN Thanh;
EXEC sp_addrolemember 'BanGiamDoc', 'Binh';
EXEC sp_addrolemember 'BanGiamDoc', 'Thanh';
-- Tạo role BoPhanThuNgan
CREATE ROLE BoPhanThuNgan;

-- Cấp quyền xem và thao tác trên hóa đơn
GRANT SELECT ON HANG TO BoPhanThuNgan;
GRANT SELECT ON DONGIA TO BoPhanThuNgan;
GRANT INSERT, UPDATE ON HOADON TO BoPhanThuNgan;
GRANT INSERT, UPDATE ON CHITIETHD TO BoPhanThuNgan;

-- Thêm người dùng vào role
CREATE USER Hai FOR LOGIN Hai;
CREATE USER Chau FOR LOGIN Chau;
EXEC sp_addrolemember 'BoPhanThuNgan', 'Hai';
EXEC sp_addrolemember 'BoPhanThuNgan', 'Chau';
-- Tạo role BoPhanKinhDoanh
CREATE ROLE BoPhanKinhDoanh;

-- Cấp quyền thao tác trên bảng KHACH
GRANT INSERT, UPDATE, DELETE ON KHACH TO BoPhanKinhDoanh;

-- Thêm người dùng vào role
CREATE USER Minh FOR LOGIN Minh;
CREATE USER An FOR LOGIN An;
CREATE USER Ngoc FOR LOGIN Ngoc;
EXEC sp_addrolemember 'BoPhanKinhDoanh', 'Minh';
EXEC sp_addrolemember 'BoPhanKinhDoanh', 'An';
EXEC sp_addrolemember 'BoPhanKinhDoanh', 'Ngoc';
-- Tạo role BoPhanKho
CREATE ROLE BoPhanKho;

-- Cấp quyền thao tác trên các bảng liên quan
GRANT INSERT, UPDATE, DELETE ON HANG TO BoPhanKho;
GRANT INSERT, UPDATE, DELETE ON NHACC TO BoPhanKho;
GRANT INSERT, UPDATE, DELETE ON NHASX TO BoPhanKho;
GRANT INSERT ON PHIEUNHAP TO BoPhanKho;
GRANT UPDATE ON DONGIA TO BoPhanKho;

-- Thêm người dùng vào role
CREATE USER Tuan FOR LOGIN Tuan;
CREATE USER Long FOR LOGIN Long;
EXEC sp_addrolemember 'BoPhanKho', 'Tuan';
EXEC sp_addrolemember 'BoPhanKho', 'Long';
REVOKE GRANT OPTION FOR SELECT ON NHASX FROM BanGiamDoc;
REVOKE GRANT OPTION FOR SELECT ON NHACC FROM BanGiamDoc;
REVOKE GRANT OPTION FOR SELECT ON DONGIA FROM BanGiamDoc;
