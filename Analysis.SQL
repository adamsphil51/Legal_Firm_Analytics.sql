
-- 1. LawFirms table
CREATE TABLE LawFirms (
    FirmID INT PRIMARY KEY,
    FirmName VARCHAR(100)
);

INSERT INTO LawFirms (FirmID, FirmName) VALUES
(1, 'Karanja & Co. Advocates'),
(2, 'Mwangi Legal Partners'),
(3, 'Omondi & Associates'),
(4, 'Kamau & Co. Solicitors'),
(5, 'Njeri Law Chambers'),
(6, 'Otieno Legal Services'),
(7, 'Mutua & Partners'),
(8, 'Wanjiku Advocates'),
(9, 'Ochieng & Associates'),
(10, 'Chebet Law Firm'),
(11, 'Gitonga Legal'),
(12, 'Makau & Partners'),
(13, 'Achieng & Co. Advocates'),
(14, 'Odhiambo Legal Chambers'),
(15, 'Muthoni & Associates'),
(16, 'Kibet Legal Services'),
(17, 'Ndegwa & Co. Solicitors'),
(18, 'Wambui Advocates'),
(19, 'Onyango Legal'),
(20, 'Baraka & Partners'),
(21, 'Juma & Associates'),
(22, 'Nyambura Law Chambers'),
(23, 'Omollo Legal Solutions'),
(24, 'Murithi & Co. Advocates'),
(25, 'Limo & Partners');

-- 2. Lawyers table
CREATE TABLE Lawyers (
    LawyerID INT PRIMARY KEY,
    LawyerName VARCHAR(100),
    FirmID INT,
    Department VARCHAR(50),
    FOREIGN KEY (FirmID) REFERENCES LawFirms(FirmID)
);

-- Sample Lawyers (you can expand)
INSERT INTO Lawyers (LawyerID, LawyerName, FirmID, Department) VALUES
(1, 'Alice Karanja', 1, 'Corporate'),
(2, 'Brian Mwangi', 2, 'Litigation'),
(3, 'Catherine Omondi', 3, 'Intellectual Property'),
(4, 'David Kamau', 4, 'Corporate'),
(5, 'Elena Njeri', 5, 'Litigation');

-- 3. Clients table
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    ClientName VARCHAR(100)
);

INSERT INTO Clients (ClientID, ClientName) VALUES
(1, 'Safaricom Ltd'),
(2, 'KenGen'),
(3, 'Equity Bank'),
(4, 'KCB Bank'),
(5, 'Twiga Foods');

-- 4. Cases table
CREATE TABLE Cases (
    CaseID INT PRIMARY KEY,
    ClientID INT,
    LawyerID INT,
    FirmID INT,
    CaseType VARCHAR(50),
    Fees DECIMAL(10,2),
    CaseDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (LawyerID) REFERENCES Lawyers(LawyerID),
    FOREIGN KEY (FirmID) REFERENCES LawFirms(FirmID)
);

-- Sample Cases
INSERT INTO Cases (CaseID, ClientID, LawyerID, FirmID, CaseType, Fees, CaseDate, Status) VALUES
(1, 1, 1, 1, 'Corporate', 500000, '2024-01-05', 'Closed'),
(2, 2, 2, 2, 'Litigation', 250000, '2024-01-10', 'Open'),
(3, 3, 3, 3, 'IP', 150000, '2024-02-01', 'Closed'),
(4, 4, 4, 4, 'Corporate', 350000, '2024-02-15', 'Closed'),
(5, 5, 5, 5, 'Litigation', 200000, '2024-03-01', 'Open');

-- =====================================================
-- Analytics Queries
-- =====================================================

-- 1. Total revenue per firm
SELECT 
    f.FirmName,
    SUM(c.Fees) AS TotalRevenue
FROM Cases c
JOIN LawFirms f ON c.FirmID = f.FirmID
GROUP BY f.FirmName
ORDER BY TotalRevenue DESC;

-- 2. Cases per department
SELECT 
    l.Department,
    COUNT(c.CaseID) AS TotalCases
FROM Cases c
JOIN Lawyers l ON c.LawyerID = l.LawyerID
GROUP BY l.Department
ORDER BY TotalCases DESC;

-- 3. Monthly case trends
SELECT 
    YEAR(CaseDate) AS Year,
    MONTH(CaseDate) AS Month,
    COUNT(CaseID) AS TotalCases
FROM Cases
GROUP BY YEAR(CaseDate), MONTH(CaseDate)
ORDER BY Year, Month;

-- 4. Average fees per case type
SELECT 
    CaseType,
    AVG(Fees) AS AvgFees
FROM Cases
GROUP BY CaseType
ORDER BY AvgFees DESC;

-- 5. Lawyer workload (number of cases per lawyer)
SELECT 
    l.LawyerName,
    COUNT(c.CaseID) AS TotalCases
FROM Cases c
JOIN Lawyers l ON c.LawyerID = l.LawyerID
GROUP BY l.LawyerName
ORDER BY TotalCases DESC;
