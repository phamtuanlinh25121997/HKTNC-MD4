create database QLSVNC;
use QLSVNC;

create table dmkhoa(
MaKhoa varchar(20) primary key,
TenKhoa varchar(255)
);

create table dmnganh(
MaNganh int primary key ,
TenNganh varchar(255),
MaKhoa varchar(20),
foreign key (MaKhoa) references dmkhoa(MaKhoa)
);
 
 create table dmlop(
 MaLop varchar(20) primary key,
 TenLop varchar(255),
 MaNganh int ,
 KhoaHoc int ,
 HeDT varchar(255),
 NamNhapHoc int,
 foreign key (MaNganh) references dmnganh(MaNganh)
 );
 
 create table dmhocphan(
 MaHP int primary key,
 TenHP varchar(255),
 Sodvht int,
 MaNganh int,
 HocKy int ,
 foreign key (MaNganh) references dmnganh(MaNganh)
 );
 
 create table  sinhvien(
 MaSV int primary key,
 HoTen varchar(255),
 MaLop varchar(20) ,
 GioiTinh tinyint(1),
 NgaySinh date,
 DiaChi varchar(255),
 foreign key (MaLop) references dmlop(MaLop)
 );
 
 create table  diemhp(
 MaSV int,
 MaHP int,
 DiemHP float,
 foreign key (MaSV) references sinhvien(MaSV),
 foreign key (MaHP) references dmhocphan(MaHP),
 primary key(MaSV,MaHP)
 );
 
 insert into dmkhoa() 
 values
 ('CNTT','Công nghệ thông tin'),
 ('KT','Kế Toán'),
 ('SP','Sư phạm');
 
 insert into dmnganh()
 values
 ('140902','Sư phạm toán tin','SP'),
 ('480202','Tin học ứng dụng','CNTT');
 
 insert into dmlop()
 values
 ('CT11','Cao đẳng tin học',480202,11,'TC',2013),
 ('CT12','Cao đẳng tin học',480202,12,'TC',2013),
 ('CT13','Cao đẳng tin học',480202,13,'TC',2014);
 
 insert into dmhocphan()
 values
 (1,'Toán cao câp A1',4,480202,1),
 (2,'Tiếng anh1',3,480202,1),
 (3,'Vật lý đại cương',4,480202,1),
 (4,'Tiếng anh 2',7,480202,1),
 (5,'Tiếng anh 1',3,140902,2),
 (6,'Xác xuất thống kê',3,480202,2);
 
 insert into sinhvien()
 values
 (1,'Phan Thanh','CT12','0','1990-09-12','Tuy Phước'),
 (2,'Nguyễn Thị Cấm','CT12','1','1994-01-12','Quy Nhơn'),
 (3,'Võ THị Hà','CT12','1','1995-07-02','An Nhơn'),
 (4,'Trần Hoài Nam','CT12','0','1994-04-05','Tây Sơn'),
 (5,'Trần Văn Hoàng','CT13','0','1995-08-04','Vĩnh Thạnh'),
 (6,'Đặng Thị Thảo','CT13','1','1995-06-12','Quy Nhơn'),
 (7,'Lê Thị Sen','CT13','1','1994-08-12','Phù Mỹ'),
 (8,'Nguyễn Văn Huy','CT11','0','1995-06-04','Tuy Phước'),
 (9,'Trần THị Hoa','CT11','1','1994-05-09','Hoài Nhơn');
 
 insert into diemhp()
 values
 (2,2,5.9),
 (2,3,4.5),
 (3,1,4.3),
 (3,2,6.7),
 (3,3,7.3),
 (4,1,4),
 (4,2,5.2),
 (4,3,3.5),
 (5,1,9.8),
 (5,2,7.9),
 (5,3,7.5),
 (6,1,6.1),
 (6,2,5.6),
 (6,3,5.4),
 (2,1,6.2);
 

 

 
--  1.	 Cho biết họ tên sinh viên KHÔNG học học phần nào (5đ)
select MaSV, HoTen from sinhvien
where MaSV not in (select distinct MaSV from diemhp);


--  2.	Cho biết họ tên sinh viên CHƯA học học phần nào có mã 1 (5đ)
select MaSV, HoTen
from sinhvien
where MaSV not in (select MaSV from diemhp where MaHP = 1);


--  3.	Cho biết Tên học phần KHÔNG có sinh viên điểm HP <5. (5đ)
select MaHP,TenHP
from dmhocphan
where MaHP not in (select MaHP from diemhp where MaHP < 5 );


--  4.	Cho biết Họ tên sinh viên KHÔNG có học phần điểm HP<5 (5đ)
select MaSV,HoTen 
from sinhvien
where MaSV not in ( select MaSV from diemhp where diemhp <5);


--  5.	Cho biết Tên lớp có sinh viên tên Hoa (5đ)
select TenLop
from dmlop
where MaLop in (select MaLop from sinhvien where HoTen like '%Hoa%');


