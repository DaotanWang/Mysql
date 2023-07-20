-- 把正确的日期格式更改成date 
UPDATE hsi_history.ph_hsi 
SET Date = STR_TO_DATE(Date, '%d-%b-%y');

-- 删除日期格式错误的数据 
DELETE FROM hsi_history.ph_hsi
WHERE Date NOT RLIKE '^[0-9]{1,2}-[a-zA-Z]{3}-[0-9]{2}$';
