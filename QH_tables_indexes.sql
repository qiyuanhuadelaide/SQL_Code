CREATE TABLE Categories (
  category_code VARCHAR(64) PRIMARY KEY,
  category VARCHAR(255)
);

CREATE TABLE Countries (
  country_code VARCHAR(3) PRIMARY KEY,
  country VARCHAR(64),
  continent VARCHAR(64)
);

CREATE TABLE Businesses (
  business VARCHAR(64) PRIMARY KEY,
  year_founded DECIMAL(4),
  category_code VARCHAR(64),
  country_code VARCHAR(3),
	FOREIGN KEY(category_code) REFERENCES categories(category_code),
	FOREIGN KEY(country_code) REFERENCES countries(country_code)
);

CREATE TABLE Account(
account_id DECIMAL(12) NOT NULL PRIMARY KEY,
first_name VARCHAR(32) NOT NULL,
last_name VARCHAR(32) NOT NULL,
user_date DATE NOT NULL);

CREATE TABLE Orders(
order_id DECIMAL(12) NOT NULL PRIMARY KEY,
account_id DECIMAL(12) NOT NULL,
spend_date DATE NOT NULL,
spend_amount DECIMAL(4,2) NOT NULL,
FOREIGN KEY(account_id) REFERENCES Account(account_id));

CREATE TABLE FreeAccount(
account_id DECIMAL(12) NOT NULL PRIMARY KEY,
FOREIGN KEY(account_id) REFERENCES Account(account_id));

CREATE TABLE PaidAccount(
account_id DECIMAL(12) NOT NULL PRIMARY KEY,
account_balance DECIMAL(4,2) NOT NULL,
renewal_date DATE NOT NULL,
FOREIGN KEY(account_id) REFERENCES Account(account_id));

CREATE TABLE BalanceChange(
balancechange_Id DECIMAL(12) NOT NULL PRIMARY KEY,
prev_balance DECIMAL(4,2) NOT NULL,
current_balance DECIMAL(4,2) NOT NULL,
paid_account_id DECIMAL(12) NOT NULL,
change_date DATE NOT NULL,
FOREIGN KEY(paid_account_id) REFERENCES PaidAccount(account_id));
-- create an index for searching business name faster
CREATE UNIQUE INDEX SearchBusiness ON Businesses (business);
	