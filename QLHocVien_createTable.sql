create database QLHOCVIEN
Go
use QLHOCVIEN

create table GiaoVien
(
	MaGV nchar(10) primary key,
	TenGV nvarchar(50) not null,
	NgaySinh date null,
	GioiTinh nvarchar(10) not null,
	DienThoai nchar(10) null,
	--constraint rangbuocsdt check(DienThoai LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	MaGVQuanLi nchar(10) null
	constraint MaGVQuanLi_MaGV foreign key (MaGVQuanLi) references GiaoVien(MaGV) ,
	--on update cascade on delete cascade
)
create table MonHoc
(
	MaMonHoc nchar(10) primary key,
	TenMonHoc nvarchar(10) not null,
	SoChi int not null
)
create table GiaoVien_Day_MonHoc
(
	MaGV nchar(10)
	constraint MaGV_MaGV foreign key (MaGV) references GiaoVien(MaGV)
	on update cascade on delete cascade,
	MaMH nchar(10)
	constraint MaMH_MaMonHoc foreign key (MaMH) references MonHoc(MaMonHoc)
	on update cascade on delete cascade,
	ThamNien int not null,
	SoLopDaDay int null,
	primary key(MaGV, MaMH)
)
create table LopHoc
(
	MaLop nchar(10) primary key,
	SiSo int not null,
	LopTruong nchar(10) not null,
	GVQuanLi nchar(10) not null
	constraint GVQUANLI_MaGV foreign key (GVQuanLi) references GiaoVien(MaGV)
	on update cascade on delete cascade,
	NamBatDau int not null,
	NamKetThuc int not null,
)
alter table LopHoc
alter column LopTruong nchar(10) null
create table HocVien
(
	MaHocVien nchar(10) primary key,
	TenHocVien nvarchar(50) not null,
	NgaySinh date not null,
	TinhTrang nvarchar(50) not null,
	MaLop nchar(10) not null
	constraint MaLop_MaLop foreign key (MaLop) references LopHoc(MaLop)
	on update cascade on delete cascade,
)

add constraint LopTruong_MaHocVien foreign key (LopTruong) references HocVien(MaHocVien)
create table PhanCong
(
	MaGV nchar(10)
	constraint MaGV_MaGV_2 foreign key (MaGV) references GiaoVien(MaGV)
	on update cascade on delete cascade,
	MaMH nchar(10)
	constraint MaMH_MaMH_2 foreign key (MaMH) references MonHoc(MaMonHoc)
	on update cascade on delete cascade,
	MaLop nchar(10)
	constraint MaLop_MaLop_2 foreign key (MaLop) references LopHoc(MaLop),
	--on update cascade on delete cascade
	Primary key(MaGV, MaMH,MaLop)
)
create table KetQua
(
	MaHV nchar(10)
	constraint MaHV_MaHocVien foreign key (MaHV) references HocVien(MaHocVien)
	on update cascade on delete cascade,
	MaMonHoc nchar(10)
	constraint MaMonHoc_MaMonHoc foreign key (MaMonHoc) references MonHoc(MaMonHoc)
	on update cascade on delete cascade,
	LanThi int , 
	Diem float null
	primary key(MaHV, MaMonHoc, LanThi)
)
-- nhap data
use QLHOCVIEN
insert into GiaoVien
values
('GV00001', N'Nguyễn Văn An', '1981-01-02', N'Nam',null,'GV00002'),
('GV00002', N'Nguyễn Thị Như Lan', '1984-12-02', N'Nữ',null,'GV00005'),
('GV00003', N'Trần Minh Anh', '1986-03-23', N'Nam','0909123999','GV00002'),
('GV00004', N'Trương Tường Vi', '1988-02-01', N'Nữ','0998990909','GV00008'),
('GV00005', N'Hà Anh Tuấn', '1986-12-03', N'Nam','0909909000','GV00008'),
('GV00006', N'Trần Anh Dũng', '1979-04-04', N'Nam',null,'GV00010'),
('GV00007', N'Nguyễn Duy Tân', '1978-01-04', N'Nam',null,'GV00002'),
('GV00008', N'Nguyễn Thị Linh', '1979-07-08', N'Nữ','0938079700','GV00009'),
('GV00009', N'Trần Thị Kiều', '1977-01-03', N'Nữ',null,null),
('GV00010', N'Trần Phương Loan', '1978-04-30', N'Nữ',null,null)

insert into LopHoc
values
('LH000001',1, null, 'GV00001', 2010,2014),
('LH000002',1, null, 'GV00003', 2009,2013),
('LH000003',2, null, 'GV00008', 2010,2014),
('LH000004',4, null, 'GV00010', 2011,2015),
('LH000005',1, null, 'GV00009', 2010,2014)

insert into HocVien
values
('HV000001', N'Nguyễn Thuỳ Linh', '1990-02-01', N'Buộc thôi học', 'LH000001'),
('HV000002', N'Nguyễn Thị Kiều Chi', '1993-12-20', N'Đang học', 'LH000001'),
('HV000003', N'Nguyễn Xuân Thu', '1994-12-30', N'Đang học', 'LH000002'),
('HV000004', N'Trần Trung Chính', '1992-03-12', N'Đang học', 'LH000003'),
('HV000005', N'Trần Minh An', '1990-12-03', N'Đang học', 'LH000003'),
('HV000006', N'Trương Mỹ Linh', '1989-12-12', N'Đã tốt nghiệp', 'LH000004'),
('HV000007', N'Nguyễn Thuỳ Linh', '1989-02-01', N'Đã tốt nghiệp', 'LH000004'),
('HV000008', N'Nguyễn Huỳnh', '1992-03-03', N'Đang học', 'LH000004'),
('HV000009', N'Nguyễn Xuân Trang', '1993-03-13', N'Đang học', 'LH000005'),
('HV000010', N'Nguyễn Bình Minh', '1992-03-12', N'Đang học', 'LH000004')

update LopHoc set LopTruong = 'HV000002' where MaLop = 'LH000001'
update LopHoc set LopTruong = 'HV000003' where MaLop = 'LH000002'
update LopHoc set LopTruong = 'HV000004' where MaLop = 'LH000003'
update LopHoc set LopTruong = 'HV000008' where MaLop = 'LH000004'
update LopHoc set LopTruong = 'HV000009' where MaLop = 'LH000005'

insert into MonHoc
values
('MH00001', N'Cơ sở dữ liệu', 5),
('MH00002', N'Cấu trúc dữ liệu', 6),
('MH00003', N'Mạng máy tính', 4),
('MH00004', N'Toán cao cấp', 6),
('MH00005', N'Tin học cơ sở', 3),
('MH00006', N'Công nghệ phần mềm', 4),
('MH00007', N'Trí tuệ nhân tạo', 4),
('MH00008', N'Khai thác dữ liệu', 3),
('MH00009', N'Phân tích thiết kế hệ thống thông tin', 5),
('MH00010', N'Cơ sở dữ liệu', 5)