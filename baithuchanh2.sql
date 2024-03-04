use QLBANHANG
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
select MaKH, HoTen, DiaChi from KhachHang
where MaKH not in (Select MaKH from HoaDon)
-- san pham san xuat o nhat ban
select * from SanPham
where NuocSX = N'Nhật Bản' or NuocSX = N'Nhật' or NuocSX = 'Japan'
-- khach hang nao da mua Sữa Dango
select KhachHang.MaKH, KhachHang.HoTen from KhachHang, CTHD, HoaDon, SanPham
where SanPham.TenSP = N'Sữa Dango' and SanPham.MaSP = CTHD.MaSP and HoaDon.SoHD = CTHD.SoHD and HoaDon.MaKH = KhachHang.MaKH
-- don hang so HD26020307 do ai ai dat, nhan vien nao lap, tri gia bao nhieu
select HoaDon.SoHD ,KhachHang.HoTen, NhanVien.HoTen, SanPham.TenSP,HoaDon.TriGia from KhachHang, NhanVien, HoaDon, CTHD, SanPham
where HoaDon.SoHD = 'HD26020307' and HoaDon.MaNV = NhanVien.MaNV and HoaDon.MaKH = KhachHang.MaKH and CTHD.SoHD = HoaDon.SoHD and CTHD.MaSP = SanPham.MaSP



-- them cot gioi tinh vao bang khach hang
alter table KhachHang
add GioiTinh bit null
--xoa cot email nhanvien
alter table NhanVien
drop column Email
-- them san pham may tinh xanh tay vao cot san pham
insert into SanPham
values
('SP24225049', N'Máy tính Apple', N'Mỹ', 'Mỹ', 15000000, 350)
-- tang gia san pham may tinh len 10%
update SanPham
set Gia += Gia * 0.1
where TenSP like N'%Máy tính%'

-- hien thi danh sach khach hang chua co so dien thoai
select * from KhachHang
where SoDt = NULL

-- san pham chua ban duoc
select SanPham.MaSP, SanPham.TenSP from SanPham, CTHD, HoaDon
where SanPham.MaSP not in (select MaSP from CTHD)
-- xem khach hang sinh nhat hom nay
select * from KhachHang
where NgaySinh = getdate()
-- xoa nhan vien tren 40
delete NhanVien
where YEAR(GETDATE()) -  year(NgaySinh) > 40
