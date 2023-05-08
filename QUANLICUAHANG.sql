CREATE TABLE NHANVIEN
  (
  MANHANVIEN CHAR(10) PRIMARY KEY,
  HOTEN NVARCHAR(30),
  NGAYSINH DATE,
  GIOITINH BIT,
  NGAYLAMVIEC DATE,
  DIACHI NVARCHAR(50),
  DIENTHOAI VARCHAR(15),
  LUONG FLOAT 
  );
  create table NHACUNGCAP
(
	MANCC char(10) primary key,
	TENNCC nvarchar(50),
	DIACHI nvarchar(100),
	SODIENTHOAI varchar(15),
	EMAIL nvarchar(50),
);
CREATE TABLE KHACH
(
  MAKHACH CHAR(10) PRIMARY KEY,
  TENKHACH NVARCHAR(30),
  DIACHI NVARCHAR(100),
  EMAIL NVARCHAR(30) UNIQUE,
  DIENTHOAI VARCHAR(15)
  );
CREATE TABLE LOAISP(
MALOAISP CHAR(10) PRIMARY KEY,
TENLOAISP NVARCHAR(50),
)

CREATE TABLE SANPHAM(
    MASP CHAR(10)PRIMARY KEY,
	TENSP NVARCHAR(100),
	MANCC CHAR(10),
	SOLUONG INT,
	DONVITINH NVARCHAR(30),
	MALOAISP CHAR(10),
	GIAHANG FLOAT,
  FOREIGN KEY(MANCC) REFERENCES NHACUNGCAP(MANCC),
  FOREIGN KEY(MALOAISP)REFERENCES LOAISP(MALOAISP)
)
CREATE TABLE HOADON(
SOHOADON CHAR(10) PRIMARY KEY,
  MAKHACH CHAR(10),
  MANHANVIEN CHAR(10),
  NGAYDATHANG DATE,
  NGAYCHUYENHANG DATE,
  NGAYGIAOHANG date,
  FOREIGN KEY (MAKHACH) REFERENCES KHACH(MAKHACH),
  FOREIGN KEY (MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN)
)

CREATE TABLE DONVIVANCHUYEN(
     MADVVC CHAR(10) PRIMARY KEY ,
	TENDVVC NVARCHAR(100) ,
	DIACHI NVARCHAR(100) ,
	SDT VARCHAR(15)
)

CREATE TABLE CHITIETHOADON(
    SOHOADON char(10),
	MASP  char(10),
	GIABAN float,
	SOLUONG int,
	MUCGIAMGIA int,
	primary key(SOHOADON,MASP),
	foreign key(SOHOADON) references HOADON(SOHOADON),
	foreign key(MASP) references SANPHAM(MASP)
)
CREATE TABLE VANCHUYEN(
    MAVD char(10) primary key,
	SOHOADON CHAR(10),
	MADVVC char(10),
	DIACHI nvarchar(50),
	PHIVANCHUYEN FLOAT,
	foreign key(MADVVC) references DONVIVANCHUYEN,
	foreign key(SOHOADON) references HOADON(SOHOADON) 
)
Insert into LOAISP(MALOAISP, TENLOAISP)
Values
('L1',N'Rau'),
('L2',N'Củ'),
('L3',N'Quả'),
('L4',N'Nấm');

Insert into DONVIVANCHUYEN (MADVVC, TENDVVC, DIACHI, SDT)
Values ('DVVC1',N'Giao hàng tiết kiệm',N'192 Đường Giải Phóng','09824317623'),
('DVVC2',N'Giao hàng nhanh',N'35 Phường Khương Trung','03734561237'),
('DVVC3',N'J&T',N'07 Phố Lê Hoàn','07231965382'),
('DVVC4',N'NinjaVan',N'12 Đường Lê Đình Chinh','0454298561');

