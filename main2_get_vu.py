import os
import re
from function_package import *
import cv2
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image

# 指定要遍历的文件夹路径
lujin = '0228scan'
folder_path = 'picture/' + lujin  # 替换为实际文件夹的路径
# folder_path = "picture_correct/correct_laser_only_3xishu"  # 替换为实际文件夹的路径
zifu = "surface"

# 获取文件夹中的所有文件
file_list = os.listdir(folder_path)
# 使用正则表达式来提取文件名中的数字
# 假设文件名中的数字是以连续的数字字符组成的
number_pattern = re.compile(r'\d+')
# 提取文件名中的数字并排序
numbers = sorted([int(number_pattern.search(file_name).group()) for file_name in file_list])

# -------------------------------------------遍历图片-----------------------------------------------------------

# 设置像素坐标txt文件保存地址
folderStore_name = 'pixel_vu/'+lujin+'/'
# folderStore_name = "pixel_vu/correct_jg_vu_3xishu/"
if not os.path.exists(folderStore_name):
    # 文件夹不存在，创建它
    os.makedirs(folderStore_name)
    print(f"文件夹 '{folderStore_name}' 已创建。")
# 遍历文件
for number in numbers:
    # 读取文件名
    file_name = f"image_{number}.png"  # 可以根据需要更改扩展名
    file_path = os.path.join(folder_path, file_name)
    # print(f"Processing file: {file_path}")
    image = cv2.imread(file_path, cv2.IMREAD_GRAYSCALE)
    # file_name = "result/jg1.txt"
    txt_name = f"{folderStore_name}{zifu}_vu{number}.txt"
    cor, pic = zhang(image)

    # print(cor)
    # print(type(cor))
    cor = cor.T
    # print(cor)
    # 可视化图像
    # # 使用Matplotlib显示图像
    # plt.imshow(pic, cmap='gray')
    # plt.title('Binary Image')
    # plt.axis('off')  # 关闭坐标轴显示
    # -------------------------------------------- 显示图像------------------------------------------------------------
    # cv2.imshow(f'skeleton{number}', (pic * 255).astype(np.uint8))
    # ---------------------------------------------保存像素坐标矩阵------------------------------------------------------
    # 打开文件以进行写入
    with open(txt_name, 'w') as file:
        for row in cor:
            # 将每行的数据转换为字符串，并添加换行符
            row_str = ' '.join(map(str, row))
            file.write(row_str + '\n')

cv2.waitKey(0)
cv2.destroyAllWindows()
