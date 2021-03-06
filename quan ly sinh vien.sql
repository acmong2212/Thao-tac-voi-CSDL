CREATE DATABASE QuanLySinhVien;

CREATE TABLE Class(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);

insert into Class
values (1, "A1", "2008-12-20", 1);
insert into Class
values (2, 'A2', '2008-12-22', 1);
insert into Class
values (3, "B3", current_date, 0);

CREATE TABLE Student(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);

insert into Student (StudentName, Address, Phone, Status, ClassId)
values ("Hung", "Ha Noi", 0912113113, 1, 1);
insert into Student(StudentName, Address, Status, ClassId)
values ("Hoa", "Hai Phong", 1, 1);
insert into Student (StudentName, Address, Phone, Status, ClassId)
values ("Manh", "HCM", 0123123123, 0, 2);

CREATE TABLE Subject(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);

insert into Subject (SubName, Credit, Status)
values ("CF", 5, 1);
insert into Subject (SubName, Credit, Status)
values ("C", 6, 1);
insert into Subject (SubName, Credit, Status)
values ("HDJ", 5, 1);
insert into Subject (SubName, Credit, Status)
values ("RDBMS", 10, 1);

CREATE TABLE Mark(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

insert into Mark(SubId, StudentId, Mark, ExamTimes)
values (1,1,8,1);
insert into Mark(SubId, StudentId, Mark, ExamTimes)
values (1,2,10,2);
insert into Mark(SubId, StudentId, Mark, ExamTimes)
values (2,1,12,1);

-- Hi???n th??? t???t c??? c??c sinh vi??n c?? t??n b???t ?????u b???ng k?? t??? ???h???
select * from student
where StudentName like "h%";

-- Hi???n th??? c??c th??ng tin l???p h???c c?? th???i gian b???t ?????u v??o th??ng 12.
select * from class
where StartDate between "2008-12-01 00:00:00" and "2021-12-31 23:59:59";

-- Hi???n th??? t???t c??? c??c th??ng tin m??n h???c c?? credit trong kho???ng t??? 3-5.
select * from subject
where Credit >= 3 and Credit <= 5;

-- Thay ?????i m?? l???p(ClassID) c???a sinh vi??n c?? t??n ???Hung??? l?? 2.
update student
set classId = 2
where studentId = 1;

-- Hi???n th??? c??c th??ng tin: StudentName, SubName, Mark. D??? li???u s???p x???p theo ??i???m thi (mark) gi???m d???n. n???u tr??ng s???p theo t??n t??ng d???n.
select StudentName, SubName, Mark from mark
join student on mark.StudentId = student.StudentId join subject on mark.SubId = subject.SubId
order by mark desc
limit 3;