insert into NHACUNGCAP(MANCC, TENNCC, DIACHI, SODIENTHOAI, EMAIL)
values ('N1',N'Nông trại Hướng Dương',N'Khu B','01275398416',N'HD@gmail.com'),
('N2',N'Nông trại Nextfarm',N'Khu B','01275398416',N'NF@gmail.com'),
('N3',N'Nông trại Hữu Cơ',N'Khu A','08352745183',N'HC@gmail.com'),
('N4',N'Vườn Xanh',N'Khu C','05472945192',N'VX@gmail.com'),
('N5',N'Nông trại Sạch',N'Khu D','09452715492',N'NT@gmail.com'),
('N6',N'Nông trại Amway',N'Đà Lạt','09452715492',N'amway@gmail.com'),
('N7',N'Nông trại Phú Diễn ',N'sapa','09452715492',N'PhuDien@gmail.com'),
('N8',N'Nông trại MocChauFarm ',N'Mộc Châu','09452715492',N'Mocchaufarm@gmail.com')

 INSERT INTO KHACH (MAKHACH, TENKHACH,  DIACHI, EMAIL, DIENTHOAI)
VALUES 
('KH1', N'Nguyễn Văn A', N'TÒA NHÀ DẢI NGÂN HÀ Hà Nội','ndgfm@gmail.com','0153427978'),
('KH2', N'Lê Văn Ba',N'KHU ĐÔ THỊ MỚI','cbdsm@gmail.com','0342618639'),
('KH3', N'Đào Nguyên', N'KHU DÂN CƯ SỐ 3 Hải Phòng','fndrx@gmail.com','0134261836'),
('KH4', N'Nguyễn Hải Vân ',N'Phú Xuyên Hà Nội','nhv@gmail.com','0754341639'),
('KH5', N'Nguyễn Tiến Cường',N'175 Tây Sơn Đống Đa Hà Nội','ntm@gmail.com','054441639'),
('KH6', N'Phạm Thị Ngọc Minh',N'Cầu Giấy Hà Nội','ptnm@gmail.com','0345341639'),
('KH7', N'Nguyễn Thu Trang ',N'Bắc Từ Liêm Hà Nội','ntt@gmail.com','0934541639'),
('KH8', N'Bùi Đức Hải ',N'Chùa Láng Hà Nội','bdh@gmail.com','0845341639'),
('KH9', N'Vũ Văn Toàn ',N'Thanh Xuân Hà Nội','vvt@gmail.com','0945341639'),
('KH10', N'Lê Vũ Long',N'Hải Phòng','lvl@gmail.com','0245341639'),
('KH11', N'Nguyễn Hồng Lan',N'Thái Nguyên','nhl@gmail.com','0345341639')

 INSERT INTO NHANVIEN (MANHANVIEN, HOTEN , NGAYSINH,GIOITINH, NGAYLAMVIEC, DIACHI, DIENTHOAI, LUONG)
