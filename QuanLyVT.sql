create database QuanLyVT
go
use QuanlyVT
create table VatTu
(
	MaVTu char(4) not null
	constraint MaVTu_pk primary key,
	TenVTu nvarchar(100) not null,
	DvTinh Nvarchar(10) not null,
	PhanTram int not null
)
create table NhaCC
(
	MaNhaCC char(3) not null
	constraint MaNhaCC_pk primary key,
	TenNhaCC nvarchar(100) not null,
	DiaChi nvarchar(200) null,
	DienThoai nvarchar(20) null
)
create table DonHD
(
	SoHD char(4) not null
	constraint SoHD_pk primary key,
	NgayDH Datetime not null,
	MaNhaCC char(3) not null
	constraint MaNhaCC_fk foreign key (MaNhaCC) references NhaCC(MaNhaCC)
	on update cascade on delete cascade,
)
create table CTDonDH
(
	SoHD char(4) not null
	constraint SoHd_pk1 primary key
	constraint SoHd_fk foreign key (SoHD) references DonHD(SoHD)
	on update cascade on delete cascade,
	MaVTu char(4) not null
	constraint MaVTu_fk foreign key (MaVTu) references VatTu(MaVTu)
	on update cascade on delete cascade,
	SLDat int null,
)
create table PNhap
(
	SoPN char(4) not null
	constraint SoPN_pk primary key,
	NgayNhap datetime not null,
	SoHD char(4)
	constraint SoHD_fk1 foreign key (SoHD) references DonHD(SoHD)
	on update cascade on delete cascade,
)
create table CTPNhap
(
	SoPN char(4) not null
	constraint SoPN_pk1 primary key
	constraint SoPN_fk foreign key (SoPN) references PNhap(SoPN)
	on update cascade on delete cascade,
	MaVTu char(4) not null
	constraint MaVTu_fk1 foreign key (MaVTu) references VatTu(MaVTu)
	on update cascade on delete cascade,
	SLNhap int null,
	DGNhap Money null,
)
create table PXuat
(
	SoPX char(4) not null
	constraint SoPX_pk primary key,
	NgayXuat datetime not null,
	TenKH nvarchar(100) not null
)
create table CTPXuat
(
	SoPX char(4) not null
	constraint SoPX_pk1 primary key
	constraint SoPX_fk foreign key (SoPX) references PXuat(SoPX)
	on update cascade on delete cascade,
	MaVTu char(4) not null
	constraint MaVTu_fk2 foreign key (MaVTu) references VatTu(MaVTu)
	on update cascade on delete cascade,
	SLXuat int not null,
	DGXuat Money not null
)
create table TonKho
(
	NamThang char(6) not null
	constraint NamThang_pk primary key ,
	MaVTu char(4) not null
	constraint MaVTu_fk3 foreign key (MaVTu) references VatTu(MaVTu)
	on update cascade on delete cascade,
	SLDau int null,
	TongSLN int null,
	TongSLX int null,
	SLCuoi int null
)
alter table VatTu add constraint rangbuocten_VT unique(TenVTu)
alter table VatTu add constraint rangbuoc_phantram check(PhanTram >= 0 and PhanTram <=100)
alter table VatTu add constraint donvitinh_df default N'Tấn' for DvTinh
alter table NhaCC add constraint nhacungcap_unique unique(TenNhaCC)
alter table NhaCC add constraint diachi_unique unique(DiaChi)
alter table NhaCC add constraint dienthoai_df default N'Chưa có' for DienThoai
alter table DonHD add constraint dondh_df default Getdate() for NgayDH
alter table CTDONDH add constraint sldat_ck check(SLDAT > 0)
