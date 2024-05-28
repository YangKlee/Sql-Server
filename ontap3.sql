-- thong ke so luong ben nhan moi phong
select PHONG.Maphong, COUNT(BENHNHAN.MaBN) as SL from PHONG  join GIUONGBENH on PHONG.Maphong =  GIUONGBENH.Maphong inner join BENHNHAN on
BENHNHAN.MaBN = GIUONGBENH.MaBN
group by PHONG.Maphong
-- hien thi danh sach benh nhan phong PCC1, PCC3, PCC5
select BENHNHAN.MaBN, Hoten, PHONG.Maphong,Tenphong from BENHNHAN inner join GIUONGBENH on BENHNHAN.MaBN = GIUONGBENH.MaBN inner join PHONG 
on PHONG.Maphong = GIUONGBENH.Maphong
where PHONG.Maphong = 'PCC1' or PHONG.Maphong = 'PCC2' or PHONG.Maphong = 'PCC3'
-- hien thi danh sach benh nhan phong hoi suc 1
select * from BENHNHAN inner join GIUONGBENH on BENHNHAN.MaBN = GIUONGBENH.MaBN inner join PHONG 
on PHONG.Maphong = GIUONGBENH.Maphong
where Tenphong = N'Hồi sức 1'
