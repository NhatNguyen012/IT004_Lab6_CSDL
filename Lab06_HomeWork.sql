----------HomeWork buổi số 5----------
USE Lab1HomeWORK;
GO
-- Tạo bảng Chuyên gia
CREATE TABLE ChuyenGia (
    MaChuyenGia INT PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    Email NVARCHAR(100),
    SoDienThoai NVARCHAR(20),
    ChuyenNganh NVARCHAR(50),
    NamKinhNghiem INT
);
GO

-- Tạo bảng Công ty
CREATE TABLE CongTy (
    MaCongTy INT PRIMARY KEY,
    TenCongTy NVARCHAR(100),
    DiaChi NVARCHAR(200),
    LinhVuc NVARCHAR(50),
    SoNhanVien INT
);
GO

-- Tạo bảng Dự án
CREATE TABLE DuAn (
    MaDuAn INT PRIMARY KEY,
    TenDuAn NVARCHAR(200),
    MaCongTy INT,
    NgayBatDau DATE,
    NgayKetThuc DATE,
    TrangThai NVARCHAR(50),
    FOREIGN KEY (MaCongTy) REFERENCES CongTy(MaCongTy)
);
GO

-- Tạo bảng Kỹ năng
CREATE TABLE KyNang (
    MaKyNang INT PRIMARY KEY,
    TenKyNang NVARCHAR(100),
    LoaiKyNang NVARCHAR(50)
);
GO

-- Tạo bảng Chuyên gia - Kỹ năng
CREATE TABLE ChuyenGia_KyNang (
    MaChuyenGia INT,
    MaKyNang INT,
    CapDo INT,
    PRIMARY KEY (MaChuyenGia, MaKyNang),
    FOREIGN KEY (MaChuyenGia) REFERENCES ChuyenGia(MaChuyenGia),
    FOREIGN KEY (MaKyNang) REFERENCES KyNang(MaKyNang)
);
GO

-- Tạo bảng Chuyên gia - Dự án
CREATE TABLE ChuyenGia_DuAn (
    MaChuyenGia INT,
    MaDuAn INT,
    VaiTro NVARCHAR(50),
    NgayThamGia DATE,
    PRIMARY KEY (MaChuyenGia, MaDuAn),
    FOREIGN KEY (MaChuyenGia) REFERENCES ChuyenGia(MaChuyenGia),
    FOREIGN KEY (MaDuAn) REFERENCES DuAn(MaDuAn)
);
GO

-- Chèn dữ liệu mẫu vào bảng Chuyên gia
INSERT INTO ChuyenGia (MaChuyenGia, HoTen, NgaySinh, GioiTinh, Email, SoDienThoai, ChuyenNganh, NamKinhNghiem)
VALUES 
(1, N'Nguyễn Văn An', '1985-05-10', N'Nam', 'nguyenvanan@email.com', '0901234567', N'Phát triển phần mềm', 10),
(2, N'Trần Thị Bình', '1990-08-15', N'Nữ', 'tranthiminh@email.com', '0912345678', N'An ninh mạng', 7),
(3, N'Lê Hoàng Cường', '1988-03-20', N'Nam', 'lehoangcuong@email.com', '0923456789', N'Trí tuệ nhân tạo', 9),
(4, N'Phạm Thị Dung', '1992-11-25', N'Nữ', 'phamthidung@email.com', '0934567890', N'Khoa học dữ liệu', 6),
(5, N'Hoàng Văn Em', '1987-07-30', N'Nam', 'hoangvanem@email.com', '0945678901', N'Điện toán đám mây', 8),
(6, N'Ngô Thị Phượng', '1993-02-14', N'Nữ', 'ngothiphuong@email.com', '0956789012', N'Phân tích dữ liệu', 5),
(7, N'Đặng Văn Giang', '1986-09-05', N'Nam', 'dangvangiang@email.com', '0967890123', N'IoT', 11),
(8, N'Vũ Thị Hương', '1991-12-20', N'Nữ', 'vuthihuong@email.com', '0978901234', N'UX/UI Design', 7),
(9, N'Bùi Văn Inh', '1989-04-15', N'Nam', 'buivaninch@email.com', '0989012345', N'DevOps', 8),
(10, N'Lý Thị Khánh', '1994-06-30', N'Nữ', 'lythikhanh@email.com', '0990123456', N'Blockchain', 4);
GO

