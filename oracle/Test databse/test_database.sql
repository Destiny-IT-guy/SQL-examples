BEGIN
    FOR t IN (SELECT table_name FROM user_tables) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE "' || t.table_name || '" CASCADE CONSTRAINTS';
    END LOOP;
END;
/

-- 1. COUNTRY
CREATE TABLE Country (
    country_id   NUMBER(3)     NOT NULL PRIMARY KEY,
    country_name VARCHAR2(25)  NOT NULL
);

-- 2. LOCATION
CREATE TABLE Location (
    city_id    NUMBER(4)   NOT NULL PRIMARY KEY,
    city_name  VARCHAR2(30),
    country_id NUMBER(3)     NOT NULL,
    CONSTRAINT location_country_id_fk FOREIGN KEY (country_id)
        REFERENCES Country(country_id)
);

-- 3. DEPARTMENT
CREATE TABLE Department (
    dept_id          NUMBER(3)    NOT NULL PRIMARY KEY,
    dept_name        VARCHAR2(35) NOT NULL,
    dept_description VARCHAR2(50),
    city_id          NUMBER(4)  NOT NULL,
    CONSTRAINT department_city_id_fk FOREIGN KEY (city_id)
        REFERENCES Location(city_id)
);

-- 4. JOB
CREATE TABLE Job (
    job_id          NUMBER(4)     NOT NULL PRIMARY KEY,
    job_name        VARCHAR2(28),
    job_description VARCHAR2(60),
    min_salary      NUMBER(8,2),
    max_salary      NUMBER(8,2)
);

-- 5. PROJECT
CREATE TABLE Project (
    project_id          NUMBER(4)     NOT NULL PRIMARY KEY,
    project_name        VARCHAR2(25),
    project_description VARCHAR2(100),
    project_start_date  DATE           NOT NULL,
    project_end_date    DATE
);

-- 6. EMPLOYEE
CREATE TABLE Employee (
    employee_id     NUMBER(6)     NOT NULL PRIMARY KEY,
    first_name      VARCHAR2(18),
    last_name       VARCHAR2(18),
    dept_id         NUMBER(3)     NOT NULL,
    email_address   VARCHAR2(30),
    phone_number    number(11)  NOT NULL,
    starting_date   DATE          NOT NULL,
    end_date        DATE,
    salary NUMBER(8,2) NOT NULL,
    mgr_id          NUMBER(6),
    job_id          NUMBER(4)     NOT NULL,
    project_id number(4) not null,
    CONSTRAINT employee_job_id_fk FOREIGN KEY (job_id)
        REFERENCES Job(job_id),
    CONSTRAINT employee_mgr_fk FOREIGN KEY (mgr_id)
        REFERENCES Employee(employee_id),
    CONSTRAINT employee_dept_id_fk FOREIGN KEY (dept_id)
        REFERENCES Department(dept_id),
    CONSTRAINT employee_project_id_fk FOREIGN KEY (project_id)
        REFERENCES Project(project_id)
);



-- 7. DAILY ATTENDANCE
CREATE TABLE Daily_Attendance (
    attendance_id  NUMBER(8)     NOT NULL PRIMARY KEY,
    employee_id    NUMBER(6)     NOT NULL,
    work_date      DATE           NOT NULL,
    clock_in       TIMESTAMP,
    clock_out      TIMESTAMP,
    status         VARCHAR2(20),
    CONSTRAINT attendance_emp_fk FOREIGN KEY (employee_id)
        REFERENCES Employee(employee_id)
);

INSERT INTO Country (country_id, country_name) VALUES (1, 'Canada');
INSERT INTO Country (country_id, country_name) VALUES (2, 'United States');
INSERT INTO Country (country_id, country_name) VALUES (3, 'Russia');
INSERT INTO Country (country_id, country_name) VALUES (4, 'Germany');

INSERT INTO Location (city_id, city_name, country_id) Values (1, 'Montreal', 1);
INSERT INTO Location (city_id, city_name, country_id) Values (2, 'Toronto', 1);
INSERT INTO Location (city_id, city_name, country_id) Values (3, 'Quebec', 1);
INSERT INTO Location (city_id, city_name, country_id) Values (4, 'Los Angeles', 2);
INSERT INTO Location (city_id, city_name, country_id) Values (5, 'New York', 2);
INSERT INTO Location (city_id, city_name, country_id) Values (6, 'Miami', 2);
INSERT INTO Location (city_id, city_name, country_id) Values (7, 'Atlanta', 2);
INSERT INTO Location (city_id, city_name, country_id) Values (8, 'Moscow', 3);
INSERT INTO Location (city_id, city_name, country_id) Values (9, 'Kazan', 3);
INSERT INTO Location (city_id, city_name, country_id) Values (10, 'Munich', 4);
INSERT INTO Location (city_id, city_name, country_id) Values (11, 'Hamburg', 4);
        

SET DEFINE OFF;

INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (101, 'Human Resources - Montreal', '', 1);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (102, 'Human Resources - Toronto', NULL, 2);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (103, 'Human Resources - Quebec', NULL, 3);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (104, 'Human Resources - Los Angeles', NULL, 4);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (105, 'Human Resources - New York', NULL, 5);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (106, 'Human Resources - Miami', NULL, 6);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (107, 'Human Resources - Atlanta', NULL, 7);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (108, 'Human Resources - Moscow', NULL, 8);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (109, 'Human Resources - Kazan', NULL, 9);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (110, 'Human Resources - Munich', NULL, 10);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (111, 'Human Resources - Hamburg', NULL, 11);

-- Field Ops / Deployment
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (112, 'Field Ops - Montreal', NULL, 1);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (113, 'Field Ops - Toronto', NULL, 2);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (114, 'Field Ops - Quebec', NULL, 3);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (115, 'Field Ops - Los Angeles', NULL, 4);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (116, 'Field Ops - New York', NULL, 5);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (117, 'Field Ops - Miami', NULL, 6);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (118, 'Field Ops - Atlanta', NULL, 7);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (119, 'Field Ops - Moscow', NULL, 8);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (120, 'Field Ops - Kazan', NULL, 9);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (121, 'Field Ops - Munich', NULL, 10);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (122, 'Field Ops - Hamburg', NULL, 11);

-- Customer Support
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (123, 'Customer Support - Montreal', NULL, 1);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (124, 'Customer Support - Toronto', NULL, 2);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (125, 'Customer Support - Quebec', NULL, 3);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (126, 'Customer Support - Los Angeles', NULL, 4);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (127, 'Customer Support - New York', NULL, 5);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (128, 'Customer Support - Miami', NULL, 6);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (129, 'Customer Support - Atlanta', NULL, 7);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (130, 'Customer Support - Moscow', NULL, 8);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (131, 'Customer Support - Kazan', NULL, 9);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (132, 'Customer Support - Munich', NULL, 10);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (133, 'Customer Support - Hamburg', NULL, 11);

-- IT & Systems
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (134, 'IT & Systems - Montreal', NULL, 1);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (135, 'IT & Systems - Toronto', NULL, 2);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (136, 'IT & Systems - Quebec', NULL, 3);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (137, 'IT & Systems - Los Angeles', NULL, 4);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (138, 'IT & Systems - New York', NULL, 5);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (139, 'IT & Systems - Miami', NULL, 6);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (140, 'IT & Systems - Atlanta', NULL, 7);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (141, 'IT & Systems - Moscow', NULL, 8);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (142, 'IT & Systems - Kazan', NULL, 9);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (143, 'IT & Systems - Munich', NULL, 10);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (144, 'IT & Systems - Hamburg', NULL, 11);

-- Finance & Accounting
INSERT INTO DEPARTMENT (dept_id, dept_name, dept_description, city_id) VALUES (145, 'Finance & Accounting - Montreal', '', 1);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (146, 'Finance & Accounting - Toronto', NULL, 2);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (147, 'Finance & Accounting - Quebec', NULL, 3);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (148, 'Finance & Accounting - Los Angeles', NULL, 4);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (149, 'Finance & Accounting - New York', NULL, 5);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (150, 'Finance & Accounting - Miami', NULL, 6);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (151, 'Finance & Accounting - Atlanta', NULL, 7);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (152, 'Finance & Accounting - Moscow', NULL, 8);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (153, 'Finance & Accounting - Kazan', NULL, 9);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (154, 'Finance & Accounting - Munich', NULL, 10);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (155, 'Finance & Accounting - Hamburg', NULL, 11);

-- Network & Security
INSERT INTO DEPARTMENT (dept_id, dept_name, dept_description, city_id) VALUES (156, 'Network & Security - Montreal', '', 1);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (157, 'Network & Security - Toronto', NULL, 2);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (158, 'Network & Security - Los Angeles', NULL, 4);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (159, 'Network & Security - New York', NULL, 5);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (160, 'Network & Security - Moscow', NULL, 8);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (161, 'Network & Security - Munich', NULL, 10);

-- Software & R&D
INSERT INTO DEPARTMENT (dept_id, dept_name, dept_description, city_id) VALUES (162, 'Software & R&D - Montreal', '', 1);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (163, 'Software & R&D - Toronto', NULL, 2);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (164, 'Software & R&D - Los Angeles', NULL, 4);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (165, 'Software & R&D - New York', NULL, 5);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (166, 'Software & R&D - Moscow', NULL, 8);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (167, 'Software & R&D - Munich', NULL, 10);


-- Management
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (201, 'Management - Montreal', 'City general management', 1);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (202, 'Management - Toronto', 'City general management', 2);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (203, 'Management - Quebec', 'City general management', 3);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (204, 'Management - Los Angeles', 'City general management', 4);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (205, 'Management - New York', 'City general management', 5);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (206, 'Management - Miami', 'City general management', 6);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (207, 'Management - Atlanta', 'City general management', 7);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (208, 'Management - Moscow', 'City general management', 8);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (209, 'Management - Kazan', 'City general management', 9);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (210, 'Management - Munich', 'City general management', 10);
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (211, 'Management - Hamburg', 'City general management', 11);

