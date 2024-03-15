import numpy as np
import mne
import os
import gdown
import zipfile
from mne.preprocessing import ICA
from mne.time_frequency import tfr_morlet
import warnings
warnings.filterwarnings('ignore', category=UserWarning, module='matplotlib')
%matplotlib inline
data_dir = "data/"
if not os.path.exists(data_dir):
 os.makedirs(data_dir)
# 从Google Drive下载
url = "https://drive.google.com/file/d/1bXD-_dDnH5Mv3DQrV7V9fYM4-xYsZ0DN/view?usp=sharing"
filename = "sample_data"
filepath = data_dir + filename + ".zip"
# 下载数据
gdown.download(url=url, output=filepath, quiet=False, fuzzy=True)
print("Download completes!")
# 数据解压
with zipfile.ZipFile(filepath, 'r') as zip:
 zip.extractall(data_dir)
print("Unzip completes!")
# 也可以通过百度⽹盘下载
# 链接:https://pan.baidu.com/s/1nQgoxeWoelDyIPduFES7YA 密码:fn96
# 下载后解压，并移动到data⽂件夹下
data_path = data_dir + 'sample_data/eeglab_data.set'
# 也可以直接使⽤你⾃⼰EEGLAB⽂件夹内的sample data⽂件夹下的数据
# data_path = "/Users/zitonglu/Desktop/EEG/eeglab14_1_2b/sample_data/eeglab_data.set"
# MNE-Python中对多种格式的脑电数据都进⾏了⽀持：
# *** 如数据后缀为.set (来⾃EEGLAB的数据)
# 使⽤mne.io.read_raw_eeglab()
# *** 如数据后缀为.vhdr (BrainVision系统)
# 使⽤mne.io.read_raw_brainvision()
# *** 如数据后缀为.edf
# 使⽤mne.io.read_raw_edf()
# *** 如数据后缀为.bdf (BioSemi放⼤器)
# 使⽤mne.io.read_raw_bdf()
# *** 如数据后缀为.gdf
# 使⽤mne.io.read_raw_gdf()
# *** 如数据后缀为.cnt (Neuroscan系统)
# 使⽤mne.io.read_raw_cnt()
# *** 如数据后缀为.egi或.mff
# 使⽤mne.io.read_raw_egi()
# *** 如数据后缀为.data
# 使⽤mne.io.read_raw_nicolet()
# *** 如数据后缀为.nxe (Nexstim eXimia系统)
# 使⽤mne.io.read_raw_eximia()
# *** 如数据后缀为.lay或.dat (Persyst系统)
# 使⽤mne.io.read_raw_persyst()
# *** 如数据后缀为.eeg (Nihon Kohden系统)
# 使⽤mne.io.read_raw_nihon()
# 读取数据
raw = mne.io.read_raw_eeglab(data_path, preload=True)