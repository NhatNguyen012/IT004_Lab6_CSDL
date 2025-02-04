﻿CREATE DATABASE THUVIEN;
GO
USE THUVIEN;
GO

CREATE TABLE TACGIA (
	MATG CHAR(5),
	HOTEN VARCHAR(20),
	DIACHI VARCHAR(50),
	NGSINH SMALLDATETIME,
	SODT VARCHAR(15)
	CONSTRAINT PK_TG PRIMARY KEY (MATG)
	)
CREATE TABLE SACH (
	MASACH CHAR(5),
	TENSACH VARCHAR(25),
	THELOAI VARCHAR(25)
	CONSTRAINT PK_SACH PRIMARY KEY (MASACH)
	)
CREATE TABLE TACGIA_SACH (
	MATG CHAR(5),
	MASACH CHAR(5)
	CONSTRAINT PK_TGS PRIMARY KEY (MATG,MASACH)
	)
CREATE TABLE PHATHANH (
	MAPH CHAR(5),
	MASACH CHAR(5),
	NGAYPH SMALLDATETIME,
	SOLUONG INT,
	NHAXUATBAN VARCHAR(20)
	CONSTRAINT PK_PT PRIMARY KEY (MAPH)
	)
 ALTER TABLE TACGIA_SACH ADD
 CONSTRAINT FK_TG FOREIGN KEY (MATG) REFERENCES TACGIA(MATG),
 CONSTRAINT FK_S FOREIGN KEY (MASACH) REFERENCES SACH(MASACH)
 ALTER TABLE PHATHANH ADD
 CONSTRAINT FK_PH FOREIGN KEY (MASACH) REFERENCES SACH(MASACH);

 --BAI2.1
 CREATE TRIGGER trg_NGAYPHATHANH ON PHATHANH
 AFTER INSERT,UPDATE
 AS
 BEGIN
	DECLARE @NGAYPH SMALLDATETIME
	DECLARE @MAPH CHAR(5)
	DECLARE @MASACH CHAR(5)
	DECLARE @NGSINH SMALLDATETIME

	SELECT @NGAYPH=NGAYPH FROM inserted
	SELECT @MAPH=MAPH FROM inserted
	SELECT @MASACH=MASACH FROM inserted
	SELECT @NGSINH=NGSINH FROM TACGIA WHERE MATG IN (SELECT MATG FROM TACGIA_SACH WHERE MASACH=@MASACH)
	IF(@NGSINH>=@NGAYPH)
	BEGIN
		PRINT'NGAYPH PHAI LON HON NGSINH'
		ROLLBACK TRAN
	END
 END
 --CAU2.2
CREATE TRIGGER trg_THELOAISACH ON PHATHANH
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @MASACH CHAR(5)
	DECLARE @NHAXB VARCHAR(20)

	SELECT @MASACH=MASACH FROM inserted
	SELECT @NHAXB=NHAXUATBAN FROM inserted
	JOIN SACH S ON S.MASACH=@MASACH
	WHERE S.THELOAI='Giáo khoa'
	IF(@NHAXB!='Giáo dục')
	BEGIN
		PRINT 'GIAOKHOA PHAI LA GIAODUC'
		ROLLBACK TRAN
	END
END
--CAU3.1
SELECT TG.MATG,HOTEN,SODT FROM TACGIA TG
JOIN TACGIA_SACH TGS ON  TGS.MATG=TG.MATG
JOIN SACH S ON S.MASACH=TGS.MASACH
JOIN PHATHANH PT ON PT.MASACH=TGS.MASACH
WHERE S.THELOAI='Van hoc' 
AND PT.NHAXUATBAN='Tre'
--CAU 3.2
SELECT DISTINCT TOP 1 NHAXUATBAN,COUNT(distinct S.THELOAI) AS SL FROM PHATHANH PT
JOIN SACH S ON S.MASACH=PT.MASACH
GROUP BY NHAXUATBAN
ORDER BY SL DESC
--CAU3.3
SELECT TOP 1 TG.MATG,HOTEN,SUM(SOLUONG) AS SL FROM TACGIA TG
JOIN TACGIA_SACH TGS ON TGS.MATG=TG.MATG
JOIN PHATHANH PT ON PT.MASACH=TGS.MASACH
GROUP BY TG.MATG,HOTEN
ORDER BY SL DESC

