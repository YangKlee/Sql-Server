create database QLBANHANG
use QLBANHANG
create table KhachHang
(
	MaKH char(10) not null
	constraint makh_pk primary key,
	HoTen nvarchar(60) not null,
	DiaChi nvarchar(100) null,
	SoDt char(11) null,
	NgaySinh date null,
	DoanhSo float null
)
create table NhanVien
(
	MaNV char(10) not null
	constraint manv_pk primary key,
	HoTen nvarchar(60) not null,
	NgaySinh date null,
	GioiTinh bit null,
	NgayLamViec date null,
	SoDt char(11) null,
	Email char (30) null
)
create table HoaDon
(
	SoHD char(10) not null
	constraint sohd_pk primary key,
	NgayHD date not null,
	MaKH char(10) not null
	constraint makh_HoaDon_to_KhachHang foreign key(MaKH) references KhachHang(MaKH)
	on delete cascade on update cascade,
	MaNV char(10) not null
	constraint manv_HoaDon_to_NhanVien foreign key(MaNV) references NhanVien(MaNV)
	on delete cascade on update cascade,
	TriGia float null
)
create table SanPham
(
	MaSP char(10) not null
	constraint masp_pk primary key,
	TenSP nvarchar(50) not null,
	DVT nvarchar(30) null,
	NuocSX nvarchar(50) null,
	Gia float not null,
	SoLuong float not null
)
create table CTHD
(
	SoHD char(10) not null
	constraint sohd_CHTD_to_HoaDon foreign key(SoHD) references HoaDon(SoHD)
	on delete cascade on update cascade,
	MaSP char(10) not null
	constraint masp_CHTD_to_SanPham foreign key(MaSP) references SanPham(MaSP)
	on delete cascade on update cascade,
	constraint sohd_masp_pk primary key(SoHD, MaSP)
	
)

