use QLBANHANG
-- nhat ban cung cap nhung mat hang nao
create view Cau1 as 
select SanPham.* from SanPham where NuocSX Like N'%Nhật%' or NuocSX Like '%Japan%'
select * from Cau1
-- san pham Fonta do nuoc nao san xuat
create view Cau2 as 
select SanPham.NuocSX from SanPham where TenSP = 'Fonta'
select * from Cau2
-- nhung khach hang nao co doanh so mua hang cao nhat
create view Max_Doanhso as
select TOP(1) DoanhSo from KhachHang
order by DoanhSo DESC
select KhachHang.* from KhachHang
where DoanhSo = ( select DoanhSo from Max_Doanhso)
-- don hang so HD23012001 do ai lap, thoi gian va tri gia
alter view GetDonHang as
select SoHD, NgayHD, NhanVien.HoTen as NVLAP, TriGia from HoaDon inner join NhanVien on HoaDon.MaNV = NhanVien.MaNV
where HoaDon.SoHD = 'HD23012001'
select * from GetDonHang
-- tong so luong sp VN
create view TongSLSPVN as
select COUNT(MaSP) as TongSP from SanPham where NuocSX = N'Việt Nam' or  NuocSX = N'VN' or  NuocSX = N'Vietnam'
select TongSP from TongSLSPVN
-- don hang so HD23012001 dat mua nhung mat hang nao, tong so tien la bao nhiu
create view DonHangSoHD23012001 as
select CTHD.SoHD, SanPham.TenSP, HoaDon.TriGia from CTHD inner join SanPham on 
CTHD.MaSP = SanPham.MaSP join HoaDon on HoaDon.SoHD = CTHD.SoHD 
where CTHD.SoHD = 'HD23012001'

select * from DonHangSoHD23012001

--Khach hang chua co sdt
create view NoPhone as 
select KhachHang.* from KhachHang where SoDt is null or SoDt = '0'
select * from NoPhone

-- Trong cty nhan vien nao cung ngay sinh ??????
create view NVCungNgaySinh as
select NhanVien.* from NhanVien
group by NgaySinh
-- nhan vien nao chua xuat hoa don trong 30 ngay qua
alter view NVHD30 as
select HoaDon.MaNV from NhanVien inner join HoaDon on NhanVien.MaNV = HoaDon.MaNV
where DATEDIFF(day,getdate(),NgayHD) <= 30

select NhanVien.MaNV, HoTen from NhanVien where NhanVien.MaNV not in (select MaNV from NVHD30)
-- san pham co so luong it hon 100
alter view SPIT10 as
select SanPham.MaSP, TenSP, SoLuong from SanPham where SoLuong <100
select * from SPIT10