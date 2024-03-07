﻿use QLBANHANG
-- hien ma sp, ten sp, so luong
select MaSP, TenSP, SoLuong from SanPham
-- danh sach nhan vien
select * from NhanVien
-- danh sach khach hang o quy nhon
select * from KhachHang
where DiaChi like N'%Quy Nhơn%'
-- ma va ten sp co gia tri lon hon 100000
select MaSP, TenSP, Gia, SoLuong from SanPham
where Gia > 100000 and SoLuong > 50
-- khach hang chua tung mua hang o cong ty
select KhachHang.* from KhachHang
where MaKH not in (Select MaKH from HoaDon)
-- san pham san xuat o nhat ban
select * from SanPham
where NuocSX = N'Nhật Bản' or NuocSX = N'Nhật' or NuocSX = 'Japan'
-- khach hang nao da mua Sữa Dango
select KhachHang.* from KhachHang, CTHD, HoaDon, SanPham
where SanPham.TenSP = N'Sữa Dango' and SanPham.MaSP = CTHD.MaSP and HoaDon.SoHD = CTHD.SoHD and HoaDon.MaKH = KhachHang.MaKH
-- don hang so HD26020307 do ai ai dat, nhan vien nao lap, tri gia bao nhieu
select HoaDon.SoHD ,KhachHang.HoTen, NhanVien.HoTen as 'Nhan vien lap', SanPham.TenSP,HoaDon.TriGia 
from KhachHang, NhanVien, HoaDon, CTHD, SanPham
where HoaDon.SoHD = 'HD26020307' and HoaDon.MaNV = NhanVien.MaNV 
and HoaDon.MaKH = KhachHang.MaKH and CTHD.SoHD = HoaDon.SoHD and CTHD.MaSP = SanPham.MaSP



-- them san pham sua dua
insert into SanPham
values('SP05030001', N'Sữa dừa Ganyu','Chai','Liyue', 60000, 699)

-- them cot gioi tinh vao bang khach hang
alter table KhachHang
add GioiTinh bit null
--xoa cot email nhanvien
alter table NhanVien
drop column Email

update SanPham
set Gia += Gia * 0.1
where TenSP like N'%Máy tính%'

-- hien thi danh sach khach hang chua co so dien thoai
select * from KhachHang
where SoDt is null

-- san pham chua ban duoc
select distinct  SanPham.MaSP, SanPham.TenSP from SanPham, CTHD, HoaDon
where SanPham.MaSP not in (select MaSP from CTHD)
-- xem khach hang sinh nhat hom nay
select * from KhachHang
where NgaySinh = getdate()
-- xoa nhan vien tren 40
delete NhanVien
where YEAR(GETDATE()) -  year(NgaySinh) > 40


-- thong ke so luong len don va cho biet tinh trang san pham
select SanPham.TenSP, count(CTHD.MaSP) as 'SL Len don',
case
	when count(CTHD.MaSP) >= 3 then N'Bán chạy'
	when count(CTHD.MaSP) < 3 and count(CTHD.MaSP) >= 2 then N'Bán chậm'
	else N'Bán ế'
	End as 'Status'

from SanPham, CTHD
where SanPham.MaSP = CTHD.MaSP 
group by SanPham.TenSP

-- tao bang danh sach huu, gom nhan vien ve huu theo quy dinh (nam tren 60 nu tren 55)
select MaNV, HoTen, GioiTinh, Email, NgaySinh into DSHUU from NhanVien
where (GioiTinh = 1 and (year(GETDATE()) - year(NgaySinh) > 55)) or (GioiTinh = 0 and year(GETDATE()) - year(NgaySinh) > 60)

-- cho biet hoa son do HD26022306 lap cach day bao nhiu ngay
select HoaDon.SoHD , DATEDIFF(DAY , HoaDon.NgayHD , GETDATE()) as 'So ngay' from HoaDon
where HoaDon.SoHD = 'HD26022306'

-- danh sach khach hang da mua hang ngay hom qua
select KhachHang.MaKH, HoTen , NgayHD as 'Ngay mua' from KhachHang, HoaDon, CTHD
where DATEDIFF(Day, HoaDon.NgayHD , GETDATE()) = 1;