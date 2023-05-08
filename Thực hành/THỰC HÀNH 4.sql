--Câu 1: Cho bảng NHANVIEN (MaNV, Hoten, Ngaysinh,...).Viết một trigger để đảm
--bảo rằng khi thêm một nhân viên mới vào thì tuổi của nhân viên không được >=45
CREATE TRIGGER TUOINHANVIEN
ON NHANVIEN
AFTER INSERT
AS
BEGIN 
DECLARE @TUOI_NV INT

SET @TUOI_NV=(select datediff(year,inserted.ngaysinh,getdate()) as tuoi from inserted)
IF (@TUOI_NV>=45)
PRINT N'TUỔI CỦA NHÂN VIÊN KHÔNG ĐƯỢC QUÁ 45 '
rollback tran
END
--(SELECT YEAR(GETDATE())-YEAR(NGAYSINH) AS TUOI FROM inserted)

DROP TRIGGER TUOINHANVIEN
INSERT INTO NHANVIEN VALUES('07',N'Nguyễn',N'Tu','02/02/1950','08/07/2021',N'Hà Nội','094878555',8000000,2000000,4500000)
--Câu 2: Tạo trigger để tránh xoá 2 bản ghi trong bảng Nhanvien đồng thời.
DROP TRIGGER XOA_NV

CREATE TRIGGER XOA_NV
ON NHANVIEN
FOR DELETE 
AS
BEGIN
IF((Select count(*) From deleted)>2)
 BEGIN
PRINT 'Ban khong duoc xoa cung luc 2 ban ghi'
ROLLBACK TRAN
END
END

SELECT * FROM NHANVIEN
alter table dondathang
drop constraint FK__DONDATHAN__MANHA__33D4B598
DELETE FROM NHANVIEN WHERE HO LIKE N'NGUYỄN'

--Câu 3: Tạo UPDATE trigger đảm bảo rằng cột lương cơ bản không được lớn hơn
--1000000 và ngày sinh không lớn hơn ngày hiện tại.
CREATE TRIGGER UPDATE_NV
ON NHANVIEN
FOR UPDATE
AS
BEGIN
DECLARE @LUONG REAL
SELECT  @LUONG =LUONGCOBAN FROM inserted
DECLARE @NS DATE 
SELECT  @NS =NGAYSINH FROM inserted
IF(@LUONG>1000000 and @NS>GETDATE())
BEGIN
PRINT N' Lương không được lớn hơn 1 triệu ,NGÀY SinH PHẢI NHỎ HƠN NGÀY HIỆN TẠI'
ROLLBACK TRAN
END
else
  print 'update thành công!'
END

UPDATE NHANVIEN
SET NGAYSINH='12-21-2021' WHERE MANHANVIEN='01'
select * from NHANVIEN
drop TRIGGER UPDATE_NV
--Câu 4: Tạo một trigger không cho phép cập nhật cột Ngaysinh trong bảng Nhanvien.
CREATE TRIGGER UPDATE_NS
ON NHANVIEN
FOR UPDATE
AS
BEGIN
if(update(ngaysinh))
begin
print 'không được cập nhật ngày sinh'
rollback tran
end
end

drop trigger UPDATE_NS
--Câu 5: Hiển thị các trigger trong bảng Nhanvien
exec sp_helptrigger 'NhanVien'
--Câu 6: Tạo trigger để kiểm tra dữ liệu nhập vào cột MaLoaiHang trong bảng
--MatHang phải là dữ liệu đã tồn tại trong cột MaLoaiHang của bảng LoaiHang
CREATE TRIGGER CAU6
ON MATHANG
FOR INSERT
AS
BEGIN
DECLARE @MALOAI INT
SELECT @MALOAI=(SELECT MALOAIHANG FROM inserted)
IF( @MALOAI NOT IN (SELECT MALOAIHANG FROM LOAIHANG))
	BEGIN
	   PRINT 'MẶT HÀNG NÀY KHÔNG TỒN TẠI'
	   ROLLBACK TRAN
	END
END
DROP TRIGGER CAU6
INSERT INTO MATHANG VALUES(11,N'GHẾ',1,10,20,N'CHIẾC',200000)
SELECT * FROM MATHANG
SELECT* FROM LOAIHANG
ALTER TABLE MATHANG
DROP CONSTRAINT FK__MATHANG__MALOAIH__2B3F6F97
--Câu 7: Tạo một cascade trigger để khi xóa một loại hàng trong bảng LoaiHang thì
--toàn bộ các mặt hàng tương ứng với loại hàng đó cũng bị xóa. Sau đó trigger này sẽ
--kích hoạt hoạt hành động hiển thị thông tin của những mặt hàng còn lại.
DROP TRIGGER CAU7
Create TRIGGER CAU7
ON LOAIHANG
FOR DELETE
AS
BEGIN
DELETE FROM MATHANG
WHERE MALOAIHANG=(SELECT MALOAIHANG FROM deleted)
END
DELETE FROM LOAIHANG WHERE MALOAIHANG='03'

