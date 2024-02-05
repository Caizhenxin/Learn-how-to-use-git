import pandas as pd
from pynwb import NWBFile, NWBHDF5IO
from datetime import datetime
from pynwb.behavior import BehavioralTimeSeries
import pytz

# 创建带有时区信息的日期
session_start_time = datetime.now(pytz.timezone('UTC'))



# 1. 读取 CSV 文件
csv_file_path = 'D:/GitHub_programe/GitHub/SPE_Database/4_Data_Extraction/4_2_Open_Data/Paper_6/P6_Exp1_raw.csv'
df = pd.read_csv(csv_file_path)

# 2. 创建一个 NWB 文件
    # 创建 NWBFile 对象
nwbfile = NWBFile('Behavioral Experiment', 'EXAMPLE_ID', session_start_time)

# 3. 添加实验描述
    # 添加实验描述到 lab_meta_data
nwbfile.lab_meta_data = {'description': 'This is my behavioral experiment.'}

# 4. 将 CSV 数据转换为 BehavioralTimeSeries
timestamps = df['timestamp'].values
behavior_data = df['behavior_data'].values

behavior_time_series = BehavioralTimeSeries('behavior_data', behavior_data, timestamps=timestamps, resolution=0.001)
nwbfile.add_acquisition(behavior_time_series)

# 5. 保存 NWB 文件
output_nwb_file = 'behavioral_data.nwb'
with NWBHDF5IO(output_nwb_file, 'w') as io:
    io.write(nwbfile)
