CREATE DATABASE QUANLYBANHANG;

CREATE TABLE KHACHHANG (
    MaKH NVARCHAR(6) primary key ,
    TenKH NVARCHAR(30) NOT NULL,
    DiaChi NVARCHAR(30) not NULL,
    DienThoai NVARCHAR(12) NOT NULL,
    Email NVARCHAR(40) ,
    LoaiKH NVARCHAR(3) CONSTRAINT CHECK_LOAIKH CHECK(LoaiKH IN ('VIP','TV'))
)

CREATE TABLE HOADON (
    MaHD NVARCHAR(5) PRIMARY KEY,
    MaKH NVARCHAR(6) CONSTRAINT PK_HOADON_KHACHHANG FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
    NgayLapHD DATE
)

CREATE TABLE HANGHOA(
    MaH NVARCHAR(5) PRIMARY KEY,
    TenH NVARCHAR(40) NOT NULL,
    DonViTinh NVARCHAR(4) NOT NULL,
    DonGia NVARCHAR(7) not NULL
);

CREATE TABLE CHITIETHD(
    MaHD NVARCHAR(5) CONSTRAINT PK_CHITIETHD_HOADON FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
    MaH NVARCHAR(5) CONSTRAINT PK_CHITIETHD_HANGHOA FOREIGN KEY (MaH)  REFERENCES HANGHOA(MaH),
    SoLuong INT NOT NULL,
    CONSTRAINT key_chitiethd PRIMARY KEY (MaHD,MaH)
);

 ALTER TABLE KHACHHANG
 ADD NgaySinh NVARCHAR(8)

 ALTER TABLE KHACHHANG
 ADD GioiTinh NVARCHAR(3) CONSTRAINT CHECK_GioiTinh CHECK(GioiTinh IN ('1','0'))
INSERT INTO KHACHHANG (MaKH,TenKH,DiaChi,DienThoai,Email,LoaiKH) values 
('KH001',N'Nguyễn Thị Mai Chi',N'Quy Nhơn','09762334445','MaiChi@gmail.com','VIP'),
('KH002',N'Phan Thị Thanh',N'Quy Nhơn','098766555555','NULL','TV'),
('KH003',N'Trần Văn Toàn',N'Tuy Phước','9876655567','ToanVan@gmail.com','TV'),
('KH004',N'Trần Văn ẤN',N'Quy Nhơn','98765545878','NULL','VIP')

INSERT INTO HANGHOA (MaH,TenH,DonViTinh,DonGia) VALUES ('H001',N'Sữa đắc ông thọ','lon','23000'),
('H002',N'Kẹo dẻo Hồng  Hà','gói','80000'),
('H003',N'Bánh xốp Quy Kinh đô','hộp','120000'),
('H004',N'Bánh quy LuXy','Hộp','150000'),
('H005',N'Đường trắng Quy Hà','gói','20000'),
('H006',N'Bánh LuXY Sài Gòn','Hộp','100000'),
('H007',N'Sữa tươi TH TrueMilk','lốc','30000')


INSERT INTO HOADON (MaHD,MaKH,NgayLapHD) VALUES ('001','KH001','2018/02/01'),
('002','KH001','2018/03/02'),
('003','KH002','2018/02/01'),
('004','KH002','2018/03/01'),
('005','KH003','2018/03/02'),
('006','KH004','2018/05/02'),
('007','KH003','2018/05/03'),
('008','KH003','2018/05/04')


INSERT INTO CHITIETHD(MaHD,MaH,SoLuong) VALUES ('001','H001','1'),
('001','H002','3'),
('002','H003','12'),
('002','H004','2'),
('003','H001','7'),
('003','H004','5'),
('004','H001','12'),
('005','H003','20'),
('005','H005','19'),
('006','H007','20'),
('006','H003','45'),
('007','H002','60'),
('007','H007','35')


--- BÀI TẬP TỰ GIẢI ---
--- Bài số 1: ---

