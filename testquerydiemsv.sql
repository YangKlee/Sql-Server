select SinhVien.MaSV,SinhVien.Ho, SinhVien.Ten , HocPhan.TenHP ,Diem.DiemHP from SinhVien, Diem, HocPhan
where SinhVien.MaSV = Diem.MaSV and Diem.MaHP = HocPhan.MaHP