VALUES ('NV1', N'NGUYỄN TIẾN ĐỨC', '1997-07-05','1','2017-03-19',N'175 Tây Sơn Đống Đa Hà Nội','0567352978341','15000000'),
 ('NV2', N'DƯƠNG HÀ  PHƯƠNG', '1998-11-19','0','2018-05-10',N'298 Chùa Láng Hà Nội','04597342241','13000000'),
 ('NV3', N' HÀ HUYỀN VŨ', '1999-12-09','1','2019-01-01',N'Bắc Từ Liêm','03418254549','9000000' ),
 ('NV4', N' NGUYỄN HẢI', '1996-12-02','1','2019-01-01',N'128 Cầu Diễn Hà Nội','04182543231','9000000' ),
 ('NV5', N' TRẦN HUYỀN THƯƠNG', '1989-10-09','0','2020-03-28',N'Long Biên','01825465781','9000000' ),
 ('NV6', N' NGUYỄN HẢI VÂN', '1996-12-05','0','2021-01-27',N'12 Thạch Bàn ','04182543231','9000000') ,
 ('NV7', N'BÙI ĐỨC HẢI', '1993-05-05','1','2021-01-01',N'28 Chùa Bộc Đống Đa Hà Nội','04182543231','9000000' ),
 ('NV8', N' NGUYỄN THU TRANG', '1997-12-04','1','2021-01-07',N'Hà Nội','04182543231','8000000' ),
 ('NV9', N' NGUYỄN THU THỦY', '1996-08-08','1','2021-05-01',N'Hà Nội','04182543231','7000000' )
 
  INSERT INTO HOADON ( SOHOADON, MAKHACH, MANHANVIEN, NGAYDATHANG, NGAYCHUYENHANG,NGAYGIAOHANG  )
  VALUES
  ('HD1','KH1','NV1','04-06-2019','04-07-2019' ,'04-09-2019'),
  ('HD2','KH2','NV2','04-30-2019','05-01-2019','05-03-2019' ),
  ('HD3','KH3','NV3','05-09-2020','05-12-2020','05-13-2020' ),
  ('HD4','KH4','NV1','10-09-2020','10-10-2020' ,'10-11-2020'),
  ('HD5','KH5','NV3','05-09-2020','05-10-2020' ,'05-11-2020'),
  ('HD6','KH6','NV2','08-09-2021','08-10-2021' ,'08-12-2021'),
  ('HD7','KH7','NV4','07-12-2021','07-13-2021','07-15-2021' ),
  ('HD8','KH8','NV5','01-09-2021','01-10-2021' ,'01-12-2021'),
  ('HD9','KH6','NV6','03-22-2021','03-23-2021' ,'03-24-2021'),
   ('HD10','KH9','NV7','04-09-2021','04-10-2021' ,'04-11-2021')

   select * from hoadon
  INSERT INTO VANCHUYEN(MAVD,SOHOADON, MADVVC,DIACHI,PHIVANCHUYEN)
VALUES ('VD1','HD1','DVVC1',N'TÒA NHÀ DẢI NGÂN HÀ','30000'),
('VD2','HD2', 'DVVC3',N'KHU ĐÔ THỊ MỚI','30000'),
('VD3','HD3', 'DVVC4',N'KHU DÂN CƯ SỐ 3','30000'),
('VD4','HD4' ,'DVVC2',N'175 Tây Sơn Đống Đa Hà Nội','30000'),
('VD5','HD5' ,'DVVC4',N'178 Tây Sơn Đống Đa Hà Nội','30000'),
('VD6','HD6' ,'DVVC2',N'18 Chùa Bộc Hà Nội','30000'),
('VD7','HD7' ,'DVVC4',N'175 Tây Sơn Đống Đa Hà Nội','30000'),
('VD8','HD8' ,'DVVC2',N'175 Cầu Giấy Hà Nội','30000'),
('VD9','HD9' ,'DVVC3',N'175 Tây Sơn Đống Đa Hà Nội','30000'),
('VD10','HD10' ,'DVVC1',N'175 Tây Sơn Đống Đa Hà Nội','30000')
select * from vanchuyen

Insert into SANPHAM( MASP, TENSP, MANCC, SOLUONG, DONVITINH, MALOAISP, GIAHANG)
Values 
('SP1', N'Bắp cải', 'N1','50','KG','L1','10000'),
('SP2', N'Cà rốt', 'N2','50','KG','L2','10000'),
('SP3', N'Cần tây', 'N3','50','KG','L1','10000'),
('SP4', N'Cải thảo', 'N4','50','KG','L1','10000'),
('SP5', N'Cải thìa ', 'N5','50','KG','L1','10000'),
('SP6', N'Cải bó xôi ', 'N2','50','KG','L1','10000'),
('SP7', N'Ớt chuông ', 'N1','50','KG','L3','10000'),
('SP8', N'Dưa leo ', 'N3','50','KG','L3','10000'),
('SP9', N'Bông cải xanh ', 'N2','50','KG','L1','10000'),
('SP10', N'Cà chua ', 'N2','50','KG','L3','10000'),
('SP11', N'Nấm kim châm', 'N1','50','KG','L4','10000');