--- 1. Cho biết danh sách gồm MaKH, TenKH, NgaySinh, GioiTinh của khách hàng thành viên. --- 
SELECT MaKH , TenKH, CONVERT(VARCHAR(10),NgaySinh,103) AS NgaySinh,
CASE GioiTinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh FROM KHACHHANG

--- 2. Cho biết danh sách gồm MaKH, TenKH, NgaySinh, GioiTinh của khách hàng nữ ở Quy Nhơn. ---
SELECT MaKH, TenKH, CONVERT(VARCHAR(10),NgaySinh,103) AS NgaySinh,
CASE GioiTinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh from KHACHHANG WHERE DiaChi=N'Quy Nhơn' AND GioiTinh= 0;

---3. Cho biết danh sách gồm MaKH, TenKH, NgaySinh, GioiTinh của khách hàng VIP ở Quy Nhơn hoặc Tuy Phước.---
SELECT MaKH , TenKH,CONVERT(VARCHAR(10),NgaySinh,103) AS NgaySinh,
CASE GioiTinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh
 FROM KHACHHANG WHERE LoaiKH='VIP' AND (DiaChi=N'Quy Nhơn' OR DiaChi=N'Tuy Phước')

---4. Cho biết số lượng hoá đơn xuất vào tháng 8.---
SELECT COUNT(*) AS SoLuongHoaDonT8 FROM HOADON WHERE MONTH(NgayLapHD) ='2';

---5. Cho biết danh sách các mặt hàng có giá bán từ 20 nghìn đến 50 nghìn.---
SELECT * FROM HANGHOA WHERE DonGia BETWEEN 20000 AND 50000

---6. Cho biết MaHD, MaH, SoLuong có số lượng bán >10.---
SELECT * FROM CHITIETHD WHERE SoLuong > 10


--- Kết nối 2 hay nhiều bảng ---

---7. Cho biết MaHD, MaH, TenH, DonGia, SoLuong, ThanhTien của hoá đơn 001.---
SELECT MaHD , HH.MaH , TenH , DonGia , SoLuong , (DonGia*SoLuong) AS ThanhTien 
FROM HANGHOA AS HH INNER JOIN CHITIETHD AS CTHD ON HH.MaH = CTHD.MaH
WHERE MaHD = '001'

---8. Cho biết MaHD, MaH, TenH, DonGia, SoLuong, ThanhTien có Thành tiền từ 1 triệu đến 2 triệu.---
SELECT MaHD , HH.MaH , TenH , DonGia , SoLuong , (DonGia*SoLuong) AS ThanhTien 
FROM HANGHOA AS HH INNER JOIN CHITIETHD AS CTHD ON HH.MaH = CTHD.MaH
WHERE DonGia*SoLuong BETWEEN 1000000 AND 2000000

---9. Cho biết thông tin khách hàng không mua hàng vào tháng 6.---
SELECT DISTINCT KH.MaKH, TenKH FROM KHACHHANG AS KH 
INNER JOIN HOADON AS HD ON KH.MaKH =  HD.MaKH
WHERE MONTH(NgayLapHD) <> 6

---10. Cho biết MaHD, NgayLapHD, MaHK, TenH, DonGia, SoLuong, ThanhTien bán vào tháng 6---
SELECT HD.MaHD,CONVERT(varchar(10),NgayLapHD,103) as NgayLapHD, HH.MaH , TenH , DonGia , SoLuong , DonGia*SoLuong AS ThanhTien 
FROM HOADON AS HD INNER JOIN CHITIETHD AS CTHD ON HD.MaHD = CTHD.MaHD
INNER JOIN HANGHOA AS HH ON HH.MaH = CTHD.MaH
WHERE MONTH(NgayLapHD) = 5

---11. Cho biết danh sách các mặt hàng đã bán được.---
SELECT DISTINCT HH.MaH , TenH , DonViTinh , DonGia FROM HANGHOA AS HH 
INNER JOIN CHITIETHD AS CTHD ON  HH.MaH = CTHD.MaH 


---BÀI TẬP TỰ GIẢI---
---1. Cho biết MaKH, TenKH, Tổng Thành tiền của từng khách hàng.---

