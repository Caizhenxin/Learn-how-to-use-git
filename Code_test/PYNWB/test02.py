import pandas as pd
import numpy as np
from pynwb import TimeSeries, NWBHDF5IO, NWBFile
from datetime import datetime
from dateutil import tz

# 1. 从CSV文件读取数据
csv_file_path = 'D:/GitHub_programe/GitHub/SPE_Database/4_Data_Extraction/4_2_Open_Data/Paper_6/P6_Exp1_raw.csv'
behavior_data = pd.read_csv(csv_file_path)

# 2. 创建NWB文件
nwbfile = NWBFile(
    session_description='Behavior Data Session',
    identifier='behavior_data',
    session_start_time=datetime(2024, 2, 5, 10, 0, 0, tzinfo=tz.tzlocal())
)

# 3. 将CSV文件中的数据写入TimeSeries
speed_time_series = TimeSeries(
    name="speed",
    data=behavior_data['Shape'].to_numpy(),  # 假设CSV文件中有一个名为'shape'的列
    timestamps=behavior_data['Lable'].to_numpy(),  # 假设CSV文件中有一个名为'Lable'的列
    description="The speed of the subject measured over time.",
    unit="m/s",
)

# 4. 添加TimeSeries到NWB文件
nwbfile.add_acquisition(speed_time_series)

# 5. 将NWB文件保存到磁盘
output_file = 'behavior_data.nwb'
with NWBHDF5IO(output_file, 'w') as io:
    io.write(nwbfile)

print(f'Behavior data from CSV file has been saved to {output_file}')
