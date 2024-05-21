create database QLbenhvien
go
use QLbenhvien
go
CREATE TABLE KHOA(
	Makhoa char(20) NOT NULL primary key ,
	Tenkhoa nvarchar(50) NULL)
go
CREATE TABLE PHONG(
	Maphong char(20) NOT NULL primary key,
	Tenphong nvarchar(50) NULL,
	Makhoa char(20) NULL foreign key references khoa(makhoa)
	on delete cascade on update cascade)
go
 CREATE TABLE BACSI(
	MaBs char(20) NOT NULL primary key,
	TenBS nvarchar(50) NULL,
	Gioitinh bit NULL,
	Chuyen_mon nvarchar(50) NULL,
	Namsinh date NULL,
	CMND int NULL,
	Makhoa char (20) NULL foreign key references khoa(makhoa)
	on delete cascade on update cascade)
go
CREATE TABLE BENHNHAN(
	MaBN char(20) NOT NULL primary key,
	Hoten nvarchar(50) NULL,
	Gioitinh bit NULL,
	Diachi nvarchar(50) NULL,
	Namsinh date NULL,
	 CMND int NULL)
go
CREATE TABLE GIUONGBENH(
	Magiuong char(20) NOT NULL,
	Trang_thai nvarchar(50) NULL,
	Maphong char(20) NOT NULL foreign key references phong(maphong)
	on delete cascade on update cascade,
	MaBN char(20) NOT NULL foreign key references benhnhan(mabn)
	on delete cascade on update cascade,
	primary key(magiuong,maphong,mabn))
go
	INSERT INTO KHOA(Makhoa, Tenkhoa)
     VALUES('KH01','Hoi suc cap cuu'),
('KH02',N'Cap cuu'),
('KH03','Rang Ham Mat'),
('KH04','Phau Thuat'),
('KH05','Ngoai'),
('KH06','Noi'),
('KH07','Than kinh'),
('KH08','Ung buu'),
('KH09','San'),
('KH10','Nhi')
go
INSERT INTO PHONG(Maphong, Tenphong, Makhoa)
VALUES ('PCC1','Phau thuat','KH02'),                
('PCC10','Nhi2','KH10'),                
('PCC11',N'Chờ sinh','KH09'),                
('PCC12',N'Hậu sản','KH09'),                
('PCC2','Hoi suc 01','KH01'),                
('PCC3','Phau thuat 02','KH04'),                
('PCC4','Benh 01','KH03'),                
('PCC5','Benh 02','KH01'),                
('PCC6','Benh 03','KH02'),                
('PCC7','Benh 04','KH02'),                
('PCC8','Benh 05','KH05'),                
('PCC9','Nhi1','KH10')
go 
INSERT INTO BACSI(MaBS,TenBS,Gioitinh,Chuyen_mon,Namsinh,CMND,Makhoa)
VALUES ('BS01','Binh Thuan',1,N'Phẫu thuật','1989-11-09',13245678,'KH01'),                
('BS02','Nhu Ngoc',0,N'Chỉnh hình','1979-01-17',8763278,'KH01'),                
('BS03','Dinh Ton',1,N'Răng hàm mặt','1969-10-09',3762178,'KH03'),                
('BS04','Nguyet',0,N'Phẫu thuật','1999-01-19',134365678,'KH02'),                
('BS05','Duc',1,N'Phẫu thuật','1980-12-09',132324218,'KH04'),                
('BS06','Kha',0,N'Nội soi','1987-09-08',12345678,'KH01')
go
INSERT INTO BENHNHAN(MaBN,Hoten,Gioitinh,Diachi,Namsinh,CMND)
VALUES  ('BN01','Nguyen An',1,'12 Dinh Tien Hoang','1976-01-04',12345678),
('BN010','Ngo Truc',0,'DakLak','1997-09-12',1),
('BN02','Nguyen Ba',1,'Dong Nai','1976-01-04',123455678),
('BN03','Nguyen Canh',1,'Binh Duong','1979-11-04',19845678),
('BN04','Nguyen Dung',0,'Nha Trang','1986-01-08',98735678),
('BN05','Nguyen Em',1,'Vung Tau','1979-01-09',4387678),
('BN06','Le An',0,'Binh Dinh','1987-09-04',0),
('BN07','Ho Nguyet',1,'Quang Ngai','1967-03-06',0),
('BN08','Tran Phong',1,'Phu Yen','1985-05-03',0),
('BN09','Dao Tam',1,'Gia Lai','1990-05-09',0)
go
INSERT INTO GIUONGBENH(Magiuong,Trang_thai,Maphong,MaBN)
VALUES ('m110','on','pcc1','BN03'),                
('m1110','ON','PCC1','BN01'),                
('m1110','on','pcc1','bn02'),                
('M1210','ON','PCC1','BN06'),                
('M1210','ON','PCC1','BN07'),                
('M1210','ON','PCC1','BN08'),                
('m1210','OFF','PCC2','BN02'),                
('m1320','OFF','PCC4','BN04'),                
('m1350','ON','PCC2','BN02'),                
('m1510','ON','PCC3','BN03'),                
('m1650','ON','PCC5','BN01'),                
('m3110','ON','PCC6','BN05')                         
go