use QLBANHANG
-- nhan vien nao cong ty ban so luong hang nhieu nhat va so luong la bao nhiu
DECLARE @SLMAX int
set @SLMAX = (select top(1) sum(SoLuong) from NhanVien inner join HoaDon on HoaDon.MaNV = NhanVien.MaNV
			  join CTHD on HoaDon.SoHD = CTHD.SoHD
			  group by NhanVien.MaNV
			  order by sum(SoLuong) DESC)
select NhanVien.MaNV, HoTen, sum(SoLuong) as SLDAT from NhanVien inner join HoaDon on HoaDon.MaNV = NhanVien.MaNV
join CTHD on HoaDon.SoHD = CTHD.SoHD
group by NhanVien.MaNV, HoTen
having sum(SoLuong) = @SLMAX
-- don hang nao co so luong dat mua it nhat
DECLARE @DATMIN int
set @DATMIN = (select MIN(SoLuong) from CTHD)
select CTHD.SoHD, SanPham.TenSP, CTHD.SoLuong, GiaBan from CTHD inner join SanPham on CTHD.MaSP = SanPham.MaSP
where CTHD.SoLuong = @DATMIN