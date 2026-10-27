# Assignment 5 – Electronic Gradebook

## Decisions I made and why

I use three tables: `students`, `subjects` and `grades`. Names are stored only once, and every grade points to its student and subject with a FOREIGN KEY, so a grade cannot belong to someone or something that does not exist. `grades` has its own `id` as PRIMARY KEY instead of (student, subject, date), because a student can get two grades in the same subject on the same day (for example an oral answer and a test). The grade is a `NUMERIC(3,2)` (one digit before the point and two after, so grades like 5.50 fit) with `CHECK (grade BETWEEN 2 AND 6)` so the database itself refuses wrong grades, and the date is a `DATE` so it sorts correctly. I deliberately do not store averages, because they are calculated by a query and can never be out of date, and I do not store which student takes which subject, because everyone in one class studies the same subjects.

## Trying to insert a grade of 7

```sql
INSERT INTO grades (student_id, subject_id, grade, graded_on) VALUES (1, 1, 7, '2026-10-20');
```

The database answers:

```
ERROR:  new row for relation "grades" violates check constraint "grades_grade_check"
DETAIL:  Failing row contains (25, 1, 1, 7.00, 2026-10-20).
```

A grade for a student that does not exist (`student_id = 999`) is refused too:

```
ERROR:  insert or update on table "grades" violates foreign key constraint "grades_student_id_fkey"
DETAIL:  Key (student_id)=(999) is not present in table "students".
```
