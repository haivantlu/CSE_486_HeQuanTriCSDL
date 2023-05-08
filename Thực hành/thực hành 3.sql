--Câu 1. Thêm một cột Thanh_tien cho bảng CHITIETDATHANG. Hãy viết một stored
--procedure đặt tên là sp_ThanhTien cập nhật trường ThanhTien cho bảng
--CHITIETDATHANG sao cho ThanhTien = SoLuong * GiaBan.

ALTER TABLE CHITIETDATHANG
ADD THANHTIEN FLOAT

CREATE PROC sp_ThanhTien
as
begin
UPDATE CHITIETDATHANG
SET ThanhTien=SOLUONG*GIABAN;
END

--Câu 2. Thêm một cột TongTien cho bảng DONDATHANG. Viết một stored procedure
--đặt tên là sp_TongTien để cập nhật trường TongTien cho bảng DONDATHANG bằng
--tổng ThanhTien của tất cả các sản phẩm trong đơn hàng
select * from DONDATHANG
SELECT * FROM CHITIETDATHANG
ALTER TABLE DONDATHANG
ADD TongTien float 

 CREATE PROCEDURE sp_TongTien
 as
 begin
 UPDATE DONDATHANG
 SET TONGTIEN=SUM(CTDH.THANHTIEN) from  CHITIETDATHANG CTDH INNER JOIN DONDATHANG D ON D.SOHOADON=CTDH.SOHOADON
 END
 
--Câu 3. Viết một stored procedure đặt tên là sp_ThuNhap để tính thu nhập của công ty
--trong một khoảng thời gian nào đó với ngày đầu và ngày cuối là tham số đầu vào của thủ
--tục. 

CREATE PROC SP_THUNHAP
@NGAYDAU DATE,@NGAYCUOI DATE
AS
BEGIN
  SELECT @NGAYDAU AS TUNGAY,@NGAYCUOI AS DENNGAY,SUM(C.THANHTIEN)AS DOANHTHU FROM CHITIETDATHANG C INNER JOIN DONDATHANG D ON D.SOHOADON=C.SOHOADON 
  WHERE NGAYDATHANG>=@NGAYDAU and NGAYDATHANG<=@NGAYCUOI 
END
DROP PROC SP_THUNHAP
SP_THUNHAP '03-01-2021','03-09-2021'

--Câu 4. Viết một đoạn mã T-SQL thực hiện gọi thủ tục sp_ThuNhap hai lần với hai khoảng
--thời gian khác nhau và thực hiện in ra màn hình khoảng thời gian đạt được thu nhập lớn
--hơn.
SP_THUNHAP '03-01-2021','03-09-2021'
declare @bien1 real

print cast(@bien1 as char(3))
SP_THUNHAP'03-01-2021','03-09-2021'

--Câu 5. Viết một thủ tục sp_NgayTrongTuan để tính ngày trong tuần của một ngày bất kỳ.
CREATE PROC SP_NGAYTRONGTUAN
@NGAY DATE 
AS
BEGIN
 DECLARE @TUAN NVARCHAR(10)
 SElect @TUAN=CASE DATEPART(DW,@NGAY)
 WHEN 1 THEN N'Chủ nhật'
 WHEN 2 THEN N'Hai'
 WHEN 3 THEN N'ba'
 WHEN 4 THEN N'Tư'
 WHEN 5 THEN N'Năm'
 WHEN 6 THEN N'Sáu'
 else N'bảy'
 END
 PRINT N'Ngày vừa nhập là thứ '+CAST(@TUAN AS NVARCHAR(10))
end

 DROP PROC SP_NGAYTRONGTUAN
 SP_NGAYTRONGTUAN '02-02-2001'


