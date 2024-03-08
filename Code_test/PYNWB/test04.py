import csv
from pynwb import NWBFile
from pynwb.core import DynamicTable
from datetime import datetime
from dateutil.tz import tzlocal

# 读取CSV文件并解析数据
data_rows = []
with open('D:/GitHub_programe/GitHub/SPE_Database/4_Data_Extraction/4_2_Open_Data/Paper_6/P6_Exp1_raw.csv', 'r') as csvfile:
    csvreader = csv.DictReader(csvfile)
    for clone in csvreader:
        data_rows.append(clone)

# 创建一个DynamicTable对象
table = DynamicTable(name='example_table', description='an example table',
                     columns=[
                         {'name': 'Shape', 'description': 'description of Shape', 'type': 'text'},
                         {'name': 'Label', 'description': 'description of Label', 'type': 'text'},
                         {'name': 'ShapeLoc', 'description': 'description of ShapeLoc', 'type': 'text'},
                         {'name': 'Condition', 'description': 'description of Condition', 'type': 'text'},
                         {'name': '.thisRepN', 'description': 'description of thisRepN', 'type': 'float'},
                         {'name': '.thisTrialN', 'description': 'description of thisTrialN', 'type': 'float'},
                         {'name': '.thisN', 'description': 'description of thisN', 'type': 'float'},
                         {'name': '.thisIndex', 'description': 'description of thisIndex', 'type': 'float'},
                         {'name': 'resp', 'description': 'description of resp', 'type': 'text'},
                         {'name': 'rt', 'description': 'description of rt', 'type': 'float'},
                         {'name': 'Exclude', 'description': 'description of Exclude', 'type': 'text'},
                         {'name': 'StrangerShape', 'description': 'description of StrangerShape', 'type': 'text'},
                         {'name': 'P1Shape', 'description': 'description of P1Shape', 'type': 'text'},
                         {'name': 'P2Shape', 'description': 'description of P2Shape', 'type': 'text'},
                         {'name': 'corr', 'description': 'description of corr', 'type': 'text'},
                         {'name': 'Training', 'description': 'description of Training', 'type': 'text'},
                         {'name': 'nCorr', 'description': 'description of nCorr', 'type': 'integer'},
                         {'name': 'trialinblock', 'description': 'description of trialinblock', 'type': 'integer'},
                         {'name': 'BlankFrames', 'description': 'description of BlankFrames', 'type': 'integer'},
                         {'name': 'Block', 'description': 'description of Block', 'type': 'integer'},
                         {'name': 'Pair Number', 'description': 'description of Pair Number', 'type': 'integer'},
                         {'name': 'Participant 1 Age', 'description': 'description of Participant 1 Age', 'type': 'integer'},
                         {'name': 'Participant 2 Age', 'description': 'description of Participant 2 Age', 'type': 'integer'},
                         {'name': 'Phase', 'description': 'description of Phase', 'type': 'text'}
                     ])

# 将数据添加到DynamicTable中
for row in data_rows:
    table.add_row(**row)

# 初始化NWBFile对象，传入session_start_time参数
nwbfile = NWBFile(
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

# 将DynamicTable添加到NWB文件中
nwbfile.add_acquisition(table)

# 保存NWB文件
from pynwb import NWBHDF5IO
with NWBHDF5IO('D:\GitHub_programe\GitHub\Learn-how-to-use-git\Code_testdynamic_table_example.nwb', mode='w') as io:
    io.write(nwbfile)
