DROP TABLE IF EXISTS Authors, Genres, Publishers, Books, Readers, Loans;

DROP TABLE IF EXISTS Authors CASCADE;
CREATE TABLE Authors (
    authorID SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
	patronymic VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS Genres CASCADE;
CREATE TABLE Genres (
    genreID SERIAL PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS Publishers CASCADE;
CREATE TABLE Publishers (
    publisherID SERIAL PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS Books CASCADE;
CREATE TABLE Books (
    bookID SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    authorID INT REFERENCES Authors(authorID),
    genreID INT REFERENCES Genres(genreID),
    publisherID INT REFERENCES Publishers(publisherID),
    publication_year INT,
    loan_count INT DEFAULT 0
);

DROP TABLE IF EXISTS Readers CASCADE;
CREATE TABLE Readers (
    readerID SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(255),
    phone_number VARCHAR(15)
);

DROP TABLE IF EXISTS Loans CASCADE;
CREATE TABLE Loans (
    loanID SERIAL PRIMARY KEY,
    bookID INT REFERENCES Books(bookID),
    readerID INT REFERENCES Readers(readerID),
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    is_overdue BOOLEAN DEFAULT FALSE
);

ALTER TABLE Readers 
RENAME COLUMN address TO email_address;

INSERT INTO Books(bookID, title, authorID, genreID, publisherID, publication_year, loan_count)
VALUES (1, 'Белая гвардия', 1, 1, 1, 1925, 15),
		(2, 'Мастер и Маргарита', 1, 1, 1, 1967, 6),
		(3, 'Братья Карамазовы', 2, 1, 2, 1880, 87),
		(4, 'Игрок', 2, 1, 2, 1866, 6),
		(5, 'Идиот', 2, 1, 2, 1868, 2),
		(6, 'Стихотворения и поэмы', 3, 2, 3, 1910, 12),
		(7, 'Черный человек', 3, 2, 3, 1926, 23),
		(8, 'Десять негритят', 4, 3, 3, 1939, 21);

INSERT INTO Loans(loanID, bookID, readerID, loan_date, return_date)
VALUES (1, 1, 1, '2024-10-03', '2025-01-01'),
		(2, 2, 1, '2024-11-08', '2024-11-15'),
		(3, 5, 2, '2024-11-12', '2024-11-26'),
		(4, 2, 2, '2024-12-23', '2025-01-09'),
		(5, 8, 2, '2024-12-28', '2025-01-03'),
		(6, 8, 3, '2025-01-03', '2025-01-27'),
		(7, 6, 3, '2025-01-09', NULL),
		(8, 8, 4, '2025-02-03', NULL);

INSERT INTO Authors(authorID, first_name, patronymic, last_name)
VALUES (1, 'Михаил', 'Афанасьевич', 'Булгаков'),
		(2, 'Фёдор','Михайлович', 'Достоевский'),
		(3, 'Сергей', 'Александрович', 'Есенин'),
		(4, 'Агата', '', 'Кристи');

INSERT INTO Genres(genreID, genre_name)
VALUES (1, 'Роман'),
		(2, 'Поэзия'),
		(3, 'Детектив');

INSERT INTO Publishers(publisherID, publisher_name)
VALUES (1, 'A'),
		(2, 'Б'),
		(3, 'В');
		
INSERT INTO Readers(readerID, first_name, last_name, email_address, phone_number)
VALUES (1,'Пётр', 'Сонько', 'sskfbkj@ej.d', 89109134567),
		(2,'ум', 'п3п3ще', 'sfeg@ej.d', 89109234567),
		(3,'ауа', 'релщр', 'ymyjt@ej.d', 89106534567),
		(4,'ауау', 'сцшца', 'qdqf@ej.d', 89176134567),
		(5,'АТМСЛ', '3еел', 'g434y@ej.d', 84309134567),
		(6,'Пётр', 'дпзр', 'g3g3@ej.d', 89109774567),
		(7,'ацуйй', 'цее', 'h4h45h@ej.d', 89104434567);