--Câu 6. Viết một thủ tục sp_ThongKe để thống kê và in ra màn hình số lượng hóa đơn theo
--ngày trong tuần.
--Ví dụ: Thứ hai: 0 hóa đơn
--Thứ ba: 1 hóa đơn
--....
--Ví dụ: đối với Thứ Hai, đây là số lượng hóa đơn của tất cả các ngày thứ 2, chứ
--không phải số lượng hóa đơn của một ngày thứ 2 của một tuần nào đó.
--Cuối cùng, in ra màn hình xem ngày nào trong tuần thường có nhiều người mua hàng nhất.
SELECT * FROM DONDATHANG
SELECT * FROM CHITIETDATHANG
CREATE PROC SP_THONGKE
AS
BEGIN
Select 
COUNT(case   DATEPART(DW,D.NGAYDATHANG) WHEN 1 THEN SOHOADON  END ) AS CHỦNHẬT ,
COUNT(case   DATEPART(DW,NGAYDATHANG) WHEN 2 THEN SOHOADON  END ) AS THỨ2,
COUNT(case   DATEPART(DW,NGAYDATHANG) WHEN 3 THEN SOHOADON END ) AS THỨ3,
COUNT(case   DATEPART(DW,NGAYDATHANG) WHEN 4 THEN SOHOADON  END ) AS THỨ4,
COUNT(case   DATEPART(DW,NGAYDATHANG) WHEN 5 THEN SOHOADON  END ) AS THỨ5,
COUNT(case   DATEPART(DW,NGAYDATHANG) WHEN 6 THEN SOHOADON END ) AS THỨ6,
COUNT(case   DATEPART(DW,NGAYDATHANG) WHEN 7  THEN SOHOADON  END ) AS THỨ7
FROM DONDATHANG D 
END
SELECT* FROM DONDATHANG
SELECT COUNT(SOHOADON),month(NGAYDATHANG) FROM DONDATHANG GROUP BY month(NGAYDATHANG)
--Câu 7. Viết một thủ tục sp_SLSP đưa ra số lượng đã bán của một sản phẩm với tên sản
--phẩm là tham số đưa vào

CREATE PROC SP_SLSP  @TENSP NVARCHAR(15)
AS
BEGIN
DECLARE @MA CHAR(3)
SELECT @MA=MAHANG FROM MATHANG WHERE TENHANG=@TENSP
SELECT MH.TENHANG,SUM(C.SOLUONG) AS SOLUONGBAN
FROM MATHANG MH  LEFT JOIN CHITIETDATHANG C ON MH.MAHANG=C.MAHANG 
WHERE MH.MAHANG=@MA
GROUP BY MH.MAHANG,MH.TENHANG
END

drop PROC SP_SLSP
EXECUTE SP_SLSP N'Đèn LED 50w'
--Câu 8. Viết một thủ tục sp_SPCao đưa ra danh sách các sản phẩm có số lượng bán nhiều
--hơn một giá trị x, với x là tham số đưa vào
CREATE PROC SP_SPCAO @X INT 
AS
BEGIN 
SELECT DISTINCT MH.TENHANG,SUM(C.SOLUONG)
FROM MATHANG MH INNER JOIN CHITIETDATHANG C ON C.MAHANG=MH.MAHANG
GROUP BY MH.TENHANG
HAVING SUM(C.SOLUONG)>@X
END
DROP PROC SP_SPCAO

SP_SPCAO 50

--Câu 9. Tạo thủ tục lưu trữ để thông qua thủ tục này có thể bổ sung thêm một bản ghi mới
--cho bảng MATHANG (thủ tục phải thực hiện kiểm tra tính hợp lệ của dữ liệu cần bổ sung:
--không trùng khoá chính và đảm bảo toàn vẹn tham chiếu).
SELECT * FROM MATHANG

CREATE PROC SP_MATHANG @MAHANG INT ,@TENHANG NVARCHAR(20),@MACONGTY INT ,
@MALOAIHANG INT,@SOLUONG INT,@DONVITINH NVARCHAR(20),@GIAHANG float
as 
begin 
if (@MAHANG is not null 
and not exists(select MAHANG from MATHANG where MAHANG = @mahang)
and @MACONGTY is not null AND exists(select MACONGTY from NHACUNGCAP where MACONGTY = @MACONGTY)
and @MALOAIHANG is not null AND exists(select MALOAIHANG from LOAIHANG where MALOAIHANG = @MALOAIHANG)
)
INSERT INTO MATHANG 
VALUES (@MAHANG ,@TENHANG ,@MACONGTY ,
@MALOAIHANG ,@SOLUONG ,@DONVITINH ,@GIAHANG)
ELSE 
PRINT N'Thông tin không thỏa mãn.Vui lòng kiểm tra lại! '
end

SP_MATHANG '09',N'đèn led','01','02',20,N'chiếc',80000
SP_MATHANG '07',N'đèn led','10','09',20,N'chiếc',80000
SP_MATHANG '07',N'đèn led','01','10',20,N'chiếc',80000
drop proc SP_MATHANG
SELECT * FROM MATHANG


