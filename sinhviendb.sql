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
--create database SinhVien
drop database SinhVien
use SinhVien
create table ThongTinCaNhan
(
	MaSV bigint not null
	constraint masv_pk primary key,

	Ho nvarchar(50) not null,
	Ten nvarchar(20) not null,
	GioiTinh bit not null,
	SoDT nvarchar(11),
	DiaChi NText
)
create table DiemSinhVien
(
	MaSV bigint not null
	constraint masv_pk1 primary key
	constraint masv_fk foreign key(MaSV) references ThongTinCaNhan(MaSV)
	on update cascade on delete cascade,
	DiemQT float,
	DiemCk float
)