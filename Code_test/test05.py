from pynwb import NWBHDF5IO

# 指定要读取的NWB文件路径
file_path = 'D:\GitHub_programe\GitHub\Learn-how-to-use-git\Code_test\dynamic_table_example.nwb'

# 使用NWBHDF5IO对象加载NWB文件
with NWBHDF5IO(file_path, mode='r') as io:
    nwbfile = io.read()

    # 从NWBFile对象中获取所需的数据
    # 例如，获取实验会话的开始时间
    session_start_time = nwbfile.session_start_time
    print("Session Start Time:", session_start_time)

    # 获取DynamicTable数据
    # 假设您的DynamicTable名称为'example_table'
    if 'example_table' in nwbfile.acquisition:
        table = nwbfile.acquisition['example_table']
        data = table.to_dataframe()  # 将DynamicTable转换为pandas DataFrame
        print("DynamicTable Data:")
        print(data.head())  # 打印前几行数据

        # 在这里进行数据分析
        # 例如，使用pandas或matplotlib进行数据分析和可视化
        # 例如，计算平均值、标准差、绘制图表等
        # 例如，data.describe()，data.plot()，等等

    # 获取其他数据...
