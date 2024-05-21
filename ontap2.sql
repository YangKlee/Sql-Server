-- them cot cmnd vao bang , update data la madatphong+maphong
alter table nhatkydatphong
add CCCD nvarchar(20)
select * from nhatkydatphong
update nhatkydatphong
set CCCD = CONCAT(madatphong, maphong)
-- khach san nao co dien tich lon nhat
select * from khachsan 
where dientich = (select max(dientich) from khachsan)
-- hien thi nhung phong co dien tich 40m2 tro len
select * from phong
where dientich >40
-- phong nao chua co khach dat
select Phong.* from phong left join nhatkydatphong on phong.maphong = nhatkydatphong.maphong
where madatphong is null
-- kiem tra thong tin dat phong tu ngay 19/7 - 20/9
select * from nhatkydatphong
where (day(checkin) >=16 and MONTH(checkin)>= 7) and (day(checkin) <=20 and MONTH(checkin)<= 9) 
-- cap nhat gio checkin
update nhatkydatphong
set checkin =  dateadd(hour, 1, checkin)
where (day(checkin) =16 and MONTH(checkin)= 7)
-- co bao nhieu phong dien tich 40m2
select count(maphong) from phong
group by dientich
having dientich > 40
-- them cot tinh trang vao phong, set off
alter table phong
add TinhTrang varchar(10)
alter table phong
add default 'OFF' for TinhTrang
update phong
set TinhTrang = 'OFF'
-- thong ke so luong phong theo loai
select loai, COUNT(maphong) as SoLuong from phong
group by loai
-- ngay hom nay checkin bao nhieu phong
select count(phong.maphong) as SoPhong from phong inner join nhatkydatphong on phong.maphong = nhatkydatphong.maphong
where checkin = GETDATE()
-- huy thong tin dat phong tu ngay 19/7 - 20/9
delete nhatkydatphong
where (day(checkin) >=91 and MONTH(checkin)>= 7) and (day(checkin) <=20 and MONTH(checkin)<= 9) 
-- co bao nhieu phong pro
select count(maphong) as SL from phong
group by loai
having loai = 'PRO'
-- thong ke so luong phong theo tang
select tang, count(maphong) as SL from phong
group by tang
-- khach san nao co dien tich lon nhat
select * from khachsan
where dientich = (select max(dientich) from khachsan)
-- co bao nhieu phong checkin ngay 13/08
select count(phong.MaPhong) as SL from Phong inner join nhatkydatphong on phong.maphong = nhatkydatphong.maphong
where (day(checkin) = 13 and MONTH(checkin)= 8)
-- tinh tien dat phong
update nhatkydatphong
set TienPhong = CASE
	WHEN datediff(day, checkin, checkout) <> 0 then datediff(day, checkin, checkout)*300000
	else
		300000
end

-- so luong nguoi den dat phong nhieu nhat la bao nhieu, ngay nao checkin
-- viet thu tuc de huy thong tin dat phong cua ma dat phong k nao do
create proc DeleteInfoDatPhong(@K int) as
BEGIN
	delete nhatkydatphong
	where madatphong = @K
END
deleteinfodatphong 5

-- viet ham tra lai so luong phong da dat trong ngay x
create function ReturnCountRoom(@DayTarget date) 
returns int as
BEGIN
	DECLARE @SOLUONG int= (select count(Madatphong) from nhatkydatphong
	where DATEDIFF(day, checkin, @DayTarget) = 0)
	return @SOLUONG
END
print(dbo.ReturnCountRoom('2024-07-15'))
select * from dbo.ReturnCountRoom('2024-07-15')
create function CuongCuTo(@x int)
returns table as
	return (select * from phong where maphong = @x)
select * from CuongCuTo(1)
-- viet ham tra ve so ngay o cua ma dat phong x
alter function Diff_DayCheckInOut(@x int)
returns int as
BEGIN
	DECLARE @CheckIn date = (select checkin from nhatkydatphong where madatphong = @x)
	DECLARE @CheckOut date = (select checkout from nhatkydatphong where madatphong = @x)
	return datediff(day, @Checkin, @CheckOut)
END
print(dbo.Diff_DayCheckInOut(3))
-- viet trigger tu dong cap nhat tinh trang phong moi khi phong co nguoi
create trigger AutoUpdateRoom on NhatKyDatPhong
for insert as
BEGIN
	DECLARE @MaPhong int = (select maphong from inserted)
	update phong
	set TinhTrang = 'ON'
	where maphong = @MaPhong
END
 
-- khong cho phep nhap checkin out cung gio
create trigger Klee_so_cute on NhatKyDatPhong
for insert as
BEGIN
	if((select checkin from inserted) = (select checkout from inserted))
	BEGIN
		print(N'Hem đc trùng thời gian')
		rollback tran
	END
END
