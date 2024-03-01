# 读取四个CSV文件
df1 <- read.csv("人口学变量表.csv")
df2 <- read.csv("焦虑自评l量表SAI.csv")
df3 <- read.csv("体育运动量表(1).csv")
df4 <- read.csv("抑郁自评量表SDS.csv")

# 将四个DataFrame按照'id'列进行合并，使用外连接（outer join），缺失值用'NA'填充
merged_df <- merge(merge(merge(df1, df2, by = "id", all = TRUE), df3, by = "id", all = TRUE), df4, by = "id", all = TRUE)

# 将合并后的DataFrame保存为CSV文件
write.csv(merged_df, "merged_data.csv", row.names = FALSE)

