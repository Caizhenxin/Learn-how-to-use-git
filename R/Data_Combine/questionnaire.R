# 安装并加载 readxl 包
install.packages("readxl")
library(readxl)

# 读取 Excel 文件  双引号里面是直接下载的文件名称，要xlsx的后缀
psqi_data <- read_excel("249960174_0_4_PSQI_94_93.xlsx") 

# 删除前6列和第25列数据
psqi_data <- psqi_data[, -c(1:6, 25)]

# 重新命名列名
colnames(psqi_data) <- c("id", "t1_h", "t1_min", "t2", "t3_h", "t3_min", "t4_1", "t4_2", "t5_a", "t5_b", "t5_c", "t5_d", "t5_e", "t5_f", "t5_g", "t5_h", "t5_i", "t5_j", "t6", "t7", "t8", "t9")

# 打印结果
print(psqi_data)
