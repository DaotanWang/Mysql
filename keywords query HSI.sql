SELECT Site, product_model, Date, SUM(hsi) as hsi
FROM 
(
  SELECT 'ph' as Site,'HUAWEI Mate 50' as product_model, Date, hsi
  FROM hsi_history.ph_hsi 
  WHERE query IN 
  (
    SELECT keywords 
    FROM hsi_history.keywords
    WHERE product_model = 'HUAWEI Mate 50' and site_code = 'ph'
  )
) tmp 
GROUP BY product_model, Date
