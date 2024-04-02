create database QLSV
go
use QLSV

create table LOP
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
	DiaChi nvarchar(100) null,
	NgaySinh date null,
	MaLop char(5) null,
	constraint MaLop_MaLop foreign key (MaLop) references Lop(MaLop)
	on update cascade on delete cascade
)
create table Diem
(
	MaSV char(10) primary key
	constraint MASV_MASV foreign key (MaSV) references SinhVien(MaSV)
	on update cascade on delete cascade,
	DiemThi numeric(4,1) not null,
	DiemKV numeric(4,1) null,
	DiemKQ numeric(4,1) null
)

insert into LOP
values
('10536', 'CNTT36', N'Lê Ngọc Nữ'),
('10537', 'CNTT37', N'Nguyễn Thị Bình'),
('10538', 'CNTT38', N'Hồ Kim Hùng'),
('10539', 'CNTT39', N'Nguyễn Minh Tâm'),
('11237', N'TH Toán37', N'Nguyễn Văn Dũng'),
('11339', 'SP Tin39', N'Trần Văn Tâm')
insert into SinhVien
values
('sv1', N'Hồ Văn', N'Nam', 1, N'Quy Nhơn', '1998-04-12', '10537'),
('sv2', N'Lê Thị', N'Nguyệt', 0, N'Quảng Ngãi', '1990-02-11', '10539'),
('sv3', N'Nguyễn Minh', N'Tùng', 1, N'Quy Nhơn', '1990-03-04', '10538'),
('sv4', N'Trần Hạ', N'Huyền', 0, N'Gia Lai', '1991-06-07', '11339'),
('sv5', N'Nguyễn Thị', N'Lan', 0, N'Quy Nhơn', '1990-04-09', '11237')
insert into Diem(MaSV, DiemThi, DiemKV)
values
('sv1', 8.0, 1.5),
('sv2', 9.0, 1.5),
('sv3', 3.0, 1.0),
('sv4', 2.0, 0.5),
('sv5', 9.0, 0.5)
alter table Diem
add constraint RangbuocDiem check(DiemThi >= 0 and DiemThi <=10)

-- query
-- cap nhat cot diem ket qua
alter table Diem
add constraint DiemKQ_rangbuoc check(DiemKQ <= 10)
update Diem
set DiemKQ =
case 
	when DiemKV+DiemThi <= 10 then DiemKV+DiemThi
	else 10
End
--2
DECLARE @MAXDIEM numeric
SET @MAXDIEM = (select MAX(DiemThi) from SinhVien inner join Diem on SinhVien.MaSV = Diem.MaSV)
select SinhVien.MaSV, HoLot, Ten, TenLop, DiaChi, DiemThi from SinhVien inner join Diem on SinhVien.MaSV = Diem.MaSV
join Lop on SinhVien.MaLop = Lop.MaLop
where DiemThi = @MAXDIEM
--3
select COUNT(SinhVien.MaSV) as 'SV DUOI 5'from SinhVien inner join Diem on SinhVien.MaSV = Diem.MaSV
where DiemThi <= 5
--4
select  SinhVien.MaSV, HoLot, Ten, TenLop, DiemThi from SinhVien inner join Diem on SinhVien.MaSV = Diem.MaSV join Lop on SinhVien.MaLop = Lop.MaLop
where DiemThi = 9
--5
select SinhVien.MaSV, HoLot, Ten, TenLop, DiemKQ into HOCBONG from SinhVien inner join Diem on SinhVien.MaSV = Diem.MaSV
join Lop on SinhVien.MaLop = Lop.MaLop
where DiemKQ >= 8
--6
select count(MaLop) as 'SO lop chua co CVHT' from Lop
where CVHT is null
--7
select count(MaSV) as 'SL SV SPTIN' from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop
where TenLop LIKE N'%SP Tin%' or TenLop LIKE N'%Sư phạm Tin%'

