CREATE DATABASE QuanLyQuanCafe;
GO

USE QuanLyQuanCafe;
GO


CREATE TABLE TableFood
(
    id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
        DEFAULT N'Bàn chưa có tên',
    status NVARCHAR(100) NOT NULL
        DEFAULT N'Trống	' --Trống || Có người
);
GO

CREATE TABLE Account
(
    UserName NVARCHAR(100) PRIMARY KEY,
    DisplayName NVARCHAR(100) NOT NULL
        DEFAULT N'ABC',
    Password NVARCHAR(100) NOT NULL
        DEFAULT 0,
    Type INT NOT NULL
        DEFAULT 0 --1: admin, 0: staff
);
GO

CREATE TABLE FoodCateGory
(
    id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
        DEFAULT N'Chưa đặt tên'
);
GO

CREATE TABLE Food
(
    id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
        DEFAULT N'Chưa đặt tên',
    idCategory INT NOT NULL,
    price FLOAT NOT NULL
        DEFAULT 0
        FOREIGN KEY (idCategory) REFERENCES dbo.FoodCateGory (id)
);
GO

CREATE TABLE Bill
(
    id INT IDENTITY PRIMARY KEY,
    DateCheckIn DATE NOT NULL
        DEFAULT GETDATE(),
    DateCheckOut DATE,
    idTable INT NOT NULL,
    status INT NOT NULL --1 đã thanh toán && 0 chưa thanh toán
        FOREIGN KEY (idTable) REFERENCES dbo.TableFood (id)
);
GO

CREATE TABLE BillInfo
(
    id INT IDENTITY PRIMARY KEY,
    idBill INT NOT NULL,
    idFood INT NOT NULL,
    count INT NOT NULL
        DEFAULT 0
        FOREIGN KEY (idBill) REFERENCES dbo.Bill (id),
    FOREIGN KEY (idFood) REFERENCES dbo.Food (id)
);
GO

INSERT INTO dbo.Account
(
    UserName,
    DisplayName,
    Password,
    Type
)
VALUES
(N'Ben', N'Ben42', N'1', 1);

INSERT INTO dbo.Account
(
    UserName,
    DisplayName,
    Password,
    Type
)
VALUES
(N'staff', N'staff', N'1', 0);
GO

CREATE PROC USP_GetAccountByUserName @Username NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM dbo.Account
    WHERE UserName = @Username;
END;
GO

EXEC dbo.USP_GetAccountByUserName @Username = N'Ben';
GO


CREATE PROC USP_Login
    @userName NVARCHAR(100),
    @password NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM dbo.Account
    WHERE UserName = @userName
          AND Password = @password;
END;
GO


--thêm bàn
DECLARE @i INT = 0;
WHILE @i <= 10
BEGIN
    INSERT dbo.TableFood
    (
        name
    )
    VALUES
    (N'Bàn ' + CAST(@i AS NVARCHAR(100)));
    SET @i = @i + 1;
END;
GO

CREATE PROC USP_GetTableList
AS
SELECT *
FROM dbo.TableFood;
GO

UPDATE dbo.TableFood
SET status = N'Có người'
WHERE id = 9;


EXEC dbo.USP_GetTableList;
GO

--thêm category
INSERT dbo.FoodCateGory
(
    name
)
VALUES
(N'Hải sản');
INSERT dbo.FoodCateGory
(
    name
)
VALUES
(N'Nông sản');
INSERT dbo.FoodCateGory
(
    name
)
VALUES
(N'Lâm sản');
INSERT dbo.FoodCateGory
(
    name
)
VALUES
(N'Hoa quả');
INSERT dbo.FoodCateGory
(
    name
)
VALUES
(N'Nước');


--thêm món ăn
INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Mực một nắng sa tế', -- name - nvarchar(100)
    1,                     -- idCategory - int
    120000.0               -- price - float 
    );
INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Dú dê Nướng', -- name - nvarchar(100)
    2,              -- idCategory - int
    90000.0         -- price - float 
    );
INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Bắp bò Mỹ', -- name - nvarchar(100)
    3,            -- idCategory - int
    100000.0      -- price - float 
    );
INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Nghêu hấp sả', -- name - nvarchar(100)
    4,               -- idCategory - int
    50000.0          -- price - float 
    );
INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Bạch tuộc nướng', -- name - nvarchar(100)
    5,                  -- idCategory - int
    90000.0             -- price - float 
    );
INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Cơm chiên', -- name - nvarchar(100)
    6,            -- idCategory - int
    50000.0       -- price - float 
    );
INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Heniken', -- name - nvarchar(100)
    7,          -- idCategory - int
    30000.0     -- price - float 
    );
INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Men',  -- name - nvarchar(100)
    8,       -- idCategory - int
    100000.0 -- price - float 
    );
		   
--thêm Bill
INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    NULL,      -- DateCheckOut - date
    1,         -- idTable - int
    0          -- status - int
    );
INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    NULL,      -- DateCheckOut - date
    2,         -- idTable - int
    0          -- status - int
    );
INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    GETDATE(), -- DateCheckOut - date
    2,         -- idTable - int
    1          -- status - int
    );

--thêm Bill Info
INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   1, -- idBill - int
    1, -- idFood - int
    2  -- count - int
    );

	INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   1, -- idBill - int
    3, -- idFood - int
    4  -- count - int
    );
	INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   1, -- idBill - int
    5, -- idFood - int
    1  -- count - int
    );
	INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   2, -- idBill - int
    1, -- idFood - int
    2  -- count - int
    );
	INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   2, -- idBill - int
    5, -- idFood - int
    2  -- count - int
    );
	INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   3, -- idBill - int
    5, -- idFood - int
    2  -- count - int
    );
	go

SELECT f.name, b.count, f.price, f.price*b.count AS TotalPrice FROM
dbo.BillInfo AS b, dbo.Bill AS bi, dbo.Food AS f WHERE b.idBill = bi.id AND b.idFood = f.id AND bi.idTable = 1
SELECT *
FROM dbo.Bill;
SELECT *
FROM dbo.BillInfo;
SELECT *
FROM dbo.Food;
SELECT *
FROM dbo.FoodCateGory;