CREATE DATABASE QLTV
ON PRIMARY 
(
    NAME = 'QLTV_PRIMARY',
    FILENAME = 'C:\KT1\QLTV_PRIMARY.mdf',
    SIZE = 20MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 10MB
)
LOG ON
(
    NAME = 'QLTV_LOG',
    FILENAME = 'C:\KT1\QLTV_LOG.ldf',
    SIZE = 5MB,
    MAXSIZE = 15MB,
    FILEGROWTH = 5MB
);
GO

USE QLTV;
GO

-- Bảng DOCGIA
CREATE TABLE DOCGIA (
    MADG CHAR(10) PRIMARY KEY,
    TENDG NVARCHAR(50),
    NGAYSINH DATE
);
GO

-- Bảng SACH
CREATE TABLE SACH(
    MASACH CHAR(10) PRIMARY KEY,
    TENSACH NVARCHAR(50),
    SOLUONG INT,
    SOCUONDAMUON INT
);
GO

-- Bảng PHIEUMUON
CREATE TABLE PHIEUMUON (
    MADG CHAR(10),
    NGAYMUON DATE,
    MASACH CHAR(10),
    SOLUONGMUON INT,
    NGAYTRA DATE,
    TIENPHAT MONEY,
    CONSTRAINT PK_PHIEUMUON PRIMARY KEY (MADG, NGAYMUON),
    CONSTRAINT FK_PHIEUMUON_DOCGIA FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG),
    CONSTRAINT FK_PHIEUMUON_SACH FOREIGN KEY (MASACH) REFERENCES SACH(MASACH)
);
GO

-- Bảng DANGKY
CREATE TABLE DANGKY (
    MADK CHAR(10) PRIMARY KEY,
    NGAYDANGKY DATE,
    MADG CHAR(10),
    MASACH CHAR(10),
    TINHTRANG CHAR(1),
    CONSTRAINT FK_DANGKY_DOCGIA FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG),
    CONSTRAINT FK_DANGKY_SACH FOREIGN KEY (MASACH) REFERENCES SACH(MASACH)
);
GO


INSERT INTO DOCGIA (MADG, TENDG, NGAYSINH) VALUES
('DG001', N'Trần Văn A', '1990-05-01'),
('DG002', N'Nguyễn Thị B', '1992-03-15'),
('DG003', N'Phạm Văn C', '1988-12-20'),
('DG004', N'Phạm Văn X', '1990-11-20'),
('DG005', N'Nguyễn Hoàng V', '1991-12-20'),
('DG006', N'Nguyễn Văn V', '1992-12-20'),
('DG007', N'Nguyễn Thị B', '1991-2-12'),
('DG008', N'Trần Văn C', '1995-4-30'),
('DG009', N'Trần Thị M', '1993-1-20');
GO
INSERT INTO SACH (MASACH, TENSACH, SOLUONG, SOCUONDAMUON)
VALUES
('S001', N'Lập Trình C', 10, 3),
('S002', N'Lập Trình Java', 7, 5),
('S003', N'Cơ Sở Dữ Liệu', 15, 2),
('S004', N'Phân Tích Thiết Kế Hệ Thống', 5, 4),
('S005', N'Mạng Máy Tính', 8, 0),
('S006', N'Cấu trúc dữ liệu và giải thuật', 5, 0);
GO
INSERT INTO PHIEUMUON (MADG, NGAYMUON, MASACH, SOLUONGMUON, NGAYTRA, TIENPHAT)
VALUES
('DG001', '2024-01-10', 'S001', 2, '2024-11-15', 0),
('DG002', '2024-02-01', 'S003', 1, '2024-10-15', 20000), -- Quá hạn, chưa trả
('DG003', '2024-01-20', 'S002', 1, '2024-11-30', 10000),
('DG004', '2024-03-01', 'S004', 1, '2024-12-07', 0),
('DG005', '2024-01-15', 'S002', 1, '2024-12-22', 0);
GO
INSERT INTO DANGKY (MADK, NGAYDANGKY, MADG, MASACH, TINHTRANG)
VALUES
('DK001', '2024-01-01', 'DG001', 'S001', 'Y'),
('DK002', '2024-01-10', 'DG001', 'S002', 'Y'),
('DK003', '2024-02-01', 'DG002', 'S003', 'N'), -- Chưa mượn được
('DK004', '2024-01-15', 'DG003', 'S004', 'Y'),
('DK005', '2024-02-20', 'DG003', 'S005', 'N');
GO

select * from DOCGIA
select * from SACH
select * from PHIEUMUON
select * from DANGKY

--Câu 1
--a. Hãy cho biết thông tin sách (MASACH, TENSACH) có số lượng cuốn sách đã và đang cho mượn (SOCUONDAMUON) là ít nhất
SELECT MASACH, TENSACH
FROM SACH
WHERE SOCUONDAMUON = (SELECT MIN(SOCUONDAMUON) FROM SACH);
GO

