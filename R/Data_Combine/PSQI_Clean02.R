# 读取 CSV 文件并将所有列转换为数值类型
psqi_data <- read.csv("匹兹堡睡眠质量量表.csv", header = TRUE, colClasses = "numeric", na.strings = c("", "00"))
psqi_data[is.na(psqi_data)] <- 0

# 确认所有列都已转换为数值类型
str(psqi_data)

#转化变量
  # 将第二列和第三列合并为上床时间
  psqi_data$bedtime <- as.POSIXct(paste(psqi_data$t1_h, psqi_data$t1_min, sep = ":"), format = "%H:%M")
  
  # 将第五列和第六列合并为起床时间
  psqi_data$wakeup_time <- as.POSIXct(paste(psqi_data$t3_h, psqi_data$t3_min, sep = ":"), format = "%H:%M")
  
  # 计算时间差（单位：小时）
  psqi_data$time_difference <- as.numeric(difftime(psqi_data$wakeup_time, psqi_data$bedtime, units = "hours"))
