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
GROUP BY Date