--b. Hãy cho biết thông tin độc giả (MADG, TENDG) đã đăng ký mượn sách nhiều lần nhất
SELECT MADG, TENDG
FROM DOCGIA
WHERE MADG = (
    SELECT TOP 1 MADG
    FROM DANGKY
    GROUP BY MADG
    ORDER BY COUNT(*) DESC
);
GO

--c. Hãy cho biết thông tin sách (MASACH, TENSACH) và thông tin đăng ký (MADK, NGAYDK) của những sách đã từng và chưa từng được đăng ký mượn sách. Nếu sách chưa từng được đăng ký thì MADK, NGAYDK là Null
SELECT SACH.MASACH, SACH.TENSACH, DANGKY.MADK, DANGKY.NGAYDANGKY
FROM SACH
LEFT JOIN DANGKY ON SACH.MASACH = DANGKY.MASACH;
GO

--d. Tạo View tên V_DsDangKy, cho biết danh sách thông tin Đăng ký đã được độc giả đăng ký mượn sách trong năm 2024, thông tin xuất ra gồm có: MADK, NGAYDANGKY, TENDG, MASACH
CREATE VIEW V_DsDangKy AS
SELECT DANGKY.MADK, DANGKY.NGAYDANGKY, DOCGIA.TENDG, DANGKY.MASACH
FROM DANGKY
JOIN DOCGIA ON DANGKY.MADG = DOCGIA.MADG
WHERE YEAR(DANGKY.NGAYDANGKY) = 2024;
GO

--e. Hãy cho biết sách nào được nhiều độc giả mượn nhất trong năm 2024. Thông tin hiển thị gồm (MADG, TENDG, SOLANMUON)
SELECT PHIEUMUON.MADG, TENDG, COUNT(*) AS SOLANMUON
FROM PHIEUMUON
JOIN DOCGIA ON PHIEUMUON.MADG = DOCGIA.MADG
WHERE YEAR(NGAYMUON) = 2024
GROUP BY PHIEUMUON.MADG, TENDG
ORDER BY SOLANMUON DESC;
GO

--Câu 2
--a. Viết thủ tục cho biết những sách đã mượn trong năm 2024 của độc giả (có mã truyền vào từ bàn phím). Thông tin gồm (MASACH, TENSACH, SOLANMUON) 
CREATE PROCEDURE GetSachDaMuon2024 (@MADG CHAR(10))
AS
BEGIN
    SELECT SACH.MASACH, SACH.TENSACH, COUNT(*) AS SOLANMUON
    FROM PHIEUMUON
    JOIN SACH ON PHIEUMUON.MASACH = SACH.MASACH
    WHERE PHIEUMUON.MADG = @MADG AND YEAR(NGAYMUON) = 2024
    GROUP BY SACH.MASACH, SACH.TENSACH;
END;
GO
--b. Viết thủ tục cho biết những sách nào mượn đã quá hạn trả trong năm. Năm được truyền vào từ bàn phím. Thông tin gồm (MASACH, TENSACH, NAM) 
CREATE PROCEDURE GetSachQuaHan (@Nam INT)
AS
BEGIN
    SELECT SACH.MASACH, SACH.TENSACH, @Nam AS NAM
    FROM PHIEUMUON
    JOIN SACH ON PHIEUMUON.MASACH = SACH.MASACH
    WHERE YEAR(NGAYMUON) = @Nam AND NGAYTRA IS NULL AND DATEDIFF(DAY, NGAYMUON, GETDATE()) > 7;
END;
GO
--Câu 3
--a. Viết hàm cho biết những độc giả chưa mượn sách lần nào. Thông tin gồm (MADG, TENDG)
CREATE FUNCTION GetDocGiaChuaMuonSach()
RETURNS TABLE
AS
RETURN (
    SELECT MADG, TENDG
    FROM DOCGIA
    WHERE MADG NOT IN (SELECT DISTINCT MADG FROM PHIEUMUON)
);
GO

--b. Viết hàm cho biết tiền phạt của độc giả là bao nhiêu. Mã độc giả được truyền vào từ bàn phím.
CREATE FUNCTION GetTienPhat (@MADG CHAR(10))
RETURNS MONEY
AS
BEGIN
    DECLARE @TienPhat MONEY;
    SELECT @TienPhat = SUM(TIENPHAT) 
    FROM PHIEUMUON
    WHERE MADG = @MADG;
    RETURN @TienPhat;
END;
GO

