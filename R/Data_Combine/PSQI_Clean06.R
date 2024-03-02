# 读取 CSV 文件并将所有列转换为数值类型
psqi_data <- read.csv("匹兹堡睡眠质量量表.csv", header = TRUE, colClasses = "numeric", na.strings = c("", "00"))
psqi_data[is.na(psqi_data)] <- 0

# 确认所有列都已转换为数值类型
str(psqi_data)


'''  I.睡眠质量(Subjective Sleep Quality)
# 获取条目6的应答
subjective_sleep_quality <- psqi_data$t6

# 定义函数计算睡眠质量得分
calculate_sleep_quality_score <- function(response) {
  if (response == 1) {
    return(0)
  } else if (response == 2) {
    return(1)
  } else if (response == 3) {
    return(2)
  } else {
    return(3)
  }
}

# 应用函数计算睡眠质量得分
sleep_quality_score <- sapply(subjective_sleep_quality, calculate_sleep_quality_score)

# 将得分添加到数据框中
psqi_data$sleep_quality_score <- sleep_quality_score

rm(sleep_quality_score,subjective_sleep_quality,calculate_sleep_quality_score)

'''






''' II.入睡时间(Sleep Latency)
# 获取条目2和5a的应答
sleep_latency <- psqi_data$t2
sleep_disturbances <- psqi_data$t5_a

# 定义函数计算入睡时间得分
calculate_sleep_latency_score <- function(latency, disturbances) {
  latency_score <- ifelse(latency == 1, 0, ifelse(latency == 2, 1, ifelse(latency == 3, 2, 3)))
  disturbances_score <- ifelse(disturbances == 1, 0, ifelse(disturbances == 2, 1, ifelse(disturbances == 3, 2, 3)))
  
  total_score <- latency_score + disturbances_score
  
  if (total_score <= 1) {
    return(0)
  } else if (total_score <= 2) {
    return(1)
  } else if (total_score <= 4) {
    return(2)
  } else {
    return(3)
  }
}

# 应用函数计算入睡时间得分
sleep_latency_score <- mapply(calculate_sleep_latency_score, sleep_latency, sleep_disturbances)

# 将得分添加到数据框中
psqi_data$sleep_latency_score <- sleep_latency_score

rm(sleep_disturbances,sleep_latency,sleep_latency_score,calculate_sleep_latency_score)

'''





'''III.睡眠时间(Sleep Duration)
# 计算睡眠时间（单位：小时）
psqi_data$sleep_time <- psqi_data$t4_1 + psqi_data$t4_2 / 60
# 获取条目4的应答（睡眠时间）
sleep_duration <- psqi_data$sleep_time

# 定义函数计算睡眠时间得分
calculate_sleep_duration_score <- function(duration) {
  if (duration > 7) {
    return(0)
  } else if (duration >= 6 && duration <= 7) {
    return(1)
  } else if (duration >= 5 && duration < 6) {
    return(2)
  } else {
    return(3)
  }
}

# 应用函数计算睡眠时间得分
sleep_duration_score <- sapply(sleep_duration, calculate_sleep_duration_score)

# 将得分添加到数据框中
psqi_data$sleep_duration_score <- sleep_duration_score

rm(sleep_duration,sleep_duration_score,sleep_time,calculate_sleep_duration_score)
'''




