use Quanlyduan
-- hien thi thong tin du an o nha trang or binh phuoc
select * from duan
where diadiem like N'%Nha Trang%' or diadiem like N'%Bình Phước%'
-- danh sach nhan vien phong quan ly phan mem nho hon 25 tuoi
select nhanvien.* from nhanvien inner join phongban on phongban.Maphong = nhanvien.maphong
where tenphong like N'%Phát triển phần mềm%' and (YEAR(GETDATE()) - YEAR(ngaysinh) < 25)
-- thong ke so luong nhan vien theo ma phong
select phongban.maphong , COUNT(nhanvien.manv) as 'So Luong' from nhanvien 
right join phongban on nhanvien.maphong = phongban.Maphong
group by phongban.Maphong
-- hien thi danh sach nhan vien co luong cao nhat
select * from nhanvien
where luong = (select max(luong) from nhanvien)
-- tong so gio cua moi du an
select duan.maduan, 
case 
	when sum(sogio) is null then 0
	else sum(sogio)
	end as 'Tong so gio'

from duan left join phancong on duan.maduan = phancong.maduan
group by duan.maduan
-- tang luong them 200000 cho nhan vien tham gia 3 du an tro len
update nhanvien
set luong += 200000
where manv in (select manv from phancong
				group by manv
				having COUNT(maduan)>=3)
-- cho biet co bao nhieu du an o binh dinh
select COUNT(maduan) as 'So du an o Binh Dinh' from duan
where diadiem like N'%Bình Định%' or diadiem = N'BĐ'
-- hien thi nhan vien nam tren 30 tuoi
select * from nhanvien
where gioitinh = 1 and (year(getdate()) - year(ngaysinh) > 30)
-- danh sach du an o Binh Dinh co so gio > 20
select duan.maduan, duan.diadiem, sum(sogio) as 'Tong so gio' from duan inner join phancong on duan.maduan = phancong.maduan
group by duan.maduan, duan.diadiem
having (diadiem like N'%Bình Định%' or diadiem = N'BĐ') and sum(sogio) > 20
-- thong ke so du an theo ma phong
select phongban.Maphong, phongban.tenphong, count(duan.maduan) as 'So Du an' from phongban left join duan on phongban.Maphong = duan.maphong
group by phongban.maphong, tenphong
--thong tin du an co so gio nhieu nhat
select duan.maduan, tenduan, diadiem, sum(sogio) as 'Tong so Gio' from duan inner join phancong on duan.maduan = phancong.maduan
group by duan.maduan, tenduan, diadiem
having sum(sogio) = (select top(1) sum(sogio) from duan inner join phancong on duan.maduan = phancong.maduan
					group by duan.maduan
					order by sum(sogio) DESC)
-- thong ke moi du an co bao nhieu nhan vien tham gia
select duan.maduan, tenduan, COUNT(phancong.manv) as 'Nhan vien tham gia' 
from duan left join phancong on duan.maduan = phancong.maduan
group by duan.maduan , tenduan
-- danh sach nhan vien khong tham gia du an nao
select nhanvien.* from nhanvien left join phancong on nhanvien.manv = phancong.manv
where phancong.manv is null
-- xoa nhung du an chua phan cong cho ai
delete duan
from duan left join phancong on duan.maduan = phancong.maduan
where phancong.maduan is null
select * from duan
-- xem danh sach nhan vien que o QN, lam o Binh Duong
select nhanvien.* from nhanvien inner join phongban on nhanvien.maphong = phongban.Maphong inner join
duan on duan.maphong = phongban.Maphong
where diachi like N'%Quy Nhơn%' and diadiem like N'%Bình Dương%'
-- cap nhat cot luong nhanvien
update nhanvien
set luong += sogio*500
from phancong
where phancong.manv = nhanvien.manv
-- hien thi thong tin du an so 1
select tenduan, diadiem, nhanvien.holot, nhanvien.ten, phongban.tenphong from duan inner join nhanvien on
duan.maphong = nhanvien.maphong inner join phongban on phongban.Maphong = nhanvien.maphong
where duan.maduan = 1
--xem thong tin nhan vien chua phan cong du an nao
select nhanvien.* from nhanvien left join duan on duan.maphong = nhanvien.maphong
where maduan is null
-- phong nao nhan nhieu du an nhat
declare @max int = (select top(1) count(maduan) as 'So du an' from duan
					group by maphong
					order by count(maduan) DESC)
