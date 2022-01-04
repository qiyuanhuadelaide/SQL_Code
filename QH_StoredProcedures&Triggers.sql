CREATE OR REPLACE FUNCTION Addfreeaccount(
	account_id IN DECIMAL,
	first_name IN VARCHAR,
	last_name IN VARCHAR,
	user_date IN Date)
	RETURNS VOID LANGUAGE plpgsql
AS
$$
BEGIN
INSERT INTO Account(account_id, first_name, last_name,user_date)
VALUES(account_id, first_name, last_name,user_date);
INSERT INTO FreeAccount (account_id) VALUES (account_id);
END;
$$;

CREATE OR REPLACE FUNCTION Addpaidaccount(
   account_ID IN DECIMAL,
   account_balance IN DECIMAL,
   renewal_date IN DATE)
   RETURNS VOID LANGUAGE plpgsql
AS
$$
BEGIN
INSERT INTO Account(account_id, account_balance, renewal_date)
VALUES(account_id, account_balance, renewal_date);
INSERT INTO PaidAccount (account_id, account_balance, renewal_date)
VALUES (account_id, account_balance, renewal_date);
END;
$$;

CREATE OR REPLACE FUNCTION BalancechanceHistory()
RETURNS TRIGGER LANGUAGE plpgsql
AS $$
BEGIN
 IF OLD.current_balance <> NEW.current_balance THEN
 INSERT INTO BalanceChange(balancechange_Id, prev_balance, current_balance, paid_account_id, change_date)
 VALUES(NEW.balancechange_Id, OLD.prev_balance, NEW.current_balance, NEW.paid_account_id, NEW.change_date);
 END IF;
 RETURN NEW;
END;
$$;
CREATE TRIGGER BCHistory
BEFORE UPDATE ON paidAccount
FOR EACH ROW
EXECUTE PROCEDURE BalancechanceHistory();