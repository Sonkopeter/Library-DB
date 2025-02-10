DROP TRIGGER IF EXISTS trigger_loan_count
ON Loans;

CREATE OR REPLACE FUNCTION update_loan_count()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Books
    SET loan_count = loan_count + 1
    WHERE bookID = NEW.bookID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_loan_count
AFTER INSERT ON Loans
FOR EACH ROW
EXECUTE FUNCTION update_loan_count();