-- executive officer
INSERT INTO Department (dept_id, dept_name, dept_description, city_id) VALUES (250, 'Executive Office - Toronto', 'Corporate executive leadership', 2);


-- Regular Staff Jobs
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (1, 'HR', 'Human Resources', 42000, 73500);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (2, 'Road Tech', 'Field Ops Technician', 36750, 63000);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (3, 'Fibre Optic Tech', 'Fiber Optic Deployment', 52500, 78750);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (4, 'Customer Support', 'Customer Support Staff', 36750, 52500);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (5, 'IT Support Level 1', 'Basic IT Support', 36750, 52500);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (6, 'IT Support Level 2', 'Intermediate IT Support', 47250, 68250);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (7, 'Electrical Engineer', 'Maintains Electrical Infrastructure', 63000, 99750);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (8, 'System Administrator', 'Manages Servers and Systems', 63000, 94500);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (9, 'Network Administrator', 'Network Admin', 68250, 94500);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (10, 'Accountant', 'Finance / Accounting', 52500, 84000);

-- Specialist / Senior Roles
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (11, 'Database Administrator', 'Maintains Databases', 63000, 99750);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (12, 'Security Analyst', 'Monitors Security', 63000, 94500);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (13, 'Network Architect', 'Designs Networks', 94500, 147000);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (14, 'Software Developer', 'Develops ISP Software', 73500, 126000);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (15, 'R&D Engineer', 'Research & Development', 73500, 126000);

-- Management Roles (Department Managers)
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (101, 'HR Manager', 'Manages HR Department', 94500, 157500);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (102, 'Field Ops Manager', 'Manages Field Ops', 94500, 157500);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (103, 'Customer Support Manager', 'Manages Customer Support', 89250, 147000);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (104, 'IT & Systems Manager', 'Manages IT & Systems', 99750, 157500);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (105, 'Finance Manager', 'Manages Finance Department', 94500, 157500);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (106, 'R&D Manager', 'Manages Research & Development Department', 100000, 165000);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (107, 'City Manager', 'Oversees operations and management of city-level activities', 100000, 168000);
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (108, 'Network & Security Manager', 'Manages network infrastructure and IT security operations', 98000, 165000);

-- Executive Role
INSERT INTO Job (job_id, job_name, job_description, min_salary, max_salary) VALUES (201, 'Executive Officer', 'Corporate Executive Leadership', 157500, 210000);

-- project

insert into project( project_id, project_name, project_description, project_start_date, project_end_date) 
Values ( 0, 'no project', null, TO_DATE('2022-03-14', 'YYYY-MM-DD'), null);


-- City Manager (dept 201, job_id 107)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (57, 'Julien', 'Lamarre', 201, 'julien.lamarre@itcorp.com', 5140001168, TO_DATE('2011-04-12','YYYY-MM-DD'), NULL, NULL, 107, 0, 165000.00);


Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (5, 'Renaud', 'Dubois', 201, 'renaud.dubois@itcorp.com', 5145001322, TO_DATE('2013-04-17', 'YYYY-MM-DD'), null, 57, 101, 0, 107800.52);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (1, 'Stephanie', 'Dupont', 101, 'stephanie.dupont@itcorp.com', 5142221234, TO_DATE('2022-03-14', 'YYYY-MM-DD'), null, 5, 1, 0, 58500.25);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (2, 'Veronique', 'Chantale', 101, 'veronique.chantale@itcorp.com', 5148211664, TO_DATE('2023-05-2', 'YYYY-MM-DD'), null, 5, 1, 0, 47800.25);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (3, 'Paul', 'Martin', 101, 'paul.martin@itcorp.com', 5142671804, TO_DATE('2020-01-15', 'YYYY-MM-DD'), null, 5, 1, 0, 64100.00);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (4, 'Cassandra', 'Verne', 101, 'cassandra.verne@itcorp.com', 5147001234, TO_DATE('2016-08-16', 'YYYY-MM-DD'), null, 5, 1, 0, 70500.25);

Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (15, 'Sarah', 'Sommert', 201, 'sarah.sommert@itcorp.com', 5140001120, TO_DATE('2012-11-16', 'YYYY-MM-DD'), null, 57, 102, 0, 130205.00);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (6, 'Bob', 'Ross', 112, 'bob.ross@itcorp.com', 5140001111, TO_DATE('2017-08-17', 'YYYY-MM-DD'), null, 15, 2, 0, 51000.73);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (7, 'Jeff', 'Birdy', 112, 'jeff.birdy@itcorp.com', 5140001112, TO_DATE('2021-01-17', 'YYYY-MM-DD'), null, 15, 2, 0, 43000.73);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (8, 'Rose', 'Lavergne', 112, 'rose.lavergne@itcorp.com', 5140001113, TO_DATE('2019-11-9', 'YYYY-MM-DD'), null, 15, 2, 0, 49000.00);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (9, 'Lion', 'Nord', 112, 'lion.nord@itcorp.com', 5140001114, TO_DATE('2016-01-12', 'YYYY-MM-DD'), null, 15, 2, 0, 62000.50);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (10, 'Mario', 'Spinoza', 112, 'mario.spinoza@itcorp.com', 5140001115, TO_DATE('2018-04-16', 'YYYY-MM-DD'), null, 15, 3, 0, 65700.00);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (11, 'Dugary', 'Joseph', 112, 'dugary.joseph@itcorp.com', 5140001116, TO_DATE('2021-05-15', 'YYYY-MM-DD'), null, 15, 3, 0, 58525.73);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (12, 'Jason', 'Bourne', 112, 'jason.bourne@itcorp.com', 5140001117, TO_DATE('2015-03-08', 'YYYY-MM-DD'), null, 15, 3, 0, 75600.80);

Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (16, 'Lemieux', 'Robert', 201, 'lemieux.robert@itcorp.com', 5140001121, TO_DATE('2015-07-21', 'YYYY-MM-DD'), null, 57, 102, 0, 12100.00);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (13, 'Carlos', 'Violon', 112, 'carlos.violon@itcorp.com', 5140001118, TO_DATE('2019-07-02', 'YYYY-MM-DD'), null, 16, 7, 0, 82800.75);
Insert into employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
Values (14, 'Michel', 'Legault', 112, 'michel.legault@itcorp.com', 5140001119, TO_DATE('2016-10-25', 'YYYY-MM-DD'), null, 16, 7, 0, 95500.00);



