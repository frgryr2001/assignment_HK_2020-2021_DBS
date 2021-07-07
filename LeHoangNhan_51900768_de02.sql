﻿
create database Quanlitiemcuoi1
use Quanlitiemcuoi1


-- 1 TẠO BẢNG NHÂN VIÊN
CREATE TABLE NHANVIEN
(
	MSNV VARCHAR(5) NOT NULL CHECK(	MSNV LIKE 'SA[0-9][0-9][0-9]' OR
									MSNV LIKE 'PG[0-9][0-9][0-9]' OR	
									MSNV LIKE 'SL[0-9][0-9][0-9]' OR
									MSNV LIKE 'TP[0-9][0-9][0-9]' OR
									MSNV LIKE 'TD[0-9][0-9][0-9]' OR
									MSNV LIKE 'VP[0-9][0-9][0-9]'),
	HOTEN NVARCHAR(80),
	GIOITINH NVARCHAR(3),
	NGAYSINH DATE,
	CMND VARCHAR(9) NOT NULL UNIQUE,
	DIACHI NVARCHAR(100),
	EMAIL VARCHAR(30),
	PRIMARY KEY(MSNV)
)


--  2 TẠO BẢNG ĐIỆN THOẠI NHÂN VIÊN
CREATE TABLE DIENTHOAINV
(
	MSNV INT IDENTITY(1,1),
	DIENTHOAI VARCHAR(13)  CHECK (DIENTHOAI LIKE '+84[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	PRIMARY KEY(MSNV,DIENTHOAI)
)




-- 3 TẠO BẢNG THỢ SỬA ẢNH
CREATE TABLE THOSUAANH
(
	MS_THOSUAANH VARCHAR(5) NOT NULL CHECK(	MS_THOSUAANH LIKE 'SA[0-9][0-9][0-9]')
	PRIMARY KEY(MS_THOSUAANH)
)

-- 4 TẠO BẢNG Photographer_ChupKiSu
CREATE TABLE PHOTOGRAPHER_CHUPKISU
(
	MS_PHOTOGRAPHERKISU VARCHAR(5) NOT NULL CHECK(	MS_PHOTOGRAPHERKISU LIKE 'PG[0-9][0-9][0-9]'),
	KIENTHUCPS INT CHECK (KIENTHUCPS LIKE '[0-1]'),
	KINHNHGIEM INT CHECK (KINHNHGIEM > 0)
	PRIMARY KEY(MS_PHOTOGRAPHERKISU)
)
-- 5 TAO BẢNG PHOTOGRAPHER_CHUPALBUMCUOI
CREATE TABLE PHOTOGRAPHER_CHUPALBUMCUOI
(
	MS_PHOTOGRAPHERALBUM VARCHAR(5) NOT NULL CHECK(	MS_PHOTOGRAPHERALBUM LIKE 'PG[0-9][0-9][0-9]'),
	KIENTHUCPS INT CHECK (KIENTHUCPS LIKE '[0-1]'),
	KINHNHGIEM INT CHECK (KINHNHGIEM > 0),
	PRIMARY KEY(MS_PHOTOGRAPHERALBUM)
)

-- 6 TẠO BẢNG Stylist 

CREATE TABLE STYLIST
(
	MS_STYLIST VARCHAR(5) NOT NULL CHECK(	MS_STYLIST LIKE 'SL[0-9][0-9][0-9]'),
	PRIMARY KEY(MS_STYLIST)
)

-- 7 TẠO BẢNG THO PHU

CREATE TABLE THOPHU
(
	MS_THOPHU  VARCHAR(5) NOT NULL CHECK( MS_THOPHU LIKE 'TP[0-9][0-9][0-9]'),
	PRIMARY KEY(MS_THOPHU)
)

-- 8 TẠO BẢNG CVTrangDiem
CREATE TABLE CVTRANGDIEM
(
	MS_CVTRANGDIEM VARCHAR(5) NOT NULL CHECK( MS_CVTRANGDIEM LIKE 'TD[0-9][0-9][0-9]'),
	GIACODAU FLOAT,
	GIANGUOINHA FLOAT,
	PRIMARY KEY(MS_CVTRANGDIEM)
)
-- 9 TAO BẢNG PhongCach_CVTrangDiem 
CREATE TABLE PHONGCACH_CVTRANGDIEM
(
	MS_CVTRANGDIEM VARCHAR(5) NOT NULL CHECK( MS_CVTRANGDIEM LIKE 'TD[0-9][0-9][0-9]'),
	PHONGCACH NVARCHAR(20),
	PRIMARY KEY(MS_CVTRANGDIEM,PHONGCACH)
)
-- 10 TẠO BẢNG NVVANPHONG
CREATE TABLE NVVANPHONG
(
	MS_VANPHONG VARCHAR(5) NOT NULL CHECK( MS_VANPHONG LIKE 'VP[0-9][0-9][0-9]'),
	VITRI NVARCHAR(20),
	KINANG NVARCHAR(20),
	PRIMARY KEY(MS_VANPHONG)
)
-- 11 TẠO BẢNG KHACHHANG
-- 
CREATE TABLE KHACHHANG
(
	MSKH CHAR(5) PRIMARY KEY CONSTRAINT IDKH DEFAULT DBO.AUTO_IDKH(),
	DIACHI NVARCHAR(30),
	NGAYCUOI DATE NOT NULL CHECK (NGAYCUOI > GETDATE()),
	HOTENCR	NVARCHAR(30) NOT NULL,
	NGAYSINHCR DATE,
	DIENTHOAICR VARCHAR(13)  CHECK (DIENTHOAICR LIKE '+84[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	EMAILCR VARCHAR(30) CHECK(EMAILCR LIKE'%@%'),
	HOTENCD NVARCHAR(30) NOT NULL,
	NGAYSINHCD DATE,
	DIENTHOAICD VARCHAR(13)  CHECK (DIENTHOAICD LIKE '+84[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'), 
	EMAILCD VARCHAR(30) CHECK(EMAILCD LIKE'%@%'),
	CONSTRAINT CK_DIENTHOAI_CDCR CHECK((DIENTHOAICR IS NOT NULL) OR (DIENTHOAICD IS NOT NULL)),
	CONSTRAINT CK_EMAIL_CDCR CHECK((EMAILCR IS NOT NULL) OR (EMAILCD IS NOT NULL))
)

-- TẠO ID TỰ ĐỘNG TĂNG CHO KHÁCH HÀNG BẢNG 11
CREATE FUNCTION AUTO_IDKH()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MSKH) FROM KHACHHANG) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSKH, 3)) FROM KHACHHANG
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'KH00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'KH0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
-- 12 TẠO BẢNG HỢP ĐỒNG
Create table HOPDONG
(
	MSHD CHAR(5) PRIMARY KEY CONSTRAINT IDHD DEFAULT DBO.AUTO_IDHD(),
	THOIDIEMKI	DATE NOT NULL,
	TONGGIA FLOAT default dbo.TONGGIA_HOPDONG(),
	MSKH CHAR(5),
	MS_VANPHONG VARCHAR(5)
)
-- CÒN TỔNG TIỀN BẢNG 12 
CREATE function TONGGIA_HOPDONG()
RETURNS FLOAT
AS
BEGIN
	DECLARE @TONGGIAALBUMCUOI FLOAT,@TONGIAVAYCUOI FLOAT,@TONGGIANGAYCUOI FLOAT,@MSHD CHAR(30),@TONG FLOAT
	SELECT @MSHD = MSHD FROM HOPDONG
	SELECT @TONGGIAALBUMCUOI = TONGGIA FROM DVALBUMCUOI WHERE MSHD = @MSHD
	SELECT @TONGIAVAYCUOI = TONGTIEN FROM DVVAYCUOI WHERE MSHD = @MSHD
	SELECT @TONGGIANGAYCUOI = TONGGIA FROM DVNGAYCUOI WHERE MSHD = @MSHD
	SET @TONG =  @TONGGIAALBUMCUOI +  @TONGIAVAYCUOI + @TONGGIANGAYCUOI
	RETURN @TONG
