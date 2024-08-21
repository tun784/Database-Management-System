create database QL_SINHVIEN on primary
(
	name='QLSV_PRIMARY',
	filename='E:\QL_SINHVIEN\QLSV_PRIMARY.mdf',
	size=15MB,
	maxsize=30MB,
	filegrowth=10%
)
log on
(
	name='QLSV_LOG',
	filename='E:\QL_SINHVIEN\QLSV_LOG.ldf',
	size=10MB,
	maxsize=20MB,
	filegrowth=15%
);
go

use QL_SINHVIEN
go
sp_spaceused

-- Tạo bảng KHOA
CREATE TABLE KHOA (
    MAKHOA CHAR(10),
    TENKHOA NVARCHAR(100),
    CONSTRAINT PK_KHOA PRIMARY KEY (MAKHOA)
);

-- Tạo bảng LOP
CREATE TABLE LOP (
    MALOP CHAR(10),
    TENLOP NVARCHAR(20),
    MAKHOA CHAR(10),
    CONSTRAINT PK_LOP PRIMARY KEY (MALOP), 
    CONSTRAINT FK_LOP_KHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);

-- Tạo bảng SINHVIEN
CREATE TABLE SINHVIEN (
    MASV CHAR(10),
    HOTEN NVARCHAR(50),
    NGSINH DATE,
    DCHI NVARCHAR(200),
    GIOTTINH NVARCHAR(5),
    MALOP CHAR(10),
    CONSTRAINT PK_SINHVIEN PRIMARY KEY (MASV), 
    CONSTRAINT FK_SINHVIEN_LOP FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
);

-- Tạo bảng MONHOC
CREATE TABLE MONHOC (
    MAMH CHAR(10),
    TENMH NVARCHAR(100),
    SOTC INT,
    CONSTRAINT PK_MONHOC PRIMARY KEY (MAMH)
);

-- Tạo bảng KETQUA
CREATE TABLE KETQUA (
    MASV CHAR(10),
    MAMH CHAR(10),
    DIEM FLOAT,
    CONSTRAINT PK_KETQUA PRIMARY KEY (MASV, MAMH),
    CONSTRAINT FK_KETQUA_SINHVIEN FOREIGN KEY (MASV) REFERENCES SINHVIEN(MASV),
    CONSTRAINT FK_KETQUA_MONHOC FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)     
);

INSERT INTO KHOA (MAKHOA, TENKHOA)
VALUES 
('01', N'Công nghệ thông tin'),
('02', N'Điện - Điện tử'),
('03', N'Công nghệ Thực phẩm');
INSERT INTO LOP (MALOP, TENLOP, MAKHOA)
VALUES 
('L001', N'15CNTT1', '01'),
('L002', N'15CNTT2', '01'),
('L003', N'14ATTT', '01'),
('L004', N'14DTVT', '02'),
('L005', N'16ATTP1', '03'),
('L006', N'16ATTP2', '03');
SET DATEFORMAT dmy;
INSERT INTO SINHVIEN (MASV, HOTEN, NGSINH, DCHI, GIOTTINH, MALOP)
VALUES 
('SV01', N'Nguyễn Thị Lan', '15/07/2005', N'TPHCM', N'Nữ', 'L001'),
('SV02', N'Trần Thanh Tùng', '19/05/2005', N'Vũng Tàu', N'Nam', 'L001'),
('SV03', N'Trương Thị Huệ', '31/08/2002', N'Đà Nẵng', N'Nữ', 'L001'),
('SV04', N'Lê Văn Khánh', '18/01/2002', N'Vũng Tàu', N'Nam', 'L002'),
('SV05', N'Ngô Đình Việt', '27/09/2004', N'Đà Nẵng', N'Nam', 'L003'),
('SV06', N'Trần Thị Liễu', '18/02/2003', N'TPHCM', N'Nữ', 'L003'),
('SV07', N'Trần Thanh Nam', '22/06/2004', N'Đồng Nai', N'Nam', 'L004'),
('SV08', N'Phạm Hoài Phong', '08/12/2003', N'Tiền Giang', N'Nam', 'L004'),
('SV09', N'Trần Thị Tổ Anh', '28/11/2004', N'TPHCM', N'Nữ', 'L005'),
('SV10', N'Đỗ Thị Hạnh', '26/04/2004', N'Đồng Nai', N'Nữ', 'L006');
INSERT INTO MONHOC (MAMH, TENMH, SOTC)
VALUES 
('M001', N'Toán cao cấp A1', 3),
('M002', N'Lịch sử đảng', 2),
('M003', N'Chính trị', 2),
('M004', N'Cơ sở dữ liệu', 4),
('M005', N'Hệ quản trị CSDL', 4),
('M006', N'Lập trình C', 3),
('M007', N'Xử lý ảnh', 2),
('M008', N'Tin học cơ bản', 3),
('M009', N'Mạng máy tính', 2),
('M010', N'Toán rời rạc', 2),
('M011', N'Lập trình web', 3),
('M012', N'Công nghệ Java', 3);
INSERT INTO KETQUA (MASV, MAMH, DIEM)
VALUES 
('SV01', 'M001', 8),
('SV01', 'M002', 4),
('SV01', 'M003', 6),
('SV02', 'M001', 4),
('SV02', 'M004', 5),
('SV03', 'M002', 7),
('SV03', 'M006', 9),
('SV04', 'M004', 10),
('SV05', 'M005', 6),
('SV06', 'M006', 9),
('SV07', 'M008', 7),
('SV08', 'M001', 3),
('SV08', 'M002', 8),
('SV09', 'M003', 6),
('SV10', 'M002', 5);
SELECT * FROM KHOA;
SELECT * FROM LOP;
SELECT * FROM SINHVIEN;
SELECT * FROM MONHOC;
SELECT * FROM KETQUA;

-- d) Liệt kê mã sinh viên, họ tên và điểm trung bình của từng sinh viên.
--    Biết rằng điểm trung bình được tính theo công thức: 
--    ĐTB = (Điểm môn 1* Số tín chỉ môn 1 + Điểm môn 2 * Số tín chỉ môn 2 + ... + Điểm môn N * Số tín chỉ môn N)
--          ----------------------------------------------------------------------------------------------------
--                                                        Tổng TC

CREATE VIEW BANGAO
AS

SELECT SINHVIEN.MASV, HOTEN, SUM(SOTC*DIEM)/SUM(SOTC) AS N'DTB'
FROM SINHVIEN, MONHOC, KETQUA
WHERE SINHVIEN.MASV = KETQUA.MASV AND MONHOC.MAMH = KETQUA.MAMH
GROUP BY SINHVIEN.MASV, HOTEN

SELECT MONHOC.MAMH, SOTC, DIEM
FROM MONHOC, KETQUA
WHERE MONHOC.MAMH = KETQUA.MAMH