ALTER TABLE CHITIETDATHANG
DROP CONSTRAINT FK__CHITIETDA__MAHAN__37A5467C
--Câu 8: Tạo một view View_Cau8 chứa MaHang, TenHang, TenLoaiHang. Thử thực
--hiện việc thêm/xóa/sửa trên trigger đó. Từ đó viết instead of trigger để thay thế cho
--những tác insert, update, delete nguyên thủy.
CREATE VIEW VIEW_HANG
AS
SELECT M.MAHANG,TENHANG,M.MALOAIHANG,L.TENLOAIHANG
FROM MATHANG M INNER JOIN LOAIHANG L ON L.MALOAIHANG=M.MALOAIHANG

SELECT * FROM VIEW_HANG
DELETE FROM VIEW_HANG WHERE MALOAIHANG=2

CREATE TRIGGER UPDATE_HANG_LOAIHANG
ON VIEW_HANG
INSTEAD OF UPDATE
AS
BEGIN
     UPDATE MATHANG
	 SET TENHANG=(SELECT  TENHANG FROM inserted)
	 WHERE MAHANG=(SELECT  MAHANG FROM inserted)
	  UPDATE MATHANG
	 SET TENHANG=(SELECT  TENHANG FROM inserted)
	 WHERE MAHANG=(SELECT  MAHANG FROM inserted)
	 TENLOAIHANG=(SELECT  MAlLOAIHANG FROM inserted)
END


CREATE TRIGGER DELETE_HANG_LOAIHANG
ON VIEW_HANG
INSTEAD OF DELETE
AS
BEGIN
     DELETE FROM MATHANG
	 SET MAHANG=(SELECT  MAHANG FROM inserted),TENHANG=(SELECT  TENHANG FROM inserted),MALOAIHANG(SELECT  MAHANG FROM inserted)
	 WHERE MAHANG=(SELECT  MAHANG FROM inserted)
END
--Câu 9: Tạo trigger thực hiện công việc sau:
--- Khi một bản ghi mới được bổ sung vào bảng này thì giảm số lượng hàng hiện
--có nếu số lượng hàng hiện có lớn hơn hoặc bằng số lượng hàng được bán ra.
--Ngược lại thì huỷ bỏ thao tác bổ sung.
--- Khi cập nhật lại số lượng hàng được bán, kiểm tra số lượng hàng được cập
--nhật lại có phù hợp hay không (số lượng hàng bán ra không được vượt quá số
--lượng hàng hiện có và không được nhỏ hơn 1). Nếu dữ liệu hợp lệ thì giảm (hoặc
--tăng) số lượng hàng hiện có trong công ty, ngược lại thì huỷ bỏ thao tác cập nhật.
Create TRIGGER CTDT_UPDATE
ON CHITIETDATHANG
FOR UPDATE
AS 
DECLARE @MAHANG INT 
SELECT @MAHANG=MAHANG FROM inserted
DECLARE @SOLUONGCO INT
SELECT @SOLUONGCO=SOLUONG FROM MATHANG WHERE MAHANG=@MAHANG
DECLARE @SOLUONGBAN INT
SELECT @SOLUONGBAN=SOLUONG FROM inserted 
IF UPDATE(SOLUONG)
IF (@@ROWCOUNT=1 AND 
BEGIN
UPDATE MATHANG
SET MATHANG.SOLUONG=MATHANG.SOLUONG-(inserted.SOLUONG-deleted.soluong)
from (deleted INNER JOIN inserted ON deleted.MAHANG=inserted.MAHANG)
              INNER JOIN MATHANG ON MATHANG.MAHANG=deleted.MAHANG
END
ELSE
BEGIN
    UPDATE MATHANG
	SET MATHANG.SOLUONG=MATHANG.SOLUONG-(SELECT SUM(inserted.SOLUONG-deleted.soluong)
	from (deleted INNER JOIN inserted ON deleted.MAHANG=inserted.MAHANG)
             WHERE inserted.MAHANG=MATHANG.MAHANG)
	WHERE MATHANG.MAHANG IN (SELECT MAHANG FROM inserted)
END

--Câu 10. Viết trigger cho bảng CHITIETDATHANG để sao cho chỉ chấp nhận giá
--hàng bán ra phải nhỏ hơn hoặc bằng giá gốc (giá của mặt hàng trong bảng
--MATHANG
CREATE TRIGGER CAU10
ON CHITIETDATHANG
FOR INSERT
AS BEGIN
DECLARE @GIABANRA REAL
DECLARE @MAHANG INT
DECLARE @GIANHAP REAL
SELECT @MAHANG=MAHANG FROM inserted
SELECT @GIABANRA =GIABAN FROM inserted
SELECT @GIANHAP=GIAHANG FROM MATHANG WHERE MAHANG=@MAHANG
  IF(@GIABANRA<@GIANHAP)
  BEGIN
  PRINT 'GIA BAN KHONG DUOC NHỎ HON GIA NHAP'
  ROLLBACK TRAN
  END
END
SELECT * FROM CHITIETDATHANG
SELECT * FROM MATHANG
INSERT INTO CHITIETDATHANG VALUES(10,2,2000000,20,'10',40000000)

ALTER TABLE CHITIETDATHANG
DROP CONSTRAINT FK__CHITIETDA__SOHOA__38996AB5