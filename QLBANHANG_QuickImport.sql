create proc KhachHang_Input
	(@MaKH char(10), 
	@HoTen nvarchar(60), 
	@DiaChi nvarchar(100),
	@SoDT char(11),
	@NgaySinh date,
	@DoanhSo float,
	@Email nvarchar(40)) as
BEGIN
	insert into KhachHang values(@MaKH, @HoTen, @DiaChi, @SoDT, @NgaySinh, @DoanhSo, @Email)
END
exec KhachHang_Input 'KH998', N'Trương Mỹ Lan', N'Hà Nội, Việt Nam', 0, '1992-06-24', 19997187, null
exec KhachHang_Input 'KH554', N'Lê Ngọc Vi', N'Tuy Phước, Bình Định', 0358191851, '2005-06-26', 54648498, null
exec KhachHang_Input 'KH556', N'Ngôn Nhất Vĩ', N'Quy Nhơn, Bình Định', 0258191852, '2005-06-26', 1, null

alter proc Import_HoaDon(
	@SoHD char(10), 
	@TenKH nvarchar(60), 
	@TenNV nvarchar(60),
	@TenSP nvarchar(50),
	@SoLuong float) as

BEGIN
	DECLARE @GetMaKH char(10)
	DECLARE @GetMaNV char(10)
	set @GetMaKH = (Select MaKH from KhachHang where HoTen = @TenKH)
	set @GetMaNV = (Select MaNV from NhanVien where HoTen = @TenNV)
	insert into HoaDon values(@SoHD, GETDATE(), @GetMaKH, @GetMaNV ,0)
END
BEGIN
	DECLARE @GetMaSP char(10)
	set @GetMaSP = (select MaSP from SanPham where TenSP = @TenSP)
	insert into CTHD values(@SoHD, @GetMaSP, @SoLuong, 0)
END
Exec Import_HoaDon 'HD1', N'Nguyễn Yến Nhi', 'Neuvilete', N'Sữa dừa Ganyu', 15
Exec Import_HoaDon 'HD2', N'Nguyễn Khánh Dương', 'Klee', N'Fonta', 200
Exec Import_HoaDon 'HD3', N'Nguyễn Yến Nhi', 'Nahida', N'Sữa Dango', 30
select * from SanPham
alter proc XemMatHangMua(@TenKH nvarchar(60)) as
BEGIN
	DECLARE @GetMaKH1 char(10)
	set @GetMaKH1 = (Select MaKH from KhachHang where HoTen = @TenKH)
	select SanPham.MaSP, TenSP, sum(CTHD.SoLuong) as 'So Luong' from SanPham inner join CTHD on CTHD.MaSP = SanPham.MaSP
	inner join HoaDon on HoaDon.SoHD = CTHD.SoHD
	where MaKH = @GetMaKH1
	group by SanPham.MaSP, TenSP
END

exec XemMatHangMua N'Nguyễn Yến Nhi'
reset_database
select * from SanPham