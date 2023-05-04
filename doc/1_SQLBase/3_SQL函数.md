# 概述
>
> SQL 拥有很多可用于计数和计算的内建函数

1. SQL Aggregate

SQL Aggregate 函数计算从列中取得的值，返回一个单一的值。

- AVG() - 返回平均值
- COUNT() - 返回行数
- FIRST() - 返回第一个记录的值
- LAST() - 返回最后一个记录的值
- MAX() - 返回最大值
- MIN() - 返回最小值
- SUM() - 返回总和

2. SQL Scalar

SQL Scalar 函数基于输入值，返回一个单一的值。

- UCASE() - 将某个字段转换为大写
- LCASE() - 将某个字段转换为小写
- MID() - 从某个文本字段提取字符，MySql 中使用
- SubString(字段，1，end) - 从某个文本字段提取字符
- LEN() - 返回某个文本字段的长度
- ROUND() - 对某个数值字段进行指定小数位数的四舍五入
- NOW() - 返回当前的系统日期和时间
- FORMAT() - 格式化某个字段的显示方式

3. 其它

- GROUP BY  - 聚合
- HAVING  - 聚合
- EXISTS  - 聚合

## SQL Aggregate

### AVG
>
> 很简单 就是平均值

1. template

```sql
SELECT AVG(column_name) FROM table_name;

```

2. 示例

```sql
SELECT AVG(count) AS CountAverage FROM access_log;

SELECT site_id, count FROM access_log WHERE count > ( SELECT AVG(count) FROM access_log );
```

3. 详细说明

### COUNT
>
> COUNT() 函数返回匹配指定条件的行数。
1.template

```sql
SELECT COUNT(column_name) FROM table_name;

SELECT COUNT(*) FROM table_name; 
-- 返回所有的条数
```

2. 示例

```sql
-- 查询 id=3 的site 的访问量
SELECT COUNT(count) AS nums FROM access_log WHERE site_id=3;

-- 表中的总数据
SELECT COUNT(*) AS nums FROM access_log;

-- 不同的site的 访问量
SELECT COUNT( DISTINCT site_id  ) AS nums FROM access_log;
```

3. 详细说明

### FIRST & LAST
>
> 这两个是对立的 我们直接放在一起讲

1.template

- FIRST

```sql
SELECT FIRST(column_name) FROM table_name;
-- 目前来看这样的语法 只有MS Accesses 支持

SELECT TOP 1 column_name FROM table_name
ORDER BY column_name ASC;
-- 这个是 SQL Server的语法

SELECT column_name FROM table_name
ORDER BY column_name ASC
LIMIT 1;

-- 这个是Mysql的语法
```

- Last

```sql
SELECT LAST(column_name) FROM table_name;
-- 仅 MS Access 支持

SELECT TOP 1 column_name FROM table_name
ORDER BY column_name DESC;
-- SQL Sever 语法

SELECT column_name FROM table_name
ORDER BY column_name DESC
LIMIT 1;
-- Mysql语法
```

2. 示例

```sql
-- 获取最后一个 （依据id 倒叙 然后取第一个
SELECT name FROM websites ORDER BY id DESC LIMIT 1;
```

3. 详细说明

### MAX & MIN
>
> 这两个是对立的 我们直接放在一起讲
1.template

```sql
-- 最大
SELECT MAX(column_name) FROM table_name;

-- 最小
SELECT MIN(column_name) FROM table_name;
```

2. 示例

```sql
SELECT MAX(alexa) AS max_alexa FROM websites;
SELECT MIN(alexa) AS max_alexa FROM websites;
```

3. 详细说明

### SUM
>
> SUM() 函数返回数值列的总数。而不是数据有多少条
1.template

```sql
SELECT SUM(column_name) FROM table_name;
```

2. 示例

```sql
-- 下面的 SQL 语句查找 "access_log" 表的 "count" 字段的总数：
SELECT SUM(count) AS nums FROM access_log;

```

3. 详细说明

## SQL Scalar

### UCASE & LCASE
>
> 把 值 转大小写

1. template

```sql
SELECT UCASE(column_name) FROM table_name;
SELECT LCASE(column_name) FROM table_name;
-- 以上的 mysql的语法 sqlServer 是 UPPER() 和 LOWER()

```

2. 例子

