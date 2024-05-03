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
alter proc Update_Gia as
BEGIN
	update CTHD
	Set GiaBan = Gia*0.2
	from SanPham
	where SanPham.MaSP = CTHD.MaSP
END
BEGIN
	update HoaDon
	set TriGia = GiaBan * SoLuong
	from CTHD
	where HoaDon.SoHD = CTHD.SoHD
END
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
	insert into HoaDon values(@SoHD, GETDATE(), @GetMaKH, @GetMaNV ,null)
END
BEGIN
	DECLARE @GetMaSP char(10)
	set @GetMaSP = (select MaSP from SanPham where TenSP = @TenSP)
	insert into CTHD values(@SoHD, @GetMaSP, @SoLuong, null)
END
BEGIN
	--exec Update_Gia
END
Exec Import_HoaDon 'HD16042405', N'Furina', 'Nahida', N'Fonta', 40
Exec Import_HoaDon 'HD160424', N'Trương Mỹ Lan', 'Furina', N'Hòm 2 tầng' ,3
Exec Import_HoaDon 'HD16042401', N'Nguyễn Khánh Dương', 'Klee', 'Fonta', 9
Exec Import_HoaDon 'HD16042413', N'ningguang', 'Neuvilete', 'Fonta' ,1999
Exec Import_HoaDon 'HD16042414', N'ningguang', 'Klee', N'Máy tính xách tay' ,200
Exec Import_HoaDon 'HD16042416', N'ningguang', 'Klee', N'Hòm 2 tầng' ,200
Exec Import_HoaDon 'HD16042420', N'Trần Thanh Cường', 'Klee', N'Gối ôm Nahida' ,2
Exec Import_HoaDon 'HD16042422', N'Toàn đẹp trai', 'Klee', N'Thùng xốp cho hai người' ,2
Exec Import_HoaDon 'HD24442406' , N'Ngôn Nhất Vĩ', 'Furina', N'Trà chanh giã chân' ,1
select * from CTHD where SoHD = 'HD16042423'
Exec Import_HoaDon 'HD16042499', N'Trần Thanh Cường', 'Klee', N'Loli nhốt 2 tháng dưới tầng hầm' ,100
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

exec XemMatHangMua N'Trần Thanh Cường'
