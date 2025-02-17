DROP TRIGGER IF EXISTS trigger_set_due_date_and_is_overdue
ON Loans;

CREATE OR REPLACE FUNCTION set_due_date_and_is_overdue()
RETURNS TRIGGER AS $$
BEGIN
    -- Автоматически вычисляем due_date
    NEW.due_date = NEW.loan_date + INTERVAL '14 days';

    -- Устанавливаем is_overdue
    IF NEW.return_date IS NOT NULL THEN
        -- можем сразу писать так, потому что булевая
        NEW.is_overdue = NEW.return_date > NEW.due_date;
    ELSE
        -- Если книга ещё не возвращена, проверяем текущую дату
        NEW.is_overdue = CURRENT_DATE > NEW.due_date;
    END IF;

    -- IF NEW.return_date IS NOT NULL THEN
    --     IF NEW.return_date > NEW.due_date THEN
    --         NEW.is_overdue = TRUE;
    --     ELSE
    --         NEW.is_overdue = FALSE;
    --     END IF;
    -- ELSE
    --     NEW.is_overdue = FALSE;
    -- END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_due_date_and_is_overdue
BEFORE INSERT OR UPDATE ON Loans
FOR EACH ROW
EXECUTE FUNCTION set_due_date_and_is_overdue();
