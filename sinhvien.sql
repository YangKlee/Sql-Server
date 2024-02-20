use SinhVienK46
create table Nganh
(
	manganh char(5) not null 
	constraint pk_manganh primary key,
	tennganh nvarchar not null,
	chitieu int not null
	--diemsan float not null
)
create table DiemSinhVien
(
	masv bigint not null 
	constraint pk_masv1 primary key,
	manganh char(5) not null,
	constraint fk_manganh1 foreign key (manganh) references Nganh(manganh)
	on delete cascade on update cascade ,
	diem float
)
create table SinhVien
(
	masv bigint not null 
	constraint pk_masv primary key,
	ho nvarchar(50) not null,
	ten nvarchar(20) not null,
	dienthoai nchar(11) null,
	diachi ntext null,
	manganh char(5) not null
	-- tham chieu den ma nganh cua bang nganh
	constraint fk_manganh2 foreign key (manganh) references Nganh(manganh)
	on delete cascade on update cascade 
)
