--                _ooOoo_                          NAM MÔ A DI ĐÀ PHẬT !
--               o8888888o
--               88" . "88                Thí chủ con tên là Nguyễn Khánh Dương, sinh 18/07/2005
--               (| -_- |)                    Ngụ tại Bùi Thị Xuân, Quy Nhơn, Bình Định
--                O\ = /O
--            ____/`---'\____         Con lạy chín phương trời, con lạy mười phương đất
--            .' \\| |// `.             Chư Phật mười phương, mười phương chư Phật
--           / \\||| : |||// \        Con ơn nhờ Trời đất chổ che, Thánh Thần cứu độ
--         / _||||| -:- |||||- \    Xin nhất tâm kính lễ Hoàng thiên Hậu thổ, Tiên Phật Thánh Thần
--           | | \\\ - /// | |                 Giúp đỡ con code sạch ít bug
--         | \_| ''\---/'' | |               Database sạch sẽ, execute vèo vèo
--         \ .-\__ `-` ___/-. /          Điểm cao ngất trời, người người ngưỡng mộ
--       ___`. .' /--.--\ `. . __
--    ."" '< `.___\_<|>_/___.' >'"". NAM MÔ VIÊN THÔNG GIÁO CHỦ ĐẠI TỪ ĐẠI BI TẦM THANH CỨU KHỔ CỨU NẠN
--   | | : `- \`.;`\ _ /`;.`/ - ` : | |  QUẢNG ĐẠI LINH CẢM QUÁN THẾ ÂM BỒ TÁT
--     \ \ `-. \_ __\ /__ _/ .-` / /
--======`-.____`-.___\_____/___.-`____.-'======
--                `=---='
create database QLBANHANG
--drop database QLBANHANG
GO
use QLBANHANG
create table KhachHang
(
	MaKH char(10) not null
	constraint makh_pk primary key,
	HoTen nvarchar(60) not null,
	DiaChi nvarchar(100) null,
	SoDt char(11) null,
	NgaySinh date null
	constraint nguongtuoi check(year(getdate()) - year(NgaySinh) >= 18),
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
	constraint sohd_masp_pk primary key(SoHD, MaSP)
	
)

