use BangHang
create table NhanVien
(
	MaNV char(10) primary key,
	HoTen nvarchar(60) not null,
	NgaySinh date,
	GioiTinh bit,
	NgayLamViec date,
	SoDienThoai char(10)

)
create table KhachHang
(
	MaKH char(10) primary key,
	HoTen nvarchar(60) not null,
	NgaySinh date,
	GioiTinh bit,
	--NgayLamViec date,
	SoDienThoai char(10)

)
create table HoaHon
(
	SoHD char(10)
	constraint SoHD_pk primary key,
	NgayHD date,
	MaKH char(10)
	constraint MaKH_fk foreign key references KhachHang(MaKH)
	on delete cascade
	on update cascade,
	MaNV char(10)
	constraint MaNV_fk foreign key references NhanVien(MaNV)
	on delete cascade
	on update cascade,
	


)
