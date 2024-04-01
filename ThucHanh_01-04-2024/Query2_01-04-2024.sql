create table MONHOC(
	MaMH nchar(10) not null primary key,
	TenMH nvarchar(20),
	SoTC int
)
create table KETQUA(
	MaSV nchar(10) not null,
	MaMH nchar(10) not null,
	Diem float,
	constraint PK_KETQUA PRIMARY KEY (MASV, MaMH),
	foreign key (MaMH) references MONHOC(MaMH),
	foreign key (MaSV) references SINHVIEN(MaSV)
)