-------------------------------------------------------------------------------------------
CREATE DATABASE DE2
GO
USE DE2
GO
CREATE TABLE NHANVIEN (
	MANV CHAR(5),
	HOTEN VARCHAR(20),
	NGAYVL SMALLDATETIME,
	HSLUONG NUMERIC(4,2),
	MAPHONG CHAR(5)
	CONSTRAINT PK_NV PRIMARY KEY (MANV)
	)
CREATE TABLE PHONGBAN (
	MAPHONG CHAR(5),
	TENPHONG VARCHAR(25),
	TRUONGPHONG CHAR(5)
	CONSTRAINT PK_PB PRIMARY KEY (MAPHONG)
	)
CREATE TABLE XE (
	MAXE CHAR(5),
	LOAIXE VARCHAR(20),
	SOCHONGOI INT,
	NAMSX INT
	CONSTRAINT PK_X PRIMARY KEY (MAXE)
	)
CREATE TABLE PHANCONG (
	MAPC CHAR(5),
	MANV CHAR(5),
	MAXE CHAR(5),
	NGAYDI SMALLDATETIME,
	NGAYVE SMALLDATETIME,
	NOIDEN VARCHAR(25)
	CONSTRAINT PK_PC PRIMARY KEY (MAPC)
	)
 ALTER TABLE NHANVIEN ADD
 CONSTRAINT FK_NV FOREIGN KEY (MAPHONG) REFERENCES PHONGBAN(MAPHONG);
  ALTER TABLE PHONGBAN ADD
 CONSTRAINT FK_P FOREIGN KEY (TRUONGPHONG) REFERENCES NHANVIEN(MANV);
  ALTER TABLE PHANCONG ADD
 CONSTRAINT FK_PC_NV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
  CONSTRAINT FK_PC_XE FOREIGN KEY (MAXE) REFERENCES XE(MAXE)
 --2.1
ALTER TABLE XE ADD
CONSTRAINT CK_XXX CHECK (  NAMSX>=2006 )
ALTER TABLE XE DROP constraint CK_Xe
ALTER TABLE XE ADD
CONSTRAINT CK_Xe CHECK (loaiXe ='Toyota' AND NamSX>=2006)
--2.2
DROP TRIGGER trg_22
CREATE TRIGGER trg_22 ON PHANCONG
FOR INSERT,UPDATE
AS
BEGIN
	DECLARE @MANV CHAR(5)
	DECLARE @MAXE CHAR(5)

	SELECT @MANV=MANV FROM inserted
	SELECT @MAXE=MAXE FROM inserted 
	IF( @MANV IN (SELECT MANV FROM NHANVIEN WHERE MAPHONG IN (SELECT MAPHONG FROM PHONGBAN WHERE TENPHONG='Ngoai thanh')) AND @MAXE IN (SELECT MAXE FROM XE WHERE LOAIXE<>'Toyota'))
	BEGIN
		PRINT 'NGOAI THANH PHAI DI TOYOTA'
		ROLLBACK TRAN
	END
END
--3.2
SELECT NV.MANV,HOTEN,COUNT(DISTINCT X.LOAIXE ) FROM NHANVIEN NV
JOIN PHANCONG PC ON PC.MANV=NV.MANV
JOIN XE X ON X.MAXE=PC.MAXE
JOIN PHONGBAN PB ON PB.TRUONGPHONG=NV.MANV
WHERE PB.TRUONGPHONG=NV.MANV
GROUP BY NV.MANV,HOTEN
HAVING COUNT(DISTINCT X.LOAIXE )=(SELECT COUNT(DISTINCT LOAIXE) FROM XE)
--3.3
SELECT NV1.MAPHONG,NV1.MANV, HOTEN FROM NHANVIEN NV1
WHERE NV1.MANV IN(
SELECT TOP 1 WITH TIES NV2.MANV FROM NHANVIEN NV2
JOIN PHANCONG PC ON PC.MANV=NV2.MANV
JOIN XE ON XE.MAXE=PC.MAXE
WHERE XE.LOAIXE='Toyota' AND NV2.MAPHONG=NV1.MAPHONG
GROUP BY NV2.MANV
ORDER BY COUNT(XE.LOAIXE) ASC)