END
-- ***************************************

-- TẠO ID TỰ ĐỘNG TĂNG CHO HỢP ĐỒNG BẢNG 12
CREATE FUNCTION AUTO_IDHD()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MSHD) FROM HOPDONG) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSKH, 3)) FROM HOPDONG
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'HD00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'HD0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
-- 13 TAO BẢNG HỢP ĐỒNG LẦN THANH TOÁN
Create table HOPDONG_LANTHANHTOAN
(
	MSHD CHAR(5),
	THOIDIEM DATE CHECK (THOIDIEM > GETDATE()),
	SOTIEN FLOAT,
	PRIMARY KEY(MSHD,THOIDIEM)
)
-- 14 TẠO BẢNG DV ALBUM CƯỚI
Create table DVALBUMCUOI
(
	MSDVALBUM CHAR(6) PRIMARY KEY CONSTRAINT IDALBUM DEFAULT DBO.AUTO_IDDVALBUMCUOI(),
	MSHD CHAR(5),
	MS_PHOTOGRAPHERALBUM VARCHAR(5),
	MS_STYLIST VARCHAR(5),
	MS_THOPHU VARCHAR(5),
	MS_CVTRANGDIEM VARCHAR(5),
	MSVEST1 char(5),
	MSVEST2 char(5),
	TONGGIA FLOAT,
	CONSTRAINT CHECK_VEST1_VEST2 CHECK(MSVEST1 != MSVEST2)
)

-- TẠO ID TỰ ĐỘNG TĂNG CHO BẢNG DVALBUMCUOI BẢNG 14

CREATE FUNCTION AUTO_IDDVALBUMCUOI()
RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(MSDVALBUM) FROM DVALBUMCUOI) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSDVALBUM, 3)) FROM DVALBUMCUOI
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'DVA00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'DVA0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END



--***************

-- BẢNG 15 TAO BANG AOVEST
Create table AOVEST
(
	MSVEST CHAR(5) PRIMARY KEY CONSTRAINT IDAOVEST DEFAULT DBO.AUTO_IDAOVEST(),
	KIEU NVARCHAR(30),
	MAU NVARCHAR(30),
	KICHCO VARCHAR(3) CHECK(KICHCO IN ('XS','S','M','L','XL','XXL')) not null,
	SOLUONG INT DEFAULT 0 CHECK(SOLUONG >=0),
	GIATHUE FLOAT
)
-- TỰ ĐỘNG TĂNG ID AOVEST CỦA BẢNG 15
CREATE FUNCTION AUTO_IDAOVEST()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MSVEST) FROM AOVEST) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSVEST, 3)) FROM AOVEST
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'VE00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'VE0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END




-- TẠO BẢNG ĐẠO CỤ BẢNG 16
Create table DAOCU
(
	MSDC CHAR(5) PRIMARY KEY CONSTRAINT IDDAOCU DEFAULT DBO.AUTO_IDDAOCU(),
	TEN NVARCHAR(30),
	GIA FLOAT,
	SOLUONG INT DEFAULT 0 CHECK(SOLUONG >= 0)
)
-- ID TU DONG TĂNG CỦA BẢNG 16 ĐẠO CỤ
CREATE FUNCTION AUTO_IDDAOCU()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MSDC) FROM DAOCU) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSDC, 3)) FROM DAOCU
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'DC00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'DC0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END



-- TẠO BẢNG 17 DV ALBUM DAO CỤ
Create table DVAlbum_DaoCu
(
	MSDVALBUM CHAR(6),
	MSDC CHAR(5),
	PRIMARY KEY(MSDVALBUM,MSDC)
)


-- TẠO BẢNG 18 ĐỊA ĐIỂM 
Create table DIADIEM
(
	MSDD CHAR(5) PRIMARY KEY CONSTRAINT IDDIADIEM DEFAULT DBO.AUTO_IDDIADIEM(),
	TEN NVARCHAR(30) NOT NULL UNIQUE,
	GIA FLOAT,
	VITRI NVARCHAR(30),
	TONGTHOIGIANCHUP NVARCHAR(30) CHECK(TONGTHOIGIANCHUP LIKE N'%NGÀY'),
	GIABOSUNGGOC FLOAT
)
-- TẠO ID TỰ ĐỘNG TANG BẢNG 18
CREATE FUNCTION AUTO_IDDIADIEM()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MSDD) FROM DIADIEM) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSDD, 3)) FROM DIADIEM
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'DD00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'DD0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END





-- TẠO BẢNG 19 DVALBUM_DIADIEM
Create table DVALBUM_DIADIEM
(
	MSDVALBUM CHAR(6),
	MSDD CHAR(5),
	THOIDIEMCHUP DATE,
	PRIMARY KEY(MSDVALBUM,MSDD)

)
-- TẠO BẢNG 20 GOCCHUP
Create table GOCCHUP
(
	MSDD CHAR(5),
	TENGOCCHUP NVARCHAR(30),
	PRIMARY KEY(MSDD,TENGOCCHUP)
)
-- TẠO BẢNG 21 
Create table DV_GOC_VAY
(
	MSDVALBUM CHAR(6),
	MSDD CHAR(5),
	TENGOCCHUP NVARCHAR(30),
	MSVCHUP CHAR(5),
	GOCBOSUNG VARCHAR(1) CHECK (GOCBOSUNG IN ('0','1'))
	PRIMARY KEY(MSDVALBUM,MSDD,TENGOCCHUP)
)
-- TẠO BẢNG 22 VAY
Create table VAY
(
	MSV CHAR(5) PRIMARY KEY CONSTRAINT IDVAY DEFAULT DBO.AUTO_IDVAY(),
	TEN NVARCHAR(30),
	KIEU NVARCHAR(30),
	HINHANH VARCHAR(30),
	MAU NVARCHAR(30),
	CHATLIEU NVARCHAR(30),
	NGUONGOC NVARCHAR(30),
	TINHTRANG VARCHAR(1) DEFAULT 'K' CHECK (TINHTRANG IN ('B','T','K','G','U'))
)
-- ID TU TANG CỦA BANG 22
CREATE FUNCTION AUTO_IDVAY()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MSV) FROM VAY) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSV, 3)) FROM VAY
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'VA00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'VA0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END


-- TẠO BẢNG 23
Create table VAYCHUPHINH
(
	MSVCHUP CHAR(5)
	PRIMARY KEY(MSVCHUP)
)


--TẠO BẢNG 24
Create table VAYNGAYCUOI
(
	MSVCUOI CHAR(5),
	GIATHUE FLOAT,
	GIABAN FLOAT,
	SOLANTHUE INT DEFAULT 0 CHECK(SOLANTHUE >= 0),
	MSDVVAY CHAR(6),
	NGAYBAN DATE,
	DISCOUNT VARCHAR(4) CHECK (DISCOUNT LIKE ('[0-9]'+'[%]') or DISCOUNT LIKE ('[0-9][0-9]'+'[%]')or DISCOUNT LIKE ('[1][0][0]'+'[%]')),
	CONSTRAINT CK_GIATHUE_GIABAN CHECK (GIABAN>GIATHUE),
	PRIMARY KEY(MSVCUOI)
)


-- TẠO BẢNG 25
Create table ALBUM
(
	MSALBUM CHAR(5) PRIMARY KEY CONSTRAINT IDALBUM1 DEFAULT DBO.AUTO_IDALBUM(),
	SOTO INT CHECK (SOTO>=15),
	MSDVALBUM CHAR(6),
	MSBIA CHAR(6),
	MSGIAY CHAR(7)
)
--ID TU DONG TANG BẢNG 25
CREATE FUNCTION AUTO_IDALBUM() 
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MSALBUM) FROM ALBUM) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSALBUM, 3)) FROM ALBUM
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'AL00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'AL0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END


