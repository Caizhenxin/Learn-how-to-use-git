'''导入相关包'''
import pynwb
import numpy as np
import pandas as pd
from dateutil import tz

from datetime import datetime
from uuid import uuid4
from dateutil.tz import tzlocal

from pynwb import NWBHDF5IO, NWBFile, TimeSeries
from pynwb.behavior import (
    BehavioralEpochs,
    BehavioralEvents,
    BehavioralTimeSeries,
    CompassDirection,
    EyeTracking,
    Position,
    PupilTracking,
    SpatialSeries,
)
from pynwb.epoch import TimeIntervals
from pynwb.misc import IntervalSeries




'''创建NWB格式文件'''
# 1. 从CSV文件读取数据
csv_file_path = 'D:/GitHub_programe/GitHub/SPE_Database/4_Data_Extraction/4_2_Open_Data/Paper_6/P6_Exp1_raw.csv'
behavior_data = pd.read_csv(csv_file_path)

# 2. 创建NWB文件
P6_Exp1 = NWBFile(
    session_description="my first synthetic recording",
    identifier='behavior_data',
    session_start_time=datetime.now(tzlocal()),
    experimenter=[
        "Merryn D. Constable,  Günther Knoblich",
    ],
    lab="01",
    institution="01",
    experiment_description="Sticking together? Re-binding previous other-associated stimuli interferes "
                           "with self-verification but not partner-verification",
    session_id="P6_Exp1",
)

# P6_Exp1
# # 4. 添加TimeSeries到NWB文件
# NWBFile.add_acquisition(P6_Exp1)

# # 5. 将NWB文件保存到磁盘
# output_file = 'behavior_data.nwb'
# with NWBHDF5IO(output_file, 'w') as io:
#     io.write(NWBFile)

# print(f'Behavior data from CSV file has been saved to {output_file}')
# 创建TimeSeries对象


# speed_time_series = TimeSeries(
#     name="speed",
#     data=behavior_data['speed'].to_numpy(),
#     timestamps=behavior_data['timestamp'].to_numpy(),
#     description="The speed of the subject measured over time.",
#     unit="m/s",
# )

# # 将TimeSeries添加到NWB文件中
# P6_Exp1.add_acquisition(speed_time_series)

# # 将NWB文件保存到磁盘
# output_file = 'behavior_data.nwb'
# with NWBHDF5IO(output_file, 'w') as io:
#     io.write(P6_Exp1)

# print(f'Behavior data from CSV file has been saved to {output_file}')

variation_time = ['rt']
time_data = pd.read_csv(csv_file_path, usecols=variation_time)
time_data_array = time_data['rt'].to_numpy()
# time_series = TimeSeries(
#     name="Time",
#     data=time_data,
#     description="The reaction of time.",
#     unit="ms",
# )

start_time = 0  # 假设开始时间为 0
num_samples = len(time_data_array)
timestamps = np.arange(start_time, start_time + num_samples, 1)

time_series = TimeSeries(
    name="Time",
    data=time_data_array,
    # timestamps=timestamps,
    description="The reaction of time.",
    unit="ms",
)

print(time_series)
behavioral_time_series = BehavioralTimeSeries(
    time_series=time_series,
    name="BehavioralTimeSeries",
)

behavior_module.add(behavioral_time_series)