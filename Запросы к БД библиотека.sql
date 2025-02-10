-- Топ 5 книг, которые были взяты наибольшее количество раз в прошлом месяце и количество раз, которое их брали.

SELECT 
    b.title AS Название_книги, 
    COUNT(l.loanID) AS Количество_выдач
FROM Loans l
	INNER JOIN Books b ON l.bookID = b.bookID
WHERE l.loan_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')
	AND l.loan_date < DATE_TRUNC('month', CURRENT_DATE)
GROUP BY b.title
ORDER BY Количество_выдач DESC
LIMIT 5;

-- ФИО читателей и количество просроченных (книги, которые не вернули в срок) ими разных 
-- (если один читатель брал книгу дважды и оба раза просрочил - нужно учитывать 1 раз) книг в жанре "Детектив"

SELECT 
    r.last_name || ' ' || r.first_name || ' ' || r.patronymic AS ФИО_читателя,
    COUNT(DISTINCT l.bookID) AS Количество_просроченных_книг
FROM Loans l
	INNER JOIN Books b ON l.bookID = b.bookID
	INNER JOIN Genres g ON b.genreID = g.genreID
	INNER JOIN Readers r ON l.readerID = r.readerID
WHERE g.genre_name = 'Детектив'
	AND l.return_date > l.due_date
GROUP BY r.readerID, r.first_name, r.last_name;