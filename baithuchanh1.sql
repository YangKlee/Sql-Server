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
('4651050044', N'Nguyễn Khánh Dương', N'Bùi Thị Xuân, Quy Nhơn, Bình Định', '0356701052', '2005-07-18', 30000),
('4651050189', N'Nguyễn Yến Nhi', N'Tuy Phước, Quy Nhơn, Bình Định', '0395374593', '2005-02-16', 200000),
('4651050034', N'Trần Thanh Cường', N'Tuy Phước, Quy Nhơn, Bình Định', '0963600126', '2005-08-25', 10000),
('8319000245', N'Hutao', N'Vãng Sinh Đường, Cảng Liyue, Teyvat', '0356701023', '1998-02-18', 5360000),
('8418036804', N'Ningguang', N'Quần Ngọc Các, Liyue, Teyvat', '0356703042', '1992-08-26', 1250687000),
('8418036805', N'Raiden Shogun', N'Thiên Thủ Cốc, Inazuma, Teyvat', '0366708042', '2000-08-26', 0),
('8418036806', N'Zhongli', N'Vãng Sinh Đường, Liyue, Teyvat', '0356703942', '1985-08-26', 0),
('8418036807', N'Venti', N'Thành Mondstadt, Mondstadt, Teyvat', '0996703046', '1925-08-26', 0),
('8418036808', N'Xianyun', N'Trầm Ngọc Cốc, Liyue, Teyvat', '0356889042', '1935-08-26', 20000),
('8418036809', N'Klee', N'Đội kỵ sĩ tây phong, Mondstadt, Teyvat', '0242336531', '1935-08-26', 15000),
('8418036810', N'Furina', N'Thành Fontaine, Fontaine, Teyvat', '0542356732', '1975-09-26', 2700000),
('8418036811', N'Lê Xuân Phạm', N'Đà Nẵng, Việt Nam', NULL, '1975-09-26', 600000)
insert into NhanVien
values
('0400002001', N'Neuvilete', '1954-12-18', 0, '2012-09-25', '0542356731', 'neuvilete@fontaine.email.com' ),
('0400002002', N'Furina', '1975-10-13', 0, '2012-09-13', '0542356732', 'furina@fontaine.email.com' ),
('0100002001', N'Klee', '2005-07-27', 1, '2019-04-27', '0242336531', 'klee@mondstadt.email.com' ),
('0300002002', N'Nahida', '2005-10-27', 1, '2014-04-16', '0244332531', 'thao@sumeru.email.com' ),
('0200002004', N'Xiao', '1980-04-17', 0, '2020-09-02', '0952336531', 'iuaethervai@liyue.email.com' )	

