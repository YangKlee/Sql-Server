﻿-- thong ke so luong phong
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
-- viet thu tuc nhap ma phong bat ky in ra thong tin cua phong
create proc GetInfoRoom(@x char(20)) as
BEGIN
	select Tenphong, Tenkhoa, TenBS  from PHONG left join KHOA on Khoa.Makhoa = Phong.Makhoa left join BACSI 
	on BACSI.Makhoa = PHONG.Makhoa
	where PHONG.Maphong = @x
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