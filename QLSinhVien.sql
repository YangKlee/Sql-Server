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
-- nhap data sinh vien
use QLSINHVIEN
insert into Khoa
values
('105', N'Công nghệ thông tin'),
('113', N'Giáo dục chính trị - Luật - Quản lí nhà nước'),
('203', N'Khoa học xã hội và nhân văn'),
('101', N'Toán và thống kê'),
('109', N'Ngoại ngữ'),
('114', N'Kinh tế'),
('115', N'Quản trị kinh doanh'),
('112', N'Giáo dục thể chất-Quốc Phòng'),
('201', N'Sư phạm'),
('187', N'Công nghiệp Game')
insert into Nganh
values
('CNTT', N'Công nghệ thông tin', 'CNTTQNU', '105'),
('KTPM', N'Kỹ thuật phần mềm', 'KTTMQNU', '105'),
('KHDL', N'Khoa học dữ liệu', 'KHDLQNU', '101'),
('TUD', N'Toán ứng dụng', 'TOANQNU', '101'),
('NNA', N'Ngôn ngữ Anh', 'NNAQNU', '109'),
('NNP', N'Ngôn ngữ Pháp', 'NNPQNU', '109'),
('NNT', N'Ngôn ngữ Trung', 'NTTQNU', '109'),
('NNN', N'Ngôn ngữ Nhật', 'NNNQNU', '109'),
('LUAT', N'Luật', 'LQNU', '113'),
('TCNN', N'Tài chính-Ngân hàng', 'TCNHQN', '114'),
('QTKD', N'Quản trị kinh doanh', 'QTKDQNU', '115'),
('GDTC', N'Giáo dục thể chất', 'GDTCQNU', '112'),
('KT', N'Kế toán', 'KTQNU', '114'),
('SPVT', N'Sư phạm Văn', 'SPVQNU', '201'),
('SPTT', N'Sư phạm Toán', 'SPTQNU', '201'),
('GI', N'Genshin Impact', 'GIQNU', '187'),
('HSR', N'Honkai Star rail', 'HSRQNU', '187'),
('LMHT', N'Liên minh huyền thoại', 'LMQNU', '187'),
('LQMB', N'Liên quân Mobie', 'LQQNU', '187')



insert into SinhVien
values
('4651050044', N'Nguyễn Khánh', N'Dương', '2005-07-18', 0, N'Bùi Thị Xuân, Quy Nhơn, Bình Định', 'CNTT' ),
('4651050189', N'Nguyễn Yến', N'Nhi', '2005-02-16', 1, N'Diêu Trì, Tuy Phước, Bình Định', 'CNTT' ),
('4651050034', N'Trần Thanh', N'Cường', '2005-08-25', 0, N'Phước An, Tuy Phước, Bình Định', 'CNTT' ),
('4651010014', N'Lê Bùi Phương', N'Thảo', '2005-01-02', 1, N'Vân Canh, Bình Định', 'TUD' ),
('4651140064', N'Lê Hoàng Bảo', N'Lâm', '2005-12-06', 0, N'Pleiku, Gia Lai', 'TCNN' ),
('4652010049', N'Lê Phùng Bảo', N'Khanh', '2005-07-16', 1, N'Bùi Thị Xuân, Quy Nhơn, Bình Định', 'SPVT' ),
('4552010044', N'Lê Thị Tuyết', N'Ngọc', '2004-02-16', 1, N'459 Tôn Đức Thắng, Hoà Khánh Nam, Liên Chiểu, Đà Nẵng, Việt Nam', 'SPTT' ),
('4651090112', N'Bùi Thị Ngọc', N'Anh', '2005-02-18', 0, N'Bùi Thị Xuân, Quy Nhơn, Bình Định', 'NNA' )

insert into Lop
values
('CNTTK46D', N'Công nghệ thông tin K46D ', '105'),
('CNTTK46B', N'Công nghệ thông tin K46B ', '105'),
('TOANK46D', N'Toán ứng dụng K46 ', '101'),
('NNAK46D', N'Ngôn ngữ anh K46D ', '109')

insert into HocPhan
values
('HP10501', N'Lập trình cơ bản', 3 , '105'),
('HP10901', N'Tiếng anh 1', 3 , '109'),
('HP11301', N'Triết học Mác Lênin', 3 , '113'),
('HP10101', N'Giải tích 1', 3 , '101'),
('HP10102', N'Đại số tuyến tính', 3 , '101'),
('HP10103', N'Toán Logic', 2 , '101'),
('HP11203', N'GDTC 1', 1 , '112')

insert into Diem
values
('4651050044', 'CNTTK46D', 'HP10501', 10, 10, 10, NULL ),
('4651050189', 'CNTTK46B', 'HP10501', 10, 8, 9, NULL ),
('4651050034', 'CNTTK46D', 'HP10501', 10, 10, 8, NULL ),

('4651050044', 'CNTTK46D', 'HP10901', 10, 9.3, 7.9, NULL ),
('4651050189', 'CNTTK46B', 'HP10901', 10, 8, 7.5, NULL ),
('4651050034', 'CNTTK46D', 'HP10901', 10, 8, 8, NULL ),

('4651050044', 'CNTTK46D', 'HP10101', 10, 10, 7, NULL ),
('4651050189', 'CNTTK46B', 'HP10101', 10, 9, 5, NULL ),
('4651050034', 'CNTTK46D', 'HP10101', 10, 10, 10, NULL )
-- cap nhat diem hoc phan
update Diem
set DiemHP = (ChuyenCan + GiuaKy + CuoiKy)/3