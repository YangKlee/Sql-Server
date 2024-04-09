-- san pham chua ban duoc
select distinct  SanPham.MaSP, SanPham.TenSP from SanPham, CTHD, HoaDon
where SanPham.MaSP not in (select MaSP from CTHD)
-- hoa don so mot cua khach hang nao, ten gi, o dau
select SoHD,KhachHang.MaKH, HoTen, DiaChi from
KhachHang inner join HoaDon on HoaDon.MaKH = KhachHang.MaKH
where SoHD = '1';
-- xem khach hang sinh nhat hom nay
select * from KhachHang
where datediff(day, NgaySinh, GETDATE()) = 0;
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
-- ngay hom nay ban duoc bao nhieu san pham, tong tien thu bao nhiu, loi bao nhiu
select count(CTHD.MaSP) as 'Tong SP ban duoc' , sum(CTHD.SoLuong*SanPham.Gia) as 'Tien thu'
,sum(CTHD.SoLuong*CTHD.GiaBan) as 'Gia loi'
from SanPham inner join CTHD on SanPham.MaSP = CTHD.MaSP join HoaDon on HoaDon.SoHD = CTHD.SoHD
where NgayHD = GETDATE()
-- tao bang danh sach huu, gom nhan vien ve huu theo quy dinh (nam tren 60 nu tren 55)
select MaNV, HoTen, GioiTinh, Email, NgaySinh into DSHUU from NhanVien
where (GioiTinh = 1 and (year(GETDATE()) - year(NgaySinh) > 55)) or (GioiTinh = 0 and year(GETDATE()) - year(NgaySinh) > 60)
-- xem khach hang co cung dia chi voi Nguyễn Thị Tuyết
select * from KhachHang
where diachi = (select diachi from KhachHang where HoTen like N'%Nguyễn Thị Tuyết%')
-- xuat nhung hoa don co 3 san pham tro len
Select sohd, count(masp)From cthd
Group by sohd
Having count(masp)>=3
-- danh sach khach hang mua hang hang hang mua hang ngay hom qua
select KhachHang.MaKH, KhachHang.HoTen, HoaDon.NgayHD from KhachHang inner join HoaDon on HoaDon.MaKH = KhachHang.MaKH
where datediff(day, NgayHD, GETDATE()) =1
-- danh sach san pham k ban duoc trong mot nam qua
select SanPham.MaSP, SanPham.TenSP, SanPham.SoLuong, NgayHD from SanPham left join CTHD 
on SanPham.MaSP = CTHD.MaSP join HoaDon on HoaDon.SoHD = CTHD.SoHD
where datediff(day, NgayHD, GETDATE()) >= 365