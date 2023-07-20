-- 建议在控制台里操作
-- C:\Users\w0000000>cd C:\Program Files\MySQL\MySQL Server 8.0\bin 》》》》mysql -u root -p
-- 先要建表，才能导入

-- 前提设置
show global variables like 'local_infile'
set global local_infile=1

-- 设置后退出 quit

-- 通过这个方法进数据库
mysql -u root -p --local-infile

-- 选择数据表导入数据库

load data local infile"D:\\tomysqltest\\JP11.csv"
into table HIS_HISTORY.jp
-- 逗号分隔 
fields terminated by ','
-- 忽略表头
ignore 1 lines;  
