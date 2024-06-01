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
--Phần làm bài
--1. Cập nhật tổng tiền cho mỗi hóa đơn theo công thức sau: TONGTIEN = Σ (SOLUONG * DONGIA)
UPDATE HOADON
SET TONGTIEN = (
    SELECT SUM(SOLUONG * DONGIA)
    FROM CHITIETHD
    WHERE CHITIETHD.MAHD = HOADON.MAHD
);
--2. Cho biết tên những linh kiện được sản xuất bởi nhà sản xuất Genius và có đơn vị tính là Cái.
SELECT TENLK
FROM LINHKIEN
WHERE NSX = N'Genius' AND DVT = N'Cái';
--3. Cho biết thông tin những linh kiện có thời gian bảo hành là 24 tháng.
SELECT *
FROM LINHKIEN
WHERE TGBH = 24;
--4. Hoá đơn nào được lập trong tháng 06/2016?
SELECT MAHD
FROM HOADON
WHERE MONTH(NGAYHD) = 6 AND YEAR(NGAYHD) = 2016;
--5. Tên và đơn vị tính của các linh kiện có đơn giá lớn hơn 1.000.000 VND.
SELECT DISTINCT L.TENLK, L.DVT
FROM LINHKIEN L
JOIN CHITIETHD C ON L.MALK = C.MALK
WHERE C.DONGIA > 1000000;
--6. Thông tin những linh kiện (MALK, TENLK, NSX, DVT) được bán ra trước ngày 31/05/2015.
SELECT DISTINCT L.MALK, L.TENLK, L.NSX, L.DVT
FROM LINHKIEN L
JOIN CHITIETHD C ON L.MALK = C.MALK
JOIN HOADON H ON C.MAHD = H.MAHD
WHERE H.NGAYHD < '2015-05-31';
--7. Cho biết danh sách những khách hàng mua linh kiện trong tháng 06/2016 có địa chỉ ở TP. HCM.
SELECT DISTINCT K.TENKH
FROM KHACHHANG K
JOIN HOADON H ON K.MAKH = H.MAKH
WHERE K.DIACHI = N'TP. HCM' AND MONTH(H.NGAYHD) = 6 AND YEAR(H.NGAYHD) = 2016;
--8. Cho biết tổng số lượng linh kiện trong hoá đơn HD007.
SELECT SUM(SOLUONG) AS TONG_SOLUONG
FROM CHITIETHD
WHERE MAHD = 'HD007';
--9. Trong tháng 05/2016 có bao nhiêu khách hàng ở Tây Ninh đến mua hàng?
SELECT COUNT(DISTINCT K.MAKH) AS SO_KHACH_HANG
FROM KHACHHANG K
JOIN HOADON H ON K.MAKH = H.MAKH
WHERE K.DIACHI = N'Tây Ninh' AND MONTH(H.NGAYHD) = 5 AND YEAR(H.NGAYHD) = 2016;
--10. Cho biết số điện thoại và địa chỉ của khách hàng có mã KH001.
SELECT DIENTHOAI, DIACHI
FROM KHACHHANG
WHERE MAKH = 'KH001';
--11. Trong tháng 05/2016 đã lập bao nhiêu đơn hàng?
SELECT COUNT(MAHD) AS SO_DON_HANG
FROM HOADON
WHERE MONTH(NGAYHD) = 5 AND YEAR(NGAYHD) = 2016;
--12. Tổng tiền của hoá đơn HD006 là bao nhiêu?
SELECT TONGTIEN
FROM HOADON
WHERE MAHD = 'HD006';
--13. Tổng tiền của 2 hoá đơn HD005 và HD007 là bao nhiêu?
SELECT SUM(TONGTIEN) AS TONG_TIEN
FROM HOADON
WHERE MAHD IN ('HD005', 'HD007');
--14. Liệt kê mã hoá đơn và số linh kiện khác nhau trong từng hoá đơn.
SELECT MAHD, COUNT(DISTINCT MALK) AS SO_LINH_KIEN
FROM CHITIETHD
GROUP BY MAHD;
--15. Cho biết tên nhà sản xuất và số linh kiện đã bán của từng nhà sản xuất.
SELECT L.NSX, COUNT(C.MALK) AS SO_LINH_KIEN
FROM LINHKIEN L
JOIN CHITIETHD C ON L.MALK = C.MALK
GROUP BY L.NSX;
--16. Liệt kê mã hoá đơn và tổng tiền của từng hoá đơn.
SELECT MAHD, TONGTIEN
FROM HOADON;
--17. Lập danh sách bao gồm tên khách hàng và mã hoá đơn có tổng tiền lớn hơn 10.000.000 VND.
SELECT K.TENKH, H.MAHD
FROM KHACHHANG K
JOIN HOADON H ON K.MAKH = H.MAKH
WHERE H.TONGTIEN > 10000000;
--18. Mỗi loại linh kiện có bao nhiêu linh kiện.
SELECT MALOAI, COUNT(MALK) AS SO_LUONG
FROM LINHKIEN
GROUP BY MALOAI;
--19. Những hoá đơn nào (MAHD) có số linh kiện lớn hơn 10?
SELECT MAHD
FROM CHITIETHD
GROUP BY MAHD
HAVING SUM(SOLUONG) > 10;
--20. Cho biết trị giá của những hoá đơn được lập ngày 07/07/2016.
SELECT TONGTIEN
FROM HOADON
WHERE NGAYHD = '2016-07-07';
--21. Cho biết tên và số lượng của từng mặt hàng trong hoá đơn HD007.
SELECT L.TENLK, C.SOLUONG
FROM CHITIETHD C
JOIN LINHKIEN L ON C.MALK = L.MALK
WHERE C.MAHD = 'HD007';
