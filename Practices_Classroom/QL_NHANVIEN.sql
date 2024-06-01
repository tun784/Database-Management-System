CREATE DATABASE QL_NHANVIEN;

USE QL_NHANVIEN;

CREATE TABLE PHONGBAN(
	MAPH CHAR(10) NOT NULL,
	TENPH NVARCHAR(50) NOT NULL,
	DIADIEM NVARCHAR(50),
	CONSTRAINT PK_PHONGBAN PRIMARY KEY(MAPH)
)
CREATE TABLE NHANVIEN(
	MANV CHAR(10) NOT NULL,
	HOTEN NVARCHAR(50) NOT NULL,
	NGAYSINH DATE,
	PHAI NVARCHAR(10),
	DIACHI NVARCHAR(50),
	LUONG MONEY,
	MANQL CHAR(10),
	MAPH CHAR(10),
	CONSTRAINT PK_NHANVIEN PRIMARY KEY (MANV),
	CONSTRAINT FK_NV_PH FOREIGN KEY (MAPH) REFERENCES PHONGBAN(MAPH),
	CONSTRAINT FK_NV_NV FOREIGN KEY (MANQL) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE DEAN(
	MADA CHAR(10) NOT NULL,
	TENDA NVARCHAR(50),
	DIADIEMDA NVARCHAR(50),
	NGAYBD DATE,
	CONSTRAINT PK_DEAN PRIMARY KEY (MADA)
)
CREATE TABLE PHANCONG(
	MANV CHAR(10) NOT NULL,
	MADA CHAR(10) NOT NULL,
	NGAYPC DATE,
	CONSTRAINT PK_PC PRIMARY KEY (MANV, MADA),
	CONSTRAINT FK_PC_DA FOREIGN KEY (MADA) REFERENCES DEAN(MADA),
	CONSTRAINT FK_PC_NV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE THANNHAN(
	MANV CHAR(10) NOT NULL,
	TENTN NVARCHAR(50) NOT NULL,
	PHAI NVARCHAR(5),
	NGAYSINH DATE,
	QUANHE NVARCHAR(50),
	CONSTRAINT PK_THANNHAN PRIMARY KEY (TENTN, MANV),
	CONSTRAINT FK_TN_NV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE THENHANVIEN(
	MATHE CHAR(10) NOT NULL,
	NGAYCAP DATE,
	MANV CHAR(10),
	CONSTRAINT PK_THENHANVIEN PRIMARY KEY (MATHE),
	CONSTRAINT FK_THENV_NV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)
)

--Nhập dữ liệu
INSERT INTO PHONGBAN VALUES ('PH001', N'Kế hoạch', N'Tầng 1 Nhà A');
INSERT INTO PHONGBAN VALUES ('PH002', N'Quản trị', N'Tầng 1 Nhà B');
INSERT INTO PHONGBAN VALUES ('PH003', N'Nhân sự', N'Tầng 2 Nhà A');
INSERT INTO PHONGBAN VALUES ('PH004', N'Tài vụ', N'Tầng 3 Nhà A');
INSERT INTO PHONGBAN VALUES ('PH005', N'Đầu tư', N'Tầng 2 Nhà B');
INSERT INTO PHONGBAN VALUES ('PH006', N'Vật tư', N'Tầng 3 Nhà A');
INSERT INTO PHONGBAN VALUES ('PH007', N'Tư vấn', N'Tầng 3 Nhà B');
SELECT * FROM PHONGBAN;

SELECT * FROM PHONGBAN;

SET DATEFORMAT DMY;
INSERT INTO NHANVIEN VALUES ('NV0001', N'Nguyễn Văn Nam', '12/07/1988', N'Nam', N'Tây Ninh', 15000000, NULL, 'PH003');
INSERT INTO NHANVIEN VALUES ('NV0002', N'Nguyễn Kim Anh', '10/02/1990', N'Nữ',  N'TP. HCM', 8000000, NULL, 'PH003');
INSERT INTO NHANVIEN VALUES ('NV0003', N'Nguyễn Thị Châu','12/10/1979', N'Nữ',  N'Vũng Tàu', 12000000, NULL, 'PH003');
INSERT INTO NHANVIEN VALUES ('NV0004', N'Trần Văn Út',    '23/08/1977', N'Nam', N'Hà Nội', 7000000, NULL, 'PH002');
INSERT INTO NHANVIEN VALUES ('NV0005', N'Trần Lệ Quyên',  '22/11/1987', N'Nữ',  N'Hà Nội', 9000000, NULL, 'PH002');
INSERT INTO NHANVIEN VALUES ('NV0006', N'Bùi Đức Chí',    '22/11/1987', N'Nam', N'TP. HCM', 10000000, 'NV0002', 'PH003');
INSERT INTO NHANVIEN VALUES ('NV0007', N'Nguyễn Tuấn Anh','06/09/1991', N'Nam', N'Tây Ninh', 30500000, 'NV0002', 'PH003');
INSERT INTO NHANVIEN VALUES ('NV0008', N'Đỗ Xuân Thủy',   '14/05/1985', N'Nam', N'TP. HCM', 21000000, NULL, 'PH002'); 
INSERT INTO NHANVIEN VALUES ('NV0009', N'Trần Minh Tú',   '17/09/1985', N'Nam', N'Đồng Nai', 18000000, NULL, 'PH001');
SELECT * FROM NHANVIEN;
update NHANVIEN
set MANQL='NV0006'
where MANV='NV0003'
update NHANVIEN
set MANQL='NV0005'
where MANV='NV0004'
update NHANVIEN
set MANQL='NV0009'
where MANV='NV0001' or MANV='NV0002' or MANV='NV0008'
update NHANVIEN
set MANQL='NV0008'
where MANV='NV0005'

SET DATEFORMAT DMY;
INSERT INTO DEAN VALUES ('DA001', N'Đền bù giải tỏa', N'Phường 12, Q. Tân Bình', '01/01/2015')
INSERT INTO DEAN VALUES ('DA002', N'Giải phóng mặt bằng', N'Phường 12, Q. Tân Bình', '01/06/2015')
INSERT INTO DEAN VALUES ('DA003', N'Cải tạo mặt đường số 9', N'Phường Tây Thạnh, Q. Tân Phú', '01/01/2016')
INSERT INTO DEAN VALUES ('DA004', N'Bắt đầu thi công', N'Phường 26, Q. Bình Thạnh', '04/05/2016')
INSERT INTO DEAN VALUES ('DA005', N'Hoàn thiện mặt bằng', N'Phường Tân Quy, Quận 7', '10/12/2016')
SELECT * FROM DEAN;

SET DATEFORMAT DMY;
INSERT INTO PHANCONG VALUES ('NV0001', 'DA001', '05/02/2015')
INSERT INTO PHANCONG VALUES ('NV0001', 'DA003', '17/03/2016')
INSERT INTO PHANCONG VALUES ('NV0003', 'DA003', '01/01/2016')
INSERT INTO PHANCONG VALUES ('NV0005', 'DA004', '10/05/2016')
INSERT INTO PHANCONG VALUES ('NV0007', 'DA005', '20/12/2016')
SELECT * FROM PHANCONG;

INSERT INTO THANNHAN VALUES ('NV0001', N'Nguyễn Thị Tám', N'Nữ', '05/09/2015', 'Con');
INSERT INTO THANNHAN VALUES ('NV0001', N'Nguyễn Văn Bình', N'Nam', '22/05/1983', N'Anh'); 
INSERT INTO THANNHAN VALUES ('NV0002', N'Nguyễn Chính Nghĩa', N'Nam', '07/03/1998', N'Em');
INSERT INTO THANNHAN VALUES ('NV0005', N'Lê Anh Hùng', N'Nam', '05/04/1978', N'Chồng');
INSERT INTO THANNHAN VALUES ('NV0006', N'Bùi Đại An', N'Nam', '03/12/1976', N'Anh');
INSERT INTO THANNHAN VALUES ('NV0008', N'Lê Thảo Nguyên', N'Nữ', '12/06/1985', N'Vợ');
INSERT INTO THANNHAN VALUES ('NV0009', N'Trần Thanh Nhàn', N'Nữ', '30/05/1979', N'Chị');
SELECT * FROM THANNHAN;
--------------------------------------------------------------------------------
--1. Tạo bảng ảo
create view dsthe
as
	select NHANVIEN.MANV, HOTEN, ngaycap
	from NHANVIEN, THENHANVIEN
	where NHANVIEN.MANV = THENHANVIEN.MANV

select * from dsthe

--2. Tìm những nhân viên (MANV, HOTEN, NGAYSINH, DIACHI, PHAI, LUONG, MANQL, MAPH) có lương trên 10.000.000 đồng
select MANV, HOTEN, NGAYSINH, DIACHI, PHAI, LUONG, MANQL, MAPH
from NHANVIEN
where luong > 10000000

--3. Cho biết họ tên của những nhân viên nam ở TP. HCM hoặc nhân viên nữ ở Hà Nội.
select *
from NHANVIEN
where (PHAI = N'Nam' and DIACHI = N'TP. HCM')
or (PHAI = N'Nữ' and DIACHI = N'Hà Nội')

--4. Cho biết mã người quản lý của nhân viên Nguyễn Kim Ánh
select MANQL
from NHANVIEN
where HOTEN = N'Nguyễn Kim Ánh'
--8. Tìm những nhân viên có lương lớn hơn 5.000.000 đồng ở phòng Nhân sự hoặc lương lớn hơn 8.000.000 đồng ở phòng Tài vụ.
select *
from NHANVIEN, PHONGBAN
where NHANVIEN.MAPH = PHONGBAN.MAPH
and (luong > 5000000 and TENPH = N'Nhân sự')
or (luong > 8000000 and TENPH = N'Tài vụ')
--10. Tìm tên những nữ nhân viên và tên người thân của họ.
select HOTEN, TENTN 
from NHANVIEN, THANNHAN
where NHANVIEN.MANV = THANNHAN.MANV
and NHANVIEN.PHAI =N'Nữ'

--11. Với mỗi nhân viên cho biết họ tên và số người thân của nhân viên đó.
select * from THANNHAN

select HOTEN, count(*) as SoTN
from THANNHAN, NHANVIEN
where THANNHAN.MANV = NHANVIEN.MANV
group by NHANVIEN.MANV, HOTEN

--Nhân viên nào có từ 2 thân nhân trở lên
having count(*) >= 2

select NHANVIEN.MANV, HOTEN, count(*) as SoNT
from NHANVIEN, THANNHAN
where NHANVIEN.MANV = THANNHAN.MANV
group by NHANVIEN.MANV, HOTEN

--12. Với mỗi phòng ban liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
select * from NHANVIEN

select p.MAPH, tenph, round(avg(LUONG), -2) as LUONGTB
from NHANVIEN n, PHONGBAN p
where n.maph = p.maph
group by p.MAPH, TENPH

--13. Cho biết danh sách những nhân viên có từ hai thân nhân trở lên.
select NHANVIEN.MANV, HOTEN, count(*) as SoNT
from NHANVIEN, THANNHAN
where NHANVIEN.MANV = THANNHAN.MANV
group by NHANVIEN.MANV, HOTEN
having count(*) >= 2

--14. Cho biết danh sách những nhân viên (MANV, HOTEN) không có thân nhân.
select * from nhanvien
select * from thannhan

select *
from nhanvien
where manv not in (select distinct manv from thannhan)

select *
from nhanvien
where not exists (	select * 
					from thannhan
					where THANNHAN.manv = nhanvien.manv
					)

--15. Cho biết mã và họ tên nhân viên có lương thấp nhất.
select manv, hoten
from nhanvien
where luong = (select min(luong) from nhanvien)

--16. Cho biết mã và họ tên nhân viên có lương cao nhất phòng Nhân sự.
select * --manv, hoten
from nhanvien, phongban
where nhanvien.maph = phongban.maph
and tenph = N'Nhân sự'
and Luong = (	select max(luong)
				from nhanvien, phongban
				where nhanvien.MAPH = phongban.maph 
				and tenph = N'Nhân sự')

select * from phongban

--17. Cho biết tên những đề án có ít nhất 3 nhân viên tham gia.
select dean.mada, tenda, count(*) as SL 
from dean, phancong
where dean.mada = phancong.mada
group by dean.mada, tenda
having count(*)>=3

--18. Những nhân viên nào (MANV, HOTEN) tham gia cả hai đề án DA001 và DA003
select phancong.MANV, hoten 
from phancong, nhanvien 
where phancong.manv = nhanvien.manv 
and MADA = 'DA001'

intersect
	select phancong.MANV, hoten 
	from phancong, nhanvien 
	where phancong.manv = nhanvien.manv 
	and MADA = 'DA003'

--19. Những nhân viên nào (HOTEN) có lương lớn hơn lương cao nhất của các nhân viên phòng Tài vụ.
select *
from nhanvien
where luong > (select max(luong) from nhanvien n, phongban p where n.maph = p.MAPH and tenph = N'Quản trị')
select * from nhanvien
select * from phongban

--20. Phòng ban nào có số nhân viên nhiều hơn số nhân viên của phòng Tài vụ.
select maph, count(*) as 'so nhanvien'
from nhanvien
group by maph
having count(*) > (select count(*) from nhanvien, phongban where nhanvien.maph = phongban.maph and tenph=N'Quản tri')
--21. Liệt kê 3 nhân viên (MANV, HOTEN) có mức lương cao nhất.
select top 3 manv, hoten, luong
from nhanvien
order by Luong desc


-------------------------------------------------

-------------------------------------------------
DROP TABLE PHONGBAN
DROP TABLE NHANVIEN
DROP TABLE DEAN
DROP TABLE PHANCONG

