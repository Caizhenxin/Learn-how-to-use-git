from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
import pandas as pd
from sklearn.manifold import TSNE
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt

# 加载模型
model = SentenceTransformer('all-MiniLM-L6-v2')

# 题目列表（vividness-MEQ（正向计分）+ AMQ2016）
questions = [
    "My memory for this event is clear.",
    "My memory for this event is very vivid.",
    "My memory for this event is very detailed.",
]

# 转换为向量（每个句子 -> 一个向量）
embeddings = model.encode(questions)

# 查看结果（每个向量是384维）
print(f"Shape: {embeddings.shape}")  # 应为 (题目数量, 384)


# 打印所有向量的形状
print(f"All embeddings shape: {embeddings.shape}")


# 已经有题目向量 embeddings
similarity_matrix = cosine_similarity(embeddings)

#计算总体相似度
# 去除对角线（每题与自己相似度 = 1，不计入平均）
n = similarity_matrix.shape[0]
mask = ~np.eye(n, dtype=bool)  # 创建一个 n×n 的布尔矩阵，对角线为 False，其他为 True
mean_similarity = similarity_matrix[mask].mean()

print(f"平均题目余弦相似度（排除对角线）: {mean_similarity:.4f}")

# 计算余弦相似度矩阵（所有题目两两之间的相似度）
similarity_matrix = cosine_similarity(embeddings)

# 打印相似度矩阵
print("Cosine Similarity Matrix:")
print(similarity_matrix)

# 可选：打印每一对题目的相似度
for i in range(len(questions)):
    for j in range(i + 1, len(questions)):
        print(f"Similarity between '{questions[i]}' and '{questions[j]}': {similarity_matrix[i][j]:.4f}")


pca = PCA()
pca.fit(embeddings)
explained_var = np.cumsum(pca.explained_variance_ratio_)

# 打印每个维度下累计解释方差
for i, var in enumerate(explained_var):
    print(f"维度 {i+1}: 累计解释方差 = {var:.4f}")
    if var >= 0.90:
        print(f"\n✅ 推荐维数：{i+1}（可解释 90% 的总方差）")
        break
