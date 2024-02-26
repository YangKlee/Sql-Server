use QLBANHANG
select KhachHang.MaKH,HoTen, TenSP , CTHD.SoLuong, GiaBan into ThongTinDonHang from KhachHang, HoaDon, CTHD, SanPham
where KhachHang.MaKH = HoaDon.MaKH and HoaDon.SoHD = CTHD.SoHD and SanPham.MaSP = CTHD.MaSP

use QLBANHANG
alter table ThongTinDonHang
add ThanhTien float null

update ThongTinDonHang
set ThanhTien = GiaBan*SoLuong
