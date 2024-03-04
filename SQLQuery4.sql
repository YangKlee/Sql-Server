SELECT MaSV, Ho, Ten, 
case
	when GioiTinh=1 then N'Nữ'
	when MaSV = 4651050034 then 'Gay'
	else N'Nam'
End
as 'Gioi tinh'
FROM SinhVien
order by GioiTinh