-- TẠO BẢNG 26
Create table BIA
(
	MSBIA CHAR(6) PRIMARY KEY CONSTRAINT IDBIA DEFAULT DBO.AUTO_IDBIA(),
	TEN NVARCHAR(30),
	GIA FLOAT,
	MAU NVARCHAR(30),
	CHATLIEU NVARCHAR(30)
)
-- TẠO ID TU DONG TANG BẢNG 26 BIA
CREATE FUNCTION AUTO_IDBIA() 
RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(MSBIA) FROM BIA) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSBIA, 3)) FROM BIA
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'BIA00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'BIA0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END



-- TẠO BẢNG 27 GIAYIN
Create table GIAYIN
(
	MSGIAY CHAR(7) PRIMARY KEY CONSTRAINT IDGIAYIN DEFAULT DBO.AUTO_IDGIAYIN(),
	CHATLIEU NVARCHAR(30),
	GiaTo FLOAT
)

-- TẠO ID TU DONG TANG BANG 27
CREATE FUNCTION AUTO_IDGIAYIN() 
RETURNS VARCHAR(7)
AS
BEGIN
	DECLARE @ID VARCHAR(7)
	IF (SELECT COUNT(MSGIAY) FROM GIAYIN) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSGIAY, 3)) FROM GIAYIN
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'GIAY00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'GIAY0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END


-- TẠO BẢNG 28
Create table DVVAYCUOI
(
	MSDVVAY CHAR(6) PRIMARY KEY CONSTRAINT IDDVVAYCUOI DEFAULT DBO.AUTO_IDVAYCUOI(),
	MSHD CHAR(5),
	TONGTIEN FLOAT,
)

-- TẠO ID TU DONG TANG CỦA BANG 28
CREATE FUNCTION AUTO_IDVAYCUOI() 
RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(MSDVVAY) FROM DVVAYCUOI) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSDVVAY, 3)) FROM DVVAYCUOI
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'DVV00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'DVV0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END


-- TẠO BẢNG 29
Create table DVVAYCUOI_THUE
(
	MSDVVAY CHAR(6),
	MSVCUOI CHAR(5),
	NGAYBATDAU DATE,
	NGAYKETTHUC DATE,
	CONSTRAINT CK_NGAYKT_NGAYBD CHECK(NGAYKETTHUC>NGAYBATDAU),
	PRIMARY KEY(MSDVVAY,MSVCUOI)
)

-- TẠO BẢNG 30
Create table DVNGAYCUOI
(
	MSDVNGAY CHAR(6) PRIMARY KEY CONSTRAINT IDNGAYCUOI DEFAULT DBO.AUTO_IDNGAYCUOI(),
	SOLUONGNGUOINHA INT CHECK(SOLUONGNGUOINHA>=0),
	DIADIEM NVARCHAR(30),
	THOIDIEM NVARCHAR(10) CHECK(THOIDIEM LIKE'%AM' OR THOIDIEM LIKE'%PM'),
	GIA FLOAT,
	MSHD CHAR(5),
	MS_PHOTOGRAPHERKISU VARCHAR(5),
	MS_THOPHU VARCHAR(5),
	TONGGIA FLOAT
)
-- TẠO ID TU DONG TANG CUA BANG 30
CREATE FUNCTION AUTO_IDNGAYCUOI() 
RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(MSDVNGAY) FROM DVNGAYCUOI) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MSDVNGAY, 3)) FROM DVNGAYCUOI
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'DVN00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'DVN0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END



-- TẠO BANG 31 
Create table NGAYCUOI_TRANGDIEM
(
	MSDVNGAY CHAR(6),
	MS_CVTRANGDIEM VARCHAR(5),
	THOIDIEM NVARCHAR(30),
	CODAUNGUOINHA VARCHAR(1) CHECK(CODAUNGUOINHA LIKE'[0-1]')
	PRIMARY KEY(MSDVNGAY,MS_CVTRANGDIEM,THOIDIEM)
)
/*
CREATE PROC CHECKNGUOINHACODA @CODAUNGUOINHA VARCHAR(30)
AS
BEGIN
	IF (@CODAUNGUOINHA = 0)
	BEGIN
		PRINT 'CO DAU'
	END
	ELSE
	PRINT 'NGUOI NHA'
END
*/

-- TAO KHÓA NGOẠI

-- KHÓA NGOẠI THỢ SỬA ẢNH BẢNG 3
ALTER TABLE THOSUAANH
ADD CONSTRAINT FK_THOSUAANH_NHANVIEN FOREIGN KEY(MS_THOSUAANH) REFERENCES NHANVIEN(MSNV)


--KHÓA NGOẠI Photographer_ChupKiSu BẢNG 4
ALTER TABLE PHOTOGRAPHER_CHUPKISU
ADD CONSTRAINT FK_PHOTOGRAPHERCHUPKISU_NHANVIEN FOREIGN KEY(MS_PHOTOGRAPHERKISU) REFERENCES NHANVIEN(MSNV)

-- KHÓA NGOẠI Photographer_ChupAlbumCuoi BẢNG 5
ALTER TABLE PHOTOGRAPHER_CHUPALBUMCUOI
ADD CONSTRAINT FK_PHOTOGRAPHERCHUPALBUMCUOI_NHANVIEN FOREIGN KEY(MS_PHOTOGRAPHERALBUM) REFERENCES NHANVIEN(MSNV)

-- KHÓA NGOẠI Stylist BẢNG 6
ALTER TABLE STYLIST
ADD CONSTRAINT FK_STYLIST_NHANVIEN FOREIGN KEY(MS_STYLIST) REFERENCES NHANVIEN(MSNV)

-- KHÓA NGOẠI THỢ PHỤ BẢNG 7
ALTER TABLE THOPHU
ADD CONSTRAINT FK_THOPHU_NHANVIEN FOREIGN KEY(MS_THOPHU) REFERENCES NHANVIEN(MSNV)

-- KHÓA NGOẠI CVTRANGDIEM BẢNG 8
ALTER TABLE CVTRANGDIEM
ADD CONSTRAINT FK_CVTRANGDIEM_NHANVIEN FOREIGN KEY(MS_CVTRANGDIEM) REFERENCES NHANVIEN(MSNV)

-- KHÓA NGOẠI PhongCach_CVTrangDiem BẢNG 9 
ALTER TABLE PHONGCACH_CVTRANGDIEM
ADD CONSTRAINT FK_PHONGCACH_CVTRANGDIEM FOREIGN KEY(MS_CVTRANGDIEM) REFERENCES CVTRANGDIEM(MS_CVTRANGDIEM)

-- KHÓA NGOẠI NVVanPhong BẢNG 10
ALTER TABLE NVVANPHONG
ADD CONSTRAINT FK_NVVANPHONG_NHANVIEN FOREIGN KEY(MS_VANPHONG) REFERENCES NHANVIEN(MSNV)

--KHÓA NGOẠI HOPDONG BẢNG 12
ALTER TABLE HOPDONG
ADD CONSTRAINT FK_HOPDONG_KHACHHANG FOREIGN KEY(MSKH) REFERENCES KHACHHANG(MSKH)
ALTER TABLE HOPDONG
ADD CONSTRAINT FK_HOPDONG_NVVANPHONG FOREIGN KEY(MS_VANPHONG) REFERENCES NVVANPHONG(MS_VANPHONG)

-- KHÓA NGOẠI  HopDong_LanThanhToan BẢNG 13
ALTER TABLE HOPDONG_LANTHANHTOAN
ADD CONSTRAINT FK_LANTHANHTOAN_HOPDONG FOREIGN KEY(MSHD) REFERENCES HOPDONG(MSHD)

