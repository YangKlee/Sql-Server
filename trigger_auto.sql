alter trigger Auto_Update_HoaDon_SP on CTHD
for insert, update as
BEGIN
	DECLARE @SLDAT int = (select SoLuong from inserted)
	DECLARE @SLHANG  int = (select SoLuong from SanPham 
						where MaSP = (select MaSP from inserted))
	if(@SLDAT <= @SLHANG)
	BEGIN
		BEGIN
			UPDATE SanPham
			Set SoLuong -= @SLDAT
			where MaSP = (select MaSP from inserted)
			DECLARE @SoLuong int = (select SoLuong from inserted)
		END
		BEGIN
			DECLARE @MASP char(10) = (select masp from inserted)
			DECLARE @GiaSP int= (select Gia from SanPham where MaSP = @MASP)
			UPDATE CTHD
			SET GiaBan = @GiaSP + (@GiaSP* 0.2)
			where SoHD = (select SoHD from inserted)
		END
		BEGIN
			DECLARE @GiaBan int = (select GiaBan from CTHD where SoHD = (select SoHD from inserted))
			UPDATE HoaDon
			SET TriGia = @GiaBan * @SoLuong
			where SoHD = (select SoHD from inserted)
			print(@GiaBan * @SoLuong)
		END
	END
	else
	BEGIN
		print(N'Không đủ hàng, cút chỗ khác mua')
		rollback tran
	END
END
create trigger Auto_Calc_DoanhSo on HOADON
for insert, update as
BEGIN
	update KhachHang
	SET DoanhSo += (select Trigia from inserted)
	where MaKH = (select MaKH from inserted)
END
select * from KhachHang


