﻿create database QLDH_MSSV;

use QLDH_MSSV;

CREATE TABLE NHACC(
	MANCC CHAR(10) NOT NULL,
	TENNCC NVARCHAR(50),
	DCHI NVARCHAR(50),
	DTHOAI CHAR(10),
	CONSTRAINT PK_NHACC PRIMARY KEY (MANCC)
)
create table MATHANG(
	MAMH CHAR(10) NOT NULL,
	TENMH NVARCHAR(50),
	DVT NVARCHAR(50),
	SLTON INT,
	DONGIA MONEY,
	CONSTRAINT PK_MATHANG PRIMARY KEY (MAMH)
)
CREATE TABLE PHIEUDATHANG(
	MADH CHAR(10) NOT NULL,
	NGAYDH DATE,
	NGAYGIAODK DATE,
	MANCC CHAR(10),
	THANHTIEN MONEY,
	TINHTRANG NVARCHAR(50),
	CONSTRAINT PK_PHIEUDATHANG PRIMARY KEY (MADH),
	CONSTRAINT FK_PHIEUDATHANG_NHACC FOREIGN KEY (MANCC) REFERENCES NHACC(MANCC)
)
CREATE TABLE CTDH(
	MADH CHAR(10) NOT NULL,
	MAMH CHAR(10) NOT NULL,
	SLDAT INT,
	DGDAT MONEY,
	CONSTRAINT PK_CTDH PRIMARY KEY (MADH, MAMH),
	CONSTRAINT FK_CTDH_PHIEUDATHANG FOREIGN KEY (MADH) REFERENCES PHIEUDATHANG(MADH),
	CONSTRAINT FK_CTDH_MATHANG FOREIGN KEY (MAMH) REFERENCES MATHANG(MAMH)
)
--------------------------------------------------------------------------------------

INSERT INTO NHACC (MANCC, TENNCC, DCHI, DTHOAI) VALUES 
('NCC01', N'Bình An', N'123 Đường A', '0123456789'),
('NCC02', N'Trường Thịnh', N'456 Đường B', '0987654321'),
('NCC03', N'Thành Công', N'789 Đường C', '0222333444'),
('NCC04', N'Phát Đạt', N'321 Đường D', '0333444555'),
('NCC05', N'Hòa Phát', N'654 Đường E', '0444555666');
select * from NHACC
INSERT INTO MATHANG (MAMH, TENMH, DVT, SLTON, DONGIA) VALUES 
('MH01', N'Mặt hàng 1', N'Cái', 100, 20000),
('MH02', N'Mặt hàng 2', N'Thùng', 50, 500000),
('MH03', N'Mặt hàng 3', N'Kg', 200, 15000),
('MH04', N'Mặt hàng 4', N'Hộp', 80, 75000),
('MH05', N'Mặt hàng 5', N'Chai', 120, 25000);
select * from MATHANG
INSERT INTO PHIEUDATHANG (MADH, NGAYDH, NGAYGIAODK, MANCC, THANHTIEN, TINHTRANG) VALUES 
('PD01', '2024-05-20', '2024-05-25', 'NCC01', 1200000, N'Chưa giao'),
('PD02', '2024-05-21', '2024-05-26', 'NCC01', 800000, N'Chưa giao'),
('PD03', '2024-05-22', '2024-05-27', 'NCC02', 1500000, N'Chưa giao'),
('PD04', '2024-05-23', '2024-05-28', 'NCC03', 500000, N'Đã giao'),
('PD05', '2024-05-24', '2024-05-29', 'NCC01', 1100000, N'Chưa giao'),
('PD06', '2024-05-25', '2024-05-30', 'NCC01', 1300000, N'Chưa giao'),
('PD07', '2024-05-26', '2024-05-31', 'NCC01', 1400000, N'Chưa giao'),
('PD08', '2024-05-27', '2024-06-01', 'NCC01', 1500000, N'Chưa giao');
select * from PHIEUDATHANG
INSERT INTO CTDH (MADH, MAMH, SLDAT, DGDAT) VALUES 
('PD01', 'MH01', 20, 20000),
('PD01', 'MH03', 40, 15000),
('PD02', 'MH02', 1, 500000),
('PD03', 'MH04', 10, 75000),
('PD03', 'MH05', 20, 25000),
('PD04', 'MH01', 10, 20000),
('PD05', 'MH02', 2, 500000),
('PD05', 'MH03', 20, 15000);
select * from CTDH
---------------------------------------------------------------------------------------
--1. Cho biết danh sách các phiếu đặt hàng của nhà cung cấp Bình An có trị giá trên 1 triệu và tình trạng là “Chưa giao”
select MADH, TENNCC, NGAYDH, NGAYGIAODK, THANHTIEN, TINHTRANG
from PHIEUDATHANG, NHACC
where NHACC.MANCC = (select MANCC from NHACC where TENNCC = N'Bình An')
  and THANHTIEN > 1000000
  and TINHTRANG = N'Chưa giao';
--2. Cho biết mã và tên các mặt hàng được đặt trong phiếu đặt hàng có mã: "PD01"
SELECT MAMH, TENMH
FROM MATHANG
WHERE MAMH IN (SELECT MAMH FROM CTDH WHERE MADH = 'PD01')
--3. Cho biết nhà cung cấp nào (MANCC, TENNCC) có trên 3 đơn hàng chưa giao.
SELECT MANCC, TENNCC
FROM NHACC
WHERE MANCC IN (
  SELECT MANCC
  FROM PHIEUDATHANG
  WHERE TINHTRANG = N'Chưa giao'
  GROUP BY MANCC
  HAVING COUNT(MADH) > 3
);