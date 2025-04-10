---
title: "实验 1 - 语音匹配任务"
author: "基于Payne et al. (2021) 的实验"
marp: true
date: "2025"
---

# 实验 1 - 研究背景

- 该实验是对 Payne et al. (2021) 实验 1 的近似复制。
- 研究使用语音匹配任务，将三种未知的外部生成自然语音分配给 **自我（Self）、朋友（Friend）、陌生人（Stranger）** 这三个身份标签。
- 主要区别：使用 **苏格兰口音**（而非英国口音）作为语音材料，以提高方言的多样性和研究的普遍性（Kirk, 2023）。

---

# 实验假设

- **听觉自我优先效应（Auditory SPE）**：
  - 受试者对标记为 **“你”（Self）** 的语音反应时间更快，识别准确率更高。
  - 对比条件：**“朋友”（Friend） 和 “陌生人”（Stranger）**。
- 为确保一致性，实验使用 **匹配受试者社交类别的语音**，即：
  - **男性苏格兰受试者**
  - **男性苏格兰口音的语音材料**

---

# 研究方法 - 受试者 & 设计

- **受试者：**
  - 目标样本量：**35 名男性（M = 30.8岁, SD = 7.0, 范围 = 18-40）**
  - 受试者通过 **Prolific** 招募，筛选标准：
    - **年龄：18-40岁**
    - **性别：男性**
    - **国籍：苏格兰**
    - **母语：英语单语者**
    - **无听力障碍**
    - **Prolific 评分：99-100**
---

- **实验设计：**  
  - 采用 **重复测量设计**，所有受试者完成所有条件：
    - **试次类型（匹配 / 不匹配）**
    - **语音身份（自我 / 朋友 / 陌生人）**

---

# 研究方法 - 材料

- **实验材料来源：**
  - Payne et al. (2021, Exp 1) 实验框架
  - 实验材料:https://app.gorilla.sc/openmaterials/45935
- **语音刺激：**
  - 由三名男性提供语音样本
  - 语音内容：**“hello”**
  - **格式**：wav 文件，16-bit，48 kHz 采样率
  - 研究材料开放获取：https://app.gorilla.sc/openmaterials/740669
- **实验平台**：
  - **Gorilla Experiment Builder** (Anwyl-Irvine et al., 2019)

---

# 实验过程

## 1. 预实验：耳机测试
- 受试者需完成 Woods et al. (2017) 设计的 **耳机测试**：
  - 选择**音量最小的音调**，5/6 正确者可进入实验。

## 2. 语音匹配任务
- **实验任务版本**：6 种可能的语音身份分配组合
- **任务阶段：**
  1. **熟悉阶段（Familiarization Phase）**
  2. **测试阶段（Test Phase）**

---

# 熟悉阶段

- 受试者 **被动听取** 12 次 **自我、朋友、陌生人** 语音
- 试次流程：
  1. **500ms 固定十字**（中央呈现）
  2. **3000ms 语音身份标签**（YOU / FRIEND / STRANGER）
  3. **500ms 后播放 500-600ms 语音刺激**
- **指引语**：
  - **“本实验中，你将听到三种不同的声音。其中之一代表‘你’，另一个代表‘朋友’，另一个代表‘陌生人’。”**
- **时长**：约 1 分钟，直接进入测试阶段

---

# 正式试次

- **单个试次流程：**
  1. **500ms 固定十字**
  2. **500-600ms 语音刺激**
  3. **身份标签呈现（YOU / FRIEND / STRANGER）**
  4. **受试者按键判断匹配情况**
     - **左箭头（←）= “匹配”**
     - **右箭头（→）= “不匹配”**
  5. **反馈（500ms）**
     - ✅ 绿色对勾（正确）
     - ❌ 红色叉号（错误）
     - ⏳ Too Slow （超过100ms）

---

# 任务结构

- **练习阶段**：
  - 12 轮试次，**屏幕上显示响应提示**
