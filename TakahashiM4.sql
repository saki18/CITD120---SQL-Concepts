-- Masaki Takahashi
-- Assignment # 4
-- Instructor: Zack Hoffman
-- CITD 120 SQL Concepts 

USE CourseQuizzes; 

-- Task 1 .   
-- (2 points) Professor Crewel would like to see the 
-- distribution of questions difficulty among the various 
-- topics. For each question list the topic title, 
-- the question id, and the question difficulty. 
-- Sort the results for question difficulty.
--  Within question difficulty sort the questions by 
-- topic title. Use a join. Do not use the INNER JOIN keywords.
--  35 rows should be returned.

SELECT Title, questionId, difficulty 
FROM Topics,Questions 
WHERE Topics.TopicId =Questions.TopicId;

-- Task 2
-- Professor Crewel would like to know the text of the 
-- questions she has used on quiz 2.
-- List the question text for the questions for quiz 2. 
-- Do not use a join. Use the IN operator.  
-- 10 rows should be returned.

SELECT TEXT
FROM Questions
WHERE QuestionID IN  
(SELECT QuestionID
FROM QuizQuestions
WHERE QuizNum = 2);

-- Task 3
-- Professor Crewel would like to know which questions she 
-- has used on quiz 2. List the question text for the questions
-- for quiz 2. Do not use a join. Use the EXISTS operator. 
--  10 rows should be returned.

SELECT TEXT 
FROM Questions 
Where EXISTS 
(SELECT *
FROM QuizQuestions 
WHERE QuizQuestions.QuestionID = Questions.QuestionID 
AND QuizNum = 2); 


-- Task 4
-- Professor Crewel would like to know if the students have
-- been guessing answer C for those questions that have an 
-- answer C where the correct answer is not C.
-- For each question that has an answer C, but the correct 
-- answer is not C, list the quiz number, the question id,
--  the question text, the correct answer, the number of 
-- students who took the quiz, and the number of students 
-- who chose answer C. Do not use IN or EXISTS. 
-- Do not use the INNER JOIN format for joining tables.  
-- Hint: when there is a composite primary key, 
-- the foreign key matching must also be composite requiring 
-- as many WHERE clauses as there are primary/foreign keys. 
-- 27 rows should be returned.

SELECT Quizzes.QuizNum, Quizzes.QuizDate, TITLE,
Questions.QuestionId, CorrectAnswer, NumStudents, NumChoseC
FROM Quizzes, Topics, QuizQuestions, Questions
WHERE Quizzes.QuizNum = QuizQuestions.QuizNum
AND Quizzes.QuizDate = QuizQuestions.QuizDate
AND QuizQuestions.QuestionId = Questions.QuestionId
AND Questions.topicId = TOPICS.TOPICID
AND AnswerC is not null 
AND CorrectAnswer <> 'C'; 

-- Task 5 -- 
-- Professor Crewel would like to compare whether students are
-- consistent in choosing answers for the same question for the
-- different quizzes. 
-- For each question that was on more than one quiz, 
-- list the following:
-- • the question id,
-- • the quiz date of the first quiz,
-- • the number of students who chose answer A on the first quiz,
-- • the quiz date of the second quiz,
-- • and the number of students who chose answer A on the second quiz.
-- The question id should be the major sort key. The first quiz
--  date listed should be the minor sort key. The column name 
-- for the first quiz should be FirstQuiz. The column name for
--  the number of students who chose answer A on the first quiz
--  should be FirstA. The column name for the second quiz should
--  be SecondQuiz. The column name for the number of students
--  who chose answer A on the second quiz should be SecondA. 
--  Do not use the INNER JOIN format for joining tables. 
-- 26 rows should be returned.

Select f. questionid, f. quizdate as FirstQuiz,
	f. numchoseA as FirstA,
	s. quizdate as secondquiz, s. numchoseA as SecondA
From quizquestions f, quizquestions s
Where f.questionid = s.questionid
And f.quizdate < s.quizdate
Order by f.questionid, f.quizdate;


