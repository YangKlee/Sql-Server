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
insert into SanPham values('SPTEST', N'Loli nhốt 2 tháng dưới tầng hầm', N'Bé', N'Việt Nam', 100000000, 100)
select * from SanPham
 

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
GO
-- cap nhat gia ban cho hoa don , cthd
alter trigger UpdateGiaHD on CTHD
for update, insert as
BEGIN 
	update CTHD
	set GiaBan = SanPham.Gia * 0.1
	from SanPham, inserted
	where SanPham.MaSP = inserted.MaSP
	-- cap nhat sl
	DECLARE @SLMUA int =  (select SoLuong from inserted)
	DECLARE @SLHangTon int = (select SanPham.SoLuong from SanPham inner join inserted on SanPham.MaSP = inserted.MaSP
	where SanPham.MaSP =  inserted.MaSP)
	if(@SLMUA <= @SLHangTon)
	BEGIN
		update SanPham
		set SoLuong -= @SLMUA
		from inserted
		where SanPham.MaSP = inserted.MaSP
	END
	else 
	BEGIN
		print('San pham mua vuot qua luong hang trong kho')
		rollback tran
	END
	
END
select * from SanPham