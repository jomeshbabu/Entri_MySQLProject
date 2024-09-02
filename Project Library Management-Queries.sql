CREATE DATABASE library;
USE library;
-- Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
desc Branch;




-- Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(255),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

desc Employee;

-- Books table
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(255),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);
Desc Books;


-- Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
desc Customer;


-- IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
desc IssueStatus;

-- ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

desc ReturnStatus;

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, 'Vellarikundu kasaragod', '04672241589'),
(2, 102, 'Edappally ernakulam', '7411964037'),
(3, 103, 'Ponnani Malappuram', '9846719254'),
(4, 104, 'Iritty Kannur', '04841526547'),
(5, 105, 'Kattappana Idukki', '9946153004');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(101, 'Judit Thomas', 'Manager', 60000, 1),
(102, 'Jobin Jose', 'Manager', 58000, 2),
(103, 'Nirmal Mani', 'Manager', 62000, 3),
(104, 'Sijumon S', 'Manager', 61000, 4),
(105, 'Rudra Kumar', 'Manager', 63000, 5),
(106, 'Sibin Xavier', 'Assistant', 40000, 1),
(107, 'Soya Joseph', 'Assistant', 42000, 2),
(108, 'Betty Sibin', 'Assistant', 41000, 3),
(109, 'Athira PS', 'Assistant', 43000, 4),
(110, 'Sajini Pilllai', 'Assistant', 44000, 5);


INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
(2001, 'Kurukkan', 'Novel', 50.00, 'yes', 'Basheer', 'DC Books'),
(2002, 'Randam Oozham', 'Epic', 55.00, 'yes', 'MT Vasudevan', 'Current Books'),
(2003, 'Odakkuzhal', 'Poetry', 45.00, 'no', 'Vayalar', 'Mathrubhumi Books'),
(2004, 'Mannu', 'Drama', 60.00, 'yes', 'Shekspear', 'Poorna Publications'),
(2005, 'Ayyappan', 'Fiction', 40.00, 'no', 'Vaikkam Muhamad Basheer', 'Green Books');

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(201, 'Subin K Joseph', 'Poovathinkal House Plachikkara', '2021-11-01'),
(202, 'Nidhin Mathew', 'Kunchirkattu Mankayam', '2022-02-14'),
(203, 'Christy Joy', 'Kodiyil Koolippara', '2020-05-21'),
(204, 'Tesimol Joseph', 'Kusrishinkal Bheemanadi', '2019-08-30'),
(205, 'Nimitha Ratheesh', 'Nallod Bandadka', '2023-01-05');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(301, 201, 'Ayyappan', '2023-06-01', 2001),
(302, 202, 'Kurukkan', '2023-06-15', 2002),
(303, 203, 'Mannu', '2023-06-20', 2004),
(304, 204, 'Ayyappan', '2023-06-25', 2001),
(305, 205, 'Kurukkan', '2023-06-30', 2002);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(401, 201, 'Ayyappan', '2023-07-01', 2001),
(402, 202, 'Odakkuzhal', '2023-07-15', 2002),
(403, 203, 'Mannu', '2023-07-20', 2004),
(404, 204, 'Ayyappan', '2023-07-25', 2001),
(405, 205, 'Kurukkan', '2023-07-30', 2002);


-- Retrieve the book title category and rental price of all available books

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- Retrieve the book titles and the corresponding customers who have issued those books.
SELECT Books.Book_title, Customer.Customer_name
FROM Books
JOIN IssueStatus ON Books.ISBN = IssueStatus.Isbn_book
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

-- Display the total count of books in each category.

SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);


-- Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- Display the names of customers who have issued books in the month of June 2023.

SELECT Customer.Customer_name
FROM Customer
JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- Retrieve book_title from book table containing history.

SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.

SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

-- Retrieve the names of employees who manage branches and their respective branch addresses.

SELECT e.Emp_name, b.Branch_address
FROM Employee e
JOIN Branch b ON e.Emp_Id = b.Manager_Id;

-- Display the names of customers who have issued books with a rental price higher than Rs. 25.

SELECT DISTINCT Customer.Customer_name
FROM Customer
JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
WHERE Books.Rental_Price > 25;

























