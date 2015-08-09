-- Masaki Takahashi
-- Assignment # 5
-- Instructor: Zack Hoffman
-- CITD 120 SQL Concepts 

USE CourseQuizzes; 

-- Task 1
-- Professor Crewel would like to see how the correct answers 
-- are distributed among the various topics. For each question,
-- list the question Id, the topic title, the correct answer,
--  and the difficulty. Sort the results by correct answer. 
-- Within correct answer sort the questions by topic title. 
-- Use the INNER JOIN syntax. (35 rows should be returned.)
-- This is the answer

SELECT QuestionID, Title,CorrectAnswer, Difficulty 
FROM Questions 
INNER JOIN TOPICS 
ON Topics.TopicID = Questions.TopicID 
ORDER BY Title; 


-- Task 2
-- Professor Crewel would like to know how many students choose 
-- answer D correctly. For each question where the correct answer
-- is D, List the Question Id, the Quiz Number, the QuizDate and 
-- the number of students who chose answer D. 
-- Use the INNER JOIN syntax. (7 rows should be returned.)
-- This is the answer

SELECT Questions.QuestionId, QuizNum, QuizDate, NumChoseD
FROM  QuizQuestions 
INNER JOIN Questions
ON QuizQuestions.QuestionId = Questions.QuestionId
WHERE CORRECTANSWER = 'D'; 

-- Task 3
-- Professor Crewel would like to know the topics that were on 
-- the quizzes where there is a significant difference between 
-- the high score and the low score. List the quiz number, date, and
--  topics for those quizzes where the difference between the 
-- high score and the low score is greater than 8.
--  Use the INNER JOIN syntax. (10 rows should be returned.)
-- This is the answer

SELECT Quizzes.QuizNum, Quizzes.QuizDate, Topics.TopicId
FROM Quizzes
INNER JOIN QuizQuestions
ON quizzes.quiznum = QuizQuestions.quiznum
and quizzes.QuizDate = QuizQuestions.QuizDate
inner join questions
on quizquestions.questionid = questions.questionid
inner join topics
on questions.TopicId = topics.topicid
WHERE (highscore - lowscore) > 8;

-- Task 4
-- Professor Crewel would like a list of all topics and the question
-- ids, and difficulty levels for those questions that have four 
-- choices. List the topic title, question id, and difficulty levels
-- for those questions that have four choices. All topics must be 
-- included in the list regardless of whether there are any questions
--  for the topic. Sort the results by topic title. 
-- (29 rows should be returned.)
-- This is the answer

SELECT Title, QuestionId, Difficulty 
From Topics Left Join Questions
on Topics.TopicID = Questions.TopicID
Where AnswerD is Not Null
order by title; 

-- SELECT *
-- FROM Topics
-- LEFT JOIN Questions
-- ON Topics.TopicId = Questions.TopicID
-- Where AnswerD is Not Null
-- order by title;

-- Task 5 
-- Create a product of the Quizzes and Topics tables. Include the
-- quiz number, quiz date, and number of class sessions in your 
-- result. Sort the result by quiz date. 
-- (312 rows should be returned.)
-- This is the answer

SELECT QuizNum, QuizDate, NumClassSessions
FROM Quizzes, Topics
Order by QuizDate; 

-- Task 6
-- Professor Crewel would like to keep track of the retired questions
-- and make some changes without affecting the current data.
-- Create a table named Retired with the same structure as the 
-- Questions table. Use the DESCRIBE command with both tables to 
-- show that they have the same structure. 
-- (1 create command and 2 describe commands.)
-- This is the answer

CREATE TABLE Retired like Questions;
DESCRIBE Questions;
DESCRIBE Retired; 

-- Task 7 
-- Professor Crewel would like to keep track of the retired questions
-- and make some changes without affecting the current data.
-- Insert into the Retired table the rows from the Questions table 
-- that have been retired (status is R). Verify that the data exists
--  in the table by showing all the contents of the table. 
-- (1 insert command and 1 select command.)
-- This is the answer

insert into Retired 
select *
From Questions 
Where Status = 'R'; 


-- Task 8 
-- Professor Crewel would like to change the difficulty of the 
-- true/false questions. Note: In MySQL Workbench, for this change to work, 
-- you must uncheck the “Safe Updates” checkbox using the menus: 
-- Edit / Preferences / SQL Queries.
-- In the Retired table double the difficulty of the true/false 
-- questions. Verify the changes by showing all the contents of the
-- table. (1 update command and 1 select command.)
-- This is the answer

UPDATE Retired
SET Difficulty = Difficulty * 2 
Where AnswerC is Null; 


-- Task 9 
-- Professor Crewel does not need the question with the topic id Jewl. 
-- Delete the Question in the Retired table having topic id Jewl.
--  Verify the changes by showing all the contents of the table. 
-- (1 delete command and 1 select command.)
-- This is the answer

DELETE from Retired 
WHERE topicid = Jewl; 

-- Task 10 
-- Professor Crewel has decided to give the students no more than
-- three choices for the questions about scrapbooking. In the
-- Retired table change Answer D for the questions that have topic 
-- id Scrp to null. Verify the changes by showing all the contents 
-- of the table. (1 update command and 1 select command.)
-- This is the answer

UPDATE Retired 
SET AnswerD = Null 
Where TopicId = 'Scrp'; 
