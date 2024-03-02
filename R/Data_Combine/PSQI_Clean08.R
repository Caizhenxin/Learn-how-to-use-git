# 读取 CSV 文件并将所有列转换为数值类型
psqi_data <- read.csv("匹兹堡睡眠质量量表.csv", header = TRUE, colClasses = "numeric", na.strings = c("", "00"))
psqi_data[is.na(psqi_data)] <- 0

# 确认所有列都已转换为数值类型
str(psqi_data)


# 调整小时为24小时制
psqi_data$t1_h <- ifelse(psqi_data$t1_h > 12, psqi_data$t1_h, psqi_data$t1_h + 12)

# 如果小时为24或者12，则将其视为第二天的零点
psqi_data$t1_h[psqi_data$t1_h == 24] <- 0
psqi_data$t1_h[psqi_data$t1_h == 12] <- 0

# 将第二列和第三列合并为上床时间
psqi_data$bedtime <- as.POSIXct(paste(psqi_data$t1_h, psqi_data$t1_min, sep = ":"), format = "%H:%M")

# 将第五列和第六列合并为起床时间
psqi_data$wakeup_time <- as.POSIXct(paste(psqi_data$t3_h, psqi_data$t3_min, sep = ":"), format = "%H:%M")

# 调整wakeup_time为第二天的时间
psqi_data$wakeup_time[psqi_data$t3_h < psqi_data$t1_h] <- psqi_data$wakeup_time[psqi_data$t3_h < psqi_data$t1_h] + 86400  # 加上一天的秒数

# 计算时间差（单位：小时）
psqi_data$bedtime <- as.POSIXct(paste(psqi_data$t1_h, psqi_data$t1_min, sep = ":"), format = "%H:%M")
psqi_data$wakeup_time <- as.POSIXct(paste(psqi_data$t3_h, psqi_data$t3_min, sep = ":"), format = "%H:%M")

# 计算睡眠时间
sleep_time <- difftime(psqi_data$wakeup_time, psqi_data$bedtime, units = "hours")

# 计算床上时间
bedtime <- psqi_data$wakeup_time - psqi_data$bedtime

# 计算睡眠效率
sleep_efficiency <- (as.numeric(sleep_time) / as.numeric(bedtime)) * 100

# 计算成分IV得分
calculate_IV_score <- function(sleep_efficiency) {
  if (sleep_efficiency > 85) {
    return(0)
  } else if (sleep_efficiency >= 75 && sleep_efficiency <= 84) {
    return(1)
  } else if (sleep_efficiency >= 65 && sleep_efficiency <= 74) {
    return(2)
  } else {
    return(3)
  }
}

# 应用函数计算成分IV得分
IV_score <- sapply(sleep_efficiency, calculate_IV_score)

# 将得分添加到数据框中
psqi_data$IV_score <- IV_score
