# Library-DB
База данных написана в СУБД PostgreSQL. В репозитории прикреплены:
- создание БД (`Инициализация.sql`)
- триггер проверяющий корректность return_date (`Триггер (check_return_date).sql`)
- триггер подсчета количечтво взятых книг (`Триггер (loan_count).sql`)
- триггер автоматически заполняющий столбцы due_date и is_overdue (`Триггер (due_date and is_overdue).sql`)
- запросы к БД, задание 3 (`Запросы к БД библиотека.sql`)
---
- ER-диаграмма построена в онлайн редакторе https://www.lucidchart.com (`LibraryDB.png` прикреплено ниже) и в PowerBI (`ERD.pbix`)
---
![Иллюстрация к проекту](https://github.com/Sonkopeter/Library-DB/blob/main/LibraryDB.png)

---
### 1. **Таблица `Authors` (Авторы)**:
   - **Поля**:
     - `author_id` (Primary Key).
     - `first_name`, `last_name`, `patronymic`: Имя, фамилия и отчество автора. (`VARCHAR(100) NOT NULL`)
   - **Связи**:
     - Связь **один ко многим** (`Authors.author_id` → `Books.author_id)`.

---

### 2. **Таблица `Genres` (Жанры)**:
   - **Поля**:
     - `genre_id` (Primary Key): Уникальный идентификатор жанра.
     - `genre_name`: Название жанра. (`VARCHAR(100) NOT NULL`)
   - **Связи**:
     - Связь **один ко многим** (`Genres.genre_id` → `Books.genre_id`).
    
---

### 3. **Таблица `Publishers` (Издатели)**:
   - **Поля**:
     - `publisher_id` (Primary Key): Уникальный идентификатор издателя.
     - `publisher_name`: Название издателя. (`VARCHAR(255) NOT NULL`)
   - **Связи**:
     - Связь **один ко многим** (`Publishers.publisher_id` → `Books.publisher_id`).

---

### 4. **Таблица `Books` (Книги)**:
   - **Поля**:
     - `book_id` (Primary Key): Уникальный идентификатор книги.
     - `title`: Название книги. (`VARCHAR(100) NOT NULL`)
     - `author_id` (Foreign Key): Ссылка на таблицу `Authors`. (`INT`)
     - `genre_id` (Foreign Key): Ссылка на таблицу `Genres`. (`INT`)
     - `publisher_id` (Foreign Key): Ссылка на таблицу `Publishers`. (`INT`)
     - `publication_year`: Год публикации книги. (`INT`)
     - `loan_count`: Количество выдач книги. (`INT DEFAULT 0`)
   - **Связи**:
     - Связана с таблицей `Authors` через `author_id`.
     - Связана с таблицей `Genres` через `genre_id`.
     - Связана с таблицей `Publishers` через `publisher_id`.
     - Связь **один ко многим** (`Books.book_id` → `Loans.book_id`).

---

### 5. **Таблица `Loans` (Выдачи)**:
   - **Поля**:
     - `loan_id` (Primary Key): Уникальный идентификатор выдачи.
     - `book_id` (Foreign Key): Ссылка на таблицу `Books`. (`INT`)
     - `reader_id` (Foreign Key): Ссылка на таблицу `Readers`. (`INT`)
     - `loan_date`: Дата выдачи книги. (`DATE NOT NULL`)
     - `due_date`: Срок возврата книги. (`DATE NOT NULL`)
     - `return_date`: Дата возврата книги. (`DATE`)
     - `is_overdue`: Флаг, указывающий, была ли книга возвращена с опозданием. (`BOOLEAN DEFAULT FALSE`)
   - **Связи**:
     - Связана с таблицей `Books` через `book_id`.
     - Связана с таблицей `Readers` через `reader_id`.

---

### 6. **Таблица `Readers` (Читатели)**:
   - **Поля**:
     - `reader_id` (Primary Key): Уникальный идентификатор читателя.
     - `first_name`, `last_name`: Имя и фамилия читателя. (`VARCHAR(100) NOT NULL`)
     - `phone_number`: Номер телефона читателя. (`VARCHAR(15)`)
     - `email_address`: Электронная почта читателя. (`VARCHAR(255)`)
   - **Связи**:
     - Связь **один ко многим** (`Readers.reader_id` → `Loans.reader_id`).

---

### Итог:
- Таблица `Books` является центральной, связывающей авторов, жанры, издателей и выдачи.
- Схема нормализована и соответствует схеме "Снежинка" (Snowflake Schema).
