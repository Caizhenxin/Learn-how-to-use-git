# 读取 CSV 文件并将所有列转换为数值类型
psqi_data <- read.csv("匹兹堡睡眠质量量表.csv", header = TRUE, colClasses = "numeric", na.strings = c("", "00"))
psqi_data[is.na(psqi_data)] <- 0

# 确认所有列都已转换为数值类型
str(psqi_data)

# 定义一个函数用于将时间统一为24小时制
convert_to_24h <- function(hour, minute, period) {
  if (period == "AM") {
    if (hour == 12) {
      hour <- 0
    }
  } else {
    if (hour != 12) {
      hour <- hour + 12
    }
  }
  return(paste(hour, minute, sep = ":"))
}

# 定义一个函数用于计算时间差
calculate_time_difference <- function(psqi_data) {
  # 将12小时制的时间统一为24小时制
  psqi_data$t1_h <- ifelse(psqi_data$t1_h == 12 & psqi_data$t1_period == "AM", 0, psqi_data$t1_h)
  psqi_data$t3_h <- ifelse(psqi_data$t3_h == 12 & psqi_data$t3_period == "AM", 0, psqi_data$t3_h)
  psqi_data$t1_h <- ifelse(psqi_data$t1_h != 24 & psqi_data$t1_period == "PM", psqi_data$t1_h + 12, psqi_data$t1_h)
  psqi_data$t3_h <- ifelse(psqi_data$t3_h != 24 & psqi_data$t3_period == "PM", psqi_data$t3_h + 12, psqi_data$t3_h)
  
  # 将时间转换为24小时制
  psqi_data$t1 <- convert_to_24h(psqi_data$t1_h, psqi_data$t1_min, psqi_data$t1_period)
  psqi_data$t3 <- convert_to_24h(psqi_data$t3_h, psqi_data$t3_min, psqi_data$t3_period)
  
  # 将时间字符串转换为POSIXct对象
  psqi_data$t1 <- as.POSIXct(psqi_data$t1, format = "%H:%M")
  psqi_data$t3 <- as.POSIXct(psqi_data$t3, format = "%H:%M")
  
  # 计算时间差（单位：小时）
  psqi_data$time_difference <- as.numeric(difftime(psqi_data$t3, psqi_data$t1, units = "hours"))
  
  return(psqi_data)  # 返回包含时间差的数据框
}

# 计算时间差（单位：小时）
psqi_data <- calculate_time_difference(psqi_data)

# 用完后释放变量
rm(convert_to_24h, calculate_time_difference)

# 确认修改后的数据
str(psqi_data)
