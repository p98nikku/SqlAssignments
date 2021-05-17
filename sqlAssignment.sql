-- Database: DepartmentalStore

-- DROP DATABASE "DepartmentalStore";

CREATE DATABASE "DepartmentalStore"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
	--creating a gender enum type in departmental store
	create type gender as enum('M','F');
	--creating a instock enum type
	create type inStock as enum('Y','N');
	--creating staff table id,name,roll,gender
	create table Staff(
		PersonId serial primary key ,
		PersonName varchar(30),
		PersonContribution varchar(30),
		PersonPhonenumber varchar(10),
		PersonGender gender
	);
	select * from Staff;
	--inserting values in staff tables
	insert into Staff(PersonName,PersonContribution,PersonPhonenumber,PersonGender) 
	values('Henry','ManagementStaff','873476799','M'),
	('Natasha','ReceptionStaff','8734767990','F'),
	('Animesh','SearchProduct','678439827','M'),
	('Medha','ReceptionStaff','763983458','F'),
	('Shruti','ManagementStaff','878685349','F'),
	('Himesh','ManagementStaff','873476899','M'),
	('Emma','Sales','8734768990','F'),
	('Ritesh','Sales','678439887','M'),
	('Monika','Manager','763983488','F'),
	('Sanjeev','Manager','878675349','M');
	
	
	--**********************************************************--
	--creating product table
	create table Product(
		ProductId serial primary key,
		ProductName varchar(30),
		ProductStock inStock,
		Manufacturer varchar(30),
		ProductCategory varchar(30),
		ProductCode varchar(30),
		CategoryId int references Category(CategoryId)
	);
	select * from Product;
	--inserting values in product table
	insert into Product(ProductName,ProductStock,Manufacturer,ProductCategory,ProductCode,CategoryId)
	values('Laptop','Y','Dell India','TechnologyItems','LAP10',1),
	('Desktop','N','Samsung India','TechnologyItems','DES10',1),
	('Speaker','Y','BOAT','Gadgets','SPK10',2),
	('Blueberry yogurt','N','Amul','DairyProducts','YOG10',3),
	('Notebook','Y','Classmate','StudyMaterial','NOTE10',4),
	('Toys','N','Hamleys','PlaySection','TOY10',5),
	('Tshirt','Y','AllenSolly','Wordrobesection','TSH10',6);
	
	
	--**************************************************--
	--creating product revenues
	create table ProductRevenue(
		RevenueId serial primary key,
		ProductId int references product(ProductId),
		CostPrice int,
		SellingPrice int,
		Month varchar(30)
	);
	select * from ProductRevenue;
	
	--inserting values in product_revenues table
	insert into ProductRevenue(ProductId,CostPrice,SellingPrice,Month)
	values(1,30000,32000,'May'),
	(3,1300,1399,'November'),
	(2,45000,45500,'April'),
	(5,100,120,'May'),
	(4,20,25,'April'),
	(6,1299,1380,'June'),
	(7,500,599,'July');	
	
	
	--************************************************************--
	--creating product categories table id,name,code
	create table Category(
		CategoryId serial primary key,
		CategoryName varchar(30),
		CategoryCode varchar(30)
	);
	select * from Category;
	--inserting category values in category table
	insert into Category(CategoryName,CategoryCode)
	values('TechnologyItems','TECH'),
	('Gadgets','GAD'),
	('DairyProducts','DAI'),
	('StudyMaterials','STUD'),
	('PlaySection','PLAY'),
	('WordrobeItems','WORD')


	--****************************************************************--
	--creating inventory table
	create table Inventory(
		ProductId int primary key references Product(ProductId),
		ProductQuantity int
	);
	select * from Inventory
	
	insert into Inventory(ProductId,ProductQuantity)
	values(2,5),(1,4),(3,8),(5,30),(6,12),(4,6),(7,5)
	
	
	--***************************************************************--
	--creating supplier table
	create table Supplier(
		SupplierId serial primary key,
		SupplierName varchar(30),
		SupplierAge int,
		SupplierGender gender,
		SupplierPhonenumber varchar(10),
		SupplierCity varchar(30),
		SupplierState varchar(30),
		SupplierEmail varchar(30)
	);
	select * from Supplier;
	insert into supplier(SupplierName,SupplierAge,SupplierGender,SupplierPhonenumber,SupplierCity,SupplierState,SupplierEmail)
	values('Hitesh',35,'M','879676575','Kanpur','UP','hitesh@gmail.com'),
	('Meenakshi',25,'F','7875765767','Mumbai','Maharashtra','meena@gmail.com'),
	('Udit',45,'M','764534567','Lucknow','UP','udit@hotmail.com'),
	('Rohan',31,'M','656879754','Pune','Maharashtra','rohan@gmail.com'),
	('Akriti',23,'F','8687578766','Kerela','Tamil Nadu','akriti@gmail.com'),
	('Vishal',31,'M','8786576557','Banaras','UP','vishal@hotmail.com');


	--****************************************************************--
	--creating  product order table 
		create table ProductOrder(
		ProductOrderId serial primary key,
		ProductOrderDate date,
		ProductOrderQuantity int
	);
	select * from ProductOrder;
	insert into ProductOrder(ProductOrderDate,ProductOrderQuantity)
	values('2020-11-09',21),('2019-10-8',12),('2020-08-09',10),('2020-09-13',8),('2021-01-13',9)	


	--**********************************************************************--
	--creating supplier product table
	create table SupplierProductOrder(
		ProductId int REFERENCES Product(ProductId),
		SupplierId int REFERENCES Supplier(SupplierId),
		ProductOrderId  int REFERENCES ProductOrder(ProductOrderId ),
		primary key(ProductId,SupplierId,ProductOrderId)
	);
	select * from SupplierProductOrder;
	insert into SupplierProductOrder(ProductId,SupplierId,ProductOrderId )
	values(1,2,1),(2,1,3),(3,3,5),(4,6,4),(5,4,3),(6,5,1),(7,2,2);


	--**************************QUERIES********************************--
	--query staff using name or phone number or both
	--a)
	select * from Staff where PersonName='Shruti' or PersonPhonenumber='763983458';
	--b)
	select * from Staff where PersonName='Medha' and PersonPhonenumber='763983458';
	
	--query staff using their role
	--a)
	select * from Staff where PersonContribution like 'Manageme%';
	
	--query product based on
	--a)
	select * from Product where ProductName like 'L%';
	--b)
	select * from Product where ProductCategory like 'D%';
	--c)
	select * from Product where ProductStock='N';
	--d)
	select a.ProductName,b.CostPrice from Product as a inner join ProductRevenue as b on SellingPrice>=2000;
	
	--name of products out of stock
	--a)	
	select * from Product where ProductStock='N';
	
	--number of products within a category
	--a)
	select a.CategoryId,count(distinct b.ProductId),a.CategoryName from Category as a inner join Product as b on a.CategoryId=b.CategoryId group by a.CategoryId;
	
	--Product-Categories listed in descending with highest number of products to the lowest number of products
	--a)
	select a.CategoryId,count(distinct b.ProductId),a.CategoryName from category as a inner join Product as b on a.CategoryId=b.CategoryId group by a.CategoryId order by a.CategoryName asc;
	
	--list of suppliers
	--a)
	select * from Supplier where SupplierName ='Rohan';
	--b)
	select * from Supplier where SupplierPhonenumber='764534567';
	--c)
	select * from Supplier where SupplierEmail like 'udit@%';
	--d)
	select * from Supplier where SupplierCity='Kanpur' or SupplierState='UP';
	
	--list of product with different suppliers
	--a)	
	select a.ProductId,a.ProductName from Product as a inner join SupplierProductOrder as b on 
	a.ProductId=b.ProductId inner join ProductOrder as c
	on c.ProductOrderId=b.ProductId where ProductOrderDate>'2020-09-08' ;
	--b)
	select a.SupplierName from Supplier as a inner join SupplierProductOrder as b on 
	a.SupplierId=b.ProductId inner join ProductOrder as c
	on c.ProductOrderId=b.ProductId where ProductOrderDate>'2020-09-08' ;
	--c)
	select a.ProductCode,a.ProductName from product as a inner join SupplierProductOrder as b on 
	a.ProductId=b.ProductId  inner join ProductOrder as c
	on c.ProductOrderId=b.ProductId where ProductOrderDate>'2021-01-01' ;
	--d)
	select a.SupplierName from Supplier as a inner join SupplierProductOrder as b on 
	a.SupplierId=b.ProductId inner join ProductOrder as c
	on c.ProductOrderId=b.ProductId where ProductOrderDate>'2020-09-08' ;
	--e)
	select a.ProductCode,a.ProductName from product as a inner join SupplierProductOrder as b on 
	a.ProductId=b.ProductId  inner join ProductOrder as c
	on c.ProductOrderId=b.ProductId where ProductOrderDate<'2021-01-01' ;
	--f)
	select a.ProductName from Product as a inner join Inventory as b on a.ProductId=b.ProductId where ProductQuantity>10;
	select a.ProductName from Product as a inner join Inventory as b on a.ProductId=b.ProductId where ProductQuantity<10;
	select a.ProductName from Product as a inner join Inventory as b on a.ProductId=b.ProductId where ProductQuantity>=10;

	
	
	
	
	