--Câu 4 Viết Trigger cập nhật lại số lượng sách (trong bảng SACH) khi cho độc giả mượn (trong bảng PHIEUMUON). Nếu số lượng sách đã hết thì báo cho độc giả biết để chọn sách khác hoặc chọn số lượng ít hơn hoặc bằng số lượng sách hiện tại đang có
CREATE TRIGGER TRIGGER_CAPNHAT_SOLUONGSACH
ON PHIEUMUON
AFTER INSERT
AS
BEGIN
    DECLARE @MASACH CHAR(10), @SOLUONGMUON INT;

    -- Lấy giá trị MASACH và SOLUONGMUON từ bản ghi vừa được chèn
    SELECT @MASACH = i.MASACH, @SOLUONGMUON = i.SOLUONGMUON
    FROM inserted i;

    -- Kiểm tra số lượng sách còn lại
    DECLARE @SOLUONGCONLAI INT;
    SELECT @SOLUONGCONLAI = (S.SOLUONG - S.SOCUONDAMUON)
    FROM SACH S
    WHERE S.MASACH = @MASACH;

    -- Nếu không đủ sách thì báo lỗi
    IF @SOLUONGMUON > @SOLUONGCONLAI
    BEGIN
        RAISERROR('Không đủ sách. Vui lòng chọn số lượng ít hơn hoặc bằng số lượng hiện tại.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Nếu đủ sách thì cập nhật số lượng sách đã được mượn
        UPDATE SACH
        SET SOCUONDAMUON = SOCUONDAMUON + @SOLUONGMUON
        WHERE MASACH = @MASACH;
    END
END;
GO

--Câu 5
-- Viết thủ tục kết hợp với Curosr có chức năng cập nhập giá trị cho cột SONGAYMUON của tất cả các phiếu mượn, mỗi số ngày mượn được tính như sau:
-- Nếu PHIEUMUON có NGAYTRA khác NULL: SONGAYMUON = NGAYTRA – NGAYMUON (trừ theo ngày, gợi ý dùng hàm DATEDIFF).
-- Nếu PHIEUMUON có NGAYTRA là NULL (chưa trả): SONGAYMUON = 0.
-- Lưu ý: Hãy thêm mới cột SONGAYMUON (Số ngày mượn) vào bảng PHIEUMUON (Phiếu mượn) bằng câu lệnh Alter.
ALTER TABLE PHIEUMUON
ADD SONGAYMUON INT;
GO

CREATE PROCEDURE UpdateSongayMuon
AS
BEGIN
    -- Khai báo các biến
    DECLARE @MADG CHAR(10), @NGAYMUON DATE, @NGAYTRA DATE, @SONGAYMUON INT;

    -- Khai báo cursor để duyệt qua các phiếu mượn
    DECLARE cursor_PM CURSOR FOR
    SELECT MADG, NGAYMUON, NGAYTRA
    FROM PHIEUMUON;

    -- Mở cursor
    OPEN cursor_PM;

    -- Lấy giá trị đầu tiên từ cursor
    FETCH NEXT FROM cursor_PM INTO @MADG, @NGAYMUON, @NGAYTRA;

    -- Vòng lặp duyệt qua tất cả các bản ghi
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Kiểm tra nếu NGAYTRA không phải NULL
        IF @NGAYTRA IS NOT NULL
        BEGIN
            SET @SONGAYMUON = DATEDIFF(DAY, @NGAYMUON, @NGAYTRA);
        END
        ELSE
        BEGIN
            SET @SONGAYMUON = 0;  -- Chưa trả sách
        END;

        -- Cập nhật giá trị SONGAYMUON cho phiếu mượn tương ứng
        UPDATE PHIEUMUON
        SET SONGAYMUON = @SONGAYMUON
        WHERE MADG = @MADG AND NGAYMUON = @NGAYMUON;

        -- Lấy giá trị tiếp theo từ cursor
        FETCH NEXT FROM cursor_PM INTO @MADG, @NGAYMUON, @NGAYTRA;
    END;

    -- Đóng cursor và giải phóng tài nguyên
    CLOSE cursor_PM;
    DEALLOCATE cursor_PM;
END;
GO

-------------------------------------------------------------------------------------------------------------------------------------

--Chạy thử các thủ tục và hàm

-- câu 2a: Gọi thủ tục, truyền mã độc giả:
EXEC GetSachDaMuon2024 'DG005';
GO

--câu 2b: Gọi thủ tục, truyền vào năm:
EXEC GetSachQuaHan 2024;
GO

--câu 3a: Gọi hàm để lấy danh sách độc giả chưa mượn sách:
SELECT * FROM GetDocGiaChuaMuonSach();
GO

--câu 3b: Gọi hàm để tính tiền phạt của độc giả:
SELECT dbo.GetTienPhat('DG002') AS TIENPHAT;
GO

--câu 4: Kiểm tra trigger bằng cách chèn dữ liệu vào PHIEUMUON
INSERT INTO PHIEUMUON (MADG, NGAYMUON, MASACH, SOLUONGMUON, NGAYTRA, TIENPHAT)
VALUES ('DG001', '2024-04-01', 'S001', 5, NULL, 0);
GO

--câu 5
EXEC UpdateSongayMuon;
GO
select * from DOCGIA
select * from SACH
select * from PHIEUMUON
select * from DANGKY

use master
drop database QLTV