-- Chèn dữ liệu mẫu vào bảng Công ty
INSERT INTO CongTy (MaCongTy, TenCongTy, DiaChi, LinhVuc, SoNhanVien)
VALUES 
(1, N'TechViet Solutions', N'123 Đường Lê Lợi, TP.HCM', N'Phát triển phần mềm', 200),
(2, N'DataSmart Analytics', N'456 Đường Nguyễn Huệ, Hà Nội', N'Phân tích dữ liệu', 150),
(3, N'CloudNine Systems', N'789 Đường Trần Hưng Đạo, Đà Nẵng', N'Điện toán đám mây', 100),
(4, N'SecureNet Vietnam', N'101 Đường Võ Văn Tần, TP.HCM', N'An ninh mạng', 80),
(5, N'AI Innovate', N'202 Đường Lý Tự Trọng, Hà Nội', N'Trí tuệ nhân tạo', 120);
GO

-- Chèn dữ liệu mẫu vào bảng Dự án
INSERT INTO DuAn (MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai)
VALUES 
(1, N'Phát triển ứng dụng di động cho ngân hàng', 1, '2023-01-01', '2023-06-30', N'Hoàn thành'),
(2, N'Xây dựng hệ thống phân tích dữ liệu khách hàng', 2, '2023-03-15', '2023-09-15', N'Đang thực hiện'),
(3, N'Triển khai giải pháp đám mây cho doanh nghiệp', 3, '2023-02-01', '2023-08-31', N'Đang thực hiện'),
(4, N'Nâng cấp hệ thống bảo mật cho tập đoàn viễn thông', 4, '2023-04-01', '2023-10-31', N'Đang thực hiện'),
(5, N'Phát triển chatbot AI cho dịch vụ khách hàng', 5, '2023-05-01', '2023-11-30', N'Đang thực hiện');
GO

-- Chèn dữ liệu mẫu vào bảng Kỹ năng
INSERT INTO KyNang (MaKyNang, TenKyNang, LoaiKyNang)
VALUES 
(1, 'Java', N'Ngôn ngữ lập trình'),
(2, 'Python', N'Ngôn ngữ lập trình'),
(3, 'Machine Learning', N'Công nghệ'),
(4, 'AWS', N'Nền tảng đám mây'),
(5, 'Docker', N'Công cụ'),
(6, 'Kubernetes', N'Công cụ'),
(7, 'SQL', N'Cơ sở dữ liệu'),
(8, 'NoSQL', N'Cơ sở dữ liệu'),
(9, 'React', N'Framework'),
(10, 'Angular', N'Framework');
GO

-- Câu hỏi SQL từ cơ bản đến nâng cao, bao gồm trigger

-- Cơ bản:
--1. Liệt kê tất cả chuyên gia trong cơ sở dữ liệu.
SELECT * FROM CHUYENGIA
GO

--2. Hiển thị tên và email của các chuyên gia nữ.
SELECT HOTEN, EMAIL
FROM CHUYENGIA
WHERE GIOITINH = N'NỮ'
GO
--3. Liệt kê các công ty có trên 100 nhân viên.
SELECT * FROM CONGTY
WHERE SONHANVIEN > 100
GO
--4. Hiển thị tên và ngày bắt đầu của các dự án trong năm 2023.
SELECT TENDUAN, NGAYBATDAU
FROM DUAN
WHERE YEAR(NGAYKETTHUC) = 2023
GO

-- Trung cấp:
--6. Liệt kê tên chuyên gia và số lượng dự án họ tham gia.
SELECT CG.HOTEN, COUNT(CGDA.MADUAN) AS SOLUONGDUAN
FROM CHUYENGIA CG
LEFT JOIN CHUYENGIA_DUAN CGDA ON CG.MACHUYENGIA = CGDA.MACHUYENGIA
GROUP BY CG.HOTEN
GO

--7. Tìm các dự án có sự tham gia của chuyên gia có kỹ năng 'Python' cấp độ 4 trở lên.
SELECT CGDA.MADUAN, DA.TenDuAn
FROM CHUYENGIA_DUAN CGDA
INNER JOIN DUAN DA ON DA.MADUAN = CGDA.MADUAN
INNER JOIN CHUYENGIA_KYNANG CGKN ON CGKN.MACHUYENGIA = CGDA.MACHUYENGIA
INNER JOIN KYNANG KN ON KN.MAKYNANG = CGKN.MAKYNANG
WHERE KN.TENKYNANG = N'Python' AND CGKN.CAPDO >= 4
GROUP BY CGDA.MADUAN, DA.TenDuAn
GO

