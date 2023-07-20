select * from hsi_history.ph_hsi;

-- 去掉空行 
SET SQL_SAFE_UPDATES = 0;
DELETE FROM hsi_history.ph_hsi
WHERE Query IS NULL 
   OR Date IS NULL
   OR Impressions IS NULL;

-- impression 变数字 
ALTER TABLE hsi_history.ph_hsi ADD impression_int INT;

UPDATE hsi_history.ph_hsi 
SET impression_int = CAST(Impressions AS UNSIGNED)
WHERE Impressions REGEXP '^[0-9]+$';

DELETE FROM hsi_history.ph_hsi
WHERE impression_int IS NULL;

ALTER TABLE hsi_history.ph_hsi DROP COLUMN Impressions;

ALTER TABLE hsi_history.ph_hsi CHANGE impression_int Impressions INT;

ALTER TABLE hsi_history.ph_hsi CHANGE impressions HSI INT;

-- 把正确的日期格式更改成date 
UPDATE hsi_history.ph_hsi 
SET Date = STR_TO_DATE(Date, '%d-%b-%y');

-- 删除日期格式错误的数据 
DELETE FROM hsi_history.ph_hsi
WHERE Date NOT RLIKE '^[0-9]{1,2}-[a-zA-Z]{3}-[0-9]{2}$';

-- 匹配查询H.S.I. 
SET @site = 'ph';
SET @product_model = 'HUAWEI Mate 50'; 
SELECT Site, product_model, Date, SUM(hsi) as hsi
FROM 
(
  SELECT @site as Site, @product_model as product_model, Date, hsi
  FROM hsi_history.ph_hsi 
  WHERE query IN 
  (
    SELECT keywords 
    FROM hsi_history.keywords
    WHERE product_model = @product_model and site_code = @site
  )
) tmp 
GROUP BY Date order by Date
