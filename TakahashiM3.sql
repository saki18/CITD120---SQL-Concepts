-- Masaki Takahashi
-- Assignment # 3
-- Instructor: Zack Hoffman
-- CITD 120 SQL Concepts 

USE CourseQuizzes; 

-- Task 1 
-- Display a list of dates that questions were modified. 
-- Display each date only once.

SELECT DISTINCT LastModDate 
From Questions; 

-- Task 2 
-- Professor Crewel is interested in knowing how many
-- topics have less than three class sessions.
-- Display the number of topics that have less than
-- three class sessions.

SELECT TopicId 
FROM Topics
WHERE NumClassSessions > 3;

-- Task 3 
-- Professor Crewel wants to know if the questions in the 
-- test bank are too hard or too easy. 
-- What is the average question difficulty?

SELECT AVG (Difficulty)
From Questions; 

-- Task 4 
-- Professor Crewel wants to know if the quizzes
-- themselves are too difficult. 
-- For how many quizzes did less than 10 students 
-- pass the quiz?

SELECT count(*)
FROM Quizzes
HAVING count(*)>10;  

-- Task 5 
-- Professor Crewel would like to know if she needs to 
-- add more questions about pots to the test bank.
-- For how many questions does the text contain the word
-- pot in the middle of the text?

SELECT count(*)
From Questions
WHERE TEXT like '%pot%';

-- Task 6 
-- Professor Crewel would like to know which topics 
-- contain questions that are the least difficult. 
-- List the title of the topics that have questions with 
-- difficulty level 1.

SELECT DISTINCT TopicId 
FROM Questions
WHERE Difficulty = 1;

-- I realize the instructions didn't ask for DISTINCT
-- but I would think this is what the Professor wanted. 

-- Task 7 
-- Professor Crewel would like to know which quizzes have the 
-- lowest low scores.List the quiz number and date of those 
-- quizzes that have a low score less than the average low score.

SELECT QuizNUM, QuizDate
FROM Quizzes 
WHERE Lowscore < AvgScore; 

-- Task 8 
-- Professor Crewel would like to make sure that all questions
-- have a difficulty level assigned to them. List the
-- question id and topic id of those questions that do not 
-- have a difficulty level assigned.

SELECT QuestionId, TopicID
FROM  Questions
WHERE Difficulty IS NULL;

-- Task 9
-- Professor Crewel is analyzing data about how students 
-- performed on a particular quiz over the various semesters.
-- She would like to know the average high score for each quiz 
-- number, but  considers only the quizzes that more than 
-- 10 students took (in one semester) to be statistically 
-- significant.For each quiz number list the quiz number and 
-- the average high score. Only include the quizzes that more
-- than 10 students took.

SELECT QuizNum, AVG(HighScore)
FROM Quizzes
Group BY NumStudents
HAVING COUNT(*)<10; 
 

-- Task 10 
-- Professor Crewel is analyzing data about how students 
-- performed on a particular quiz over the various semesters.
--  She would like to know the total number of students who
--  passed the quiz, but only wants to include the quizzes 
-- that more than 75 students took (total for all semesters)
-- List the quiz number and the total number of students 
-- passing that quiz for those quizzes that more than 
-- 75 students took.

SELECT QuizNum, NumStudents NumPassing 
From Quizzes 
Group By NumStudents 
HAVING COUNT(*)<75;

