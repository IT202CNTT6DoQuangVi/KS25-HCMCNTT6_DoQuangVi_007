CREATE DATABASE medical_exami_management;
USE medical_exami_management;

-- PHẦN 1 

-- PATIENTS
CREATE TABLE patients (
	patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(11) NOT NULL UNIQUE,
    gender VARCHAR(6) NOT NULL CHECK(gender IN('Male','Female')),
    date_of_birth DATE
);


-- DOCTORS
CREATE TABLE doctors(
	doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    specialty VARCHAR(10) NOT NULL,
    phone_number VARCHAR(11) NOT NULL UNIQUE,
    rating DECIMAL(2,1) DEFAULT(5.0) CHECK(rating BETWEEN 0.0 AND 5.0)
);


-- APPOINTMENTS
CREATE TABLE appointments(
	appointment_id VARCHAR(10) PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_time DATETIME NOT NULL,
    fee DECIMAL(10,2) CHECK(fee > 0),
    appointment_status VARCHAR(9) CHECK(  appointment_status IN ('Booked','Complete','Cancelled')) ,
	FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id)  REFERENCES doctors(doctor_id)
);


-- MEDICAL_RECORDS
CREATE TABLE medical_records(
	record_id VARCHAR(10) PRIMARY KEY,
    appointment_id VARCHAR(10),
    symptoms VARCHAR(300) NOT NULL,
    diagnosis VARCHAR(200) NOT NULL,
    prescription TEXT,
    record_date DATETIME DEFAULT(CURRENT_TIMESTAMP),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- VISIT LOG
CREATE TABLE visit_log(
	log_id INT AUTO_INCREMENT PRIMARY KEY,
    record_id VARCHAR(10),
    doctor_id INT,
    log_time DATETIME NOT NULL,
    note TEXT,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);


-- insert patients
INSERT INTO patients(full_name,phone_number,gender,date_of_birth)
VALUES('Nguyen Thi Lan','0901234567','Female','1999-03-12'),
	('Tran Van Minh','0902345678','Male','1996-11-25'),
    ('Le Hoai Phuong','0913456789','Female','2001-07-08'),
    ('Pham Duc Anh', '0984567890','Male','1998-01-19'),
    ('Hoang Ngoc Mai','0975678901','Female','2000-09-30');
    
-- insert doctors

INSERT INTO doctors(full_name,specialty,phone_number,rating)
VALUES('BS. Nguyen Van Hai','Noi','0931112223', 4.8 ),
	('BS. Tran Thu Ha','Nhi','0932223334',5),
    ('BS. Le Quoc Tuan','Ngoai','0933334445',4.6),
    ('BS. Pham Minh Chau','Da lieu','0934445556',4.9),
    ('BS. Hoang Gia Bao','Tim mach','0935556667',4.7);

-- insert appointments

INSERT INTO appointments
VALUES('7001',1,1,'2024-05-20 8:00',200000,'Booked'),
	('7002',2,2,'2024-05-20 9:30',250000,'Complete'),
    ('7003',3,3,'2024-05-20 10:15', 300000,'Booked'),
    ('7004',4,5,'2024-05-21 7:00',350000,'Complete'),
    ('7005',5,4,'2024-05-21 8:45',220000,'Cancelled');
    
    -- insert medical_records
    
    INSERT INTO medical_records
    VALUES('8001','7002','Sốt cao, ho','Viêm họng','Paracetamol + siro ho','2024-05-20 10:00'),
		('8002','7004','Đau ngực nhẹ','Theo dõi tim mạch','Vitamin + tái khám','2024-05-21 8:00'),
        ('8003','7001','Đau bụng','Rối loạn tiêu hóa','Men tiêu hóa','2024-05-20 9:00'),
        ('8004','7003','Đau vai gáy','Căng cơ','Giảm đau + nghỉ ngơi','2024-05-20 11:00'),
        ('8005','7005','Ngứa da','Dị ứng','Thuốc bôi ngoài da','2024-05-21 9:00');
		
        
-- insert visit log

INSERT INTO visit_log(record_id,doctor_id,log_time,note)
VALUES('8003',1,'2024-05-20 9:05','Đã khám lần đầu'),
	('8001',2,'2024-05-20 10:05','Hoàn tất khám'),
    ('8004',3,'2024-05-20 11:10','Tư vấn trị liệu'),
    ('8002',5,'2024-05-21 8:10','Hướng dẫn tái khám'),
    ('8005',4,'2024-05-21 9:05','Bệnh nhân hủy khám');
    
    
    -- Câu 2 phần 2:
    -- Tăng 10% phí khám cho phiếu hẹn có trạng thái commplete và bệnh nhân sinh < 2000
    -- xóa bản ghi trong visit log thỏa mãn logtime trước 20/05/2024
    
    UPDATE 