insert into CHITIETHOADON
values
('HD1','SP1','15000','10','1'),
('HD1','SP2','15000','10','9'),
('HD1','SP3','15000','10','5'),
('HD2','SP2','20000','10','10'),
('HD2','SP3','15000','10','9'),
('HD3','SP3','25000','10','7'),
('HD3','SP2','15000','10','3'),
('HD4','SP4','27000','10','8'),
('HD4','SP1','15000','10','9'),
('HD5','SP5','15000','10','4'),
('HD6','SP6','15000','10','15'),
('HD7','SP2','15000','10','9'),
('HD8','SP1','15000','10','6'),
('HD9','SP3','15000','10','9'),
('HD10','SP5','15000','10','8')
select * from SANPHAM
select * from LOAISP
select * from DONVIVANCHUYEN
select * from NHACUNGCAP
select * from CHITIETHOADON
select * from  VANCHUYEN
SELECT * FROM KHACH

ALTER TABLE HOADON
ADD THANHTIEN FLOAT
         --------------------------Bảo mật phân quyền----------------------------------------------
----Tạo login
sp_addlogin 'nhvan','123';
sp_addlogin 'ptnminh','123';
sp_addlogin 'nttrang','123';
----tạo user
sp_grantdbaccess 'nhvan','van';
sp_grantdbaccess 'ptnminh', 'minh'
sp_grantdbaccess 'nttrang', 'trang'
---tạo role 
sp_addrole quanly;
sp_addrole nhanvien;
-----cấp quyền cho role QUANLY
 GRANT select,insert,delete,update  ON NHANVIEN to QUANLY
 GRANT select,insert,delete,update  ON SANPHAM to QUANLY
 GRANT select,insert,delete,update  ON HOADON to QUANLY
 GRANT select,insert,delete,update  ON CHITIETHOADON to QUANLY
 GRANT select,insert,delete,update  ON KHACH to QUANLY
 GRANT select,insert,delete,update  ON LOAISP to QUANLY
 GRANT select,insert,delete,update  ON VANCHUYEN to QUANLY
 GRANT select,insert,delete,update  ON DONVIVANCHUYEN to QUANLY
 GRANT select,insert,delete,update  ON NHACUNGCAP to QUANLY
 --Cấp quyền cho role nhân viên
 grant  select on SANPHAM TO NHANVIEN
 GRANT select,insert,delete,update  ON KHACH to NHANVIEN
 GRANT select,insert,delete,update  ON HOADON to NHANVIEN
 GRANT select,insert,delete,update  ON CHITIETHOADON to NHANVIEN
 ---Add member vào role
 sp_addrolemember 'QUANLY','van';
 sp_addrolemember 'NHANVIEN','minh';
 sp_addrolemember 'NHANVIEN','trang';
 --Xóa user minh
 sp_revokedbaccess 'minh'



--------------------------------------------View---------------------------------------------


--CÂU 1:Tạo View view hiển thị thông tin về các sản phẩm được đặt hàng đúng 1 lần trong năm 2021.
CREATE VIEW SP_BAN1LAN_2021
AS
SELECT *
FROM SANPHAM 
WHERE MASP IN ( SELECT CTHD.MASP  FROM CHITIETHOADON CTHD INNER JOIN HOADON HD ON CTHD.SOHOADON=HD.SOHOADON
                                      WHERE   (YEAR(HD.NGAYDATHANG)=2021)
									  Group By CTHD.MASP
									  Having count(CTHD.MASP)=1)