select maphong,count(maduan) as 'So du an' from duan
group by maphong
having COUNT(maduan)  = @max
-- nhung du an co mot nhan vien tham gia
select duan.maduan, tenduan from phancong inner join nhanvien on phancong.manv = nhanvien.manv 
inner join duan on duan.maduan = phancong.maduan
group by duan.maduan , tenduan
having count(nhanvien.manv) = 1
-- liet ke du an phong big data
select duan.* from duan inner join phongban on duan.maphong = phongban.Maphong
where tenphong like N'%Big Data%'
-- hien thi 3 du an co so gio it nhat
select top(3) duan.maduan, duan.tenduan, sum(sogio) as 'So gio' from duan right join phancong on duan.maduan = phancong.maduan
group by duan.maduan, tenduan
order by sum(sogio) ASC
-- danh sach nhan vien co luong thap nhat
select nhanvien.* from nhanvien
where luong = (select min(luong) from nhanvien)
-- moi nhan vien tham gia bao nhieu du an
select nhanvien.manv, holot, ten , count(maduan) as 'So du an tham gia'from nhanvien left join phancong on nhanvien.manv = phancong.manv
group by nhanvien.manv, holot, ten
-- xoa du an co tong so gio duoi 50
delete duan
where maduan in (select duan.maduan from duan left join phancong on duan.maduan = phancong.maduan
				group by duan.maduan
				having sum(sogio) < 50)
-- cho biet phong ban nao chua co du an
select phongban.* from phongban left join duan on phongban.Maphong = duan.maphong
where duan.maphong is null
-- xem thong tin phong ban co hai nhan vien tro len va thuc hien 3 du an tro len
select phongban.Maphong, tenphong from phongban inner join nhanvien on phongban.Maphong = nhanvien.maphong 
inner join duan on duan.maphong = phongban.Maphong
group by phongban.Maphong, tenphong
having COUNT(nhanvien.manv) >=2 and COUNT(duan.maduan) >=3
-- viet thu tuc nhap vao ma du an bat ky, in ra thong tin du an do
alter proc InThongTinDuAn(@maduan char(5)) as
BEGIN
	select tenduan, tenphong, sum(sogio) as 'Tong gio' from duan 
	inner join phancong on duan.maduan = phancong.maduan inner join phongban on phongban.Maphong
	= duan.maphong
		where duan.maduan = @maduan
	group by tenduan, tenphong

END
exec InThongTinDuAn 1
-- viet ham tra ve tong du an do phong x dam nhan
create function GetInfPhongBan (@x char(5))
returns int as
BEGIN 
	DECLARE @SoDuAn int
	set @SoDuAn = (select count(duan.maduan) from duan right join 
	phongban on phongban.Maphong = duan.maphong where phongban.Maphong = @x)
	return @SoDuAn

END
print (dbo.GetInfPhongBan(3))
-- viet thu tuc nhap vao ma nhan vien bat ky in ra thong tin nhan vien
create proc GetInfNV(@manv char(5))as
BEGIN
	select nhanvien.manv, holot, ten, tenphong, tenduan from nhanvien inner join phongban on nhanvien.maphong= phongban.Maphong
	inner join phancong  on nhanvien.manv =  phancong.manv inner join duan on phancong.maduan = duan.maduan
	where nhanvien.manv = @manv	
END
exec GetInfNV 'mv1'
--viet ham tra ve tong gio du an x
alter function  GetHoursDuAn(@x char(5))
returns int as
BEGIN
	DECLARE @TongSoGio int
	set @TongSoGio = (select sum(sogio) from duan left join phancong on duan.maduan = phancong.maduan
						group by duan.maduan
						having duan.maduan = @x)
	if(@TongSoGio is null)
	BEGIN
		return 0
	END
	return @TongSoGio

END
print(dbo.GetHoursDuAn(1))
-- viet ham nhap ma nhan vien x tra ve tong so du an 
create function GetDuAnNhanVien(@x char(5))
returns int as
BEGIN 
	DECLARE @TongSoDuAn int
	set @TongSoDuAn = (select count(maduan) from nhanvien left join phancong on nhanvien.manv = phancong.manv
						group by nhanvien.manv
						having nhanvien.manv = @x)
	if(@TongSoDuAn is null) return 0
	return @TongSoDuAn
