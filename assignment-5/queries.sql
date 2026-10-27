-- Question 1: all grades of a given student in a given subject, by date.
-- Returns the date and the grade, one row per grade, oldest first
-- (here: Ivan Petrov in Mathematics). Grades on the same date keep the order they were entered.
SELECT g.graded_on, g.grade
FROM grades g
JOIN students s   ON s.id = g.student_id
JOIN subjects sub ON sub.id = g.subject_id
WHERE s.first_name = 'Ivan' AND s.last_name = 'Petrov'
  AND sub.name = 'Mathematics'
ORDER BY g.graded_on, g.id;

-- Question 2: the class average grade in each subject (two decimals) and the number of grades.
-- Returns one row per subject; LEFT JOIN keeps a subject with no grades (count 0, empty average).
SELECT sub.name               AS subject,
       ROUND(AVG(g.grade), 2) AS average_grade,
       COUNT(g.id)            AS grade_count
FROM subjects sub
LEFT JOIN grades g ON g.subject_id = sub.id
GROUP BY sub.id, sub.name
ORDER BY sub.name;
