-- Masaki Takahashi
-- Assignment # 6
-- Instructor: Zack Hoffman
-- CITD 120 SQL Concepts 


-- Task 1
-- Once a question has been moved to the Retired table,
-- Professor Crewel no longer needs the status. 
-- Remove the column named Status from the Retired table.
-- Verify that the column has been deleted by using 
-- the DESCRIBE statement. 
-- (1 alter command and 1 describe command.)
-- The final answer is: 

ALTER Table Retired
Drop Status;
DESCRIBE Retired; 
 

-- Task 2
-- Once a question has been moved to the Retired table,
-- the last modification date should be the date the
-- question was moved. Set the value in the value of 
-- the last modification date to today for all rows.
-- Verify that the data exists in the table by showing
-- all the contents of the table. 
-- (1 update command and 1 select command.)
-- The final answer is: 

Update Retired
Set LastModDate = '2015-07-26';

Select * 
From Retired; 


-- Task 3
-- Once a question has been moved to the Retired table, 
-- Professor Crewel wants to be able to store the average
-- number of students who correctly answered the questions.
-- In the Retired table change the Difficulty column so it
-- can accept a number as high as 99.9 with no more than one
-- decimal place. Verify that the column has been changed by
-- using the DESCRIBE statement. 
-- (1 alter command and 1 describe command.)
-- The final answer is: 

alter table retired 
Modify difficulty decimal(3,1); 
describe retired; 


-- Task 4 
-- Once a question has been moved to the Retired table, 
-- it is required to have a last modification date.
-- Change the LastModDate column in the Retired table to 
-- reject nulls. Verify that the column has been changed by
-- using the DESCRIBE statement. 
-- (1 alter command and 1 describe command.)
-- The final answer is: 


Alter Table Retired 
Modify LastModDate date not Null; 
describe retired; 

-- Task 5
-- Which of the changes you made in Tasks 1 through 4 cannot 
-- be undone using a ROLLBACK command? Why?
-- The final answer is:

-- Task 1, Task 3 & Task 4 as ALTER TABLE does its own COMMIT. You cannot 
-- roll back a change made with ALTER TABLE; you must use another ALTER TABLE
-- command to undo the changes. 


-- Task 6
-- Professor Crewel often wants to review the questions that
-- have a difficulty of less than 3.
-- Create a view named EasyQuestions that contains the question Id.
-- topic Id, text, and correct answer of every question with a
-- difficulty less than 3. Verify that the view has been created 
-- correctly by showing all the contents of the view. 
-- (1 create command and 1 select command. 14 rows should be returned.)


Create View EasyQuestions as 
SELECT QuestionId, TopicID, Text, CorrectAnswer 
From Questions 
Where Difficulty < 3; 

Select *
From EasyQuestions; 

-- Task 7
-- Professor Crewel would like to view information for the easy questions
-- that have a correct answer of A.
-- Using the EasyQuestions view list the text, topic id, and question id 
-- for every easy question whose correct answer is A. 
-- (6 rows should be returned.)
-- The final answer is: 


SELECT Text, TopicId, QuestionId
From EasyQuestions
WHERE CorrectAnswer = 'A'; 


-- Task 8
-- Professor Crewel frequently often want to review information about
-- questions on quizzes that appear to be difficult.
-- Create a view named HardQuizzes that contains the quiz number, 
-- quiz date, average score, question id, number of students who 
-- chose A, number of students who chose B, number of students who chose C,
-- and number of students who chose D for each question on a quiz where 
-- the average score is less than 15.
-- Verify that the view has been created correctly by showing all 
-- the contents of the view. 
-- (1 create command and 1 select command. 5 rows should be returned.)
-- The final answer is: 

Create View HardQuizzes 
AS SELECT Q.QuizNum, Q.QuizDate, AvgScore, QuestionID, NumChoseA, NumChoseB, NumChoseC, NumChoseD
From QuizQuestions QU 
Inner Join Quizzes Q
On Q.Quiznum = Qu.Quizdate
and Q.Quizdate = Qu.Quizdate
Where AvgScore < 15; 

SELECT * 
From HardQuizzes; 


-- Task 9 
-- Professor Crewel would like to analyze the questions on difficult quizzes
-- where more students chose answer A than answer B.
-- Using the HardQuizzes view, List the quiz number, quiz date, topic title,
-- question text, and the correct answer for those questions on difficult
--  quizzes where more students chose answer A than chose answer B. 
-- (2 rows should be returned.)
-- The final answer is: 

 
Select H.QuizNum, H.QuizDate, Title, Text, CorrectAnswer 
From HardQuizzes H, Questions Q, Topics T
Where Q.TopicID = T.TopicID
and Q.QuestionID = H.QuestionID
And NumChoseA > NumchoseB; 


-- Task 10
-- Professor Crewel often want to know how many times a question has 
-- been used and the average number of students who chose each answer.
-- Create a view named QuestionStats that contains the question id, 
-- number of times it has been used, average number of students who 
-- chose answer A, average number of students who chose answer B, 
-- average number of students who chose answer C, and average number 
-- of students who chose answer D. Use Used as the name of the column 
-- that containsnumber of times the question has been used. 
-- Use A as the name of the column that contains the average number 
-- of students who chose answer A. Use B as the name of the column 
-- that contains the average number of students who chose answer B. 
-- Use C as the name of the column that contains the average number 
-- of students who chose answer C. Use D as the name of the column 
-- that contains the average number of students who chose answer D.
-- Verify that the view has been created correctly by showing all the
-- contents of the view.
-- (1 create command and 1 select command. 29 rows should be returned.)
-- The final answer is: 


Create View QuestionStats (QuestionID, Used, A,B,C,D)
As Select QuestionID, Count(*), AVG(NumChoseA),AVG(NumChoseB), AVG(NumChoseC), AVG(NumChoseD)
From QuizQuestions
GROUP By QuestionID; 


Select * 
From QuestionStats; 