--8. Hiển thị tên công ty và số lượng dự án đang thực hiện.
SELECT CT.TenCongTy, COUNT(DA.MADUAN) AS SOLUONGDUAN
FROM CONGTY CT
INNER JOIN DUAN DA ON CT.MACONGTY = DA.MACONGTY
WHERE DA.TRANGTHAI = N'Đang thực hiện'
GROUP BY CT.TenCongTy
GO

--9. Tìm chuyên gia có số năm kinh nghiệm cao nhất trong mỗi chuyên ngành.
SELECT HOTEN, CHUYENNGANH, NAMKINHNGHIEM
FROM CHUYENGIA CG
WHERE NAMKINHNGHIEM = (
	SELECT MAX(NAMKINHNGHIEM)
	FROM CHUYENGIA
	WHERE CHUYENNGANH = CG.CHUYENNGANH);
Go


--10. Liệt kê các cặp chuyên gia đã từng làm việc cùng nhau trong ít nhất một dự án.
SELECT DISTINCT CG1.MaChuyenGia, CG1.HOTEN AS CHUYENGIA1, CG2.MaChuyenGia, CG2.HOTEN AS CHUYENGIA2
FROM CHUYENGIA_DUAN CGDA1
INNER JOIN CHUYENGIA_DUAN CGDA2 ON CGDA1.MADUAN = CGDA2.MADUAN
AND CGDA1.MACHUYENGIA < CGDA2.MACHUYENGIA
INNER JOIN CHUYENGIA CG1 ON CG1.MACHUYENGIA = CGDA1.MACHUYENGIA
INNER JOIN CHUYENGIA CG2 ON CG2.MACHUYENGIA = CGDA2.MACHUYENGIA
GO

-- Nâng cao:
--11. Tính tổng thời gian (theo ngày) mà mỗi chuyên gia đã tham gia vào các dự án.
SELECT CG.HOTEN, SUM(DATEDIFF(DAY,CGDA.NGAYTHAMGIA,DA.NGAYKETTHUC)) AS TONGTHOIGIAN
FROM CHUYENGIA_DUAN CGDA
INNER JOIN DUAN DA ON DA.MADUAN = CGDA.MADUAN
INNER JOIN CHUYENGIA CG ON CG.MACHUYENGIA = CGDA.MACHUYENGIA
WHERE DA.NGAYKETTHUC >= CGDA.NGAYTHAMGIA
GROUP BY CG.HOTEN
GO

-- 12 Tìm các công ty có tỷ lệ dự án hoàn thành cao nhất (trên 90%)
SELECT CT.TenCongTy, CAST(COUNT(CASE WHEN DA.TrangThai = N'Hoàn thành' THEN 1 END) AS FLOAT) / COUNT(*) * 100 AS TiLeHoanThanh
FROM CONGTY CT
JOIN DUAN DA ON CT.MaCongTy = DA.MaCongTy
GROUP BY CT.TenCongTy
HAVING CAST(COUNT(CASE WHEN DA.TrangThai = N'Hoàn thành' THEN 1 END) AS FLOAT) / COUNT(*) * 100 > 90
ORDER BY TiLeHoanThanh DESC;
GO

--13. Liệt kê top 3 kỹ năng được yêu cầu nhiều nhất trong các dự án.
SELECT TOP 3 WITH TIES
KN.TENKYNANG, COUNT(CGKN.MAKYNANG) AS SOLANYEUCAU
FROM KYNANG KN
INNER JOIN CHUYENGIA_KYNANG CGKN ON KN.MAKYNANG = CGKN.MAKYNANG
GROUP BY KN.TENKYNANG
ORDER BY COUNT(CGKN.MAKYNANG) DESC
GO

--14. Tính lương trung bình của chuyên gia theo từng cấp độ kinh nghiệm (Junior: 0-2 năm, Middle: 3-5 năm, Senior: >5 năm).
SELECT 
    CASE 
        WHEN NamKinhNghiem <= 2 THEN 'Junior'
        WHEN NamKinhNghiem <= 5 THEN 'Middle'
        ELSE 'Senior'
    END AS CapDo,
    AVG(Luong) AS LuongTrungBinh
