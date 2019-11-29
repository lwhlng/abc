create database PRO1041_QLCT

USE PRO1041_QLCT
GO 

---Tao bang nguoi dung
IF Object_ID('NGUOIDUNG') is not null 
	drop table NGUOIDUNG 
GO 
create table NGUOIDUNG
(
	tennguoidung	nvarchar(50) not null,
	sotien			int		 null,
	constraint PK_NGUOIDUNG primary key (tennguoidung)
)

---Tao bang nguon tien 
IF Object_ID('NGUONTIEN') is not null 
	drop table NGUONTIEN 
GO 
create table NGUONTIEN
(
	tennguon	nvarchar(50) not null,
	loai		nvarchar(50) null,
	trangthai	nvarchar(50) null,
	constraint PK_NGUONTIEN primary key (tennguon)
)

---Tao bang thu chi 
IF Object_ID('THUCHI') is not null 
	drop table THUCHI 
GO 
create table THUCHI
(
	id				int identity(1,1) not null,
	ten				nvarchar(50) null,
	sotien			int	null,
	ngay			date null,
	tennguon		nvarchar(50) null,
	ghichu			nvarchar(200) null,
	tennguoidung	nvarchar(50) null,
	constraint PK_THUCHI primary key (id),
	constraint FK_NGUONTIEN_THUCHI foreign key (tennguon) references NGUONTIEN,
	constraint FK_NGUOIDUNG_THUCHI foreign key (tennguoidung) references NGUOIDUNG
)

---Tao bang luc hu 
IF Object_ID('LUCHU') is not null 
	drop table LUCHU 
GO 
create table LUCHU
(
	tenhu	nvarchar(50) not null,
	sotien	int null,
	constraint PK_LUCHU primary key (tenhu)
)

-- Tạo người dùng mới
If OBJECT_ID('spTaoNguoiDung') is not null
drop proc spTaoNguoiDung
go
Create proc spTaoNguoiDung
@ten nvarchar(50),
@soTien int
as
begin
	Insert into NGUOIDUNG values(@ten, @soTien)
end

-- Load bảng người dùng
If OBJECT_ID('spLoadNguoiDung') is not null
drop proc spLoadNguoiDung
go
Create proc spLoadNguoiDung
as
begin
	Select * from NGUOIDUNG
end

-- Thêm nguồn tiền
If OBJECT_ID('spThemNguonTien') is not null
drop proc spThemNguonTien
go
Create proc spThemNguonTien
@tenNguon nvarchar(50),
@loai	  nvarchar(50)
as
begin
	Insert into NGUONTIEN values(@tenNguon,@loai)
end

-- Xóa nguồn tiền
If OBJECT_ID('spXoaNguonTien') is not null
drop proc spXoaNguonTien
go
Create proc spXoaNguonTien
@tenNguon nvarchar(50)
as
begin
	Update NGUONTIEN set trangthai = 'Xoa' where tennguon like @tenNguon
end	

--Thêm thu chi
If OBJECT_ID('spThemThuChi') is not null
drop proc spThemThuChi
go
Create proc spThemThuChi
@ten			nvarchar(50),
@sotien			int,
@ngay			date ,
@tennguon		nvarchar(50),
@tennguoidung	nvarchar(50)
as
begin
	Insert into THUCHI values(@ten, @sotien, @ngay, @tennguon, @tennguoidung)
end	

--Xóa thu chi
If OBJECT_ID('spXoaThuChi') is not null
drop proc spXoaThuChi
go
Create proc spXoaThuChi
@ten			nvarchar(50),
@sotien			int,
@ngay			date ,
@tennguon		nvarchar(50),
@tennguoidung	nvarchar(50)
as
begin
	Insert into THUCHI values(@ten, @sotien, @ngay, @tennguon, @tennguoidung)
end	
