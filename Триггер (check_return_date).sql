CREATE OR REPLACE FUNCTION check_return_date()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.return_date IS NOT NULL AND NEW.return_date < NEW.loan_date THEN
        RAISE EXCEPTION 'Дата возврата не может быть раньше даты выдачи!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_return_date
BEFORE INSERT OR UPDATE ON Loans
FOR EACH ROW
EXECUTE FUNCTION check_return_date();