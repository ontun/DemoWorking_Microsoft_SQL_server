INSERT INTO Purchase(Purchase_id, Purchase_date_time, Client_id, Employee_id, Status_name, Post_id, Institution_id) 
VALUES 
(1, CONVERT(datetime, '2023-05-06 11:00:00'), 1, 1, '������� �� �����', 1, 1),
(2, CONVERT(datetime, '2023-05-06 12:00:00'), 2, 2, '������� �� �����', 2, 2),
(3, CONVERT(datetime, '2023-05-06 13:00:00'), 3, 3, '���������', 3, 3),
(4, CONVERT(datetime, '2023-05-06 14:00:00'), 4, 4, '�����', 1, 2),
(5, CONVERT(datetime, '2023-05-06 15:00:00'), 5, 5, '������� �� �����', 1, 3),
(6, CONVERT(datetime, '2023-05-06 16:00:00'), 6, 6, '���������', 1, 2),
(7, CONVERT(datetime, '2023-05-06 17:00:00'), 7, 7, '�����', 3, 2),
(8, CONVERT(datetime, '2023-05-06 18:00:00'), 8, 8, '������� �� �����', 2, 2),
(9, CONVERT(datetime, '2023-05-06 19:00:00'), 9, 9, '���������', 3, 2),
(10, CONVERT(datetime, '2023-05-06 20:00:00'), 10, 10, '�����', 2, 2),
(11, CONVERT(datetime, '2023-05-06 21:00:00'), 11, 10, '������� �� �����', 2, 2),
(12, CONVERT(datetime, '2023-05-06 22:00:00'), 12, 11, '���������', 1, 1),
(13, TRY_CONVERT(datetime, '2023-05-08 23:00:00'), 13, 12, '�����', 2, 2),
(14, TRY_CONVERT(datetime, '2023-05-08 00:00:00'), 14, 13, '������� �� �����', 3, 3),
(15, TRY_CONVERT(datetime, '2023-05-09 01:00:00'), 15, 14, '���������', 1, 1),
(16, TRY_CONVERT(datetime, '2023-05-10 02:00:00'), 16, 15, '�����', 1, 1),
(17, TRY_CONVERT(datetime, '2023-05-11 03:00:00'), 17, 1, '������� �� �����', 1, 1),
(18, TRY_CONVERT(datetime, '2023-05-02 04:00:00'), 18, 15, '���������', 1, 1),
(19, TRY_CONVERT(datetime, '2023-05-03 05:00:00'), 19, 15, '�����', 1, 1),
(20, TRY_CONVERT(datetime, '2023-05-12 06:00:00'), 20, 1, '������� �� �����', 1, 1),
(21, TRY_CONVERT(datetime, '2023-05-13 07:00:00'), 21, 2, '���������', 2, 2),
(22, TRY_CONVERT(datetime, '2023-05-14 08:00:00'), 22, 3, '�����', 3, 3),
(23, TRY_CONVERT(datetime, '2023-05-14 09:00:00'), 23, 4, '������� �� �����', 1, 2),
(24, TRY_CONVERT(datetime, '2023-05-14 10:00:00'), 24, 5, '���������', 1, 3),
(25, TRY_CONVERT(datetime, '2023-05-14 11:00:00'), 25, 5, '�����', 1, 3);