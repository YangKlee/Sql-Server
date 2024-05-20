create database QLCHITIEU
use QLCHITIEU

create table NguoiDung
(
	UserID int not null identity(1,1) primary key,
	UserName nvarchar(20) not null unique,
	LoginVerify nvarchar(100) not null,
	UserRole varchar(10) null
)

create table ChiTieu
(
	UserID int not null primary key
	constraint connect_ngdung foreign key (userID) references NguoiDung(UserID)
	on update cascade on delete cascade,
	SoDu int default 0 check(SoDu >=0),
)
create table LichSuChiTieu
(
	STT int identity(1,1) primary key,
	UserID int not null
	constraint connect_ngdung2 foreign key(UserID) references NguoiDung(UserID),
	ThoiGian datetime,
	HoatDong nvarchar(10),
	SoTien int not null,
	NoiDung nvarchar(1000) null
)
create proc AddUser(@UserName nvarchar(20), @Password nvarchar(100)) as
BEGIN
	insert into NguoiDung (UserName, LoginVerify)
	values (@UserName, concat(@UserName,@Password))
END
create trigger CheckUserName on NguoiDung
for insert as
BEGIN
	if((select count(userid) from NguoiDung where UserName = (select Username from inserted) ) > 1)
	BEGIN
		print('Ten nguoi dung da ton tai')
		rollback tran
	END
	else
	BEGIN
		insert into ChiTieu
		values((select UserID from NguoiDung where UserName = (select UserName from inserted)), 0)
	END
END
exec AddUser N'YangSimpKlee', '18072005'
alter function LoginFunc(@UserName nvarchar(100) , @PassWord nvarchar(100))
returns int as
BEGIN
	DECLARE @UserIDGet int = (select UserID from NguoiDung where LoginVerify = CONCAT(@UserName, @PassWord))
	if(@UserIDGet is null)
		return -1
	return @UserIDGet
END

create proc NapRutTien(@UserID int, @isNap bit, @SoTien float, @NoiDung nvarchar(1000)) as
BEGIN
	if(@isNap = 1)
	BEGIN
		if(@SoTien > 0)
		begin
			update ChiTieu
			set SoDu += @SoTien
			where UserID = @UserID
			insert into LichSuChiTieu(UserID, ThoiGian, HoatDong, SoTien, NoiDung)
			values(@UserID, GETDATE(), N'Nạp', @SoTien, @NoiDung)
		end
		else
			print(N'Số tiền nạp phải lớn hơn 0')
	END
	else if(@isNap = 0)
	BEGIN
		if(@SoTien > 0 )
		begin
			if((select SoDu from ChiTieu where UserID = @UserID) >= @SoTien)
			BEGIN
				update ChiTieu
				set SoDu -= @SoTien
				where UserID = @UserID
				insert into LichSuChiTieu(UserID, ThoiGian, HoatDong, SoTien, NoiDung)
				values(@UserID, GETDATE(), N'Rút', @SoTien, @NoiDung)
			END
			Else
				print(N'Số dư hem đủ')
		end
		else
			print(N'Số tiền rút phải lớn hơn 0')
	END
	
END
exec NapRutTien 2,0, 99999000, N'Mua hòm Hutao'
select * from LichSuChiTieu
create function GetSoDu(@UserId int)
returns int as
BEGIN
	return (select SoDu from ChiTieu where UserID = @UserID)
END

create proc GetSaoKe(@UserId int, @Mode int) as
BEGIN
	if(@Mode = 0)
		(select * from LichSuChiTieu where UserID = @UserId and HoatDong = N'Rút')
	else if(@Mode = 1)
		(select * from LichSuChiTieu where UserID = @UserId and HoatDong = N'Nạp')
	else
	 (select * from LichSuChiTieu where UserID = @UserId)
END
