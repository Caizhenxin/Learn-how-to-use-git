# 读取 CSV 文件并将所有列转换为数值类型
psqi_data <- read.csv("匹兹堡睡眠质量量表1.csv", header = TRUE, colClasses = "numeric", na.strings = c("", "00"))
psqi_data[is.na(psqi_data)] <- 0

# 确认所有列都已转换为数值类型
str(psqi_data)

# 获取被试id列，假设被试id列在第一列
subject_ids <- unique(psqi_data[, 1])

# 定义一个函数用于计算条目2的得分
calculate_sleep_latency <- function(minutes) {
  if (length(minutes) == 0 || is.na(minutes)) {
    return(NA)  # 处理空值或缺失值
  } else if (minutes <= 15) {
    return(0)
  } else if (minutes <= 30) {
    return(1)
  } else if (minutes <= 60) {
    return(2)
  } else {
    return(3)
  }
}


# 定义计算睡眠时间得分的函数
calculate_sleep_duration <- function(hours) {
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

# 定义计算睡眠效率得分的函数
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

# 定义计算睡眠障碍得分的函数
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

# 定义计算日间功能障碍得分的函数
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

# 循环处理每个被试的数据
for (subject_id in subject_ids) {
    subject_data <- subset(psqi_data, psqi_data$A == subject_id)
    
    # 检查子数据框是否为空
    if (nrow(subject_data) == 0) {
      next  # 如果子数据框为空，跳过当前循环
    }
    
    # 计算得分和其他操作...
  
  # 计算条目2得分
  subject_data$D_score <- calculate_sleep_latency(subject_data$D)
  
  # 计算睡眠时间得分
  subject_data$H_score <- calculate_sleep_duration(subject_data$H)
  
  # 计算睡眠效率得分
  subject_data$P_score <- calculate_sleep_efficiency(subject_data$H, (subject_data$F * 60 + subject_data$G) - (subject_data$B * 60 + subject_data$C))
  
  # 计算睡眠障碍得分
  subject_data$R_score <- calculate_sleep_disturbance(subject_data[, 9:18])
  
  # 计算日间功能障碍得分
  psqi_data$V_score <- calculate_daytime_dysfunction(psqi_data[, 19], psqi_data[, 20])
  
  # 计算PSQI总分
  subject_data$PSQI_Total <- rowSums(subject_data[, c("S", "T", "U", "V", "P", "O", "R")])
  
  # 输出结果或者将结果存储到另一个数据结构中
  print(subject_data)
}
write.csv(psqi_data, "processed_data.csv", row.names = FALSE)