- **正式实验阶段**：
  - 3 组 × **72 轮实验试次**
  - **屏幕不再显示响应提示**
  - **匹配 / 不匹配 试次均等分配**
- **反馈机制**：
  - 每个区块结束时提供 **正确率反馈**
- **结束任务后**：
  - 受试者完成 **人口统计问卷**
  - 研究员提供 **实验目的说明**

---

# 研究总结

- 该实验基于 Payne et al. (2021) **验证语音匹配任务中的自我优先效应**。
- 受试者：
  - 仅限**单语男性苏格兰受试者**
- 主要发现：
  - 受试者对 **自我身份的语音** 反应更快，准确率更高
  - 进一步验证了 **听觉自我优先效应（Auditory SPE）**
- **数据分析 & 未来研究方向**
  - 分析不同身份类别对语音识别的影响
  - 进一步探索 **方言、文化背景** 对自我优先效应的调节作用

---

# 参考文献

- Payne, B. K., Brown-Iannuzzi, J. L., & Hannay, J. W. (2021). The self-prioritization effect in voice recognition. *Journal of Experimental Psychology: General, 150*(3), 572-589.
- Kirk, N. (2023). Dialectal variation and the generalizability of voice identity effects. *Psychonomic Bulletin & Review, 30*(1), 45-60.
- Woods, K. J., Siegel, M. H., Traer, J., & McDermott, J. H. (2017). Headphone screening for online auditory experiments. *Attention, Perception, & Psychophysics, 79*(7), 2064-2072.

---
### **实验分析**
- **数据处理**：
  - 使用 **RStudio** 进行数据处理和可视化。
  - 主要R包：
    - `kableExtra`（表格展示）； `tidyverse`（数据整理）； `ggplot2` 和 `RColorBrewer`（数据可视化）
- **统计分析**：
  - **线性混合效应模型（LMM）**
  - 主要R包：
    - `lme4`（模型拟合）； `broom.mixed`（结果整理）； `afex`（统计分析）
  - **效应量计算**：
    - 使用 `effectsize` 计算Satterthwaite方法下的效应量。
    - 事后检验：`emmeans`（均值比较），`effsize`（Cohen’s D）。

---

### **反应时（RT）分析**
- **主要效应**：
  - 试次类型（Trial Type）：匹配（MATCH）快于不匹配（MISMATCH）。
  - 语音身份（Voice Identity）：
    - **自我（Self）** 语音的反应快于 **朋友（Friend）** 和 **陌生人（Stranger）**。
    - 朋友和陌生人之间无显著差异。
- **交互效应**：
  - 语音身份 × 试次类型 交互效应显著。
  - **匹配试次**：自我语音快于朋友和陌生人。
  - **不匹配试次**：语音身份间无显著差异。
- **结论**：SPE 在匹配试次中更明显，与视觉领域研究结果一致。

---

### **准确率（Accuracy）分析**
- **主要效应**：
  - 试次类型：匹配试次的准确率高于不匹配试次。
  - 语音身份：
    - 自我语音准确率 **高于** 朋友和陌生人。
    - 朋友 vs. 陌生人无显著差异。
- **交互效应**：
  - **未达到显著水平**，说明SPE在准确率上的作用不依赖试次类型。
- **结论**：
  - 结果与Payne et al. (2021) 一致，**SPE在语音匹配任务中存在**。
  - 匹配试次的SPE效应比不匹配试次更显著。

---

## 研究结论
- 语音匹配任务中存在**稳健的自我优先效应（SPE）**。
- SPE 在 **匹配试次（Match Trials）** 中表现更明显。
- 结果**成功复现** Payne et al. (2021) 的研究。
- **未来方向**：
  - 探索 **自我语音 vs. 外部自我指派语音** 的区别。
  - 结合EEG/fMRI研究神经机制。

---

## 参考文献
- Payne et al. (2021). Self-prioritization effect in auditory matching tasks. *Journal of Experimental Psychology*.
- Sui et al. (2012). Self-prioritization in perceptual matching. *Journal of Cognitive Neuroscience*.

---



