create database TEST on primary
(
	name= 'TEST_Primary',
	filename= 'E:\test\testPrimary.mdf',
	size=20MB,
	maxsize=100MB,
	filegrowth=10MB
)
log on
(
	name='TEST_Log',
	filename='E:\test\testLog.ldf',
	size=5MB,
	maxsize=15MB,
	filegrowth=5MB
);
go