SELECT * FROM SP_BAN1LAN_2021

 --CÂU 3 :tạo khung nhìn Đưa ra mã nhân viên,họ tên ,địa chỉ  ,số lân lập hóa đơn của các nhân viên có số lần lập hóa đơn nhiều nhất
 select * FROM NHANVIEN
 SELECT *FROM HOADON
 CREATE VIEW NHANVIEN_MAX_HOADON
 AS
 SELECT  NHANVIEN.MANHANVIEN,HOTEN,DIACHI,COUNT(HOADON.MANHANVIEN)AS SO_LAN_LAP_HOADON 
 FROM NHANVIEN ,HOADON
 WHERE NHANVIEN.MANHANVIEN=HOADON.MANHANVIEN
 GROUP  BY  NHANVIEN.MANHANVIEN,HOTEN,DIACHI
 HAVING COUNT(HOADON.MANHANVIEN)>= ALL (SELECT COUNT(HOADON.MANHANVIEN) 
                                        FROM HOADON INNER JOIN NHANVIEN ON NHANVIEN.MANHANVIEN=HOADON.MANHANVIEN 
										GROUP BY HOADON.MANHANVIEN)
  SELECT * FROM NHANVIEN_MAX_HOADON

-------------HÀM-----------------------------

--CÂU 3:Hàm tính tổng tiền của mỗi hóa đơn của bảng hóa đơn,với số hóa đơn là tham số truyền vào

CREATE FUNCTION HD_TONGTIEN (@SOHD CHAR(10))
RETURNS FLOAT
  BEGIN
	 DECLARE @TONGTIEN FLOAT
	 SELECT @TONGTIEN= SUM(SOLUONG*GIABAN - SOLUONG*GIABAN*MUCGIAMGIA/100) FROM CHITIETHOADON
	 WHERE SOHOADON=@SOHD 
	 GROUP BY SOHOADON
	 RETURN @TONGTIEN
  END
 SELECT  dbo.HD_TONGTIEN('HD1')

 --CÂU 4:Viết hàm kiểm tra nhân viên có lập hóa đơn trong 1 tháng bất kì của năm 2021 không ,với đầu vào là mã nhân viên và tháng
CREATE FUNCTION CHECK_NV(@MANV CHAR(10),@THANG INT)
RETURNS CHAR(10)
AS
   BEGIN
	   DECLARE @KETQUA NVARCHAR(10)
	   IF (EXISTS (SELECT NHANVIEN.MANHANVIEN FROM NHANVIEN,HOADON 
	                      WHERE NHANVIEN.MANHANVIEN=HOADON.MANHANVIEN
						  AND HOADON.MANHANVIEN =@MANV AND MONTH(HOADON.NGAYDATHANG)=@THANG AND YEAR(HOADON.NGAYDATHANG)=2021
					     ))
		 SET @KETQUA='TRUE'
		ELSE
		 SET @KETQUA='FALSE'
		RETURN @KETQUA
  END

 SELECT DBO.CHECK_NV('NV2',8)
  
  DROP FUNCTION DBO.CHECK_NV

--CÂU 5: VIẾT MỘT HÀM TRẢ VỀ GIÁ TRỊ TÊN CỦA NHÂN VIÊN VỚI KIỂU NVARCHAR SỬ DỤNG HÀM ĐÓ ĐỂ LẤY RA THÔNG TIN CỦA NHÂN VIÊN TÊN 'PHƯƠNG'
SELECT * FROM NHANVIEN
CREATE FUNCTION TACH_TEN_NV(@HOTEN NVARCHAR(50))
RETURNS NVARCHAR(20)
AS
BEGIN
 DECLARE @TEN NVARCHAR(20)
 SELECT @TEN= RIGHT(RTRIM(@HOTEN), CHARINDEX(' ', LTRIM(REVERSE(@HOTEN))))
 RETURN @TEN
END
SELECT * FROM NHANVIEN where dbo.TACH_TEN_NV(HOTEN) LIKE N'%PHƯƠNG%' 
DROP FUNCTION TACH_TEN_NV

                             -------------------------------Thủ tục---------------------------------------