# '''  IV.睡眠效率(Habitual Sleep Efficiency)'''
# #计算床上时间的function
#         adjust_and_compute_time_difference <- function(psqi_data) {
#           with(psqi_data, {
#             # 调整小时为24小时制
#             t1_h <- ifelse(t1_h > 12, t1_h, t1_h + 12)
#             
#             # 如果小时为24或者12，则将其视为第二天的零点
#             t1_h[t1_h == 24] <- 0
#             t1_h[t1_h == 12] <- 0
#             
#             # 将第二列和第三列合并为上床时间
#             bedtime <- as.POSIXct(paste(t1_h, t1_min, sep = ":"), format = "%H:%M")
#             
#             # 将第五列和第六列合并为起床时间
#             wakeup_time <- as.POSIXct(paste(t3_h, t3_min, sep = ":"), format = "%H:%M")
#             
#             # 调整wakeup_time为第二天的时间
#             wakeup_time[t3_h < t1_h] <- wakeup_time[t3_h < t1_h] + 86400  # 加上一天的秒数
#             
#             # 计算时间差（单位：小时）
#             time_difference <- as.numeric(difftime(wakeup_time, bedtime, units = "hours"))
#             
#             # 释放变量（除时间差外）
#             psqi_data <- psqi_data[, !(names(psqi_data) %in% c("t1_h", "t1_min", "t3_h", "t3_min", "bedtime", "wakeup_time"))]
#           })
#           
#           return(psqi_data)
#         }
# 
# # 使用函数
# psqi_data <- adjust_and_compute_time_difference(psqi_data)
# 
# 
# 
# 
# 
# # 计算床上时间
# bedtime <- psqi_data$time_difference
# 
# # 计算睡眠时间（单位：小时）
# sleep_time <- psqi_data$t4_1 + psqi_data$t4_2 / 60
# 
# # 计算睡眠效率
# sleep_efficiency <- (sleep_time / bedtime) * 100
# 
# # 计算成分IV得分
# calculate_IV_score <- function(sleep_efficiency) {
#   if (sleep_efficiency > 85) {
#     return(0)
#   } else if (sleep_efficiency >= 75 && sleep_efficiency <= 84) {
#     return(1)
#   } else if (sleep_efficiency >= 65 && sleep_efficiency <= 74) {
#     return(2)
#   } else {
#     return(3)
#   }
# }
# 
# # 应用函数计算成分IV得分
# IV_score <- sapply(sleep_efficiency, calculate_IV_score)
# 
# # 将得分添加到数据框中
# psqi_data$IV_score <- IV_score

'''IV.睡眠效率(Habitual Sleep Efficiency)
    #计算  床上时间=起床时间（条目3）—上床时间（条目1）

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
'''


'''V睡眠障碍(Sleep Disturbance)
# 移除t5_a列
psqi_data <- psqi_data[, !grepl("^t5_a", names(psqi_data))]

# 获取剩余的条目5b到5j的应答
sleep_disturbances <- psqi_data[, grep("^t5_", names(psqi_data))]

# 定义函数计算睡眠障碍得分
calculate_sleep_disturbance_score <- function(responses) {
  disturbances_score <- ifelse(responses == 1, 0, ifelse(responses == 2, 1, ifelse(responses == 3, 2, 3)))
  total_score <- sum(disturbances_score)
  
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

# 应用函数计算睡眠障碍得分
sleep_disturbance_score <- apply(sleep_disturbances, 1, calculate_sleep_disturbance_score)

# 将得分添加到数据框中
psqi_data$sleep_disturbance_score <- sleep_disturbance_score

rm(sleep_disturbances,sleep_disturbance_score,calculate_sleep_disturbance_score)
'''


'''VI催眠药物(Used Sleep Medication)
# 获取条目7的应答
sleep_medication <- psqi_data$t7

# 定义函数计算催眠药物使用得分
calculate_sleep_medication_score <- function(response) {
  if (response == 1) {
    return(0)
  } else if (response == 2) {
    return(1)
  } else if (response == 3) {
    return(2)
  } else {
    return(3)
  }
}

# 应用函数计算催眠药物使用得分
sleep_medication_score <- sapply(sleep_medication, calculate_sleep_medication_score)

# 将得分添加到数据框中
psqi_data$sleep_medication_score <- sleep_medication_score

# 打印结果
rm(sleep_medication,sleep_medication_score,calculate_sleep_medication_score)
'''







# 获取条目8和9的应答
daytime_dysfunction_8 <- psqi_data$t8
daytime_dysfunction_9 <- psqi_data$t9

# 定义函数计算日间功能障碍得分
calculate_daytime_dysfunction_score <- function(response_8, response_9) {
  score_8 <- ifelse(response_8 == 1, 0, ifelse(response_8 == 2, 1, ifelse(response_8 == 3, 2, 3)))
  score_9 <- ifelse(response_9 == 1, 0, ifelse(response_9 == 2, 1, ifelse(response_9 == 3, 2, 3)))
  
  total_score <- score_8 + score_9
  
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

# 应用函数计算日间功能障碍得分
daytime_dysfunction_score <- mapply(calculate_daytime_dysfunction_score, daytime_dysfunction_8, daytime_dysfunction_9)

# 将得分添加到数据框中
psqi_data$daytime_dysfunction_score <- daytime_dysfunction_score

rm(daytime_dysfunction_8,daytime_dysfunction_9,daytime_dysfunction_score,calculate_daytime_dysfunction_score)







