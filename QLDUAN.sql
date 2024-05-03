
Create database Quanlyduan
go
use quanlyduan
go
create table phongban
(Maphong char(5) primary key,
tenphong nvarchar(30) null,
sodt char(10) null)
go
Create table duan
(maduan char(5) primary key,
tenduan nvarchar(30) null,
diadiem nvarchar(30) null,
maphong char(5) foreign key references phongban(maphong) on delete cascade on update cascade,
)
go
Create table nhanvien
(manv char(5) primary key,
holot nvarchar(30) null,
ten nvarchar(15) null,
gioitinh bit null,
ngaysinh date null,
diachi nvarchar(30) null,
luong int null,
maphong char(5)foreign key references phongban(maphong) on delete cascade on update cascade,
)
go
Create table phancong
(manv char(5) foreign key references nhanvien(manv),
maduan char(5)foreign key references duan(maduan),
sogio float null,
primary key (manv, maduan))
go

insert into phongban
values(1, N'Big Data', '0256789012')
insert into phongban
values(2, N'Xử lý ngôn ngữ tự nhiên','0278901234')
insert into phongban
values(3, N'Phát triển phần mềm','0876594323')
insert into phongban
values(4, N'Marketing', '0987689067')
insert into phongban
values(5, N'Kế toán','0745734890')
insert into phongban
values(6, N'Truyền thông','0134325678')
insert into phongban
values(7, N'Dự án 1','0634325679')
insert into phongban
values(8, N'Dự án 2','0834933679')
insert into phongban
values(9, N'Dự án 3','0834933622')
go
insert into duan
values(1, N'Sản phẩm X',N'Quy Nhơn',1)
insert into duan
values(2, N'Sản phẩm Y',N'Nha Trang',2)
insert into duan
values(3, N'Sản phẩm Z',N'TP.HCM',3)
insert into duan
values(10, N'Tin học hóa',N'Bình Dương',4)
insert into duan
values(4, N'Nhận diện khuôn mặt',N'Bình Định',4)
insert into duan
values(5, N'Nhà thông minh',N'Bình Định',2)
insert into duan
values(6, N'Bãi đậu xe thông minh',N'Bình Phước',1)
insert into duan
values(7, N'Thư viện số',N'Dak Lak',4)
insert into duan
values(8, N'Sổ tay điện tử',N'Bình Định',6)
insert into duan
values(9, N'Quản lý nhân sự',N'Bình Định',5)
insert into duan
values(11, N'Quản lý bệnh nhân',N'Bình Định',7)
go
insert into nhanvien
values('mv1', N'Nguyễn Minh',N'Tâm', 1, '1/4/1988', N'Bình Định', 4000,1)
insert into nhanvien
values('mv2', N'Nguyễn Ngọc',N'Bích', 0, '10/9/1984', N'Phú Yên', 2000,2)
insert into nhanvien
values('mv3', N'Hồ Văn',N'Tâm', 1, '11/9/1986', N'Gia Lai', 5000,3)
insert into nhanvien
values('mv4', N'Lê Minh',N'Thành', 1, '2/14/1987', N'Quảng Ngãi', 3000,2)
insert into nhanvien
values('mv5', N'Nguyễn Thị',N'Thắm', 0, '10/4/1980', N'Bình Dương', 6000,5)
insert into nhanvien
values('mv6', N'Trần Thị',N'Hoa', 0, '1/4/1975', N'Bình Phước', 6000,6)
insert into nhanvien
values('mv7', N'Lê Văn',N'Nam', 1, '8/4/1985', N'Bình Phước', 6000,7)
insert into nhanvien
values('mv8', N'Hồ Ngọc',N'Hà', 0, '9/5/1995', N'Bình Dương', 5000,7)
insert into nhanvien
values('mv9', N'Nguyễn Kim',N'Kha', 1, '6/8/1991', N'Bình Dương', 5000,8)
insert into nhanvien
values('mv10', N'Nguyễn Ngọc',N'Hoa', 0, '7/8/1990', N'Bình Định', 5000,9)
go
insert into phancong
values('mv1',1,30.0)
insert into phancong
values('mv2',2,8.0)
insert into phancong
values('mv3',3,15.0)
insert into phancong
values('mv4',1,20.0)
insert into phancong
values('mv5',3,25.0)
insert into phancong
values('mv1',4,25.0)
insert into phancong
values('mv2',6,25.0)
insert into phancong
values('mv1',5,25.0)
insert into phancong
values('mv2',4,20.0)