-- KHÓA NGOẠI DVAlbumCuoi BẢNG 14
ALTER TABLE DVALBUMCUOI
ADD CONSTRAINT FK_DVALBUMCUOI_HOPDONG FOREIGN KEY(MSHD) REFERENCES HOPDONG(MSHD)
ALTER TABLE DVALBUMCUOI
ADD CONSTRAINT FK_DVALBUMCUOI_PHOTOGRAPHERALBUM FOREIGN KEY(MS_PHOTOGRAPHERALBUM) REFERENCES PHOTOGRAPHER_CHUPALBUMCUOI(MS_PHOTOGRAPHERALBUM)
ALTER TABLE DVALBUMCUOI
ADD CONSTRAINT FK_DVALBUMCUOI_STYLIST FOREIGN KEY(MS_STYLIST) REFERENCES STYLIST(MS_STYLIST)
ALTER TABLE DVALBUMCUOI
ADD CONSTRAINT FK_DVALBUMCUOI_THOPHU FOREIGN KEY(MS_THOPHU) REFERENCES THOPHU(MS_THOPHU)
ALTER TABLE DVALBUMCUOI
ADD CONSTRAINT FK_DVALBUMCUOI_CVTRANGDIEM FOREIGN KEY(MS_CVTRANGDIEM) REFERENCES CVTRANGDIEM(MS_CVTRANGDIEM)
ALTER TABLE DVALBUMCUOI
ADD CONSTRAINT FK_DVALBUMCUOI_AOVEST1 FOREIGN KEY(MSVEST1) REFERENCES AOVEST(MSVEST)
ALTER TABLE DVALBUMCUOI
ADD CONSTRAINT FK_DVALBUMCUOI_AOVEST2 FOREIGN KEY(MSVEST2) REFERENCES AOVEST(MSVEST)
-- KHOA NGOẠI DVAlbum_DaoCu BẢNG 17
ALTER TABLE DVALBUM_DAOCU
ADD CONSTRAINT FK_DVALBUMDAOCU_DVALBUMCUOI FOREIGN KEY(MSDVALBUM) REFERENCES DVALBUMCUOI(MSDVALBUM)
ALTER TABLE DVALBUM_DAOCU
ADD CONSTRAINT FK_DVALBUMDAOCU_DAOCU FOREIGN KEY(MSDC) REFERENCES DAOCU(MSDC)

-- KHÓA NGOẠI DiaDiem BẢNG 19
ALTER TABLE DVALBUM_DIADIEM
ADD CONSTRAINT FK_DVALBUMDIADIEM_DVALBUMCUOI FOREIGN KEY(MSDVALBUM) REFERENCES DVALBUMCUOI(MSDVALBUM)
ALTER TABLE DVALBUM_DIADIEM
ADD CONSTRAINT FK_DVALBUMDIADIEM_DIADIEM FOREIGN KEY(MSDD) REFERENCES DIADIEM(MSDD)

-- KHÓA NGOẠI BẢNG 20 GOC CHỤP
ALTER TABLE GOCCHUP
ADD CONSTRAINT FK_GOCCHUP_DIADIEM FOREIGN KEY(MSDD) REFERENCES DIADIEM(MSDD)



-- KHÓA NGOẠI DV_Goc_Vay BẢNG 21
ALTER TABLE DV_GOC_VAY
ADD CONSTRAINT FK_DVGOCVAY_DVALBUMCUOI FOREIGN KEY(MSDVALBUM) REFERENCES DVALBUMCUOI(MSDVALBUM)
--ALTER TABLE DV_GOC_VAY
--ADD CONSTRAINT FK_DVGOCVAY_DIADIEM FOREIGN KEY(MSDD) REFERENCES DIADIEM(MSDD)

ALTER TABLE DV_GOC_VAY
ADD CONSTRAINT FK_DVGOCVAY_GOCCHUP FOREIGN KEY(MSDD,TENGOCCHUP) REFERENCES GOCCHUP(MSDD,TENGOCCHUP)
-- lỗi
ALTER TABLE DV_GOC_VAY
ADD CONSTRAINT FK_DVGOCVAY_VAYCHUPHINH FOREIGN KEY(MSVCHUP) REFERENCES VAYCHUPHINH(MSVCHUP)

-- KHÓA NGOẠI VAY BẢNG 23
ALTER TABLE VAYCHUPHINH
ADD CONSTRAINT FK_DVGOCVAY_VAY FOREIGN KEY(MSVCHUP) REFERENCES VAY(MSV)


-- KHÓA NGOẠI BẢNG 24
ALTER TABLE VAYNGAYCUOI
ADD CONSTRAINT FK_VAYNGAYCUOI_VAY FOREIGN KEY(MSVCUOI) REFERENCES VAY(MSV)
ALTER TABLE VAYNGAYCUOI
ADD CONSTRAINT FK_VAYNGAYCUOI_DVVAYCUOI FOREIGN KEY(MSDVVAY) REFERENCES DVVAYCUOI(MSDVVAY)
--*******************************************************


-- KHÓA NGOẠI BẢNG 25
ALTER TABLE ALBUM
ADD CONSTRAINT FK_ALBUM_DVALBUMCUOI FOREIGN KEY(MSDVALBUM) REFERENCES DVALBUMCUOI(MSDVALBUM)
ALTER TABLE ALBUM
ADD CONSTRAINT FK_ALBUM_BIA FOREIGN KEY(MSBIA) REFERENCES BIA(MSBIA)
ALTER TABLE ALBUM
ADD CONSTRAINT FK_ALBUM_GIAY FOREIGN KEY(MSGIAY) REFERENCES GIAYIN(MSGIAY)

-- KHÓA NGOẠI BẢNG 28
ALTER TABLE DVVAYCUOI
ADD CONSTRAINT FK_DVVAYCUOI_HOPDONG FOREIGN KEY(MSHD) REFERENCES HOPDONG(MSHD)

-- KHÓA NGOẠI BẢNG 29
ALTER TABLE DVVAYCUOI_THUE 
ADD CONSTRAINT FK_DVVAYCUOITHUE_DVVAYCUOI FOREIGN KEY(MSDVVAY) REFERENCES DVVAYCUOI(MSDVVAY)
ALTER TABLE DVVAYCUOI_THUE
ADD CONSTRAINT FK_DVVAYCUOITHUE_VAYNGAYCUOI FOREIGN KEY(MSVCUOI) REFERENCES VAYNGAYCUOI(MSVCUOI)


-- KHÓA NGOẠI BẢNG 30

ALTER TABLE DVNGAYCUOI
ADD CONSTRAINT FK_DVNGAYCUOI_HOPDONG FOREIGN KEY(MSHD) REFERENCES HOPDONG(MSHD)
ALTER TABLE DVNGAYCUOI
ADD CONSTRAINT FK_DVNGAYCUOI_PHOTOGRAPHERCHUPKISU FOREIGN KEY(MS_PHOTOGRAPHERKISU) REFERENCES PHOTOGRAPHER_CHUPKISU(MS_PHOTOGRAPHERKISU)
ALTER TABLE DVNGAYCUOI
ADD CONSTRAINT FK_DVNGAYCUOI_THOPHU FOREIGN KEY(MS_THOPHU) REFERENCES THOPHU(MS_THOPHU)


-- KHÓA NGOẠI BẢNG 31
ALTER TABLE NGAYCUOI_TRANGDIEM
ADD CONSTRAINT FK_NGAYCUOITRANGDIEM_DVNGAYCUOI FOREIGN KEY(MSDVNGAY) REFERENCES DVNGAYCUOI(MSDVNGAY)
ALTER TABLE NGAYCUOI_TRANGDIEM
ADD CONSTRAINT FK_NGAYCUOITRANGDIEM_CVTRANGDIEM FOREIGN KEY(MS_CVTRANGDIEM) REFERENCES CVTRANGDIEM(MS_CVTRANGDIEM)




-- TAO INDEX CAU A
create index idx_MSVCUOI
on VAYNGAYCUOI (MSVCUOI)
CREATE INDEX IDX_KIEU
ON VAY(MSV,KIEU)
-- TAO INDEX CAU B
CREATE INDEX INX_KHACHHANG
ON KHACHHANG (NGAYCUOI)


