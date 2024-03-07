use DiemThiTHPTQG
select sbd, 
	toan+vat_li+hoa_hoc as 'A00' ,
	toan+vat_li+ngoai_ngu as 'A01' ,
	toan+vat_li+sinh_hoc as 'A02' ,
	toan+hoa_hoc+sinh_hoc as 'B00' ,
	ngu_van+lich_su+dia_li as 'C00' ,
	ngu_van+gdcd+lich_su as 'C19' ,
	toan+ngu_van+ngoai_ngu as 'D01' 



from BinhDinh


