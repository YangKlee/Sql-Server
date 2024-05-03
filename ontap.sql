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
create view getphongban_3duan as
select phongban.Maphong from phongban inner join duan on phongban.Maphong = duan.maphong
group by phongban.Maphong
having COUNT(duan.maduan) >= 3
GO
update nhanvien
set luong += 200000
where maphong = (select * from getphongban_3duan)
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
select phongban.Maphong, phongban.tenphong, count(duan.maduan) from phongban left join duan on phongban.Maphong = duan.maphong
group by phongban.maphong, tenphong
--thong tin du an co so gio nhieu nhat
select duan.maduan, tenduan, diadiem, sum(sogio) as 'Tong so Gio' from duan inner join phancong on duan.maduan = phancong.maduan
group by duan.maduan, tenduan, diadiem
having sum(sogio) = (select top(1) sum(sogio) from duan inner join phancong on duan.maduan = phancong.maduan
					group by duan.maduan
					order by sum(sogio) DESC)
-- thong ke moi du an co bao nhieu nhan vien tham gia
select duan.maduan, COUNT(nhanvien.manv) as 'SL Nhan vien tham gia' from nhanvien join phongban 
on nhanvien.maphong = phongban.Maphong right join duan on duan.maphong = phongban.Maphong
group by duan.maduan
select * from nhanvien
-- danh sach nhan vien khong tham gia du an nao
select nhanvien.* from nhanvien inner join phongban on 
nhanvien.maphong = phongban.Maphong left join duan on duan.maphong = phongban.Maphong
where maduan is null
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
select maphong,count(maduan) as 'So du an' from duan
group by maphong
having COUNT(maduan) = (select top(1) count(maduan) from duan 
						group by maphong
						order by count(maduan) DESC)
-- nhung du an co mot nhan vien tham gia
select maduan, tenduan, count(manv) as 'SL' from duan left join nhanvien on duan.maphong = nhanvien.maphong
group by maduan, tenduan
having COUNT(manv) = 1
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
-- 