--Câu 10. Tạo thủ tục lưu trữ có chức năng thống kê tổng số lượng hàng bán được của một
--mặt hàng có mã bất kỳ (mã mặt hàng cần thống kê là tham số của thủ tục).
CREATE PROC SP_THONGKE @MALOAI INT 
AS
SELECT LOAIHANG.TENLOAIHANG,SUM(C.SOLUONG)AS SOLUONG
FROM LOAIHANG,CHITIETDATHANG C,MATHANG MH
WHERE LOAIHANG.MALOAIHANG=MH.MALOAIHANG AND C.MAHANG=MH.MAHANG AND LOAIHANG.MALOAIHANG=@MALOAI
GROUP BY LOAIHANG.TENLOAIHANG
END
SP_THONGKE 2
--Câu 11. Viết hàm trả về một bảng trong đó cho biết tổng số lượng hàng bán được của mỗi
--mặt hàng. Sử dụng hàm này để thống kê xem tổng số lượng hàng (hiện có và đã bán) của
--mỗi mặt hàng là bao nhiêu.

CREATE FUNCTION F_TONG()
returns TABLE
AS
return ( select  MH.TENHANG,tong=MH.SOLUONG+
case 
when sum(c.soluong) is null then 0
else SUM(c.soluong)
end
FROM  MATHANG MH  LEFT JOIN CHITIETDATHANG C ON MH.MAHANG=C.MAHANG
GROUP BY MH.TENHANG,mh.SOLUONG)

SELECT * FROM [dbo].[F_TONG] ()

--Câu 12. Viết một hàm để tính tổng số đơn đặt hàng của một nhân viên 
CReate FUNCTION TONG_DON( @MANV INT )
RETURNS TABLE
AS
RETURN (SELECT NHANVIEN.MANHANVIEN ,COUNT(DONDATHANG.MANHANVIEN) AS SODON
FROM NHANVIEN LEFT JOIN DONDATHANG ON NHANVIEN.MANHANVIEN=DONDATHANG.MANHANVIEN
WHERE DONDATHANG.MANHANVIEN=@MANV
GROUP BY NHANVIEN.MANHANVIEN
)
SELECT * FROM [dbo].[TONG_DON] (01)

--Câu 13. Viết một hàm để trả về danh sách nhân viên làm việc trong tháng 5/2020.
SELECT * FROM NHANVIEN

CReate FUNCTION DS_NHANVIEN()
RETURNS TABLE
AS
RETURN (SELECT NHANVIEN.*
FROM NHANVIEN 
WHERE (MONTH(NGAYLAMVIEC)=5) AND (YEAR(NGAYLAMVIEC)=2020)
)
SELECT * FROM [dbo].[DS_NHANVIEN] ()

--Câu 14. Viết một hàm trả về giá trị thứ trong tuần của một kiểu datetime. Sử dụng hàm đó
--để lấy ra những nhân viên sinh vào ‘Chủ nhật’.

CREATE FUNCTION NgaySinh (@ngay datetime)
returns nvarchar(20)
as 
begin
	declare @thu nvarchar(20)
	select @thu = (case DATEPART(DW,@ngay)
	when 1 then N'Chủ Nhật'
	when 2 then N'Thứ Hai'
	when 3 then N'Thứ Ba'
	when 4 then N'Thứ Tư'
	when 5 then N'Thứ Năm'
	when 6 then N'Thứ Sáu'
	else N'Thứ Bảy'
	end )
return @thu
end

select * from NHANVIEN
where dbo.NgaySinh(NGAYSINH) = N'Chủ Nhật' 

drop FUNCTION NGAY_SINH
--Câu 15. Viết một hàm trả về danh sách các mặt hàng của một loại hàng bất kỳ. Nếu loại
--hàng không có trong CSDL thì hiển thị tất cả cả các mặt hàng theo từng loại hàng.

CReate FUNCTION MAT_HANG( @MALOAI INT )
RETURNS TABLE
AS
RETURN (SELECT MATHANG.* 
FROM  MATHANG INNER JOIN LOAIHANG ON LOAIHANG.MALOAIHANG=MATHANG.MALOAIHANG AND LOAIHANG.MALOAIHANG=@MALOAI
)