-- TẠO TRIGGER PHẦN 2 
-- CAU A
CREATE TRIGGER VAYCUOI_THUE
ON DVVAYCUOI_THUE
FOR INSERT
AS
BEGIN
	DECLARE @MSVCUOI VARCHAR(30),@SOLANTHUE INT,@DISCOUNT CHAR(4)
	SELECT @MSVCUOI =  MSVCUOI from inserted
	SELECT @SOLANTHUE = SOLANTHUE FROM VAYNGAYCUOI WHERE MSVCUOI=@MSVCUOI
	SET @SOLANTHUE = @SOLANTHUE + 1 
	IF (@SOLANTHUE = 0)
		BEGIN
			SET @DISCOUNT = '0%'
		END
	IF (@SOLANTHUE = 1)
		BEGIN
			SET @DISCOUNT = '5%'

		END
	IF (@SOLANTHUE = 2)
		BEGIN
			SET @DISCOUNT = '10%'
		END
	IF (@SOLANTHUE = 3)
		BEGIN
			SET @DISCOUNT = '15%'
		END
	IF (@SOLANTHUE = 4)
		BEGIN
			SET @DISCOUNT = '20%'
		END
	-- CẬP NHẬT LẠI TÌNH TRẠNG CHO BẢNG VAY SAU KHI ĐƯỢC THUÊ
	UPDATE VAY SET TINHTRANG = 'T' WHERE MSV = @MSVCUOI
	-- CẬP NHẬT SỐ LẦN THUÊ CHO BẢNG VAY NGAY CUOI SAU KHI ĐƯỢC THUÊ
	UPDATE VAYNGAYCUOI SET SOLANTHUE = @SOLANTHUE WHERE MSVCUOI = @MSVCUOI
	-- -- CẬP NHẬT DISCOUNT CHO BẢNG VAY NGAY CUOI SAU KHI ĐƯỢC THUÊ
	UPDATE VAYNGAYCUOI SET DISCOUNT = @DISCOUNT WHERE MSVCUOI = @MSVCUOI
END

-- CÂU B

CREATE TRIGGER VAY_BAN
ON VAYNGAYCUOI
FOR INSERT,UPDATE
AS
BEGIN
	DECLARE @MSVCUOI VARCHAR(30)
	SELECT  @MSVCUOI = MSVCUOI FROM inserted
	if EXISTS( Select NGAYBAN From VAYNGAYCUOI where MSVCUOI = @MSVCUOI) and (( Select NGAYBAN From VAYNGAYCUOI where MSVCUOI = @MSVCUOI) IS NOT NULL)
		UPDATE VAY SET TINHTRANG = 'B' where MSV = @MSVCUOI
END
-- CÂU C
CREATE TRIGGER	VAYNGAYCUOI_VAYCHUPHINH
ON VAYNGAYCUOI
FOR INSERT,UPDATE
AS
BEGIN
	DECLARE @MSVCUOI VARCHAR(30)
	SET @MSVCUOI = (SELECT MSVCUOI FROM inserted)
	IF (SELECT SOLANTHUE FROM inserted WHERE MSVCUOI=@MSVCUOI ) = 5
	BEGIN
		-- RÀNG BUỘC GIỮA 2 BẢNG DVVAYCUOI_THUE VÀ VAYNGAYCUOI NÊN XÓA DỮ LIỆU DVVAYCUOI_THUE TRƯỚC
		DELETE FROM DVVAYCUOI_THUE WHERE MSVCUOI= @MSVCUOI
		-- XÓA DỮ LIỆU VAYNGAYCUOI
		DELETE FROM VAYNGAYCUOI WHERE MSVCUOI= @MSVCUOI
		-- THÊM DỮ LIỆU CỦA @MSVCUOI VÀO BẢNG VAYCHUPHINH
		INSERT INTO VAYCHUPHINH VALUES(@MSVCUOI)
	END
END

--- PROC !!!!!!!

CREATE PROC TONGGIADVVAYCUOI @MSDVVAY VARCHAR(30)
AS
BEGIN
	DECLARE @GIABAN FLOAT,@GIATHUE FLOAT,@DISCOUNT FLOAT 
	SELECT @DISCOUNT = REPLACE(DISCOUNT,'%','')FROM VAYNGAYCUOI WHERE MSDVVAY = @MSDVVAY
	IF (Select NGAYBAN From VAYNGAYCUOI where MSDVVAY = @MSDVVAY) IS NOT NULL
		BEGIN
			SELECT @GIABAN = GIABAN FROM VAYNGAYCUOI where MSDVVAY = @MSDVVAY
		END
	ELSE
		SET @GIABAN = 0
	SELECT @GIATHUE = GIATHUE FROM VAYNGAYCUOI  WHERE  MSDVVAY = @MSDVVAY
	update DVVAYCUOI SET TONGTIEN = @GIABAN*@DISCOUNT/100 + @GIATHUE FROM DVVAYCUOI A,VAYNGAYCUOI B,DVVAYCUOI_THUE C
	WHERE A.MSDVVAY=B.MSDVVAY AND B.MSDVVAY=C.MSDVVAY AND A.MSDVVAY = @MSDVVAY
END

EXEC TONGGIADVVAYCUOI 'DVV004'





-- ******************INSERT DỮ LIỆU VÀO BẢNG**************************

-- BẢNG 1
SET DATEFORMAT DMY
INSERT INTO NHANVIEN VALUES
('SA001',N'NGUYỄN VĂN SANG','NAM','22/3/1997','332165478',N'QUẬN 6,TPHCM','SANG@GMAIL.COM'),
('SA002',N'HUỲNH THÁI AN','NAM','27/4/1991','332465978',N'QUẬN 9,TPHCM','AN@GMAIL.COM'),
('SA003',N'NGUYỄN THỊ NGỌC',N'NỮ','16/7/1997','332124569',N'QUẬN 6,TPHCM','NGOC@GMAIL.COM'),
('SA004',N'VÕ VĂN TÀI','NAM','22/3/1994','332165226',N'QUẬN 4,TPHCM','TAI@GMAIL.COM'),
('PG001',N'NGUYỄN THÁI VINH','NAM','5/8/1995','352365987',N'QUẬN 5,TPHCM','VINH@GMAIL.COM'),
('PG002',N'TRẦN MINH NGUYÊN','NAM','5/8/1999','352123427',N'QUẬN 1,TPHCM','NGUYEN@GMAIL.COM'),
('PG003',N'HUỲNH HIỆP PHÁT','NAM','5/8/1996','352122345',N'QUẬN 2,TPHCM','PHAT@GMAIL.COM'),
('PG004',N'LÊ QUỐC TRUNG','NAM','2/3/1990','352122311',N'QUẬN 8,TPHCM','TRUNG@GMAIL.COM'),
('PG005',N'TRẦN THỊ MINH ANH',N'NỮ','5/1/1996','352121145',N'QUẬN 2,TPHCM','MINHANH@GMAIL.COM'),
('PG006',N'HUỲNH ĐỨC TOÀN','NAM','25/4/1999','352122321',N'QUẬN 6,TPHCM','TOAN@GMAIL.COM'),
('PG007',N'LÊ MINH TRIẾT','NAM','11/3/1992','352126547',N'QUẬN 3,TPHCM','TRIET@GMAIL.COM'),
('PG008',N'PHAN THANH TÙNG','NAM','5/8/1989','352122322',N'QUẬN 1,TPHCM','TUNG@GMAIL.COM'),
('SL001',N'LÊ VĂN TRÍ','NAM','7/6/1992','331234563',N'QUẬN 11,TPHCM','TRI@GMAIL.COM'),
('SL002',N'HUỲNH VĂN BẰNG','NAM','7/6/1993','331234213',N'QUẬN 12,TPHCM','BANG@GMAIL.COM'),
('SL003',N'TRẦN QUANG VINH','NAM','21/8/1992','331234767',N'QUẬN 7,TPHCM','VINH@GMAIL.COM'),
('SL004',N'LÊ TẤN KIỆT','NAM','7/6/1988','331236987',N'QUẬN 11,TPHCM','KIET@GMAIL.COM'),
('TP001',N'LÊ THỊ HUYỀN',N'NỮ','24/2/1994','332165213',N'QUẬN 1,TPHCM','HUYEN@GMAIL.COM'),
('TP002',N'TRẦN ANH KHOA','NAM','1/1/1995','332165233',N'QUẬN 2,TPHCM','KHOA@GMAIL.COM'),
('TP003',N'TRẦN THỊ TRANG',N'NỮ','23/2/1996','332165390',N'QUẬN 3,TPHCM','TRANG@GMAIL.COM'),
('TP004',N'TRẦN BẢO NGỌC',N'NỮ','16/3/1997','332165354',N'QUẬN 4,TPHCM','NGOC@GMAIL.COM'),
('TD001',N'NGUYỄN NGỌC MAI',N'NỮ','17/3/1992','332166556',N'QUẬN 5,TPHCM','MAI@GMAIL.COM'),
('TD002',N'TRẦN BẢO NGỌC',N'NỮ','21/5/1997','332165214',N'QUẬN 6,TPHCM','NGOC@GMAIL.COM'),
('TD003',N'TRẦN BẢO TRÂN',N'NỮ','11/9/1993','332165975',N'QUẬN 7,TPHCM','TRAN@GMAIL.COM'),
('TD004',N'NGUYỄN MINH HÀO','NAM','16/3/1993','332165657',N'QUẬN 8,TPHCM','HAO@GMAIL.COM'),
('VP001',N'NGUYỄN QUANG HUY','NAM','17/8/1992','332166598',N'QUẬN 7,TPHCM','HUY@GMAIL.COM'),
('VP002',N'NGUYỄN HỒNG NGỌC',N'NỮ','17/3/1994','332166212',N'QUẬN 6,TPHCM','NGOC@GMAIL.COM'),
('VP003',N'NGUYỄN KIM NGÂN',N'NỮ','17/3/1990','332166534',N'QUẬN 5,TPHCM','NGÂN@GMAIL.COM'),
('VP004',N'HÀ BẢO CHÂU',N'NỮ','17/3/1995','332165987',N'QUẬN 4,TPHCM','CHAU@GMAIL.COM')

