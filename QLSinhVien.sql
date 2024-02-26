create database QLSINHVIEN
GO
use QLSINHVIEN

create table Khoa
(
	MaKhoa char(3) not null
	constraint MaKhoa_pk primary key,
	TenKhoa nvarchar(150) not null,
)
create table Nganh
(
	MaNganh char(5) not null
	constraint MaNganh_pk primary key,
	TenNganh nvarchar(150) not null,
	MoTa char(7) not null,
	MaKhoa char(3) not null
	constraint MaKhoa_fk foreign key(MaKhoa) references Khoa(MaKhoa)
	on update cascade on delete cascade
)
create table SinhVien
(
	MaSV char(10) not null
	constraint MaSV_pk primary key,
	Ho Nvarchar(150) not null,
	Ten Nvarchar(8) not null,
	NgaySinh date not null,
	GioiTinh bit not null,
	DiaChi nvarchar(150) null,
	MaNganh char(5) not null
	constraint MaNganh_fk foreign key(MaNganh) references Nganh(MaNganh)
	on update cascade on delete cascade,
)
create table HocPhan
(
	MaHP char(7) not null
	constraint MaHP_pk primary key,
	TenHP nvarchar(150) not null,
	SoTC int not null,
	MaKhoa char(3) not null
	constraint MaKhoa_fk1 foreign key(MaKhoa) references Khoa(MaKhoa)
	on update cascade on delete cascade,
)
create table Lop
(
	MaLop char(10) not null
	constraint MaLop_pk primary key,
	TenLop Nvarchar(150) not null,
	MaKhoa char(3) not null
	constraint MaKhoa_fk2 foreign key (MaKhoa) references Khoa(MaKhoa)
	on update cascade on delete cascade,
)
create table Diem
(
	MaSV char(10) not null
	constraint MaSV_fk foreign key (MaSV) references SinhVien(MaSV)
	on update cascade on delete cascade,
	MaLop char(10) not null
	constraint MaLop_fk2 foreign key (MaLop) references Lop(MaLop),
	MaHP char(7) not null
	constraint MaHP_fk foreign key (MaHP) references HocPhan(MaHP),
	constraint set_pk_diem primary key(MaSV, MaLop, MaHP),
	ChuyenCan numeric(5 , 2) not null,
	GiuaKy numeric(5 , 2) not null,
	CuoiKy numeric(5 , 2) not null,
	DiemHP numeric(5 , 2) null

)