FROM ChuyenGia
GROUP BY 
    CASE 
        WHEN NamKinhNghiem <= 2 THEN 'Junior'
        WHEN NamKinhNghiem <= 5 THEN 'Middle'
        ELSE 'Senior'
    END;

--15. Tìm các dự án có sự tham gia của chuyên gia từ tất cả các chuyên ngành.
SELECT DA.TenDuAn
FROM DUAN DA
INNER JOIN ChuyenGia_DuAn CGDA ON DA.MaDuAn = CGDA.MaDuAn
INNER JOIN ChuyenGia CG ON CGDA.MaChuyenGia = CG.MaChuyenGia
GROUP BY DA.TenDuAn, DA.MaDuAn
HAVING COUNT(DISTINCT CG.ChuyenNganh) = (SELECT COUNT(DISTINCT ChuyenNganh) FROM ChuyenGia);
GO

-- Trigger:
--16. Tạo một trigger để tự động cập nhật số lượng dự án của công ty khi thêm hoặc xóa dự án.
CREATE TRIGGER trg_CapNhatSoDuAnCongTy
ON DuAn
AFTER INSERT, DELETE
AS
BEGIN
    UPDATE CongTy
    SET SoDuAn = SoDuAn + 1
    FROM CongTy
    INNER JOIN inserted ON CongTy.MaCongTy = inserted.MaCongTy;

    UPDATE CongTy
    SET SoDuAn = SoDuAn - 1
    FROM CongTy
    INNER JOIN deleted ON CongTy.MaCongTy = deleted.MaCongTy;
END;

--17. Tạo một trigger để ghi log mỗi khi có sự thay đổi trong bảng ChuyenGia.
CREATE TABLE ChuyenGiaLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    MaChuyenGia INT,
    HanhDong NVARCHAR(10),
    NgayThayDoi DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_LogChuyenGia
ON ChuyenGia
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @HanhDong NVARCHAR(10);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @HanhDong = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @HanhDong = 'INSERT';
    ELSE
        SET @HanhDong = 'DELETE';
    
    INSERT INTO ChuyenGiaLog (MaChuyenGia, HanhDong)
    SELECT MaChuyenGia, @HanhDong
    FROM inserted
    UNION ALL
    SELECT MaChuyenGia, @HanhDong
    FROM deleted;
END;

--18. Tạo một trigger để đảm bảo rằng một chuyên gia không thể tham gia vào quá 5 dự án cùng một lúc.
CREATE TRIGGER trg_GioiHanDuAn
ON ChuyenGia_DuAn
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT MaChuyenGia
        FROM ChuyenGia_DuAn
        GROUP BY MaChuyenGia
        HAVING COUNT(DISTINCT MaDuAn) > 5
    )
    BEGIN
        RAISERROR ('Một chuyên gia không thể tham gia vào quá 5 dự án cùng một lúc.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

--19. Tạo một trigger để tự động cập nhật trạng thái của dự án thành 'Hoàn thành' khi tất cả chuyên gia đã kết thúc công việc.
CREATE TRIGGER trg_CapNhatTrangThaiDuAn
ON ChuyenGia_DuAn
AFTER UPDATE
AS
BEGIN
    UPDATE DuAn
    SET TrangThai = N'Hoàn thành'
    WHERE MaDuAn IN (
        SELECT MaDuAn
        FROM ChuyenGia_DuAn
        GROUP BY MaDuAn
        HAVING COUNT(*) = SUM(CASE WHEN NgayKetThuc IS NOT NULL THEN 1 ELSE 0 END)
    )
    AND TrangThai != N'Hoàn thành';
END;

--20. Tạo một trigger để tự động tính toán và cập nhật điểm đánh giá trung bình của công ty dựa trên điểm đánh giá của các dự án.
CREATE TRIGGER trg_CapNhatDiemDanhGiaCongTy
ON DuAn
AFTER UPDATE
AS
BEGIN
    IF UPDATE(DiemDanhGia)
    BEGIN
        UPDATE CongTy
        SET DiemDanhGia = (
            SELECT AVG(DiemDanhGia)
            FROM DuAn
            WHERE MaCongTy = CongTy.MaCongTy AND DiemDanhGia IS NOT NULL
        )
        FROM CongTy
        INNER JOIN inserted ON CongTy.MaCongTy = inserted.MaCongTy;
    END
END;