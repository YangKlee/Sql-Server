use QLBANHANG
GO
--rang buoc so luong bang san pham
create trigger RangBuocSLCTHD on CTHD
FOR INSERT AS
Begin
	DECLARE @SLMUA int
	DECLARE @SLSP int
	SET @SLMUA = (select SoLuong from inserted)
	SET @SLSP = (select SanPham.SoLuong from SanPham inner join inserted on SanPham.MaSP = inserted.MaSP)
	If(@SLMUA >= @SLSP)
	BEGIN
		print('So luong san pham dat hang vuot qua luong hang ton kho')
		rollback tran
	END
End
GO
-- rang buoc bang san pham so luong nhap vao <= 10
alter trigger RangBuocSPVao on SanPham
For insert, update as
BEGIN
	Declare @SL_Nhap int = (Select SoLuong from inserted)
	if(@SL_Nhap <= 10)
	BEGIN 
		print('So luong san pham khong duoc nho hon 10')
		rollback tran
	END
END
-- test
insert into SanPham values('SPTEST', N'Loli nhốt 2 tháng dưới tầng hầm', N'Bé', N'Việt Nam', 100000000, 1)
select * from SanPham
GO

alter trigger Print_Info_SP_Modify on SanPham
For update, delete as

BEGIN
	DECLARE @MaSP char(10) = (select MaSP from inserted)
	DECLARE @Gia_cu int = (select Gia from deleted where MaSP = @MaSP)
	DECLARE @Gia_moi int = (select Gia from inserted )
	BEGIN
		print(@MaSP )
		print(@Gia_cu)
		print(@Gia_moi)

	END
END
update SanPham
set Gia = 17500
where MaSP  = 'SP20230408' 