-- BẢNG 2
INSERT INTO DIENTHOAINV(DIENTHOAI) VALUES
('+846597123456'),
('+846597895445'),
('+846597547896'),
('+846596598742'),
('+846597123654'),
('+846565498715'),
('+846213216545'),
('+846523532156'),
('+846592316549'),
('+846521354354'),
('+846591235436'),
('+846597854879'),
('+846597032465'),
('+846501326577'),
('+846511654987'),
('+846512549875'),
('+846597124654'),
('+846597132165'),
('+846597895445'),
('+846597124376'),
('+846597895445'),
('+846597235544'),
('+846592135784'),
('+846597123553'),
('+846597326457'),
('+846129398438'),
('+848765398475'),
('+846893450923')

-- BẢNG 3
INSERT INTO THOSUAANH VALUES
('SA001'),
('SA002'),
('SA003'),
('SA004')
-- BẢNG 4
INSERT INTO PHOTOGRAPHER_CHUPKISU VALUES
('PG001',0,5),
('PG002',1,3),
('PG003',1,2),
('PG004',1,4)
-- BẢNG 5
INSERT INTO PHOTOGRAPHER_CHUPALBUMCUOI VALUES
('PG005',1,2),
('PG006',0,1),
('PG007',0,5),
('PG008',1,2)
-- BẢNG 6
INSERT INTO STYLIST VALUES
('SL001'),
('SL002'),
('SL003'),
('SL004')
--BẢNG 7
INSERT INTO THOPHU VALUES	
('TP001'),
('TP002'),
('TP003'),
('TP004')

-- BẢNG 8
INSERT INTO CVTRANGDIEM VALUES	
('TD001',2000000,1500000),
('TD002',2500000,1700000),
('TD003',3000000,1200000),
('TD004',2700000,2000000)


-- BẢNG 9 
INSERT INTO PHONGCACH_CVTRANGDIEM VALUES
('TD001',N'ĐÁM TIỆC'),
('TD002','HÓA TRANG'),
('TD003','ĐÁM TIỆC'),
('TD004','ĐÁM TIỆC')

-- BẢNG 10
INSERT INTO NVVANPHONG VALUES
('VP001',N'TRƯỞNG PHÒNG',N'GIAO TIẾP'),
('VP002',N'KẾ TOÁN',N'THỐNG KÊ'),
('VP003',N'TIẾP TÂN',N'GIAO TIẾP'),
('VP004',N'THƯ KÍ',N'HỖ TRỢ')


-- BANG11

SET DATEFORMAT DMY
INSERT INTO KHACHHANG VALUES(DBO.AUTO_IDKH(),N'QUẬN 2,TPHCM','22/5/2021',N'LÊ MINH TẤN','22/1/2001','+840202020122',
'TAN@GMAIL.COM',N'TRẦN THỊ DIỆU','23/1/1999','+840202020202','DIEU@GMAIL.COM')
INSERT INTO KHACHHANG(DIACHI,NGAYCUOI,HOTENCR,NGAYSINHCR,DIENTHOAICR,EMAILCR,HOTENCD,NGAYSINHCD,DIENTHOAICD,EMAILCD) VALUES
(N'QUẬN 7,TPHCM','22/7/2021',N'LÊ MINH QUANG','22/1/2001','+840202020123',
'QUANG@GMAIL.COM',N'NGUYỄN THỊ NGUYÊN','22/1/2001','+840202020202','NGUYEN@GMAIL.COM')
INSERT INTO KHACHHANG(DIACHI,NGAYCUOI,HOTENCR,NGAYSINHCR,DIENTHOAICR,EMAILCR,HOTENCD,NGAYSINHCD,DIENTHOAICD,EMAILCD) VALUES
(N'QUẬN 8 ,TPHCM','22/9/2021',N'TRẦN VĂN SĨ','22/1/1995','+840202021234',
'SI@GMAIL.COM',N'TRẦN THỊ DUNG','22/1/1996','+840202022234','DUNG@GMAIL.COM')
INSERT INTO KHACHHANG(DIACHI,NGAYCUOI,HOTENCR,NGAYSINHCR,DIENTHOAICR,EMAILCR,HOTENCD,NGAYSINHCD,DIENTHOAICD,EMAILCD) VALUES
(N'QUẬN 9,TPHCM','22/11/2021',N'LÊ CHIẾN SĨ','22/1/1992','+840202020123',
'QUANG@GMAIL.COM',N'NGUYỄN THI NGỌC','21/6/1991','+840202056466','NGOC@GMAIL.COM')


-- BẢNG 12
SET DATEFORMAT DMY
INSERT INTO HOPDONG(THOIDIEMKI,TONGGIA,MSKH,MS_VANPHONG) VALUES
('5/2/2021',2332323,'KH001','VP001')
INSERT INTO HOPDONG(THOIDIEMKI,TONGGIA,MSKH,MS_VANPHONG) VALUES
('2/4/2021',2323232,'KH002','VP003')
INSERT INTO HOPDONG(THOIDIEMKI,TONGGIA,MSKH,MS_VANPHONG) VALUES
('5/1/2021',2323564,'KH003','VP002')
INSERT INTO HOPDONG(THOIDIEMKI,TONGGIA,MSKH,MS_VANPHONG) VALUES
('2/3/2021',2134546,'KH004','VP004')


-- BẢNG 13
INSERT INTO HOPDONG_LANTHANHTOAN VALUES
('HD001','6/6/2021',5100000),
('HD002','6/5/2021',4100000),
('HD003','24/6/2021',3100000),
('HD004','21/7/2021',4300000)

