-- Tạo CSDL
CREATE DATABASE QL_NHANVIEN
USE QL_NHANVIEN
/*-----------------------------------------------------------------------------------------*/
-- Tạo bảng
CREATE TABLE PHONGBAN
(
	MAPH CHAR(5) NOT NULL,
	TENPH NVARCHAR(30)NOT NULL,
	DIADIEM NVARCHAR(40)
	CONSTRAINT PK_PHONGBAN PRIMARY KEY(MAPH)
)
CREATE TABLE NHANVIEN
(
	MANV CHAR(6) NOT NULL,
	HOTEN NVARCHAR(40)NOT NULL,
	NGAYSINH DATE,
	PHAI NVARCHAR(3),
	DIACHI NVARCHAR(40),
	LUONG MONEY,
	MANQL CHAR(6),
	MAPH CHAR(5),
	CONSTRAINT PK_NHANVIEN PRIMARY KEY(MANV),
	CONSTRAINT FK_NV_PH FOREIGN KEY(MAPH) REFERENCES PHONGBAN(MAPH),
	CONSTRAINT FK_NV_NV FOREIGN KEY(MANQL) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE DEAN
 (
	MADA CHAR(5) NOT NULL,
	TENDA NVARCHAR(50),
	DIADIEMDA NVARCHAR(30),
	NGAYBD DATE,
	CONSTRAINT PK_DEAN PRIMARY KEY (MADA)
 )

 CREATE TABLE PHANCONG
 (
	MANV CHAR(6) NOT NULL,
	MADA CHAR(5) NOT NULL,
	NGAYPC DATE,
	CONSTRAINT PK_PC PRIMARY KEY (MANV, MADA),
	CONSTRAINT FK_PC_NV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_PC_DA FOREIGN KEY (MADA) REFERENCES DEAN(MADA)
 )
 
 CREATE TABLE THANNHAN
 (
	MANV CHAR(6) NOT NULL,
	TENTN NVARCHAR(40) NOT NULL,
	PHAI NCHAR(3),
	NGAYSINH DATE,
	QUANHE NVARCHAR(15),
	CONSTRAINT PK_THANNHAN PRIMARY KEY(MANV, TENTN),
	CONSTRAINT FK_TN_NV FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV)
 )
 CREATE TABLE THENHANVIEN
 (
	MATHE CHAR(6) NOT NULL,
	NGAYCAP DATE,
	MANV CHAR(6)
	CONSTRAINT PK_THENHANVIEN PRIMARY KEY(MATHE),
	CONSTRAINT FK_THENV_NV FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV)
)
/*-----------------------------------------------------------------------------------------*/
