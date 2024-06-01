--Chạy câu lệnh này đầu tiên
CREATE DATABASE QL_LINHKIEN;
--Chạy câu lệnh này lần thứ 2
USE QL_LINHKIEN;
--Chạy tất cả dòng lệnh bên dưới tới phần Nhập dữ liệu
CREATE TABLE LINHKIEN(
	MALK CHAR(10) NOT NULL, -- Mã linh kiện
	TENLK NVARCHAR(50), --Tên linh kiện
	NGAYSX DATE, --Ngày sản xuất
	TGBH INT, --Thời gian bảo hành
	MALOAI CHAR(10), --Mã loại
	NSX NVARCHAR(50), -- NHÀ SẢN XUẤT
	DVT NVARCHAR(10), --Đơn vị tính
	CONSTRAINT PK_LINHLIEN PRIMARY KEY(MALK)
)
CREATE TABLE KHACHHANG(
	MAKH CHAR(10) NOT NULL,
	TENKH NVARCHAR(50),
	DIACHI NVARCHAR(50), --Địa chỉ
	DIENTHOAI CHAR(12), --số điện thoại
	CONSTRAINT PK_KHACHHANG PRIMARY KEY (MAKH),
)
CREATE TABLE HOADON(
	MAHD CHAR(10) NOT NULL,
	NGAYHD DATE, --Ngày xuất hóa đơn
	MAKH CHAR(10),
	TONGTIEN MONEY,
	CONSTRAINT PK_HOADON PRIMARY KEY (MAHD),
	CONSTRAINT FK_HOADON_KHACHHANG FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH)
)
CREATE TABLE CHITIETHD(
	MAHD CHAR(10) NOT NULL,
	MALK CHAR(10) NOT NULL,
	SOLUONG INT,
	DONGIA MONEY, --Đơn giá
	CONSTRAINT PK_CHITIETHD PRIMARY KEY (MAHD, MALK),
	CONSTRAINT FK_CHITIETHD_HOADON FOREIGN KEY (MAHD) REFERENCES HOADON(MAHD),
	CONSTRAINT FK_CHITIETHD_LINHKIEN FOREIGN KEY (MALK) REFERENCES LINHKIEN(MALK)
)
---------------------------------------------------------------------------------------------------------
--Nhập dữ liệu
-- Chèn dữ liệu vào bảng LINHKIEN
SET DATEFORMAT DMY;
INSERT INTO LINHKIEN (MALK, TENLK, NGAYSX, TGBH, MALOAI, NSX, DVT) VALUES
('MOU001', N'Chuột quang có dây', '01/01/2014', 12, 'MOU', N'Genius', N'Cái'),
('MOU002', N'Chuột quang không dây', '04/02/2015', 12, 'MOU', N'Mitsumi', N'Cái'),
('MOU003', N'Chuột không dây', '02/04/2014', 24, 'MOU', N'Abroad', N'Cái'),
('CPU001', N'CPU ADM', '05/04/2015', 24, 'CPU', N'Abroad', N'Cái'),
('CPU002', N'CPU INTEL', '07/02/2016', 36, 'CPU', N'Mitsumi', N'Cái'),
('CPU003', N'CPU ASUS', '08/12/2015', 36, 'CPU', N'Abroad', N'Cái'),
('MAI001', N'Mainboard ASUS', '04/12/2015', 36, NULL, N'Mitsumi', N'Cái'),
('MAI002', N'Mainboard ATXX', '03/03/2016', 12, NULL, N'Mitsumi', N'Cái'),
('MAI003', N'Mainboard ACER', '14/04/2015', 12, NULL, N'Genius', N'Cái'),
('PCX001', N'Acer', '19/10/2015', 12, NULL, N'Acer', N'Bộ');

-- Chèn dữ liệu vào bảng KHACHHANG
INSERT INTO KHACHHANG (MAKH, TENKH, DIACHI, DIENTHOAI) VALUES
('KH001', N'Nguyễn Thu Tâm', N'Tây Ninh', '0989751723'),
('KH002', N'Đinh Bảo Lộc', N'Lâm Đồng', '0918234654'),
('KH003', N'Trần Thanh Diệu', N'TP. HCM', '0978123765'),
('KH004', N'Hồ Tuấn Thành', N'Hà Nội', '0909456768'),
('KH005', N'Huỳnh Kim Ánh', N'Khánh Hòa', '0932987567');

-- Chèn dữ liệu vào bảng HOADON
INSERT INTO HOADON (MAHD, NGAYHD, MAKH, TONGTIEN) VALUES
('HD001', '01/04/2015', 'KH001', NULL),
('HD002', '15/05/2016', 'KH005', NULL),
('HD003', '14/06/2016', 'KH004', NULL),
('HD004', '03/06/2016', 'KH005', NULL),
('HD005', '05/06/2016', 'KH001', NULL),
('HD006', '07/07/2016', 'KH003', NULL),
('HD007', '12/08/2016', 'KH002', NULL),
('HD008', '25/09/2016', 'KH003', NULL);

-- Chèn dữ liệu vào bảng CHITIETHD
INSERT INTO CHITIETHD (MAHD, MALK, SOLUONG, DONGIA) VALUES
('HD001', 'MOU001', 2, 1000000),
('HD002', 'MOU002', 1, 2000000),
('HD003', 'MOU003', 6, 3000000),
('HD004', 'CPU001', 5, 500000),
('HD005', 'CPU002', 6, 560000),
('HD006', 'CPU003', 3, 400000),
('HD006', 'MAI001', 1, 200000),
('HD007', 'MAI002', 1, 150000),
('HD007', 'MAI003', 2, 160000),
('HD007', 'MOU001', 1, 1000000),
('HD008', 'CPU001', 2, 500000);
SELECT * FROM LINHKIEN;
SELECT * FROM KHACHHANG;
SELECT * FROM HOADON;
SELECT * FROM CHITIETHD;
---------------------------------------------------------------------------------------------------------
