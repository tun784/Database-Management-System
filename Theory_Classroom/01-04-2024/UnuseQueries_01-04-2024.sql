	FOREIGN KEY(MALOP) REFERENCES LOP(MALOP),
	constraint PK_MONHOC primary key(MaMH)
	foreign key (MaMH) references MONHOC(MaMH),
	constraint FK_KETQUA_MONHOC FOREIGN KEY (MaMH) REFERENCES MONHOC(MaMH)
	constraint PK_KETQUA PRIMARY KEY (MASV, MaMH),
	constraint FK_KETQUA_MONHOC FOREIGN KEY (MaMH) REFERENCES MONHOC(MaMH)
