# 读取 CSV 文件并将所有列转换为数值类型
psqi_data <- read.csv("匹兹堡睡眠质量量表.csv", header = TRUE, colClasses = "numeric", na.strings = c("", "00"))
psqi_data[is.na(psqi_data)] <- 0

# 确认所有列都已转换为数值类型
str(psqi_data)


#
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
    psqi_data$time_difference <- as.numeric(difftime(psqi_data$wakeup_time, psqi_data$bedtime, units = "hours"))
