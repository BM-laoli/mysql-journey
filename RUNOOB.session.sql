SELECT *
FROM websites;
SELECT *
FROM access_log;
SELECT *
FROM apps;
SELECT *
FROM WebsitesBackup2016;
DELETE FROM WebsitesBackup2016;
-- 创建 Websites 的备份复件：
CREATE TABLE WebsitesBackup2016 AS
SELECT *
FROM websites;
-- 只复制一些列插入到新表中：
SELECT name,
  url INTO WebsitesBackup2016
FROM Websites;
-- 只复制中国的网站插入到新表中：
SELECT * INTO WebsitesBackup2016
FROM Websites
WHERE country = 'CN';
-- 复制多个表中的数据插入到新表中：
SELECT websites.name,
  access_log.count,
  access_log.date INTO WebsitesBackup2016
FROM websites
  LEFT JOIN access_log ON websites.id = access_log.site_id;