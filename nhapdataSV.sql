use QLSINHVIEN
insert into Khoa
values
('K01', N'Công nghệ thông tin'),
('K02', N'Xã hội nhân văn'),
('K03', N'Sư Phạm'),
('K04', N'Toán và thống kê'),
('K05', N'Ngoại ngữ'),
('K06', N'Kinh tế'),
('K07', N'Chiêm tinh & Phép thuật')

insert into Nganh
values
('CNTT', N'Công nghệ thông tin', 'CNTTQNU', 'K01'),
('KTPM', N'Kỹ thuật phần mềm', 'KTTMQNU', 'K01'),
('KHDL', N'Khoa học dữ liệu', 'KHDLQNU', 'K04'),
('TUD', N'Toán ứng dụng', 'TOANQNU', 'K04'),
('NNA', N'Ngôn ngữ Anh', 'NNAQNU', 'K05'),
('NNP', N'Ngôn ngữ Pháp', 'NNPQNU', 'K05'),
('NNT', N'Ngôn ngữ Trung', 'NTTQNU', 'K05'),
('QTKD', N'Quảng trị kinh doanh', 'QTKDQNU', 'K06'),
('KT', N'Kế toán', 'KTQNU', 'K04'),
('SPVT', N'Sư phạm Văn', 'SPVQNU', 'K03'),
('SPTT', N'Sư phạm Toán', 'SPTQNU', 'K03'),
('TT', N'Tiên tri', 'TTQNU', 'K07'),
('CTH', N'Chiêm tinh học', 'CTHQNU', 'K07')

insert into SinhVien
values
('4651050044', N'Nguyễn Khánh Dương')