END
print(dbo.GetDuAnNhanVien('mv1'))
-- viet thu tuc nhap ma phong x va in ra thong tin cua phong va du an phong do dam nhan
create proc GetPhong(@x char(5)) as
BEGIN
	select * from phongban where Maphong = @x
	select duan.maduan,duan.tenduan, duan.diadiem from duan inner join phongban on duan.maphong = phongban.Maphong
	where phongban.maphong = @x
END
-- viet ham in ra tong so gio thuc hien du an cua nhan vien x
create function GetGioDuAn (@x char(5))
returns int as
BEGIN
	DECLARE @TongSoGio int
	SET @TongSoGio = (select sum(sogio) from nhanvien left join phancong on nhanvien.manv = phancong.manv
					group by nhanvien.manv
					having nhanvien.manv = @x)
	if(@TongSoGio is null) return 0
	return @TongSoGio
END
-- viet ham in ra thoi gian hoan thanh cua du an x
alter function GetThoiGianDuAn(@x char(5))
returns varchar(20)
BEGIN
	DECLARE @DD int = day(Getdate())
	DECLARE @MM int = month(Getdate())
	DECLARE @YY int = year(Getdate())
	DECLARE @HH int = 0
	DECLARE @SoGio int = (select sum(sogio) from duan inner join phancong on duan.maduan = phancong.maduan
							group by duan.maduan
							having duan.maduan = @x)
	if(@SoGio >= 24)
	BEGIN 
		SET @DD += @SoGio/24
		SET @HH = @SoGio%24
	END
	else
	BEGIN
		SET @HH = @SoGio
	END

	return concat(@DD,'-', @MM, '-',@YY,'-', @HH, 'h')	
END
print(dbo.GetThoiGianDuAn(1))
select * from phancong
-- viet trigger khong cho phep mot nhan vien thuc hien qua 3 du an
create trigger GioiHanPhanCong on PhanCong
for update, insert as
BEGIN
	DECLARE @SOLANPHANCONG int
	DECLARE @Manv char(5) = (select manv from inserted)
	set @SOLANPHANCONG = (select COUNT(phancong.maduan) from nhanvien left join phancong on nhanvien.manv = phancong.manv
						group by nhanvien.manv
						having nhanvien.manv = @Manv)
	if(@SOLANPHANCONG >3)
	BEGIN
		print(N'Một nhân viên không thể quản lý quá 3 dự án')
		rollback tran
	END
END 
select * from phancong
insert into phancong
values('mv1', 1, 110)
-- viet trigger khong cho phep xoa du an o Binh Duong
create trigger XoaDuAnBinhDuong on Duan
for delete as
BEGIN 
	if((select diadiem from deleted) like N'%Bình Dương%')
	BEGIN
		print(N'Khum cho xoá dự án ở Bình Dương!')
		rollback tran
	END
END
delete duan
where maduan = 10
-- Viet trigger khong cho phep them du dan o Dak Nong
alter trigger NoAddDakNong on DuAn
for insert as
BEGIN
	if((select diadiem from inserted) like N'%DakNong%')
	BEGIN
		print(N'Khum cho thêm dự án ở DakNong')
		rollback tran
	END
END
insert into duan
values(13, N'Đi tìm kho báu Trương Mỹ Lan', N'Tổ 4,DakNong', 1)
select * from duan
-- viet trigger khong cho phep mot du an co nhieu hon 5 nhan vien thuc hien
create trigger PhanCongNhanVien on PhanCong
for insert, update as
BEGIN
	DECLARE @SLNVPC int
	DECLARE @MaDuAn int = (select maduan from inserted)
	SET @SLNVPC = (select COUNT(phancong.manv) from phancong inner join nhanvien on phancong.manv = nhanvien.manv
					right join duan on duan.maduan = phancong.maduan
					group by duan.maduan
					having duan.maduan = @MaDuAn
					)
	if(@SLNVPC > 5)
	BEGIN
		print(N'Khong the phan cong du an nhieu hon 5 nv thuc hien')
		rollback tran
	END
END