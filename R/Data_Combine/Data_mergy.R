# 加载所需的库
library(dplyr)

# 读取五个CSV文件
df1 <- read.csv("人口学变量表.csv")
df2 <- read.csv("焦虑自评l量表SAI.csv")
df3 <- read.csv("体育运动量表(1).csv")
df4 <- read.csv("抑郁自评量表SDS.csv")
df5 <- read.csv("匹兹堡睡眠质量量表.csv")

# 将五个数据框按照'id'列进行左连接（left join）合并
merged_df <- df1 %>%
  left_join(df2, by = "id") %>%
  left_join(df3, by = "id") %>%
  left_join(df4, by = "id") %>%
  left_join(df5, by = "id")

# 将NA替换为字符串"NA"
merged_df[is.na(merged_df)] <- "NA"

# 将合并后的数据框写入CSV文件
write.csv(merged_df, "merged_data1.csv", row.names = FALSE)
