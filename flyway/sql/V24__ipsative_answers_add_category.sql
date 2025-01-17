ALTER TABLE mappa.ipsative_answers ADD COLUMN category TEXT;

UPDATE mappa.ipsative_answers SET (category) =
  (SELECT mappa.ipsative_categories.category
  FROM mappa.ipsative_categories
  where mappa.ipsative_categories.uuid = mappa.ipsative_answers.category_id);

CREATE OR REPLACE VIEW mappa.ipsative_data AS

SELECT 
S.uuid as survey_id,
Q.uuid as question_id,
Q.title as question_title,
Q.order_number as question_order_number,
A.uuid as answer_id,
A.answer as answer,
A.order_number as answer_order_number,
A.category as category
FROM mappa.ipsative_surveys S
JOIN mappa.ipsative_questions Q  on S.uuid = Q.survey_id
JOIN mappa.ipsative_answers A on Q.uuid = A.question_id
ORDER BY question_order_number;

CREATE OR REPLACE VIEW "1".ipsative_data as
  SELECT *
  FROM mappa.ipsative_data;

GRANT SELECT, INSERT ON mappa.ipsative_data to member;
GRANT all ON "1".ipsative_data to member;