-- Task 6 
-- Professor Crewel would like to know the question id, 
-- question text, and text of answer A for all questions whose
-- answer is A or where the topic has more than 2 class 
-- sessions. 
-- List the question id, question text, text of answer A
--  for all questions whose answer is A or where the topic
--  has more than 2 class sessions. Use a UNION. Do not use
--  the INNER JOIN format for joining tables (but using a
--  “regular” join is OK).  Sort by question text.  
-- 19 rows should be returned.

SELECT Questions.QuestionID, Text, AnswerA
From Questions
WHERE CorrectAnswer = 'A'
union 
select questionid, text, AnswerA 
FROM Questions, Topics
WHERE Topics.TopicId = Questions.TopicId
AND NumClassSessions > 2 
order by text;

-- task 7 
-- List the question id, question text, text of answer A 
-- for all questions whose answer is A or where more than 
-- 10 students chose answer A. Do not use a UNION. 
-- Do not use the INNER JOIN format for joining tables.  
-- Sort by question text.  19 rows should be returned.

SELECT Questions.QuestionId, text, AnswerA
FROM Questions, Topics, QuizQuestions
WHERE Questions.TopicId= Topics.TopicId
AND QuizQuestions.QuestionID = Questions.QuestionID 
AND (CorrectAnswer = 'A' 
or NumChoseA > 10) 
order by TEXT; 

-- Task 8 
-- Professor Crewel would like to know the status of the questions
-- that have a difficulty that is less than the difficulty of 
-- questions with the topic id Qult. Find the question id and status
--  of each question whose difficulty level is less than the 
-- difficulty of all questions with topic id Qult. Use ANY or ALL.
--  Do not use the INNER JOIN format for joining tables.
-- Note: You need to make your choice based upon what the task 
-- is requiring you to do. Only one choice, ANY or ALL, 
-- is correct. If the correct choice is ANY, then it is not possible
-- to formulate a correct statement using ALL. If the correct choice
-- is ALL, then it is not possible to formulate a correct statement
-- using ANY. 6 rows should be returned.



Select questionid, status  
from Questions
Where Difficulty < all  
(select Difficulty
from Questions
where TopicId = 'Qult');


-- Task 9 
-- Professor Crewel would like to know the status of the questions 
-- that have a difficulty that is less than the difficulty of 
-- questions with the topic id Qult.
-- Find the question id and status of each question whose difficulty
-- level is less than the difficulty of all questions with topic id
-- Qult. Do not use ANY or ALL.  Do not use the INNER JOIN format
-- for joining tables. The same 6 rows should be returned as
-- for question #3.

select QuestionId, status 
from Questions
where Difficulty <
(select min(difficulty)
from Questions 
Where TopicID = 'Qult'); 


-- Task 10 
-- Professor Crewel is interested to know the number of 
-- students who pass quizzes which contain questions with 
-- a difficulty of 3 or more.  She wants to know the question’s
--  text and which topic it comes from as well as the date the 
-- quiz was given. List the text of all questions with a 
-- difficulty of 3 or higher.  For each of these questions, 
-- also list its topic title, quiz number in which it appears
-- and date that quiz was given.  List the number of students
--  who passed the quiz.  Order the rows returned by date.
--   Do not use the INNER JOIN format for joining tables. 
-- Hint: when there is a composite primary key, 
-- the foreign key matching must also be composite requiring
--  as many WHERE clauses as there are primary/foreign keys.

SELECT questions.TEXT, topics.Title, quizzes.QuizNum,
quizzes.QuizDate, quizzes.NumPassing 
FROM questions, quizquestions, quizzes,topics 
WHERE quizzes.Quizdate = quizquestions.quizdate
and Quizzes.QuizNum = QuizQuestions.Quiznum 
and quizquestions.QuestionID = questions.QuestionId 
and questions.TopicID = topics.TopicID 
and DIFFICULTY >= 3
order by QuizDate; 


