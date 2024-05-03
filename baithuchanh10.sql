create database QLSV
use QLSV
create table Lop
(
	MaLop char(5) primary key,
	TenLop nvarchar(30) null,
	CVHT nvarchar(30) null
)
create table SinhVien
(
	MaSV char(10) primary key, 
	HoLot nvarchar(30) null,
	Ten nvarchar(10) null,
	GioiTinh bit null,
	DiaChi nvarchar(30) null, 
	NgaySinh date null,
	MaLop char(5) null
	constraint MaLop_fk foreign key (MaLop) references Lop(MaLop)
)
alter table SinhVien
add constraint NgaySinh18Tuoi check(YEAR(Getdate()) - Year(NgaySinh)>= 18)
insert into Lop 
values
('10537', 'CNTT37', N'Nguy?n Th? B?nh'),
('11339', N'SP Tin 39', N'Tr?n Vãn Tâm'),
('10536', 'CNTT36', N'Lê Ng?c N?'),
('10538', 'CNTT38', N'H? Kim Hùng'),
('11237', N'TH Toán 37', N'Nguy?n Vãn D?ng')

insert into SinhVien
values
('SV01', N'H? Vãn', N'Nam', 1, N'Quy Nhõn', '1998-04-12', '10537'),
('SV02', N'Lê Th?', N'Nguy?t', 0, N'Qu?ng Ng?i', '1990-02-01', null),
('SV03', N'Nguy?n Minh', N'Tùng', 1, N'Quy Nhõn', '1990-03-04', '10538'),
('SV04', N'Tr?n H?', N'Huy?n', 0, N'Gia Lai', '1991-06-07', '11339'),
('SV05', N'Nguy?n Th?', N'Lan', 0, N'Quy Nhõn', '1990-04-09', '11237')
