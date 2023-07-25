-- Q:为什么把CSV放进Mysql的时候 Hex有可能会被加上0D？
-- A:原因是CSV文件和MySQL数据库对回车换行符的处理方式不同所导致的。
-- CSV文件通常使用 \r\n (回车+换行)来表示一行的结束。
-- 但是MySQL数据库内部采用 \n (换行)来表示一行结束。
-- 当使用LOAD DATA INFILE将CSV文件导入MySQL时,会发生自动转换:
-- 1. CSV里的\r\n会被转换成\n
-- 2. 而原本的\n不会被转换,这样就出现了两个\n
-- 3. 为了避免两个\n,MySQL会在\n前面加上一个回车符\r(十六进制为0D)
-- 所以一个CSV的\r\n在导入MySQL时,会被转换成\r\n:
-- - \r\n (CSV行结束) --> \n (MySQL行结束)
-- - \n (CSV行结束) --> \r\n (避免两个\n,前面加了\r)
-- 这个自动转换导致CSV里本来就存在的\n会在导入时前面增加一个\r,显示成十六进制的0D。
-- 解决方法是:
-- 1. 在导入前,用编辑器把CSV文件的\r\n全部转换成\n
-- 2. 在导入语句中指定COLUMNS TERMINATED BY '\n'
-- 3. 导入后,再把多余的\r删掉


-- 在条件查询里发现like可以查到，=却不行且确定字段里有要查询的值，可能是输入的字符值和数据中的存储值length不同，导致无法查询
-- link：https://blog.csdn.net/Analyser_wu/article/details/107662927

-- 查询length方法：
   select length('HUAWEI Mate 50 Pro') ,hex('HUAWEI Mate 50 Pro'),product_model,hex(product_model),length(product_model) from hsi_history.keywords;

-- 解决方法：通过HEX在字符最后看见了0D，在这里去除。
UPDATE hsi_history.keywords
SET product_model = TRIM(TRAILING CHAR(13) FROM REPLACE(product_model, CHAR(13), ''));

