UPDATE Client SET Client_gender = 'Мужской' WHERE Client_id IN (1,3,5,9,11,13,15,17,19,21,23);
UPDATE Client SET Client_gender = 'Женский' WHERE Client_id IN (2,4,6,7,8,10,12,14,16,18,20,22,24,25);
UPDATE Client SET Client_birthday = CONVERT(date,'1990-01-01') WHERE Client_id IN (1,2,3,4,5);
UPDATE Client SET Client_birthday = CONVERT(date,'1995-01-01') WHERE Client_id IN (6,7,8,9,10);
UPDATE Client SET Client_birthday = CONVERT(date,'2000-01-01') WHERE Client_id IN (11,12,13,14,15);
UPDATE Client SET Client_birthday = CONVERT(date,'2005-01-01') WHERE Client_id IN (16,17,18,19,20);
UPDATE Client SET Client_birthday = CONVERT(date,'2010-01-01') WHERE Client_id IN (21,22,23,24,25);