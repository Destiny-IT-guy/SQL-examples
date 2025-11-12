# Creating database table

this will be a reminder to self on of how to create a database in oracle.

There are many data type but i will only stick to the main one

## data type
### 1. number 
this data type store number with a maximal number of digits.
example 
```sql 
Salary number(9,2),
```
this will create a column named salary that allow a maximum of 9 digits which 2 digits after the decimal. the max number would be 9 999 999.99. I can also put no commas to have no decimal number. 

### 2. Vachar2
this data type allow us to a string a variable lenght string.
example 
```sql
Name varchar2(15), Not Null.
```
this create a column named "name" which i can enter a string of maximum lenght 15 but it cant be null so it has to have a minimum of 1 character string. Also after you select a varchar2 number it is possible to increase the number but impossible to decrease the number so i can increase it to 20 but cant decrase it to 10.

### date
this data type store data in a date type format like YYYY-MM-DD or DD-MM-YYYY and many more unconvential type
example
```sql
Hiredate date not null,
```

## keys
there are multiple keys but im sticking to primary and foreign keys

to link multiple different table togther we need to use  keys. first there is the primary keys. they 

### primary key
Primary key uniquely identifies each row in a table.  
It ensures that no two rows have the same value in the primary key column(s) and that the value cannot be NULL. It is recommended to atleast have 1 primary key for each table

### foreign key
When i want to connect 2 table i would usualy add the column of the primary key of the first table to the second table. 
This column in the second table becomes the foreign key.  
It ensures that the values in the second table **match existing values** in the first table’s primary key, maintaining referential integrity between the tables.

## adding foreign key
adding a foreign key is a lil more complex than a primary key. to start aftr adding each column in you table you have to add the following to lines
```sql
CONSTRAINT name_of_foreign_key FOREIGN KEY (column_of_primary_key)
REFERENCES table_with_the_primary_key (column_of_primary_key)
```    
you will see an example when i create 2 table at the end of this file

## create and deleting table

to create a table use the following structure
```sql
CREATE TABLE Example (
Product_ID NUMBER(2) PRIMARY KEY,
Product_name VARCHAR2 (30) NOT NULL,
DESCRIPTION VARCHAR2 (200),
QUANTITY_available NUMBER,
Creation_Date DATE);

Create Table Example2 (
Worker_ID Number(5) not null Primary key,
Worker_First_Name varchar2(20) not null,
Worker_Last_Name varchar2(20) not null, 
Hire_date date not null,
Last_date date);

CREATE TABLE Example3 (
Transaction_ID NUMBER(5) PRIMARY KEY,
Product_ID NUMBER(2) NOT NULL,
Worker_ID NUMBER(5) NOT NULL,
Quantity_Sold NUMBER,
Transaction_Date DATE,                       

CONSTRAINT fk_product FOREIGN KEY (Product_ID)
    REFERENCES Example(Product_ID),
CONSTRAINT fk_worker FOREIGN KEY (Worker_ID)
    REFERENCES Example2(Worker_ID)
);
```
I created 3 table which table 1 and 2 are linked to table 3 but they arent directly link to eachother 

to delete a table its prteey simple just enter the following command
```sql
drop table table_name
```

## modify or add 
if i want to modify a column i can do this
```sql
alter table example (
Product_ID number(3) Primary key;
)
```
i just increase the maximum digits of the column Product id.

if i want to add a column i can do this
```sql
alter table example (
ADD Product_end_date date;)
```

if i want to remove a table i just to replace add with drop.


## end
My next part i will show myself how to create a bigger databse and add data and serach for data 