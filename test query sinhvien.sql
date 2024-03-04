use QLSINHVIEN
-- lay ra sinh vien o binh dinh
select * from SinhVien
where DiaChi like N'%Bình Định%'
-- lay ra sinh vien hoc nganh cntt
select SinhVien.* from SinhVien, Nganh
where SinhVien.MaNganh = Nganh.MaNganh and TenNganh = N'Công nghệ thông tin'

-- cho biet do tuoi cua tung sinh vien
select MaSV, Ho, Ten, GioiTinh, year(getdate()) - year(NgaySinh) as 'Age' from SinhVien
select count(MaSV) from SinhVien