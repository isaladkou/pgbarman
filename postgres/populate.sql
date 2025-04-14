-- Создание таблицы учителей
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    subject VARCHAR(50)
);

-- Создание таблицы классов
CREATE TABLE Classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(20),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

-- Создание таблицы учеников
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    birth_date DATE,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

-- Вставка данных в таблицу учителей
INSERT INTO Teachers (teacher_id, full_name, subject) VALUES
(1, 'Иванова Мария Петровна', 'Математика'),
(2, 'Сидоров Алексей Викторович', 'Русский язык'),
(3, 'Петрова Елена Николаевна', 'История');

-- Вставка данных в таблицу классов
INSERT INTO Classes (class_id, class_name, teacher_id) VALUES
(101, '5А', 1),
(102, '6Б', 2),
(103, '7В', 3);

-- Вставка данных в таблицу учеников
INSERT INTO Students (student_id, full_name, birth_date, class_id) VALUES
(1, 'Анна Смирнова', '2012-04-15', 101),
(2, 'Дмитрий Кузнецов', '2011-09-10', 102),
(3, 'Екатерина Васильева', '2010-01-22', 103),
(4, 'Игорь Мельников', '2012-07-03', 101),
(5, 'Мария Фролова', '2011-03-17', 102);