--CÂU 6: viết một stored procedure thống kê số lượng bán 1 sản phẩm theo các ngày trong tuần với tên sản phẩm là tham số truyền vào .
CREATE PROC SANPHAM_THONGKE @TENSP NVARCHAR(30)
AS
	BEGIN
	DECLARE @MASP CHAR(10)
	SELECT @MASP=MASP FROM SANPHAM WHERE TENSP=@TENSP
	SELECT
		SUM(case   DATEPART(DW,HD.NGAYDATHANG) WHEN 1 THEN CTHD.SOLUONG  END ) AS CHỦNHẬT ,
		SUM(case   DATEPART(DW,HD.NGAYDATHANG) WHEN 2 THEN CTHD.SOLUONG  END ) AS THỨ2,
		SUM(case   DATEPART(DW,HD.NGAYDATHANG) WHEN 3 THEN CTHD.SOLUONG END ) AS THỨ3,
		SUM(case   DATEPART(DW,HD.NGAYDATHANG) WHEN 4 THEN CTHD.SOLUONG  END ) AS THỨ4,
		SUM(case   DATEPART(DW,HD.NGAYDATHANG) WHEN 5 THEN CTHD.SOLUONG  END ) AS THỨ5,
		SUM(case   DATEPART(DW,HD.NGAYDATHANG) WHEN 6 THEN CTHD.SOLUONG END ) AS THỨ6,
		SUM(case   DATEPART(DW,HD.NGAYDATHANG) WHEN 7  THEN CTHD.SOLUONG  END ) AS THỨ7
		FROM CHITIETHOADON CTHD INNER JOIN  HOADON HD  ON CTHD.SOHOADON=HD.SOHOADON       
		WHERE CTHD.MASP=@MASP
	END

EXEC SANPHAM_THONGKE N'Cà rốt'
DROP PROC SANPHAM_THONGKE

--CÂU 7: Thủ tục cập nhật tổng tiền của hóa đơn trong bảng hóa đơn bằng tổng tiền của các mặt hàng +phí vận chuyển

 CREATE PROC CAP_NHAT_TONGTIEN
 AS
 UPDATE HOADON
 SET THANHTIEN=dbo.HD_TONGTIEN(HOADON.SOHOADON)+PHIVANCHUYEN
 FROM CHITIETHOADON ,VANCHUYEN 
 where CHITIETHOADON.SOHOADON=HOADON.SOHOADON AND VANCHUYEN.SOHOADON=HOADON.SOHOADON

EXEC CAP_NHAT_TONGTIEN

--câu 8:TẠO THỦ TỤC ĐƯA RA THÔNG TIN CỦA NHỮNG HÓA ĐƠN ĐƯỢC VẬN CHUYỂN BỞI ĐƠN VỊ VẬN CHUYỂN 
--VỚI TÊN ĐƠN VỊ VẬN CHUYỂN LÀ THAM SỐ TRUYỀN VÀO
CREATE PROC HOADON_VANCHUYEN @TENDVVC NVARCHAR(50)=N'GIAO HÀNG TIẾT KIỆM'
AS
BEGIN
  SELECT HOADON.* FROM HOADON INNER JOIN VANCHUYEN ON HOADON.SOHOADON=VANCHUYEN.SOHOADON
                              INNER JOIN DONVIVANCHUYEN ON DONVIVANCHUYEN.MADVVC=VANCHUYEN.MADVVC
				  WHERE DONVIVANCHUYEN.TENDVVC =@TENDVVC
END

EXECUTE HOADON_VANCHUYEN N'GIAO HÀNG NHANH'

DROP PROC HOADON_VANCHUYEN

select * from DONVIVANCHUYEN
select * from HOADON
SELECT * FROM VANCHUYEN