SELECT KH.MaKH , TenKH ,SUM(SoLuong*DonGia) AS TongThanhTien FROM KHACHHANG AS KH
INNER JOIN HOADON AS HD ON HD.MaKH = KH.MaKH
INNER JOIN CHITIETHD AS CTHD ON CTHD.MaHD = HD.MaHD
INNER JOIN HANGHOA AS HH ON HH.MaH = CTHD.MaH
GROUP BY KH.MaKH , TenKH

---2. Cho biết MaKH, TenKH, Tổng Thành tiền của khách hàng VIP.---
SELECT KH.MaKH , TenKH ,SUM(SoLuong*DonGia) AS TongThanhTien FROM KHACHHANG AS KH
INNER JOIN HOADON AS HD ON HD.MaKH = KH.MaKH
INNER JOIN CHITIETHD AS CTHD ON CTHD.MaHD = HD.MaHD
INNER JOIN HANGHOA AS HH ON HH.MaH = CTHD.MaH
WHERE LoaiKH = 'Vip'
GROUP BY KH.MaKH , TenKH

---3. Cho biết MaKH, TenKH, Tổng Thành tiền của từng khách hàng có ---
---Tổng thành tiền mua được >=20 triệu.---
SELECT KH.MaKH , TenKH ,SUM(SoLuong*DonGia) AS TongThanhTien FROM KHACHHANG AS KH
INNER JOIN HOADON AS HD ON HD.MaKH = KH.MaKH
INNER JOIN CHITIETHD AS CTHD ON CTHD.MaHD = HD.MaHD
INNER JOIN HANGHOA AS HH ON HH.MaH = CTHD.MaH
GROUP BY KH.MaKH , TenKH
HAVING SUM(SoLuong*DonGia) >= 20000000

---4. Cho biết MaH, TenH, Tổng số lượng của từng mặt hàng---
SELECT HH.MaH , TenH , SUM(SoLuong) AS TongSoLuong FROM HANGHOA AS HH
INNER JOIN CHITIETHD AS CTHD ON HH.MaH = CTHD.MaH
GROUP BY HH.MaH , TenH

---5. Cho biết MaHD, Tổng thành tiền của những hoá đơn có tổng thành tiền lớn hơn 5 triệu.---
SELECT HD.MaHD ,SUM(SoLuong*DonGia) AS TongThanhTien FROM HOADON AS HD
INNER JOIN CHITIETHD AS CTHD ON CTHD.MaHD = HD.MaHD
INNER JOIN HANGHOA AS HH ON HH.MaH = CTHD.MaH
GROUP BY HD.MaHD
HAVING SUM(SoLuong*DonGia) > 5000000

---6. Cho biết hoá đơn bán ít nhất hai mặt hàng H001 và H002---
SELECT  HD.MaHD , MaKH, CONVERT(varchar(10),NgayLapHD,103) AS NgayLapHD  FROM HOADON AS HD
INNER JOIN CHITIETHD AS CTHD ON CTHD.MaHD = HD.MaHD
WHERE MaH IN ('H001','H002')
GROUP BY HD.MaHD, MaKH ,NgayLapHD
HAVING COUNT(MaH) >= 2

---7. Cho biết MaKH mua tất các các mặt hàng bánh.---
SELECT MaKH  FROM HOADON AS HD 
INNER JOIN CHITIETHD AS CTHD ON HD.MaHD = CTHD.MaHD
INNER JOIN HANGHOA AS HH ON HH.MaH = CTHD.MaH
WHERE TenH LIKE N'Bánh%'
GROUP BY MaKH
HAVING COUNT(HH.MaH) = (SELECT COUNT(MaH) FROM HANGHOA WHERE TenH LIKE N'Bánh%')

---8. Đếm số hoá đơn của mỗi khách hàng---
SELECT KH.MaKH , TenKH , COUNT(MaHD) AS SoHD FROM KHACHHANG AS KH
INNER JOIN HOADON AS HD ON KH.MaKH = HD.MaKH
GROUP by KH.MaKH , TenKH

