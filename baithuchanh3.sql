use QLBANHANG

-- san pham chua tung duoc khach hang mua den thoi diem nay
select distinct SanPham.MaSP,SanPham.TenSP from SanPham left join CTHD  on SanPham.MaSP = CTHD.MaSP
where SoHD is null

-- nhan vien chua tung lap hoa don tinh toi thoi diem nay
select distinct NhanVien.MaNV, HoTen from NhanVien left join HoaDon on NhanVien.MaNV = HoaDon.MaNV
where SoHD is null

-- nhan vien nao co tham nien cao nhat
select * from NhanVien
where year(NgayLamViec) = (select MIN(year(ngayLamViec)) from NhanVien)

-- tong so tien ma khach hang phai tra cho moi hoa don
select CTHD.SoHD,Gia*CTHD.SoLuong as 'Thanh tien'from CTHD join SanPham on CTHD.MaSP = SanPham.MaSP 
-- trong nam 2022 san pham nao dat mua dung mot lan
select SanPham.MaSP, SanPham.TenSP, count(CTHD.MaSP) from CTHD inner join SanPham on CTHD.MaSP = SanPham.MaSP
join HoaDon on year(NgayHD) = 2022 and HoaDon.SoHD = CTHD.SoHD
group by SanPham.MaSP, SanPham.TenSP
having count(CTHD.MaSP) = 1;

-- moi nhan vien cty lap bao nhieu hoa don
select NhanVien.MaNV, NhanVien.HoTen, count(SoHD) as 'So don lap'from NhanVien left join HoaDon on NhanVien.MaNV = HoaDon.MaNV
group by NhanVien.MaNV, NhanVien.HoTen

-- thong ke luong hang ton cua cong ty
select SanPham.MaSP, TenSP, SanPham.SoLuong - COUNT(CTHD.SoLuong) as 'Luong hang ton kho' from SanPham 
inner join CTHD on SanPham.MaSP = CTHD.MaSP
group by SanPham.MaSP, TenSP, SanPham.SoLuong
-- Tinh tri gia cho moi hoa don
update HoaDon
set TriGia = ctds.TriGia
from (select sohd, sum(soluong * giaban) as TriGia
	from cthd group by (SoHD)) as ctds
	where HoaDon.SoHD =	ctds.TriGia
-- tinh doanh so mua hang cua moi khach hang
update KhachHang
set DoanhSo = temp.doanhso
from (select makh, sum(trigia) as doanhso from HoaDon
group by makh) as temp
where KhachHang.MaKH = temp.MaKH
-- tong tien loi cong ty thu duoc nam 2023
select sum(HoaDon.TriGia-(SanPham.Gia*SanPham.SoLuong)) as 'Tien loi'from CTHD 
inner join SanPham on SanPham.MaSP = CTHD.MaSP join HoaDon on CTHD.SoHD = HoaDon.SoHD
where year(NgayHD) = 2023