```sql
SELECT UCASE(name) AS site_title, url FROM websites;
SELECT LCASE(name) AS site_title, url FROM websites;
```

3. 详细说明

### MID
>
> 截取 和 提取字符串

1. template

```sql
SELECT MID(column_name[,start,length]) FROM table_name;

-- column_name 要被提取的 字段
-- start 开始的位置 默认为1 
-- 截取的长度 若没有写 那么返回 start 之后的全部
```

2. 例子

```sql
SELECT MID(name,1,4) AS ShortTitle
FROM websites;
```

3. 详细说明

### LEN
>
> 函数返回文本字段中值的长度。

1. template

```sql
SELECT name, LENGTH(url) as LengthOfURL FROM Websites;
-- mysql 的语法
```

2. 例子
3. 详细说明

### ROUND
>
> ROUND() 函数用于把数值字段舍入为指定的小数位数。

1. template

```sql
SELECT ROUND(column_name,decimals) FROM TABLE_NAME;
-- column_name  必需。要舍入的字段。
-- decimals 可选。规定要返回的小数位数。
```

2. 例子

```sql
SELECT ROUND(-1.23);
SELECT ROUND(-1.59);
```

3. 详细说明

### NOW
>
> 返回系统时间

1. template

```sql
SELECT NOW() FROM table_name;
```

2. 例子

```sql
SELECT name, url, Now() AS query_action_date
FROM websites;
```

3. 详细说明

### FORMAT
>
> FORMAT() 函数用于对字段的显示进行格式化。

1. template

```sql
SELECT FORMAT(column_name,format) FROM table_name;
```

2. 例子

```sql
SELECT name, url, DATE_FORMAT(Now(),'%Y-%m-%d') AS date
FROM Websites;
```

3. 详细说明

## 其它

### GROUP BY
>
> GROUP BY 语句用于结合聚合函数，根据一个或多个列对结果集进行分组。

1. template

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name;
```

2. 例子

```sql

-- 统计 access_log 各个 site_id 的访问量
SELECT site_id, SUM(access_log.count) AS nums FROM access_log GROUP BY site_id;

-- 用于多表连接中
SELECT websites.name, COUNT( access_log.aid ) AS nums 
  FROM access_log LEFT JOIN websites ON access_log.site_id=websites.id
  GROUP BY websites.name

```

3. 详细说明

### HAVING
>
> 使用呢 Group by 之后无法和 where 结合，所以我们有量这个函数

1. template

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name
HAVING aggregate_function(column_name) operator value;
```

2. 例子

```sql

-- 现在我们想要查找总访问量大于 200 的网站。
SELECT websites.name,
  SUM(access_log.count) AS nums
FROM (
    access_log
    INNER JOIN websites ON access_log.site_id = websites.id
  )
GROUP BY websites.name
HAVING SUM(access_log.count) > 200;

-- 现在我们想要查找总访问量大于 200 的网站，并且 alexa 排名小于 200。
SELECT websites.name,
  SUM(access_log.count) AS nums
FROM websites
  INNER JOIN access_log ON websites.id = access_log.site_id
WHERE websites.alexa < 200
GROUP BY websites.name
HAVING SUM(access_log.count) > 200;
```

3. 详细说明

where 和having之后都是筛选条件，但是有区别的：

1.where在group by前， having在group by 之后

2.聚合函数（avg、sum、max、min、count），不能作为条件放在where之后，但可以放在having之后

### EXISTS
>
> EXISTS 运算符用于判断查询子句是否有记录，如果有一条或多条记录存在返回 True，否则返回 False。

1. template

```sql
SELECT column_name(s)
FROM table_name
WHERE EXISTS
(SELECT column_name FROM table_name WHERE condition);



```

2. 例子

```sql
-- 现在我们想要查找总访问量(count 字段)大于 200 的网站是否存在。
SELECT websites.name, websites.url 
FROM websites 
WHERE EXISTS (SELECT count FROM access_log WHERE websites.id = access_log.site_id AND count > 200);


-- EXISTS 可以与 NOT 一起
SELECT websites.name, websites.url 
FROM websites 
WHERE NOT EXISTS (SELECT count FROM access_log WHERE websites.id = access_log.site_id AND count > 200);


```

3. 详细说明

### 参考link

<https://www.runoob.com/sql/sql-quickref.html>