---9. Cho biết Cho biết MaHD, Tổng thành tiền, Khuyến mãi 5% cho---
---những hoá đơn có tổng thành tiền lớn hơn 500 nghìn.---
SELECT MaHD , SUM(DonGia*SoLuong) AS TongThanhTien ,SUM(DonGia*SoLuong)*5/100 AS SoTienDuocKM 
FROM HANGHOA AS HH INNER JOIN CHITIETHD AS CTHD ON HH.MaH = CTHD.MaH
GROUP BY MaHD
HAVING SUM(DonGia*SoLuong) >500000

---10. Cho biết thông tin khách hàng VIP có tổng thành tiến trong năm 2018---
---nhỏ hơn 20 triệu.---
SELECT KH.MaKH, TenKH , CONVERT(varchar(10),NgaySinh ,103) AS NgaySinh,CASE GioiTinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh, 
DiaChi , DienThoai , Email , LoaiKH , SUM(DonGia*SoLuong) AS TongThanhTien FROM KHACHHANG AS KH
INNER JOIN HOADON AS HD ON HD.MaKH = KH.MaKH
INNER JOIN CHITIETHD AS CTHD ON CTHD.MaHD = HD.MaHD
INNER JOIN HANGHOA AS HH ON HH.MaH =  CTHD.MaH
WHERE YEAR(NgayLapHD) = 2018 AND LoaiKH ='Vip'
GROUP BY KH.MaKH, TenKH,NgaySinh,GioiTinh , DiaChi , DienThoai , Email , LoaiKH
HAVING  SUM(DonGia*SoLuong) <20000000

---11. Cho biết hoá đơn có tổng trị giá lớn nhất gồm các thông tin: Số hoá ---
---đơn, ngày bán, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.---
SELECT TOP 1 Hd.MaHD,CONVERT(varchar(10),NgayLapHD,103) AS NgayBan, TenKH , DiaChi , SUM(DonGia*SoLuong) AS TongGiaTri FROM KHACHHANG AS KH
INNER JOIN HOADON AS HD ON KH.MaKH = HD.MaKH
INNER JOIN CHITIETHD AS CTHD ON HD.MaHD = CTHD.MaHD
INNER JOIN HANGHOA AS HH ON HH.MaH =  CTHD.MaH
GROUP BY Hd.MaHD,NgayLapHD, TenKH , DiaChi
ORDER BY SUM(DonGia*SoLuong) DESC

---12. Cho biết hoá đơn có tổng trị giá lớn nhất trong tháng 5/2000 gồm các---
---thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị---
---giá của hoá đơn.---
SELECT TOP 1 Hd.MaHD,CONVERT(varchar(10),NgayLapHD,103) AS NgayBan, TenKH , DiaChi , SUM(DonGia*SoLuong) AS TongGiaTri FROM KHACHHANG AS KH
INNER JOIN HOADON AS HD ON KH.MaKH = HD.MaKH
INNER JOIN CHITIETHD AS CTHD ON HD.MaHD = CTHD.MaHD
INNER JOIN HANGHOA AS HH ON HH.MaH = CTHD.MaH
WHERE MONTH(NgayLapHD) = 5 AND YEAR(NgayLapHD)=2018
GROUP BY Hd.MaHD,NgayLapHD, TenKH , DiaChi
ORDER BY SUM(DonGia*SoLuong) DESC

---13. Cho biết hoá đơn có tổng trị giá nhỏ nhất gồm các thông tin: Số hoá---
---đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.---
SELECT TOP 1 Hd.MaHD,CONVERT(varchar(10),NgayLapHD,103) AS NgayBan, TenKH , DiaChi , SUM(DonGia*SoLuong) AS TongGiaTri FROM KHACHHANG AS KH
INNER JOIN HOADON AS HD ON KH.MaKH = HD.MaKH
INNER JOIN CHITIETHD AS CTHD ON HD.MaHD = CTHD.MaHD
INNER JOIN HANGHOA AS HH ON HH.MaH =  CTHD.MaH
GROUP BY Hd.MaHD,NgayLapHD, TenKH , DiaChi
ORDER BY SUM(DonGia*SoLuong) ASC