insert into SanPham
values
('SP20230401', N'Fonta', N'Chai', 'Fontaine', 9000, 2000),
('SP20230402', N'Hòm 2 tầng', N'Chiếc', 'Liyue', 20500000, 100),
('SP20230403', N'Sữa Dango', N'Chai', 'Inazuma', 15000, 1000),
('SP20230404', N'Nước thánh Barbara', N'Chai', 'Mondstadt', 100000, 300),
('SP20230405', N'Nồi cơm điện', N'Cái', N'Nhật Bản', 5400000, 1500),
('SP20230406', N'Gối ôm Nahida', N'Cái', N'Trung Quốc', 79000, 1050),
('SP20230407', N'Sushi', N'Hộp', N'Nhật Bản', 75000, 5000),
('SP20230408', N'Thùng xốp cho hai người', N'Thùng', N'Việt Nam', 15000, 9000),
('SP24225049', N'Máy tính Apple', N'Chiếc', N'Mỹ', 15000000, 150),
('SP24225050', N'Máy tính bảng', N'Chiếc', N'Nhật', 17000000, 450),
('SP24225051', N'Máy tính xách tay', N'Chiếc', N'Trung Quốc', 9000000, 350),
('SP24225052', N'Trà chanh giã chân', N'Ly', N'Việt Nam', 15000, 1550)
insert into HoaDon(SoHD, NgayHD, MaKH, MaNV)
values
('HD26022401', '2024-02-26', '4651050044', '0100002001'),
('HD26022002', '2024-02-26', '8418036805', '0400002002'),
('HD22042201', '2022-04-01', '8418036808', '0400002002'),
('HD23012001', '2023-01-20', '8418036806', '0400002002'),
('HD26022305', '2024-02-23', '8319000245', '0300002002'),
('HD26022306', '2024-02-23', '4651050189', '0100002001'),
('HD26020307', '2024-02-20', '4651050034', '0400002002'),
('HD26020308', '2024-02-19', '4651050034', '0400002002'),
--
('HD27022401', '2024-02-27', '4651050044', '0100002001'),
('HD27022002', '2024-02-27', '8418036805', '0400002002'),
('HD27042201', '2024-02-26', '4651050044', '0300002002'),
('HD27012001', '2024-07-02', '8418036806', '0400002002'),
('HD27022305', '2024-02-25', '4651050034', '0300002002'),
('HD27022306', '2024-02-27', '4651050189', '0100002001'),
('HD27020307', '2024-02-29', '4651050189', '0300002002'),
('HD27020308', '2024-02-18', '8418036804', '0100002001')



insert into CTHD
values
('HD26022401', 'SP20230401', 3, 0),
('HD26022002', 'SP20230403', 15, 0),
('HD22042201', 'SP20230405', 1, 0 ),
('HD23012001', 'SP20230406', 4, 0),
('HD26022305', 'SP20230402', 10, 0),
('HD26022306', 'SP20230407', 2, 0),
('HD26020307', 'SP20230408', 100, 0),
('HD26020308', 'SP20230404', 10, 0),
--
('HD27022401', 'SP24225052', 5 , 0),
('HD27022002', 'SP24225052', 15, 0),
('HD27042201', 'SP20230403', 6 , 0),
('HD27012001', 'SP20230401', 15, 0),
('HD27022305', 'SP20230401', 6, 0),
('HD27022306', 'SP24225052', 3, 0),
('HD27020307', 'SP20230401', 200, 0),
('HD27020308', 'SP24225049', 2, 0)

-- tu dong cap nhat gia cho cthd
update CTHD
set GiaBan = CTHD.SoLuong*SanPham.Gia
from SanPham
where SanPham.MaSP = CTHD.MaSP

-- tu dong cap nhat gia cho tri gia bang hoa don
update HoaDon
set TriGia = SanPham.Gia*CTHD.SoLuong
from SanPham, CTHD
where SanPham.MaSP = CTHD.MaSP and HoaDon.SoHD = CTHD.SoHD


-- sp tai nhat tang 10%
update SanPham
set Gia += Gia * 0.1	
where NuocSX = N'Nhật Bản' OR NuocSX =  N'Nhật' OR NuocSX = 'Japan'

-- cap nhat gia loi 20%
update CTHD
set GiaBan += GiaBan * 0.2 
from SanPham
where SanPham.MaSP = CTHD.MaSP

-- xoa nhan vien tren 40 tuoi
delete from NhanVien
where (Year(Getdate()) - year(NgaySinh) > 40)

-- xoa khach hang sdt 0963600126
delete from CTHD
from KhachHang, HoaDon
where HoaDon.MaKH = KhachHang.MaKH and KhachHang.SoDt = '0963600126' and HoaDon.SoHD = CTHD.SoHD
delete from HoaDon
from KhachHang
where HoaDon.MaKH = KhachHang.MaKH and KhachHang.SoDt = '0963600126'

-- xoa khach hang mot nam khong co don hang nao
delete from KhachHang
from HoaDon, CTHD
where HoaDon.MaKH = KhachHang.MaKH and datediff(day, HoaDon.NgayHD, GETDATE()) > 365 or HoaDon.MaKH not in (Select MaKH from HoaDon)