-------------------------------------------------------------------------------------------
CREATE DATABASE DE3
USE DE3
CREATE TABLE DOCGIA (
	MADG CHAR(5),
	HOTEN VARCHAR(30),
	NGAYSINH SMALLDATETIME,
	DIACHI VARCHAR(30),
	SODT VARCHAR(15)
	CONSTRAINT PK_NV PRIMARY KEY (MADG)
	)
CREATE TABLE SACH (
	MASACH CHAR(5),
	TENSACH VARCHAR(25),
	THELOAI VARCHAR(25),
	NHAXUATBAN VARCHAR(30)
	CONSTRAINT PK_SACH PRIMARY KEY (MASACH)
	)
CREATE TABLE PHIEUTHUE (
	MAPT CHAR(5),
	MADG CHAR(5),
	NGAYTHUE SMALLDATETIME,
	NGAYTRA SMALLDATETIME,
	SOSACHTHUE INT
	CONSTRAINT PK_PT PRIMARY KEY (MAPT)
	)
CREATE TABLE CHITIET_PT(
	MAPT CHAR(5),
	MASACH CHAR(5)
	CONSTRAINT PK_CTPT PRIMARY KEY (MAPT,MASACH)
)
ALTER TABLE PHIEUTHUE ADD
 CONSTRAINT FK_PT FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG);
 ALTER TABLE CHITIET_PT ADD
 CONSTRAINT FK_CTPT_SACH FOREIGN KEY (MASACH) REFERENCES SACH(MASACH),
 CONSTRAINT FK_CTPT_PT FOREIGN KEY (MAPT) REFERENCES PHIEUTHUE(MAPT)
 --2.1
 ALTER TABLE PHIEUTHUE ADD
 CONSTRAINT CK_TG CHECK (DATEDIFF(DAY, NgayThue, NgayTra) <= 10)
 --2.2
CREATE TRIGGER trg_CheckSoSachThue
ON CHITIET_PT
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    -- Kiểm tra ràng buộc
    IF EXISTS (
        SELECT 1
        FROM PHIEUTHUE PT
        WHERE PT.SoSachThue != (
            SELECT COUNT(*)
            FROM CHITIET_PT CT
            WHERE CT.MaPT = PT.MaPT
        )
    )
    BEGIN
        -- Nếu không thỏa mãn ràng buộc, rollback và báo lỗi
        ROLLBACK TRANSACTION;
        RAISERROR ('Số sách thuê không khớp giữa PHIEUTHUE và CHITIET_PT.', 16, 1);
    END
END;

 --3.1
 SELECT DISTINCT DG.MADG,HOTEN FROM DOCGIA DG
 JOIN PHIEUTHUE PT ON PT.MADG=DG.MADG
 JOIN CHITIET_PT CT ON CT.MAPT=PT.MAPT
 JOIN SACH ON SACH.MASACH=CT.MASACH
 WHERE SACH.THELOAI='Tin hoc' AND YEAR(PT.NGAYTHUE)=2007
 --3.2
 SELECT TOP 1 WITH TIES DG.MADG,HOTEN FROM DOCGIA DG
 JOIN PHIEUTHUE PT ON PT.MADG=DG.MADG
 JOIN CHITIET_PT CT ON CT.MAPT=PT.MAPT
 JOIN SACH ON SACH.MASACH=CT.MASACH
 GROUP BY DG.MADG,HOTEN
 ORDER BY COUNT(THELOAI) DESC
 --3.3
 SELECT DISTINCT S1.THELOAI,S1.MASACH,S1.TENSACH FROM SACH S1
 WHERE S1.MASACH IN (
 SELECT TOP 1 WITH TIES S2.MASACH FROM CHITIET_PT
 JOIN SACH S2 ON S2.MASACH=CHITIET_PT.MASACH
 WHERE S1.THELOAI=S2.THELOAI
 GROUP BY S2.MASACH
 ORDER BY COUNT(MAPT) DESC
 )
 -------------------------------------------------------------------------------------------
