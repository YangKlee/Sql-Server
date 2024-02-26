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
	SoLuong float null,
	GiaBan float null,
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
('4651050044', N'Nguyễn Khánh Dương', N'Bùi Thị Xuân, Quy Nhơn, Bình Định', '0356701052', '2005-07-18', 300),
('4651050189', N'Nguyễn Yến Nhi', N'Tuy Phước, Quy Nhơn, Bình Định', '0395374593', '2005-02-16', 345.9),
('4651050034', N'Trần Thanh Cường', N'Tuy Phước, Quy Nhơn, Bình Định', '0963600126', '2005-08-25', 879.5),
('8319000245', N'Hutao', N'Vãng Sinh Đường, Cảng Liyue, Teyvat', '0356701023', '2005-02-18', 1930.68),
('8418036804', N'Ningguang', N'Quần Ngọc Các, Liyue, Teyvat', '0356703042', '2005-08-26', 999999.9)
insert into NhanVien
values
('0400002001', N'Neuvilete', '1954-12-18', 0, '2012-09-25', '0542356731', 'neuvilete@fontaine.email.com' ),
('0400002002', N'Furina', '2005-10-13', 0, '2012-09-13', '0542356732', 'furina@fontaine.email.com' ),
('0100002001', N'Klee', '2005-07-27', 1, '2019-04-27', '0242336531', 'klee@mondstadt.email.com' ),
('0300002002', N'Nahida', '2005-10-27', 1, '2014-04-16', '0244332531', 'thao@sumeru.email.com' ),
('0200002004', N'Xiao', '2005-04-17', 0, '2020-09-02', '0952336531', 'iuaethervai@liyue.email.com' )	
insert into SanPham
values
('SP20230401', N'Fonta', N'Viện KH Fontaine', 'Fontaine', 300, 2000),
('SP20230402', N'Hòm 2 tầng', N'Vãng Sinh Đường', 'Liyue', 25000, 100),
('SP20230403', N'Sữa Dango', N'Thành Inazuma', 'Inazuma', 100, 1000),
('SP20230404', N'Nước thánh Barbara', N'Không rõ nguồn gốc', 'Mondstadt', 10000, 50),
('SP20230405', N'Gối ôm Klee', N'Nhật Bản', N'Nhật Bản', 54000, 1500),
('SP20230406', N'Gối ôm Nahida', N'Nhật Bản', N'Nhật Bản', 79000, 1050),
('SP20230407', N'Sushi', N'Nhật Bản', N'Nhật Bản', 1000, 50000)
insert into HoaDon
values
('HD24022401', '2024-02-23', '8319000245', '0400002002', 75000),
('HD24022403', '2024-02-24', '4651050189', '0400002001', 900),
('HD24022402', '2024-02-25', '4651050044', '0100002001', 1900)
insert into CTHD
values
('HD24022401', 'SP20230402' ,3, 25000),
('HD24022402', 'SP20230403' ,19, 100),
('HD24022403', 'SP20230401' ,3, 300)


update SanPham
set Gia += Gia * 0.1	
where NuocSX = N'Nhật Bản'

update CTHD
set GiaBan += GiaBan * 0.2 

alter table KhachHang
add Email varchar(100)

update KhachHang
set Email = MaKH+ '@shopee.vn'

delete from NhanVien
where (Year(Getdate()) - year(NgaySinh) > 40)

delete from HoaDon
from KhachHang
where HoaDon.MaKH = KhachHang.MaKH and KhachHang.SoDt = '0963600126'

delete from KhachHang
from HoaDon
where HoaDon.MaKH = KhachHang.MaKH and (year(GETDATE()) != year(HoaDon.NgayHD))