--  6.	Cho biết HoTen sinh viên có điểm học phần 1 là <5.
select HoTen
from sinhvien
where MaSV in (select MaSV from diemhp where MaHP = 1 and DiemHP <5 );

--  7.	Cho biết danh sách các học phần có số đơn vị học trình lớn hơn hoặc bằng số đơn vị
--  học trình của học phần mã 1.
select MaHP,TenHP,Sodvht,MaNganh,HocKy
from dmhocphan
where Sodvht >=  (SELECT Sodvht FROM dmhocphan WHERE MaHP = 1);


--  8.	Cho biết HoTen sinh viên có DiemHP cao nhất. (ALL)
select sv.MaSV,sv.HoTen,dhp.MaHP,dhp.DiemHP
from sinhvien sv join diemhp dhp on sv.Masv = dhp.Masv
where sv.MaSV = (select dhp.MaSV from diemhp dhp order by dhp.DiemHP desc limit 1);


--  9.	Cho biết MaSV, HoTen sinh viên có điểm học phần mã 1 cao nhất. (ALL)
select MaSV,HoTen
from sinhvien 
where MaSV = ( select MaSV from diemhp where MaHP = 1 order by DiemHP desc limit 1);

--  10.	Cho biết MaSV, MaHP có điểm HP lớn hơn bất kì các điểm HP của sinh viên mã 3 
select MaSV,MaHP
from diemhp
where DiemHP > any (select DiemHP from diemhp where MaSV = 3 );


--  11.	Cho biết MaSV, HoTen sinh viên ít nhất một lần học học phần nào đó. (EXISTS)
select MaSV, HoTen
from sinhvien sv
where exists (
    select 1
	from diemhp dhp
    where sv.MaSV = dhp.MaSV
);


--  12.	Cho biết MaSV, HoTen sinh viên đã không học học phần nào. (EXISTS)
select MaSV, HoTen
from sinhvien sv
where not exists (
	select 1
    from diemhp dhp
    where sv.MaSV =  dhp.MaSV
);

--  13.	Cho biết MaSV đã học ít nhất một trong hai học phần có mã 1, 2. 
select MaSV
from sinhvien sv
where exists (
select 1
from diemhp dhp
where sv.MaSV =  dhp.MaSV and dhp.MaHP in (1,2)
);



--  14.	Tạo thủ tục có tên KIEM_TRA_LOP cho biết HoTen sinh viên KHÔNG có điểm HP <5 ở 
--  lớp có mã chỉ định (tức là tham số truyền vào procedure là mã lớp). Phải kiểm tra MaLop 
--  chỉ định có trong danh mục hay không, nếu không thì hiển thị thông báo ‘Lớp này không 
--  có trong danh mục’. Khi lớp tồn tại thì đưa ra kết quả.
--  Ví dụ gọi thủ tục: Call KIEM_TRA_LOP(‘CT12’).
delimiter //
create procedure KIEM_TRA_LOP  ()
begin
select * from 

end
// delimiter ;

--  15.	Tạo một trigger để kiểm tra tính hợp lệ của dữ liệu nhập vào bảng sinhvien là MaSV 
--  không được rỗng  Nếu rỗng hiển thị thông báo ‘Mã sinh viên phải được nhập’.

--  16.	Tạo một TRIGGER khi thêm một sinh viên trong bảng sinhvien ở một lớp nào đó thì cột 
--  SiSo của lớp đó trong bảng dmlop (các bạn tạo thêm một cột SiSo trong bảng dmlop) tự động 
--  tăng lên 1, đảm bảo tính toàn vẹn dữ liệu khi thêm một sinh viên mới trong bảng sinhvien thì
--  sinh viên đó phải có mã lớp trong bảng dmlop. Đảm bảo tính toàn vẹn dữ liệu khi thêm là mã 
--  lớp phải có trong bảng dmlop.

-- 17.	Viết một function DOC_DIEM đọc điểm chữ số thập phân thành chữ  Sau đó ứng dụng để lấy 
-- ra MaSV, HoTen, MaHP, DiemHP, DOC_DIEM(DiemHP) để đọc điểm HP của sinh viên đó thành chữ

-- 18.	Tạo thủ tục: HIEN_THI_DIEM Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, MaHP của 
-- những sinh viên có DiemHP nhỏ hơn số chỉ định, nếu không có thì hiển thị thông báo không có 
-- sinh viên nào.
-- VD: Call HIEN_THI_DIEM(5);

-- 19.	Tạo thủ tục: HIEN_THI_MAHP hiển thị HoTen sinh viên CHƯA học học phần có mã chỉ định. 
-- Kiểm tra mã học phần chỉ định có trong danh mục không. Nếu không có thì hiển thị thông báo 
-- không có học phần này.
-- Vd: Call HIEN_THI_MAHP(1);

-- 20.	Tạo thủ tục: HIEN_THI_TUOI  Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh, 
-- GioiTinh, Tuoi của sinh viên có tuổi trong khoảng chỉ định. Nếu không có thì hiển thị 
-- không có sinh viên nào.
-- VD: Call HIEN_THI_TUOI (20,30);

 
 
 
 
 
 