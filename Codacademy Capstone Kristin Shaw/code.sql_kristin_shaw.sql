SELECT *
 FROM survey
 LIMIT 10;

SELECT  question, 
 	COUNT(DISTINCT user_id)
 FROM survey
 GROUP BY question;

-------------------------
SELECT *
 FROM quiz
 LIMIT 5;

 SELECT *
 FROM home_try_on
 LIMIT 5;

 SELECT *
 FROM purchase
 LIMIT 5;


SELECT DISTINCT q.user_id,
  h.user_id IS NOT NULL AS 'is_home_try_on',
  h.number_of_pairs,
  p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
	ON q.user_id = h.user_id
LEFT JOIN purchase p
	ON q.user_id = p.user_id
LIMIT 10;

----------------------------------
WITH funnels AS (
SELECT DISTINCT q.user_id,
	h.user_id IS NOT NULL AS 'is_home_try_on',
  h.number_of_pairs,
  p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz as 'q'
LEFT JOIN home_try_on as 'h'
	ON q.user_id = h.user_id
LEFT JOIN purchase as 'p'
	ON q.user_id = p.user_id)
SELECT COUNT(*) AS 'num_quiz',
   SUM(is_home_try_on) AS 'num_try_on',
   SUM(is_purchase) AS 'num_purchase'
FROM funnels;


---------------------------------
WITH funnels AS (
SELECT DISTINCT q.user_id,
	h.user_id IS NOT NULL AS 'is_home_try_on',
  h.number_of_pairs,
  p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz as 'q'
LEFT JOIN home_try_on as 'h'
	ON q.user_id = h.user_id
LEFT JOIN purchase as 'p'
	ON q.user_id = p.user_id)
SELECT number_of_pairs, COUNT(*) AS 'num_quiz',
   SUM(is_home_try_on) AS 'num_try_on',
   SUM(is_purchase) AS 'num_purchase'
FROM funnels
WHERE number_of_pairs IS NOT NULL
GROUP BY number_of_pairs;

----------------------------------

It appears the survey respondent can pick multipe responses to questions, however, this shows that questions and response counts are the same for each user (looking at 100). 
SELECT user_id, count(question), count(response)
FROM survey
GROUP BY user_id
ORDER BY user_id desc
LIMIT 100;

----------------------------------
Descriptive analysis of Purchase and quiz table data (examples):

SELECT style, COUNT(style)
FROM purchase
GROUP BY style;

SELECT color, COUNT(color)
FROM purchase
GROUP BY color
ORDER BY COUNT(color) desc;

SELECT color, COUNT(color), style
FROM purchase
GROUP BY color, style
ORDER BY COUNT(color) desc;

SELECT color, COUNT(color), style
FROM quiz
GROUP BY color, style
ORDER BY COUNT(color) desc;