CREATE DATABASE DE4
USE DE4
CREATE TABLE KHACHHANG (
	MAKH CHAR(5),
	HOTEN VARCHAR(30),
	DIACHI VARCHAR(30),
	SODT VARCHAR(15),
	LOAIKH VARCHAR(10)
	CONSTRAINT PK_KH PRIMARY KEY (MAKH)
	)
CREATE TABLE BANG_DIA (
	MABD CHAR(5),
	TENBD VARCHAR(25),
	THELOAI VARCHAR(25)
	CONSTRAINT PK_BD PRIMARY KEY (MABD)
	)
CREATE TABLE PHIEUTHUE (
	MAPT CHAR(5),
	MAKH  CHAR(5),
	NGAYTHUE SMALLDATETIME,
	NGAYTRA SMALLDATETIME,
	SOLUONGTHUE INT
	CONSTRAINT PK_PT PRIMARY KEY (MAPT)
	CONSTRAINT FK_PT_KH FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH)
	)
CREATE TABLE CHITIET_PM(
	MAPT CHAR(5),
	MABD CHAR(5)
	CONSTRAINT PK_CTPM PRIMARY KEY (MAPT,MABD)
	CONSTRAINT FK_CTPM_PT FOREIGN KEY (MAPT) REFERENCES PHIEUTHUE(MAPT),
	CONSTRAINT FK_CTPM_BD FOREIGN KEY (MABD) REFERENCES BANG_DIA(MABD)

)

--2.1
ALTER TABLE BANG_DIA ADD
CONSTRAINT CK_BD CHECK (THELOAI IN('ca nhac','phim hanh dong','phim tinh cam'))
--2.2
CREATE TRIGGER trg_22 ON PHIEUTHUE
FOR INSERT,UPDATE
AS
BEGIN
	DECLARE @SOLUONGTHUE INT
	SELECT @SOLUONGTHUE=SOLUONGTHUE FROM inserted WHERE MAKH IN (SELECT MAKH FROM KHACHHANG WHERE LOAIKH<>'VIP')
	IF(@SOLUONGTHUE>5)
	BEGIN
		PRINT'VIP MOI DUOC THUE TREN 5'
		ROLLBACK TRAN
	END
END
--3.1
SELECT KH.MAKH,HOTEN FROM KHACHHANG KH
JOIN PHIEUTHUE PT ON PT.MAKH=KH.MAKH
JOIN CHITIET_PM CT ON CT.MAPT=PT.MAPT
JOIN BANG_DIA BD ON BD.MABD=CT.MABD
WHERE BD.THELOAI='Tinh cam'
AND SOLUONGTHUE>3
--3.2
SELECT MAKH,HOTEN FROM KHACHHANG
WHERE LOAIKH='VIP'
AND MAKH IN (
SELECT TOP 1 WITH TIES MAKH FROM PHIEUTHUE
GROUP BY MAKH
ORDER BY SUM(SOLUONGTHUE) DESC)
--3.3
SELECT DISTINCT BD.THELOAI,KH.MAKH,HOTEN FROM BANG_DIA BD
JOIN CHITIET_PM CT ON CT.MABD=BD.MABD
JOIN PHIEUTHUE PT ON PT.MAPT=CT.MAPT
JOIN KHACHHANG KH ON KH.MAKH=PT.MAKH
WHERE KH.MAKH IN(
SELECT TOP 1 WITH TIES KH2.MAKH FROM KHACHHANG KH2
JOIN PHIEUTHUE PT2 ON PT2.MAKH=KH2.MAKH
JOIN CHITIET_PM CT2 ON CT2.MAPT=PT2.MAPT
JOIN BANG_DIA BD2 ON BD2.MABD=CT2.MABD
WHERE BD.THELOAI=BD2.THELOAI
GROUP BY KH2.MAKH
ORDER BY COUNT(PT2.MAPT) DESC)

