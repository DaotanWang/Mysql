-- 在条件查询里发现like可以查到，=却不行且确定字段里有要查询的值，可能是输入的字符值和数据中的存储值length不同，导致无法查询
-- link：https://blog.csdn.net/Analyser_wu/article/details/107662927

-- 查询length方法：
   select length('HUAWEI Mate 50 Pro') ,hex('HUAWEI Mate 50 Pro'),product_model,hex(product_model),length(product_model) from hsi_history.keywords;