--------------------------trigger--------------------------------
--Câu 1 :Viết trigger kiểm tra việc chèn dữ liệu vào bảng chi tiết hóa đơn ,nếu số hóa đơn hoặc mã hàng sai thì không cho phép chèn
CREATE TRIGGER CHECK_INSERT_CTHD
ON CHITIETHOADON
FOR INSERT
AS
BEGIN
DECLARE @SOHD CHAR(10),@MASP CHAR(10)
SELECT @SOHD=SOHOADON FROM inserted
SELECT @MASP=MASP FROM inserted
 if (@SOHD is null OR not exists(select SOHOADON from HOADON where SOHOADON=@SOHD)
    OR @MASP is null OR NOT exists(select MASP from SANPHAM where MASP = @MASP))
  BEGIN
     Print N'Vui lòng kiểm tra lại số hóa đơn và mã sản phẩm'
	 ROLLBACK TRAN
  END
 ELSE
   PRINT N'Chèn bản ghi mới thành công'
END

INSERT INTO CHITIETHOADON VALUES('','SP20',10000,20,1)
INSERT INTO CHITIETHOADON VALUES('HD3','SP2',10000,20,1)
DROP TRIGGER CHECK_INSERT_CTHD
SELECT * FROM CHITIETHOADON
---XÓA RÀNG BUỘC-----
ALTER TABLE CHITIETHOADON
DROP CONSTRAINT PK_HD

ALTER TABLE CHITIETHOADON
ADD CONSTRAINT PK_HD FOREIGN KEY(SOHOADON) REFERENCES HOADON(SOHOADON)
ALTER TABLE CHITIETHOADON
ADD CONSTRAINT PK_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)

SELECT * FROM SANPHAM								 
--Câu 2 viết kiểm tra khi xóa một sản phẩm trong bảng sản phẩm ,nếu sản phẩm đó tồn tại trong chi tiết đơn hàng thì không cho xóa nữa và hiện thông báo,ngược lại 
--thì báo thành công
CREATE TRIGGER DELETE_SANPHAM
ON SANPHAM
FOR DELETE 
AS
BEGIN
DECLARE @MASP CHAR(10)
SELECT @MASP=MASP FROM deleted
IF EXISTS (SELECT MASP FROM CHITIETHOADON WHERE MASP=@MASP)
   BEGIN
     PRINT N'Không thể xóa sản phẩm này'
	  ROLLBACK TRAN
   END
ELSE
 PRINT N'Xóa sản phẩm thành công'
END
DROP TRIGGER DELETE_SANPHAM

DELETE FROM SANPHAM WHERE MASP='SP1'
DELETE FROM SANPHAM WHERE MASP='SP10'

--Câu 11 Viết một trigger để đảm bảo rằng khi thêm một nhân viên mới vào thì tuổi của nhân viên không được nhỏ hơn 18 và >=45
CREATE TRIGGER CHECK_TUOINHANVIEN
ON NHANVIEN
FOR INSERT
AS
BEGIN 
DECLARE @TUOI_NV INT
SET @TUOI_NV=(select datediff(year,inserted.ngaysinh,getdate()) from inserted)
IF (@TUOI_NV>=45)
  BEGIN
	PRINT N'TUỔI CỦA NHÂN VIÊN KHÔNG ĐƯỢC QUÁ 45 '
	rollback tran
  END
ELSE IF(@TUOI_NV<18)
  BEGIN
	PRINT N'TUỔI CỦA NHÂN VIÊN KHÔNG ĐƯỢC NHỎ HƠN 18 '
	rollback tran
  END
ELSE
 PRINT N'CHÈN BẢN GHI THÀNH CÔNG '
END

SELECT * FROM NHANVIEN
INSERT INTO NHANVIEN VALUES('NV11',N'NGUYỄN VĂN A','09-12-1960',1,'07-09-2021',N'HÀ NỘI','04354363636',15000000)
INSERT INTO NHANVIEN VALUES('NV10',N'NGUYỄN VĂN A','09-12-1999',1,'07-09-2021',N'HÀ NỘI','04354363636',15000000)