# 读取 CSV 文件并将所有列转换为数值类型
psqi_data <- read.csv("匹兹堡睡眠质量量表1.csv", header = TRUE, colClasses = "numeric", na.strings = c("", "00"))
psqi_data[is.na(psqi_data)] <- 0

# 确认所有列都已转换为数值类型
str(psqi_data)

# 定义一个函数用于计算条目2的得分
calculate_sleep_latency <- function(time_in_minutes) {
  if (time_in_minutes <= 15) {
    return(0)
  } else if (time_in_minutes <= 30) {
    return(1)
  } else if (time_in_minutes <= 60) {
    return(2)
  } else {
    return(3)
  }
}

# 定义一个函数用于计算条目2的得分
calculate_sleep_latency <- function(time_in_minutes) {
  if (is.na(time_in_minutes)) {
    return(0)  # 处理空值或缺失值
  } else if (time_in_minutes <= 15) {
    return(0)
  } else if (time_in_minutes <= 30) {
    return(1)
  } else if (time_in_minutes <= 60) {
    return(2)
  } else {
    return(3)
  }
}

# 定义一个函数用于计算条目2的得分
calculate_sleep_latency <- function(time_in_minutes) {
  if (is.na(time_in_minutes)) {
    return(0)  # 如果参数为NA值，则返回默认值0
  } else if (length(time_in_minutes) == 0) {
    return(NA)  # 如果参数长度为零，返回NA值
  } else if (time_in_minutes <= 15) {
    return(0)
  } else if (time_in_minutes <= 30) {
    return(1)
  } else if (time_in_minutes <= 60) {
    return(2)
  } else {
    return(3)
  }
}


# 计算条目2的得分
psqi_data$D <- calculate_sleep_latency(psqi_data$D)


# 定义一个函数用于计算睡眠时间的得分
calculate_sleep_duration <- function(hours)
{
  if (hours > 7) {
    return(0)
  } else if (hours >= 6) {
    return(1)
  } else if (hours >= 5) {
    return(2)
  } else {
    return(3)
  }
}

# 计算睡眠时间的得分
psqi_data$H <- calculate_sleep_duration(psqi_data$H)

# 定义一个函数用于计算睡眠效率的得分
calculate_sleep_efficiency <- function(sleep_hours, bed_hours) {
  efficiency <- (sleep_hours / bed_hours) * 100
  if (efficiency > 85) {
    return(0)
  } else if (efficiency >= 75) {
    return(1)
  } else if (efficiency >= 65) {
    return(2)
  } else {
    return(3)
  }
}

# 计算睡眠效率的得分
psqi_data$P <- calculate_sleep_efficiency(psqi_data$H, (psqi_data$F - psqi_data$B))

# 定义一个函数用于计算睡眠障碍的得分
calculate_sleep_disturbance <- function(scores) {
  total_score <- sum(scores)
  if (total_score == 0) {
    return(0)
  } else if (total_score <= 9) {
    return(1)
  } else if (total_score <= 18) {
    return(2)
  } else {
    return(3)
  }
}

# 计算睡眠障碍的得分
psqi_data$R <- calculate_sleep_disturbance(psqi_data[, 9:18])

# 定义一个函数用于计算日间功能障碍的得分
calculate_daytime_dysfunction <- function(scores_8, scores_9) {
  total_score <- sum(scores_8, scores_9)
  if (total_score == 0) {
    return(0)
  } else if (total_score <= 2) {
    return(1)
  } else if (total_score <= 4) {
    return(2)
  } else {
    return(3)
  }
}

# 计算日间功能障碍的得分
psqi_data$V <- calculate_daytime_dysfunction(psqi_data$I, psqi_data$J)

# 计算PSQI总分
psqi_data$PSQI_Total <- rowSums(psqi_data[, c("S", "T", "U", "V", "P", "O", "R")])

# 将处理后的数据保存为CSV文件
write.csv(psqi_data, "processed_data.csv", row.names = FALSE)