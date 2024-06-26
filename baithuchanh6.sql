-- viet thu tuc de xem doanh so mua hang cua khach hang co ma x
create proc XemDoanhSo (@Code char(10)) as
begin
	select MaKH, HoTen, DoanhSo from KhachHang where MaKH = @Code
end
XemDoanhSo'4651050189'
-- viet thu tuc xem san pham co gia tri > x va so luong it hon y
create proc XemSP (@xvalue int, @yvalue int) as
begin
	select MaSP, TenSP from SanPham where Gia > @xvalue and SoLuong <@yvalue
end
execute XemSP @xvalue = 5000000 , @yvalue = 1000
-- viet thu tuc xem nhan vien x lap duoc bao nhieu hoa don
create proc SoHDNVLap (@NVCODE char(10))as
begin
	select HoaDon.MaNV, NhanVien.HoTen, count(SoHD) as 'Don da lap'
	from NhanVien inner join HoaDon on NhanVien.MaNV = HoaDon.MaNV
	group by HoaDon.MaNV, NhanVien.HoTen
	having HoaDon.MaNV = @NVCODE
end
execute SoHDNVLap @NVCODE = '0300002002'
-- san pham mua sl nhieu nhat
alter proc MaxSPSL as
begin
	DECLARE @SPSLMAX int
	SET @SPSLMAX = (select TOP(1) SUM(CTHD.SoLuong) from SanPham inner join CTHD on CTHD.MaSP = SanPham.MaSP
					group by CTHD.MaSP
					order by SUM(CTHD.SoLuong) DESC)
	select CTHD.MaSP ,TenSP,SUM(CTHD.SoLuong) as SLDATMUA from SanPham inner join CTHD on CTHD.MaSP = SanPham.MaSP group by CTHD.MaSP , TenSP
	having SUM(CTHD.SoLuong) = @SPSLMAX
end
exec MaxSPSL
-- viet thu tuc xem hoa don x la do nhan vien nao lap, co bao nhieu san pham tren hoa don
alter proc Xem_SP_NV_LAP (@SoHD char(10)) as
BEGIN
	select HoaDon.SoHD, NhanVien.MaNV, HoTen as TenNVLap, count(MaSP) as SoSP from NhanVien inner join HoaDon on NhanVien.MaNV = HoaDon.MaNV 
	join CTHD on CTHD.SoHD = HoaDon.SoHD
	group by HoaDon.SoHD, NhanVien.MaNV, HoTen
	having HoaDon.SoHD = @SoHD
END
select * from SanPham
-- viet thu tuc xem hoa don lap ngay hom qua
create proc XemHDYesterday as
BEGIN
	select * from HoaDon where DATEDIFF(DAY, NgayHD, GETDate()) = 1
END
exec XemHDYesterday