---14. Cho biết các thông tin của khách hàng có số lượng hoá đơn mua hàng nhiều nhất.---
SELECT TOP 1 KH.MaKH, TenKH , DiaChi , DienThoai , Email , LoaiKH , COUNT(MaHD) AS SOLUONGHOADON 
FROM KHACHHANG AS KH
INNER JOIN HOADON AS HD ON KH.MaKH = HD.MaKH
GROUP BY KH.MaKH, TenKH , DiaChi , DienThoai , Email , LoaiKH
ORDER BY COUNT(HD.MaHD) DESC

---15. Cho biết các thông tin của khách hàng có số lượng hàng mua nhiều nhất.---
SELECT TOP 1 KH.MaKH, TenKH , DiaChi , DienThoai , Email , LoaiKH , SUM(SoLuong) AS SOLUONGMUA 
FROM KHACHHANG AS KH
INNER JOIN HOADON AS HD ON KH.MaKH = HD.MaKH
INNER JOIN CHITIETHD AS CTHD ON HD.MaHD = CTHD.MaHD
GROUP BY KH.MaKH, TenKH , DiaChi , DienThoai , Email , LoaiKH
ORDER BY SUM(SoLuong) DESC

---16. Cho biết các thông tin về các mặt hàng mà được bán trong nhiều hoá đơn nhất.----
--TẠO  BẢNG CAU 16---
SELECT  HH.MaH , TenH, COUNT(hh.MaH)  AS solanXH 
into cau16
FROM HANGHOA AS HH 
INNER JOIN CHITIETHD AS CTHD ON HH.MaH = CTHD.MaH
GROUP BY HH.MaH , TenH

SELECT  HH.MaH , TenH, COUNT(hh.MaH)  AS solanXH 
FROM HANGHOA AS HH 
INNER JOIN CHITIETHD AS CTHD ON HH.MaH = CTHD.MaH
GROUP BY HH.MaH , TenH
HAVING COUNT(HH.MaH) = (SELECT max(solanxh) FROM cau16)

---17. Cho biết các thông tin về các mặt hàng mà được bán nhiều nhất---
SELECT HH.MaH , TenH, SUM(SoLuong) AS SOLUONGDABAN 
INTO CAU17
FROM HANGHOA AS HH 
INNER JOIN CHITIETHD AS CTHD ON HH.MaH = CTHD.MaH
GROUP BY HH.MaH , TenH

SELECT HH.MaH , TenH, SUM(SoLuong) AS SOLUONGDABAN 
FROM HANGHOA AS HH 
INNER JOIN CHITIETHD AS CTHD ON HH.MaH = CTHD.MaH
GROUP BY HH.MaH , TenH
HAVING SUM(SoLuong) = (SELECT max(SOLUONGDABAN) FROM CAU17)

---1. Cho biết MaH, TenH chưa được bán.---
SELECT MaH, TenH FROM HANGHOA 
WHERE MaH NOT IN (SELECT DISTINCT MaH FROM CHITIETHD)

---2. Cho biết thông tin khách hàng chưa mua hàng vào tháng 5---
SELECT * FROM KHACHHANG 
WHERE MaKH NOT IN (SELECT DISTINCT MaKH FROM HOADON WHERE MONTH(NgayLapHD)=5)

---3. Cho biết thông tin mặt hàng chưa được bán vào tháng 2.---
SELECT  MaH , TenH , DonViTinh, DonGia 
FROM HANGHOA
WHERE MaH NOT IN (SELECT DISTINCT MaH FROM CHITIETHD WHERE MaHD IN (SELECT DISTINCT MaHD FROM HOADON WHERE MONTH(NgayLapHD)=2)) 

---4. Cho biết TenKH có mua mặt hàng BÁNH---
SELECT TenKH FROM KHACHHANG 
WHERE MaKH IN 
(SELECT MaKH FROM HOADON WHERE MaHD IN (SELECT DISTINCT MaHD FROM CHITIETHD WHERE MaH IN (SELECT  MaH FROM HANGHOA WHERE TenH LIKE N'%BÁNH%')) )