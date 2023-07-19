-- 去空（无主键会有保护从而无法update和delete，SET SQL_SAFE_UPDATES = 0去除保护）
SET SQL_SAFE_UPDATES = 0;
DELETE FROM hsi_history.ph_hsi
WHERE Query IS NULL 
OR Date IS NULL
OR Impressions IS NULL;
