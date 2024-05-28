-- thong ke so luong ben nhan moi phong
select PHONG.Maphong, COUNT(BENHNHAN.MaBN) as SL from PHONG  join GIUONGBENH on PHONG.Maphong =  GIUONGBENH.Maphong inner join BENHNHAN on
BENHNHAN.MaBN = GIUONGBENH.MaBN
group by PHONG.Maphong
-- hien thi danh sach benh nhan phong PCC1, PCC3, PCC5
select BENHNHAN.MaBN, Hoten, PHONG.Maphong,Tenphong from BENHNHAN inner join GIUONGBENH on BENHNHAN.MaBN = GIUONGBENH.MaBN inner join PHONG 
on PHONG.Maphong = GIUONGBENH.Maphong
where PHONG.Maphong = 'PCC1' or PHONG.Maphong = 'PCC2' or PHONG.Maphong = 'PCC3'
-- hien thi danh sach benh nhan phong hoi suc 1
select distinct BENHNHAN.MaBN, Hoten, PHONG.Maphong,Tenphong from BENHNHAN inner join GIUONGBENH on BENHNHAN.MaBN = GIUONGBENH.MaBN inner join PHONG 
on PHONG.Maphong = GIUONGBENH.Maphong
where Tenphong = N'Hồi sức 01' or Tenphong = 'Hoi Suc 01'
order by BENHNHAN.MaBN ASC
-- cap nhat benh nhan 'BN01' sang giuong ma so ‘M1210’
update GIUONGBENH
set Magiuong = 'M1210'
from BENHNHAN
where BENHNHAN.MaBN = GIUONGBENH.MaBN and BENHNHAN.MaBN = 'BN01'
-- xem danh sach phong khong co benh nhan dieu tri
select PHONG.* from PHONG left join GIUONGBENH on PHONG.Maphong =  GIUONGBENH.Maphong
where Magiuong is null
-- Tạo bảng benhnhan_ĐB dữ liệu lấy từ bảng BENHNHAN gồm những bệnh nhân ở phòng ‘Hoi suc cap cuu’ 
select BENHNHAN.* into BenhNhan_ĐB from BENHNHAN inner join GIUONGBENH on BENHNHAN.MaBN = GIUONGBENH.MaBN inner join PHONG
on Phong.Maphong = GIUONGBENH.Maphong
where Tenphong = N'Hồi sức cấp cứu' or Tenphong = 'Hoi suc cap cuu'
-- 7.	Hiển thị danh sách bệnh nhân chưa có số CMND
select * from BENHNHAN
where CMND is null or CMND = 0
-- 8.	Thống kê số lượng bác sĩ của mỗi khoa?
select KHOA.Makhoa, Tenkhoa , count(MaBs) as SL from KHOA left join BACSI on KHOA.Makhoa = BACSI.Makhoa
group by KHOA.Makhoa, Tenkhoa
-- 9.	Hiển thị danh sách bác sĩ ở khoa Phẫu thuật?
select BACSI.* from BACSI inner join KHOA on BACSI.Makhoa = KHOA.Makhoa
where Tenkhoa = 'Phau Thuat' or Tenkhoa = N'Phẫu thuật'
-- 10.	Cho biết các khoa nào chưa có bác sĩ?
select Khoa.* from KHOA left join BACSI on KHOA.Makhoa = BACSI.Makhoa
where BACSI.MaBs is null
-- 11.	Xem thông tin các phòng bệnh của khoa Rang Ham Mat 
select Phong.* from PHONG inner join KHOA on PHONG.Makhoa = KHOA.Makhoa
where Tenkhoa = N'Răng hàm mặt' or Tenkhoa = 'Rang Ham Mat'
-- 12.	Xem thông tin bác sĩ nữ, chuyên môn Chỉnh hình
select * from BACSI
where Gioitinh = 0 and (Chuyen_mon = 'Chinh Hinh' or Chuyen_mon = N'Chỉnh hình')
-- 13.	Chuyển (cập nhật thông tin) bác sĩ có mã ‘BS01’ sang khoa Ngoai.
update BACSI
set Makhoa = (select Makhoa from KHOA where Tenkhoa = 'Ngoai' or Tenkhoa = N'Ngoại')
where MaBs ='BS01'
-- 14.	Xóa thông tin các phòng không thuộc khoa nào
delete PHONG
where Maphong in(select PHONG.Maphong from PHONG left join KHOA on PHONG.Makhoa = KHOA.Makhoa
				where KHOA.Makhoa is null
-- 15.	Thống kê số lượng phòng của mỗi khoa?
select Khoa.Makhoa, Tenkhoa, COUNT(PHONG.Maphong) as SL from KHOA left join PHONG on KHOA.Makhoa = PHONG.Makhoa
group by KHOA.Makhoa, Tenkhoa
-- thong ke so luong phong
select Khoa.Makhoa, Tenkhoa, count(Maphong) as 'So luong phong' from Khoa left join Phong on Khoa.Makhoa = PHONG.Makhoa
group by Khoa.Makhoa, Tenkhoa
-- hien thi nhung danh sach bac si o khoa Nhi
select BACSI.* from BACSI inner join KHOA on KHOA.Makhoa = BACSI.Makhoa
where Tenkhoa = N'Nhi'
-- xem thong tin cac phong ben khoa san
select Phong.* from Phong inner join Khoa on Khoa.Makhoa = Phong.Makhoa
where TenKhoa = N'San' or Tenkhoa = N'Sản'
-- cho biet khoa nao chua co phong ben
select Khoa.* from Khoa left join Phong on Khoa.Makhoa = Phong.Makhoa
where Phong.Maphong is null
-- cap nhat chuyen mon cua bac si ma BS01
update BACSI
set Chuyen_mon = N'Nội soi'
where MaBs = 'BS01'
-- xem thong tin bac si 40 tuoi, chuyen mon phau thuat
select * from BACSI
where (Chuyen_mon = N'Phẫu thuật' or Chuyen_mon = 'Phau thuat') and (year(getdate()) - year(Namsinh)> 40)
-- in ra 2 bac si tre tuoi nhat
select top(2) MaBs, TenBS, Gioitinh, Chuyen_mon, year(GETDATE()) - year(namsinh) as Tuoi ,Makhoa from BACSI
order by Tuoi ASC
-- 1.	Viết thủ tục tham số truyền vào là mabn (mã bệnh nhân), thủ tục sẽ in ra thông tin về bệnh nhân đó
--(tên bệnh nhân, ở phòng điều trị nào, giường số mấy). 
create proc GetInfoBN(@x char(20)) as
BEGIN
	select Hoten, Tenphong, Magiuong from BENHNHAN inner join GIUONGBENH on BENHNHAN.MaBN = GIUONGBENH.MaBN inner join PHONG
	on PHONG.Maphong = GIUONGBENH.Maphong
	where BENHNHAN.MaBN = @x
END
-- 2.	Viết thủ tục nhập vào mã bác sĩ bất kỳ (mabs là tham số), thủ tục sẽ in ra thông tin của bác sĩ đó.
create proc GetInfoDoctor(@x char(20)) as
BEGIN
	select TenBS, Chuyen_mon, Tenkhoa from BACSI inner join KHOA on BACSI.Makhoa = KHOA.Makhoa
	where MaBs = @x
END
-- viet thu tuc nhap ma phong bat ky in ra thong tin cua phong
create proc GetInfoRoom(@x char(20)) as
BEGIN
	select Tenphong, Tenkhoa, TenBS  from PHONG left join KHOA on Khoa.Makhoa = Phong.Makhoa left join BACSI 
	on BACSI.Makhoa = PHONG.Makhoa
	where PHONG.Maphong = @x
END
-- 4.	Viết hàm tham số truyền vào là maphong (mã phòng), hàm sẽ trả về số giường của phòng đó
create function ReturnCountRoom (@x char(20)) 
returns int as
BEGIN
	return (select  count(distinct Magiuong) from GIUONGBENH right join PHONG on GIUONGBENH.Maphong = PHONG.Maphong
	group by Phong.Maphong
	having Phong.Maphong = @x)
END
--	1.	Viết trigger không cho phép một giường có quá 2 bệnh nhân. 
create trigger HaruSoCute on GiuongBenh
for insert as
BEGIN
	DECLARE @MaGiuong char(20)= (select MaGiuong from inserted)
	DECLARE @SOBN int = (select count(MaBN) from GIUONGBENH
						group by Magiuong
						having Magiuong = @MaGiuong)
	if(@SOBN > 2)
	BEGIN
		print(N'Hết chỗ gòi')
		rollback tran
	END
END
-- 2.	Viết trigger ràng buộc một khoa không có quá 3 bác sĩ. 
create trigger ThisTimeIWant on BacSi
for insert as
BEGIN
	DECLARE @MAKHOA char(20) = (select Makhoa from inserted)
	DECLARE @SoBSInKhoa int = (select count(MaBS) from BACSI right join KHOA on BACSI.Makhoa = KHOA.Makhoa
								group by KHOA.Makhoa
								having KHOA.Makhoa = @MAKHOA)
	if(@SoBSInKhoa > 3)
	BEGIN
		print('So bac si khong vuot qua 3')
		rollback tran
	END
END
-- viet trigger khum cho phep xoa bs khoa cap cuu
create trigger BlockDelete on BacSi
for delete as
BEGIN
	DECLARE @MaKhoaCC char(20)
	set @MaKhoaCC = (select MaKhoa from KHOA where Tenkhoa = N'Cấp cứu' or Tenkhoa = 'Cap cuu')
	if(@MaKhoaCC = (select MaKhoa from deleted))
	BEGIN
		print(N'Xóa BS cấp cứu thì bệnh nhân hết cứu nha!')
		rollback tran
	END
END
-- Viết trigger thực hiện công việc sau: Khi xóa 1 bệnh nhân thì trigger tự động cập nhật trạng thái giường của bệnh nhân đó thành OFF 
create trigger AutoSwichOFF on BenhNhan
for delete as
BEGIN
	DECLARE @MABN_DELETED char(20) = (select MaBN from deleted)
	update GIUONGBENH
	set Trang_thai = 'OFF'
	where MaBN = @MABN_DELETED
END