-- BẢNG 14 
INSERT INTO DVALBUMCUOI(MSHD,MS_PHOTOGRAPHERALBUM,MS_STYLIST,MS_THOPHU,MS_CVTRANGDIEM,MSVEST1,MSVEST2,TONGGIA) VALUES
('HD001','PG007','SL001','TP001','TD001','VE001','VE002',5000000)
INSERT INTO DVALBUMCUOI(MSHD,MS_PHOTOGRAPHERALBUM,MS_STYLIST,MS_THOPHU,MS_CVTRANGDIEM,MSVEST1,MSVEST2,TONGGIA) VALUES
('HD002','PG005','SL002','TP002','TD002','VE003','VE004',4000000)
INSERT INTO DVALBUMCUOI(MSHD,MS_PHOTOGRAPHERALBUM,MS_STYLIST,MS_THOPHU,MS_CVTRANGDIEM,MSVEST1,MSVEST2,TONGGIA) VALUES
('HD003','PG006','SL003','TP003','TD003','VE005','VE006',6000000)
INSERT INTO DVALBUMCUOI(MSHD,MS_PHOTOGRAPHERALBUM,MS_STYLIST,MS_THOPHU,MS_CVTRANGDIEM,MSVEST1,MSVEST2,TONGGIA) VALUES
('HD004','PG008','SL004','TP004','TD004','VE007','VE008',5600000)
SELECT * FROM DVALBUMCUOI
-- BẢNG 15
INSERT INTO AOVEST(KIEU,MAU,KICHCO,SOLUONG,GIATHUE) VALUES
(N'TÂY',N'VÀNG','XS',3,5000000)
INSERT INTO AOVEST(KIEU,MAU,KICHCO,SOLUONG,GIATHUE) VALUES
(N'TÂY',N'ĐỎ','XL',2,6000000)
INSERT INTO AOVEST(KIEU,MAU,KICHCO,SOLUONG,GIATHUE) VALUES
(N'TÂY',N'HỒNG','L',1,4000000)
INSERT INTO AOVEST(KIEU,MAU,KICHCO,SOLUONG,GIATHUE) VALUES
(N'TÂY',N'XANH','XXL',1,5000000)
INSERT INTO AOVEST(KIEU,MAU,KICHCO,SOLUONG,GIATHUE) VALUES
(N'THÁI',N'VÀNG','XL',3,5000000)
INSERT INTO AOVEST(KIEU,MAU,KICHCO,SOLUONG,GIATHUE) VALUES
(N'THÁI',N'ĐỎ','XL',2,6000000)
INSERT INTO AOVEST(KIEU,MAU,KICHCO,SOLUONG,GIATHUE) VALUES
(N'TÂY',N'HỒNG','M',1,4000000)
INSERT INTO AOVEST(KIEU,MAU,KICHCO,SOLUONG,GIATHUE) VALUES
(N'TÂY',N'XANH','M',1,5000000)



-- BẢNG 16
INSERT INTO DAOCU(TEN,GIA,SOLUONG) VALUES
(N'NƠ',3000000,4)
INSERT INTO DAOCU(TEN,GIA,SOLUONG) VALUES
(N'BÔNG',3000000,5)
INSERT INTO DAOCU(TEN,GIA,SOLUONG) VALUES
(N'XE',3000000,2)
INSERT INTO DAOCU(TEN,GIA,SOLUONG) VALUES
(N'GIẤY DÁN',3000000,1)


-- BẢNG 17
INSERT INTO DVAlbum_DaoCu(MSDVALBUM,MSDC) VALUES
('DVA001','DC001')
INSERT INTO DVAlbum_DaoCu(MSDVALBUM,MSDC) VALUES
('DVA002','DC002')
INSERT INTO DVAlbum_DaoCu(MSDVALBUM,MSDC) VALUES
('DVA003','DC003')
INSERT INTO DVAlbum_DaoCu(MSDVALBUM,MSDC) VALUES
('DVA004','DC004')


-- BẢNG 18
INSERT INTO DIADIEM(TEN,GIA,VITRI,TONGTHOIGIANCHUP,GIABOSUNGGOC) VALUES
(N'NHÀ THỜ',5000000,N'TRONG NHA THỜ','1 NGÀY',2000000)
INSERT INTO DIADIEM(TEN,GIA,VITRI,TONGTHOIGIANCHUP,GIABOSUNGGOC) VALUES
(N'NHÀ',3000000,N'TẠI NHÀ','1 NGÀY',3000000)
INSERT INTO DIADIEM(TEN,GIA,VITRI,TONGTHOIGIANCHUP,GIABOSUNGGOC) VALUES
(N'NHÀ HÀNG',4000000,N'TẠI CỬA HÀNG','2 NGÀY',1000000)
INSERT INTO DIADIEM(TEN,GIA,VITRI,TONGTHOIGIANCHUP,GIABOSUNGGOC) VALUES
(N'NHÀ SỰ KIỆN',2000000,N'TRONG NHA THỜ','1 NGÀY',1500000)


-- Bang 19
INSERT INTO DVALBUM_DIADIEM VALUES
('DVA001','DD001','12/4/2021'),
('DVA002','DD002','23/5/2021'),
('DVA003','DD003','25/7/2021'),
('DVA004','DD004','22/6/2021')

-- BANG 20
INSERT INTO GOCCHUP VALUES
('DD001',N'BIỂN'),
('DD002',N'NHÀ THỜ'),
('DD003',N'STUDIO'),
('DD004',N'BIỂN')

-- BẢNG 21
INSERT INTO DV_GOC_VAY VALUES
('DVA001','DD001',N'BIỂN','VA001',1),
('DVA002','DD002',N'NHÀ THỜ','VA002',0),
('DVA003','DD003',N'STUDIO','VA003',1),
('DVA004','DD004',N'BIỂN','VA004',1)

-- BẢNG 22
INSERT INTO VAY(TEN,KIEU,HINHANH,MAU,CHATLIEU,NGUONGOC,TINHTRANG) VALUES
('Halter',N'dây bắt chéo sau cổ','AOCUOI.COM',N'TRẮNG',N'VẢI',N'PHƯƠNG TÂY','T')
INSERT INTO VAY(TEN,KIEU,HINHANH,MAU,CHATLIEU,NGUONGOC,TINHTRANG) VALUES
('High Neck ',N'cổ cao','AOCUOI.COM',N'HỒNG',N'VẢI',N'PHƯƠNG TÂY','K')
INSERT INTO VAY(TEN,KIEU,HINHANH,MAU,CHATLIEU,NGUONGOC,TINHTRANG) VALUES
('llusion',N'cổ giả','AOCUOI.COM',N'ĐỎ',N'VẢI',N'PHƯƠNG TÂY','G')
INSERT INTO VAY(TEN,KIEU,HINHANH,MAU,CHATLIEU,NGUONGOC,TINHTRANG) VALUES
('Jewel',N'cổ tròn thấp','AOCUOI.COM',N'VÀNG',N'VẢI',N'PHƯƠNG TÂY','K')


-- BẢNG 23
INSERT INTO VAYCHUPHINH VALUES
('VA001'),
('VA002'),
('VA003'),
('VA004')

-- BANG 24
SET DATEFORMAT DMY
INSERT INTO VAYNGAYCUOI VALUES
('VA011',4500000,5000000,5,'DVV013','22/2/2021','20%'),
('VA001',4500000,5000000,1,'DVV001','22/2/2021','10%'),
('VA002',4500000,5000000,1,'DVV002','22/2/2021','15%'),
('VA004',4500000,5000000,1,'DVV004','22/2/2021','5%')

DELETE FROM VAYNGAYCUOI



-- BẢNG 25 
INSERT INTO ALBUM VALUES
('AL001',16,'DVA001','BIA001','GIAY001'),
('AL002',18,'DVA002','BIA002','GIAY002'),
('AL003',19,'DVA003','BIA003','GIAY003'),
('AL004',20,'DVA004','BIA004','GIAY004')

-- BẢNG 26

INSERT INTO BIA(TEN,GIA,MAU,CHATLIEU) VALUES
(N'BÌA CƯỚI',500000,N'TRẮNG','GIẤY')
INSERT INTO BIA(TEN,GIA,MAU,CHATLIEU) VALUES
(N'BÌA CƯỚI',200000,N'HỒNG','GIẤY')
INSERT INTO BIA(TEN,GIA,MAU,CHATLIEU) VALUES
(N'BÌA CƯỚI',300000,N'VÀNG','GIẤY')
INSERT INTO BIA(TEN,GIA,MAU,CHATLIEU) VALUES
(N'BÌA CƯỚI',400000,N'ĐỎ','GIẤY')

