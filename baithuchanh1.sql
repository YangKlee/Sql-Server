create database QLBANHANG
go
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
-- them rang buoc
alter table NhanVien
add constraint rangbuoctuoi check(year(getdate())- year(ngaysinh) >= 18)
alter table KhachHang
add constraint rangbuocstd unique(sodt)
alter table SanPham
add constraint rangbuocsp check(soluong >=50)

-- nhap data
insert into KhachHang
values
('4651050044', N'Nguyễn Khánh Dương', N'Bùi Thị Xuân, Quy Nhơn, Bình Định', '0356701052', '18-07-2005', 300),
('4651050189', N'Nguyễn Yến Nhi', N'Tuy Phước, Quy Nhơn, Bình Định', '0395374593', '16-02-2005', 345.9),
('4651050034', N'Trần Thanh Cường', N'Tuy Phước, Quy Nhơn, Bình Định', '0358398336', '25-08-2005', 879.5),
('8319000245', N'Hutao', N'Vãng Sinh Đường, Cảng Liyue, Teyvat', '0356701023', '18-02-2005', 1930.68),
('8418036804', N'Ningguang', N'Quần Ngọc Các, Liyue, Teyvat', '0356703042', '26-08-2005', 999999.9)
insert into NhanVien
values
('0400002001', N'Neuvilete', '18-12-2005', 0, '25-09-2012', '0542356731', 'thamphandanhdan@fontaine.email.com' ),
('0400002002', N'Furina', '13-10-2005', 0, '13-09-2012', '0542356732', 'furina@fontaine.email.com' ),
('0100002001', N'Klee', '27-07-2005', 1, '27-04-2019', '0242336531', 'kleesiucute@mondstadt.email.com' ),
('0300002002', N'Nahida', '27-10-2005', 1, '17-04-2014', '0244332531', 'thaothandangiu@sumeru.email.com' ),
('0200002004', N'Xiao', '17-04-2005', 0, '07-09-2020', '0952336531', 'iuaethervai@liyue.email.com' )	
insert into SanPham
values
('SP20230401', N'Fonta', N'Viện KH Fontaine', 'Fontaine', 300, 2000),
('SP20230402', N'Hòm 2 tầng', N'Vãng Sinh Đường', 'Liyue', 25000, 100),
('SP20230403', N'Sữa Dango', N'Thành Inazuma', 'Inazuma', 100, 1000),
('SP20230404', N'Nước thánh Barbara', N'Không rõ nguồn gốc', 'Mondstadt', 10000, 3)
insert into HoaDon
values
('HD24022401', '23-02-2024', '8319000245', '0400002002', 75000),
('HD24022403', '24-02-2024', '4651050189', '0400002001', 900),
('HD24022402', '23-02-2024', '4651050044', '0100002001', 1900)
insert into CTHD
values
('HD24022401', 'SP20230402' ,3, 25000),
('HD24022402', 'SP20230403' ,19, 100),
('HD24022403', 'SP20230401' ,3, 300)