-- Customer Support Managers
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (17, 'Alice', 'Durand', 123, 'alice.durand@itcorp.com', 5140001122, TO_DATE('2015-06-01','YYYY-MM-DD'), NULL, 57, 103, 0, 95000.00); 
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (18, 'Marc', 'Beaulieu', 123, 'marc.beaulieu@itcorp.com', 5140001123, TO_DATE('2014-03-15','YYYY-MM-DD'), NULL, 57, 103, 0, 100500.00); 

-- 5 Customer Support Staff (job_id 4, mgr_id 17 or 18)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (19, 'Lucie', 'Petit', 123, 'lucie.petit@itcorp.com', 5140001124, TO_DATE('2019-01-10','YYYY-MM-DD'), NULL, 17, 4, 0, 40000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (20, 'Nicolas', 'Lemoine', 123, 'nicolas.lemoine@itcorp.com', 5140001125, TO_DATE('2018-05-22','YYYY-MM-DD'), NULL, 17, 4, 0, 42000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (21, 'Sophie', 'Marceau', 123, 'sophie.marceau@itcorp.com', 5140001126, TO_DATE('2020-11-03','YYYY-MM-DD'), NULL, 17, 4, 0, 39500.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (22, 'Antoine', 'Dubois', 123, 'antoine.dubois@itcorp.com', 5140001127, TO_DATE('2021-07-15','YYYY-MM-DD'), NULL, 18, 4, 0, 38000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (23, 'Claire', 'Moreau', 123, 'claire.moreau@itcorp.com', 5140001128, TO_DATE('2017-09-30','YYYY-MM-DD'), NULL, 18, 4, 0, 43000.00);

-- 4 IT Support Level 1 Staff (job_id 5, mgr_id 17)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (24, 'Julien', 'Rousseau', 123, 'julien.rousseau@itcorp.com', 5140001129, TO_DATE('2018-02-12','YYYY-MM-DD'), NULL, 17, 5, 0, 42000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (25, 'Emilie', 'Carpentier', 123, 'emilie.carpentier@itcorp.com', 5140001130, TO_DATE('2019-08-20','YYYY-MM-DD'), NULL, 17, 5, 0, 40000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (26, 'Thomas', 'Benoit', 123, 'thomas.benoit@itcorp.com', 5140001131, TO_DATE('2020-06-01','YYYY-MM-DD'), NULL, 17, 5, 0, 39500.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (27, 'Laura', 'Fournier', 123, 'laura.fournier@itcorp.com', 5140001132, TO_DATE('2021-10-18','YYYY-MM-DD'), NULL, 17, 5, 0, 37500.00);

-- 3 IT Support Level 2 Staff (job_id 6, mgr_id 104)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (28, 'Hugo', 'Lefevre', 123, 'hugo.lefevre@itcorp.com', 5140001133, TO_DATE('2016-03-22','YYYY-MM-DD'), NULL, 18, 6, 0, 50000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (29, 'Isabelle', 'Garcia', 123, 'isabelle.garcia@itcorp.com', 5140001134, TO_DATE('2017-11-05','YYYY-MM-DD'), NULL, 18, 6, 0, 52000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (30, 'Vincent', 'Petit', 123, 'vincent.petit@itcorp.com', 5140001135, TO_DATE('2018-09-17','YYYY-MM-DD'), NULL, 18, 6, 0, 51000.00);


INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (31, 'Daniel', 'Fortier', 134, 'daniel.fortier@itcorp.com', 5140001136, TO_DATE('2012-01-10','YYYY-MM-DD'), NULL, 57, 104, 0, 150000.00); 

INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (32, 'Sebastien', 'Renaud', 134, 'sebastien.renaud@itcorp.com', 5140001137, TO_DATE('2016-05-21','YYYY-MM-DD'), NULL, 31, 8, 0, 88000.00); 
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (33, 'Camille', 'Benoit', 134, 'camille.benoit@itcorp.com', 5140001138, TO_DATE('2018-07-15','YYYY-MM-DD'), NULL, 31, 8, 0, 77000.00); 
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (34, 'Olivier', 'Gagnon', 134, 'olivier.gagnon@itcorp.com', 5140001139, TO_DATE('2020-03-01','YYYY-MM-DD'), NULL, 31, 8, 0, 65000.00); 

INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (35, 'Elodie', 'Martin', 134, 'elodie.martin@itcorp.com', 5140001140, TO_DATE('2017-09-10','YYYY-MM-DD'), NULL, 31, 9, 0, 90000.00); 
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (36, 'Julien', 'Moreau', 134, 'julien.moreau@itcorp.com', 5140001141, TO_DATE('2019-12-01','YYYY-MM-DD'), NULL, 31, 9, 0, 75000.00); 


INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (37, 'Isabelle', 'Cote', 134, 'isabelle.cote@itcorp.com', 5140001142, TO_DATE('2015-02-15','YYYY-MM-DD'), NULL, 31, 11, 0, 98000.00); 
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (38, 'Mathieu', 'Lapointe', 134, 'mathieu.lapointe@itcorp.com', 5140001143, TO_DATE('2018-06-20','YYYY-MM-DD'), NULL, 31, 11, 0, 68000.00); 

-- 1 Finance Manager (job_id 105, dept_id 201)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (39, 'Philippe', 'Lafleur', 201, 'philippe.lafleur@itcorp.com', 5140001147, TO_DATE('2012-09-01','YYYY-MM-DD'), NULL, 57, 105, 0, 150000.00);

INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (40, 'Anne', 'Boucher', 145, 'anne.boucher@itcorp.com', 5140001144, TO_DATE('2019-03-12','YYYY-MM-DD'), NULL, 39, 10, 0, 54000.00);

INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (41, 'Julien', 'Girard', 145, 'julien.girard@itcorp.com', 5140001145, TO_DATE('2016-06-20','YYYY-MM-DD'), NULL, 39, 10, 0, 61000.00);

INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (42, 'Claire', 'Renaud', 145, 'claire.renaud@itcorp.com', 5140001146, TO_DATE('2013-01-15','YYYY-MM-DD'), NULL, 39, 10, 0, 78000.00);

-- Network & Security Manager 
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (43, 'Henri', 'Tremblay', 201, 'henri.tremblay@itcorp.com', 5140001151, TO_DATE('2011-04-01','YYYY-MM-DD'), NULL, 57, 108, 0, 98000.00);


INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (44, 'Alice', 'Noel', 156, 'alice.noel@itcorp.com', 5140001152, TO_DATE('2017-06-01','YYYY-MM-DD'), NULL, 43, 12, 0, 63500.00); 
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (45, 'Marc', 'Dufresne', 156, 'marc.dufresne@itcorp.com', 5140001153, TO_DATE('2016-03-15','YYYY-MM-DD'), NULL, 43, 12, 0, 80000.00); 
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (46, 'Sophie', 'Benoit', 156, 'sophie.benoit@itcorp.com', 5140001154, TO_DATE('2015-09-20','YYYY-MM-DD'), NULL, 43, 12, 0, 94000.00); 

INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (47, 'Paul', 'Lafleur', 156, 'paul.lafleur@itcorp.com', 5140001155, TO_DATE('2018-01-10','YYYY-MM-DD'), NULL, 43, 13, 0, 95000.00); 
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (48, 'Caroline', 'Martel', 156, 'caroline.martel@itcorp.com', 5140001156, TO_DATE('2019-05-22','YYYY-MM-DD'), NULL, 43, 13, 0, 145000.00);


-- R&D Manager (dept 201, job_id 106)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (49, 'Luc', 'Boucher', 201, 'luc.boucher@itcorp.com', 5140001160, TO_DATE('2010-05-12','YYYY-MM-DD'), NULL, 57, 106, 0, 158000.00);


INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (50, 'Emma', 'Girard', 162, 'emma.girard@itcorp.com', 5140001161, TO_DATE('2018-01-15','YYYY-MM-DD'), NULL, 49, 14, 0, 74000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (51, 'Louis', 'Fortin', 162, 'louis.fortin@itcorp.com', 5140001162, TO_DATE('2016-06-20','YYYY-MM-DD'), NULL, 49, 14, 0, 90000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (52, 'Camille', 'Leclerc', 162, 'camille.leclerc@itcorp.com', 5140001163, TO_DATE('2014-09-10','YYYY-MM-DD'), NULL, 49, 14, 0, 120000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (53, 'Nicolas', 'Beaulieu', 162, 'nicolas.beaulieu@itcorp.com', 5140001164, TO_DATE('2019-03-05','YYYY-MM-DD'), NULL, 49, 14, 0, 76000.00);


INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (54, 'Sophie', 'Dumont', 162, 'sophie.dumont@itcorp.com', 5140001165, TO_DATE('2013-07-21','YYYY-MM-DD'), NULL, 49, 15, 0, 125000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (55, 'Alexandre', 'Roy', 162, 'alexandre.roy@itcorp.com', 5140001166, TO_DATE('2017-11-01','YYYY-MM-DD'), NULL, 49, 15, 0, 85000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (56, 'Isabelle', 'Carpentier', 162, 'isabelle.carpentier@itcorp.com', 5140001167, TO_DATE('2015-02-18','YYYY-MM-DD'), NULL, 49, 15, 0, 110000.00);


-- Quebec
-- City Manager (dept 203, job_id 107)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (58, 'Sylvie', 'Tremblay', 203, 'sylvie.tremblay@itcorp.com', 5812201000, TO_DATE('2014-07-01','YYYY-MM-DD'), NULL, NULL, 107, 0, 158000.00);

-- HR Manager (dept 103, job_id 101)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (59, 'Pierre', 'Gauthier', 103, 'pierre.gauthier@itcorp.com', 5812201001, TO_DATE('2015-03-15','YYYY-MM-DD'), NULL, 58, 101, 0, 107800.00);

-- HR Staff (dept 103, job_id 1)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (60, 'Marie', 'Pelletier', 103, 'marie.pelletier@itcorp.com', 5812201002, TO_DATE('2021-06-01','YYYY-MM-DD'), NULL, 59, 1, 0, 50000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (61, 'Luc', 'Beaulieu', 103, 'luc.beaulieu@itcorp.com', 5812201003, TO_DATE('2022-04-12','YYYY-MM-DD'), NULL, 59, 1, 0, 55000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (62, 'Julie', 'Desjardins', 103, 'julie.desjardins@itcorp.com', 5812201004, TO_DATE('2023-09-20','YYYY-MM-DD'), NULL, 59, 1, 0, 48000.00);

-- Field Ops Manager (dept 114, job_id 102)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (63, 'Andre', 'Cote', 114, 'andre.cote@itcorp.com', 5812201005, TO_DATE('2013-08-01','YYYY-MM-DD'), NULL, 58, 102, 0, 128000.00);

-- Field Ops - Road Tech (dept 114, job_id 2)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (64, 'Claude', 'Lavoie', 114, 'claude.lavoie@itcorp.com', 5812201006, TO_DATE('2017-01-10','YYYY-MM-DD'), NULL, 63, 2, 0, 50000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (65, 'Rene', 'Bouchard', 114, 'rene.bouchard@itcorp.com', 5812201007, TO_DATE('2018-03-15','YYYY-MM-DD'), NULL, 63, 2, 0, 48000.00);

-- Field Ops - Fibre Optic Tech (dept 114, job_id 3)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (66, 'Michele', 'Roy', 114, 'michele.roy@itcorp.com', 5812201008, TO_DATE('2016-11-01','YYYY-MM-DD'), NULL, 63, 3, 0, 60000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (67, 'Jacques', 'Leclerc', 114, 'jacques.leclerc@itcorp.com', 5812201009, TO_DATE('2018-07-22','YYYY-MM-DD'), NULL, 63, 3, 0, 58000.00);

-- Field Ops - Electrical Engineer (dept 114, job_id 7)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (68, 'Jean', 'Dupuis', 114, 'jean.dupuis@itcorp.com', 5812201010, TO_DATE('2019-05-10','YYYY-MM-DD'), NULL, 63, 7, 0, 90000.00);

-- Customer Support Manager (dept 125, job_id 103)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (69, 'Nicolas', 'Gagnon', 125, 'nicolas.gagnon@itcorp.com', 5812201011, TO_DATE('2015-10-30','YYYY-MM-DD'), NULL, 58, 103, 0, 98000.00);

-- Customer Support (dept 125, job_id 4)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (70, 'Sophie', 'Trudel', 125, 'sophie.trudel@itcorp.com', 5812201012, TO_DATE('2019-08-01','YYYY-MM-DD'), NULL, 69, 4, 0, 41000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (71, 'Emilie', 'Fortin', 125, 'emilie.fortin@itcorp.com', 5812201013, TO_DATE('2020-09-15','YYYY-MM-DD'), NULL, 69, 4, 0, 40000.00);

-- IT Support Level 1 (dept 125, job_id 5)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (72, 'Laurent', 'Bolduc', 125, 'laurent.bolduc@itcorp.com', 5812201014, TO_DATE('2018-02-15','YYYY-MM-DD'), NULL, 69, 5, 0, 39000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (73, 'Patrick', 'Girard', 125, 'patrick.girard@itcorp.com', 5812201015, TO_DATE('2019-06-01','YYYY-MM-DD'), NULL, 69, 5, 0, 41000.00);

-- IT Support Level 2 (dept 125, job_id 6)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (74, 'Marina', 'Lacroix', 125, 'marina.lacroix@itcorp.com', 5812201016, TO_DATE('2017-11-05','YYYY-MM-DD'), NULL, 69, 6, 0, 38000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (75, 'David', 'Deschamps', 125, 'david.deschamps@itcorp.com', 5812201017, TO_DATE('2018-10-02','YYYY-MM-DD'), NULL, 69, 6, 0, 39000.00);

-- IT & Systems Manager (dept 136, job_id 104)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (76, 'Serge', 'Moreau', 136, 'serge.moreau@itcorp.com', 5812201018, TO_DATE('2012-02-01','YYYY-MM-DD'), NULL, 58, 104, 0, 150000.00);

-- System Administrator (dept 136, job_id 8)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (77, 'Julien', 'Hamel', 136, 'julien.hamel@itcorp.com', 5812201019, TO_DATE('2016-03-10','YYYY-MM-DD'), NULL, 76, 8, 0, 85000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (78, 'Camille', 'Beauchemin', 136, 'camille.beauchemin@itcorp.com', 5812201020, TO_DATE('2017-07-20','YYYY-MM-DD'), NULL, 76, 8, 0, 80000.00);

-- Network Administrator (dept 136, job_id 9)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (79, 'Olivier', 'Caron', 136, 'olivier.caron@itcorp.com', 5812201021, TO_DATE('2015-05-05','YYYY-MM-DD'), NULL, 76, 9, 0, 80000.00);

-- Finance Manager (dept 147, job_id 105)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (80, 'Yves', 'Leduc', 147, 'yves.leduc@itcorp.com', 5812201022, TO_DATE('2014-09-01','YYYY-MM-DD'), NULL, 58, 105, 0, 150000.00);

-- Accountant (dept 147, job_id 10)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (81, 'Claire', 'Gautier', 147, 'claire.gautier@itcorp.com', 5812201023, TO_DATE('2019-03-15','YYYY-MM-DD'), NULL, 80, 10, 0, 56000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (82, 'Daniel', 'Leblanc', 147, 'daniel.leblanc@itcorp.com', 5812201024, TO_DATE('2020-01-10','YYYY-MM-DD'), NULL, 80, 10, 0, 60000.00);


-- Toronto City Manager (employee_id 112)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (112, 'Jonathan', 'King', 202, 'jonathan.king@itcorp.com', 6470001000, TO_DATE('2010-01-01','YYYY-MM-DD'), NULL, NULL, 107, 0, 160000.00);

-- Toronto — employee_id from 83 to 111

-- HR Manager (dept 102)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (83, 'Michael', 'Turner', 102, 'michael.turner@itcorp.com', 6470002001, TO_DATE('2014-02-10','YYYY-MM-DD'), NULL, 112, 101, 0, 125000.00);

-- HR Staff
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (84, 'Emma', 'Clark', 102, 'emma.clark@itcorp.com', 6470002002, TO_DATE('2021-06-01','YYYY-MM-DD'), NULL, 83, 1, 0, 47000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (85, 'Daniel', 'White', 102, 'daniel.white@itcorp.com', 6470002003, TO_DATE('2019-09-15','YYYY-MM-DD'), NULL, 83, 1, 0, 52000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (86, 'Olivia', 'Baker', 102, 'olivia.baker@itcorp.com', 6470002004, TO_DATE('2016-11-20','YYYY-MM-DD'), NULL, 83, 1, 0, 60000.00);


-- Field Ops Manager (dept 113)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (87, 'Steven', 'Hall', 113, 'steven.hall@itcorp.com', 6470003001, TO_DATE('2015-03-10','YYYY-MM-DD'), NULL, 112, 102, 0, 130000.00);

-- Field Ops staff
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (88, 'Kevin', 'Reed', 113, 'kevin.reed@itcorp.com', 6470003002, TO_DATE('2020-01-08','YYYY-MM-DD'), NULL, 87, 2, 0, 47000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (89, 'Laura', 'Hughes', 113, 'laura.hughes@itcorp.com', 6470003003, TO_DATE('2018-05-14','YYYY-MM-DD'), NULL, 87, 3, 0, 60000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (90, 'Brian', 'Cole', 113, 'brian.cole@itcorp.com', 6470003004, TO_DATE('2016-07-22','YYYY-MM-DD'), NULL, 87, 7, 0, 80000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (91, 'Megan', 'Foster', 113, 'megan.foster@itcorp.com', 6470003005, TO_DATE('2019-10-01','YYYY-MM-DD'), NULL, 87, 2, 0, 52000.00);

-- Customer Support Manager (dept 124)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (92, 'Andrew', 'Morris', 124, 'andrew.morris@itcorp.com', 6470004001, TO_DATE('2016-04-18','YYYY-MM-DD'), NULL, 112, 103, 0, 110000.00);

-- Customer Support staff
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (93, 'Samantha', 'Green', 124, 'samantha.green@itcorp.com', 6470004002, TO_DATE('2020-08-05','YYYY-MM-DD'), NULL, 92, 4, 0, 40000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (94, 'Ethan', 'Coleman', 124, 'ethan.coleman@itcorp.com', 6470004003, TO_DATE('2018-02-20','YYYY-MM-DD'), NULL, 92, 5, 0, 45000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (95, 'Natalie', 'Mason', 124, 'natalie.mason@itcorp.com', 6470004004, TO_DATE('2017-09-11','YYYY-MM-DD'), NULL, 92, 6, 0, 54000.00);

-- IT & Systems Manager (dept 135)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (96, 'Robert', 'Fisher', 135, 'robert.fisher@itcorp.com', 6470005001, TO_DATE('2012-01-15','YYYY-MM-DD'), NULL, 112, 104, 0, 150000.00);

-- IT & Systems staff
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (97, 'Jason', 'Wright', 135, 'jason.wright@itcorp.com', 6470005002, TO_DATE('2019-06-24','YYYY-MM-DD'), NULL, 96, 8, 0, 85000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (98, 'Christine', 'Adams', 135, 'christine.adams@itcorp.com', 6470005003, TO_DATE('2017-03-30','YYYY-MM-DD'), NULL, 96, 9, 0, 90000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (99, 'Daniel', 'Bryant', 135, 'daniel.bryant@itcorp.com', 6470005004, TO_DATE('2015-10-05','YYYY-MM-DD'), NULL, 96, 11, 0, 98000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (100, 'Rebecca', 'Mills', 135, 'rebecca.mills@itcorp.com', 6470005005, TO_DATE('2016-07-12','YYYY-MM-DD'), NULL, 96, 8, 0, 82000.00);

-- Finance Manager (dept 146)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (101, 'Patrick', 'Stone', 146, 'patrick.stone@itcorp.com', 6470006001, TO_DATE('2014-09-01','YYYY-MM-DD'), NULL, 112, 105, 0, 140000.00);

-- Accountants
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (102, 'Holly', 'Evans', 146, 'holly.evans@itcorp.com', 6470006002, TO_DATE('2019-03-20','YYYY-MM-DD'), NULL, 101, 10, 0, 60000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (103, 'Gavin', 'Knight', 146, 'gavin.knight@itcorp.com', 6470006003, TO_DATE('2017-05-28','YYYY-MM-DD'), NULL, 101, 10, 0, 72000.00);

-- Network & Security Manager (dept 157)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (104, 'Christopher', 'Coleman', 157, 'christopher.coleman@itcorp.com', 6470007001, TO_DATE('2013-12-03','YYYY-MM-DD'), NULL, 112, 108, 0, 120000.00);

-- Net/Security staff
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (105, 'Julia', 'Parker', 157, 'julia.parker@itcorp.com', 6470007002, TO_DATE('2018-11-19','YYYY-MM-DD'), NULL, 104, 12, 0, 68000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (106, 'Mark', 'Wells', 157, 'mark.wells@itcorp.com', 6470007003, TO_DATE('2015-04-07','YYYY-MM-DD'), NULL, 104, 13, 0, 120000.00);

-- Software & R&D Manager (dept 163)
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (107, 'Kevin', 'Anderson', 163, 'kevin.anderson@itcorp.com', 6470008001, TO_DATE('2014-06-25','YYYY-MM-DD'), NULL, 112, 106, 0, 135000.00);

-- Software & R&D staff
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (108, 'Brandon', 'Harris', 163, 'brandon.harris@itcorp.com', 6470008002, TO_DATE('2019-08-01','YYYY-MM-DD'), NULL, 107, 14, 0, 80000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (109, 'Ashley', 'Reed', 163, 'ashley.reed@itcorp.com', 6470008003, TO_DATE('2016-10-10','YYYY-MM-DD'), NULL, 107, 14, 0, 110000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (110, 'Trevor', 'Simpson', 163, 'trevor.simpson@itcorp.com', 6470008004, TO_DATE('2015-02-18','YYYY-MM-DD'), NULL, 107, 15, 0, 115000.00);
INSERT INTO employee (employee_id, first_name, last_name, dept_id, email_address, phone_number, starting_date, end_date, mgr_id, job_id, project_id, salary)
VALUES (111, 'Nicole', 'Bennett', 163, 'nicole.bennett@itcorp.com', 6470008005, TO_DATE('2021-09-01','YYYY-MM-DD'), NULL, 107, 14, 0, 78000.00);

SET DEFINE ON;
