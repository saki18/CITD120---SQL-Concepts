USE TESTALEX;


-- task 1
SELECT * FROM TESTOWNER;

-- Task 2
INSERT INTO TESTOWNER
VALUES
('KA63', 'Kane', 'Candy', '123 Sugar Loaf' , 'Lansing' , 'MI' ,'48901');

-- Task 3
INSERT INTO TESTOWNER (OWNER_NUM, LAST_NAME, FIRST_NAME)
VALUES ('TW23','Twain', 'Lionel'); 

-- Task 4 

UPDATE TESTOWNER 
SET ADDRESS='405 Orange Grv'
WHERE Owner_Num='AD57'; 

-- Task 5 

DELETE FROM TESTOWNER
WHERE Owner_Num='AN75';

USE COURSEQUIZZES;

-- Task 6 
SELECT QuizDate
FROM Quizzes
WHERE QuizNum = 1;

-- Task 7 
SELECT TopicId, Text
FROM Questions 
WHERE  CorrectAnswer != 'D';

-- Task 8 
SELECT QuizNum, QuizDate
FROM Quizzes
WHERE LowScore >= 10
AND LowScore <= 15;

-- Task 9 
SELECT TITLE, NumClassSessions, 
(NumClassSessions * .75) 
AS NewSessions
FROM Topics; 

-- Task 10 
SELECT QuestionId, text, difficulty, TopicId 
FROM QUESTIONS  
WHERE TopicID IN ('Qult','Pott','Jewl')
Order by difficulty DESC, Text;