-- BẢNG 27

INSERT INTO GIAYIN(CHATLIEU,GiaTo) VALUES
('3D',50000)
INSERT INTO GIAYIN(CHATLIEU,GiaTo) VALUES
('2D',40000)
INSERT INTO GIAYIN(CHATLIEU,GiaTo) VALUES
('GIẤY CAO CẤP',30000)
INSERT INTO GIAYIN(CHATLIEU,GiaTo) VALUES
('GIẤY THƯỜNG',30000)

-- BẢNG 28
INSERT INTO DVVAYCUOI(MSHD,TONGTIEN) VALUES
('HD001',4000000)
INSERT INTO DVVAYCUOI(MSHD,TONGTIEN) VALUES
('HD002',3000000)
INSERT INTO DVVAYCUOI(MSHD,TONGTIEN) VALUES
('HD003',5000000)
INSERT INTO DVVAYCUOI(MSHD,TONGTIEN) VALUES
('HD004',6000000)

-- BANG 29
-- TRIGGER CAU A INSERT TỪNG DÒNG
SET DATEFORMAT DMY
INSERT INTO DVVAYCUOI_THUE VALUES
('DVV001','VA001','22/3/2021','25/3/2021')
-- TRIGGER CAU A INSERT TỪNG DÒNG
SET DATEFORMAT DMY
INSERT INTO DVVAYCUOI_THUE VALUES
('DVV002','VA002','12/3/2021','16/3/2021')
-- TRIGGER CAU A INSERT TỪNG DÒNG
SET DATEFORMAT DMY
INSERT INTO DVVAYCUOI_THUE VALUES
('DVV003','VA003','23/4/2021','28/4/2021')
-- TRIGGER CAU A INSERT TỪNG DÒNG
SET DATEFORMAT DMY
INSERT INTO DVVAYCUOI_THUE VALUES
('DVV004','VA004','4/2/2021','10/2/2021')



-- BẢNG 30
INSERT INTO DVNGAYCUOI(SOLUONGNGUOINHA,DIADIEM,THOIDIEM,GIA,MSHD,MS_PHOTOGRAPHERKISU,MS_THOPHU,TONGGIA) VALUES
(10,N'NHÀ THỜ','8:00AM',1000000,'HD001','PG001','TP001',4000000)
INSERT INTO DVNGAYCUOI(SOLUONGNGUOINHA,DIADIEM,THOIDIEM,GIA,MSHD,MS_PHOTOGRAPHERKISU,MS_THOPHU,TONGGIA) VALUES
(11,N'NHÀ HÀNG','9:00AM',1000000,'HD002','PG002','TP002',7000000)
INSERT INTO DVNGAYCUOI(SOLUONGNGUOINHA,DIADIEM,THOIDIEM,GIA,MSHD,MS_PHOTOGRAPHERKISU,MS_THOPHU,TONGGIA) VALUES
(12,N'NHÀ','10:00AM',1000000,'HD003','PG003','TP003',6000000)
INSERT INTO DVNGAYCUOI(SOLUONGNGUOINHA,DIADIEM,THOIDIEM,GIA,MSHD,MS_PHOTOGRAPHERKISU,MS_THOPHU,TONGGIA) VALUES
(13,N'NHÀ THỜ','7:00AM',1000000,'HD004','PG004','TP004',5000000)


-- BẢNG 31

INSERT INTO NGAYCUOI_TRANGDIEM VALUES
('DVN002','TD001','22/4/2021','1')
INSERT INTO NGAYCUOI_TRANGDIEM VALUES
('DVN003','TD002','22/3/2021','0')
INSERT INTO NGAYCUOI_TRANGDIEM VALUES
('DVN003','TD003','16/5/2021','1')
INSERT INTO NGAYCUOI_TRANGDIEM VALUES
('DVN004','TD004','13/4/2021','0')
-- UPDATE 
UPDATE VAY SET TINHTRANG ='K' FROM VAYNGAYCUOI,VAY WHERE VAYNGAYCUOI.MSVCUOI=VAY.MSV AND  TINHTRANG = 'T'

-- DELETE
DELETE FROM HOPDONG
/*-Không xóa được, vì  CÓ KHÓA CHÍNH LÀ MSHD , MÀ CÁC BẢNG NHƯ HopDong_LanThanhToan,DVAlbumCuoi,DVVayCuoi,DVNgayCuoi có MSHD đều tham chiếu đến
bảng hợp đồng , còn MSKH,MS_VANPHONG CỦA HỢP ĐỒNG LÀ KHÓA NGOẠI  THAM CHIẾU ĐẾN BẢNG KHÁCH HÀNG VÀ NVVANPHONG
	- Nếu muốn xóa dữ liệu trong Hợp đồng ta phải xóa hết các ràng buộc của các bảng tham chiếu đến bảng Hợp đồng và bảng hợp đồng tham chiếu đến các bảng 
*/



-- Phần select

-- CÂU A
SELECT MSNV,HOTEN,COUNT(MSNV) AS N'SỐ LẦN TRANG DIEM CÔ DÂU'
FROM NHANVIEN A,CVTRANGDIEM B,NGAYCUOI_TRANGDIEM C
WHERE A.MSNV = B.MS_CVTRANGDIEM AND B.MS_CVTRANGDIEM = C.MS_CVTRANGDIEM AND CODAUNGUOINHA ='0'
GROUP BY MSNV,HOTEN
------------
SELECT MSNV,HOTEN,COUNT(MSNV) AS N'SỐ LẦN TRANG DIEM NGƯỜI NHÀ'
FROM NHANVIEN A,CVTRANGDIEM B,NGAYCUOI_TRANGDIEM C
WHERE A.MSNV = B.MS_CVTRANGDIEM AND B.MS_CVTRANGDIEM = C.MS_CVTRANGDIEM AND CODAUNGUOINHA ='1'
GROUP BY MSNV,HOTEN


--- CÂU B
SELECT distinct A.MSNV,A.HOTEN,THOIDIEMCHUP,TEN,TONGTHOIGIANCHUP
FROM NHANVIEN A,PHOTOGRAPHER_CHUPALBUMCUOI B,DIADIEM C,DVALBUM_DIADIEM D,DVALBUMCUOI E
WHERE A.MSNV=B.MS_PHOTOGRAPHERALBUM AND E.MSDVALBUM=D.MSDVALBUM AND
D.MSDD=C.MSDD AND E.MS_PHOTOGRAPHERALBUM=B.MS_PHOTOGRAPHERALBUM


-- CÂU C
SELECT A.MSHD,A.THOIDIEM,A.SOTIEN FROM HOPDONG_LANTHANHTOAN A,HOPDONG B
WHERE B.MSHD=A.MSHD

-- PHÂN QUYỀN TRUY CẬP

-- TẠO USER
SP_ADDLOGIN 'USER1','123456','quanlitiemcuoi1'
SP_ADDLOGIN 'USER2','123456','quanlitiemcuoi1'

--CAU A
sp_adduser 'USER1','USERNVVANPHONG'
sp_adduser 'USER2','USERKHACHHANG'
-- CAU B
grant insert,update,delete
on HOPDONG
TO USERNVVANPHONG

grant insert,update,delete
on HOPDONG_LANTHANHTOAN
TO USERNVVANPHONG

grant insert,update,delete
on DVALBUMCUOI
TO USERNVVANPHONG

grant insert,update,delete
on DVVAYCUOI
TO USERNVVANPHONG

grant insert,update,delete
on DVNGAYCUOI
TO USERNVVANPHONG

-- CAU C

grant SELECT
on BIA
TO USERKHACHHANG

grant SELECT
on GIAYIN
TO USERKHACHHANG

grant SELECT
on VAYCHUPHINH
TO USERKHACHHANG

grant SELECT
on VAYNGAYCUOI
TO USERKHACHHANG

grant SELECT
on DIADIEM
TO USERKHACHHANG

grant SELECT
on DAOCU
TO USERKHACHHANG

grant SELECT
on AOVEST
TO USERKHACHHANG
