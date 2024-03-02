# 安装并加载 readxl 包
install.packages("readxl")
library(readxl)

# # 读取 Excel 文件  双引号里面是直接下载的文件名称，要xlsx的后缀
# psqi_data <- read_excel("249960174_0_4_PSQI_94_93.xlsx") 
# 
# # 删除前6列和第25列数据
# psqi_data <- psqi_data[, -c(1:6, 25)]
# 
# # 重新命名列名
# colnames(psqi_data) <- c("id", "t1_h", "t1_min", "t2", "t3_h", "t3_min", "t4_1", "t4_2", "t5_a", "t5_b", "t5_c", "t5_d", "t5_e", "t5_f", "t5_g", "t5_h", "t5_i", "t5_j", "t6", "t7", "t8", "t9")
# 
# # 打印结果
# print(psqi_data)

library(openxlsx)

# 读取xlsx文件
psqi_data <- read.xlsx("249960174_0_4_PSQI_94_93.xlsx")

# 删除前6列和第25列
psqi_data <- psqi_data[, -c(1:6, 25)]

# 重命名列名
colnames(psqi_data) <- c("id", "t1_h", "t1_min", "t2", "t3_h", "t3_min", "t4_1", "t4_2", "t5_a", "t5_b", "t5_c", 
                         "t5_d", "t5_e", "t5_f", "t5_g", "t5_h", "t5_i", "t5_j", "t6", "t7", "t8", "t9")

# 定义计分函数
calculate_score <- function(response, type) {
  if (type == "t2") {
    if (response <= 15) {
      return(1)
    } else if (response <= 30) {
      return(2)
    } else if (response <= 60) {
      return(3)
    } else {
      return(4)
    }
  } else if (grepl("^t5_", type)) {
    if (response == "无") {
      return(1)
    } else if (response == "小于1次／周") {
      return(2)
    } else if (response == "1-2次／周") {
      return(3)
    } else if (response == "大于等于3次／周") {
      return(4)
    }
  } else if (type == "t6") {
    if (response == "很好") {
      return(1)
    } else if (response == "较好") {
      return(2)
    } else if (response == "较差") {
      return(3)
    } else {
      return(4)
    }
  } else if (grepl("^t[7-8]$", type)) {
    if (response == "无") {
      return(1)
    } else if (response == "小于1次／周") {
      return(2)
    } else if (response == "1-2次／周") {
      return(3)
    } else if (response == "大于等于3次／周") {
      return(4)
    }
  } else if (type == "t9") {
    if (response == "没有") {
      return(1)
    } else if (response == "偶尔有") {
      return(2)
    } else if (response == "有时有") {
      return(3)
    } else {
      return(4)
    }
  } else {
    return(NA)
  }
}

# 计算各个变量的得分
psqi_data$t2_score <- sapply(psqi_data$t2, calculate_score, type = "t2")
psqi_data$t5_a_score <- sapply(psqi_data$t5_a, calculate_score, type = "t5")
psqi_data$t5_b_score <- sapply(psqi_data$t5_b, calculate_score, type = "t5")
psqi_data$t5_c_score <- sapply(psqi_data$t5_c, calculate_score, type = "t5")
psqi_data$t5_d_score <- sapply(psqi_data$t5_d, calculate_score, type = "t5")
psqi_data$t5_e_score <- sapply(psqi_data$t5_e, calculate_score, type = "t5")
psqi_data$t5_f_score <- sapply(psqi_data$t5_f, calculate_score, type = "t5")
psqi_data$t5_g_score <- sapply(psqi_data$t5_g, calculate_score, type = "t5")
psqi_data$t5_h_score <- sapply(psqi_data$t5_h, calculate_score, type = "t5")
psqi_data$t5_i_score <- sapply(psqi_data$t5_i, calculate_score, type = "t5")
psqi_data$t5_j_score <- sapply(psqi_data$t5_j, calculate_score, type = "t5")
psqi_data$t6_score <- sapply(psqi_data$t6, calculate_score, type = "t6")
psqi_data$t7_score <- sapply(psqi_data$t7, calculate_score, type = "t7")
psqi_data$t8_score <- sapply(psqi_data$t8, calculate_score, type = "t8")
psqi_data$t9_score <- sapply(psqi_data$t9, calculate_score, type = "t9")

# 计算PSQI总分
psqi_data$PSQI_total <- rowSums(psqi_data[, -c(1, 20)], na.rm = TRUE)

# 将结果保存为新的CSV文件
write.csv(psqi_data, file = "new_file.csv", row.names = FALSE)
