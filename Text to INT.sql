-- 文本方便导入，转成数字方便计算

-- 加一行
ALTER TABLE hsi_history.ph_hsi ADD impression_int INT;

-- CAST类型转换，UNSIGNED无符号整数，REGEXP正则表达判断数字。
UPDATE hsi_history.ph_hsi 
SET impression_int = CAST(Impressions AS UNSIGNED)
WHERE Impressions REGEXP '^[0-9]+$';

-- 删掉没法转换的行
DELETE FROM hsi_history.ph_hsi
WHERE impression_int IS NULL;

-- 删掉列
ALTER TABLE hsi_history.ph_hsi DROP COLUMN Impressions;

-- 新列更名
ALTER TABLE ph_hsi CHANGE impression_int Impressions INT;
