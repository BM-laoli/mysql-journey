-- 在RUNOOB 中创建一个视图
SELECT *
FROM access_log;
SELECT *
FROM websites;
SELECT MID(name, 1, 4) AS ShortTitle
FROM websites;
SELECT name,
  url,
  DATE_FORMAT(Now(), '%Y-%m-%d') AS date
FROM websites;