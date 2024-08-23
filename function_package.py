import numpy as np
from skimage import morphology, draw
import cv2
import matplotlib.pyplot as plt

# 欧拉角转换为旋转矩阵
# 输入为欧拉角为 弧度制
# euler_angles = [-0.05366141770874149, -1.2561686529408898, 1.6272221428848495]
def eulerAnglesToRotationMatrix(theta):
    R_x = np.array([[1, 0, 0],
                    [0, np.cos(theta[0]), -np.sin(theta[0])],
                    [0, np.sin(theta[0]), np.cos(theta[0])]
                    ])

    R_y = np.array([[np.cos(theta[1]), 0, np.sin(theta[1])],
                    [0, 1, 0],
                    [-np.sin(theta[1]), 0, np.cos(theta[1])]
                    ])

    R_z = np.array([[np.cos(theta[2]), -np.sin(theta[2]), 0],
                    [np.sin(theta[2]), np.cos(theta[2]), 0],
                    [0, 0, 1]
                    ])

    R = np.dot(R_z, np.dot(R_y, R_x))
    print(f"Rotate matrix:\n{R}")
    return R


def solve_R(path):
    # 打开txt文件进行读取
    line_count = 0
    with open(path, 'r') as file:
        # 读取文件内容并将其分割成行
        lines = file.read().splitlines()
        for line in lines:
            line_count = line_count + 1
    # print(type(file))

    # 初始化一个空的列表以存储数据
    num = line_count // 3
    matrix = np.zeros((num, 3, 3))
    current_matrix = np.zeros((3, 3))
    # 遍历每一行数据，并将其解析为浮点数
    count = -1
    matrix_count = -1
    for line in lines:
        count = count + 1
        line_data = [float(value) for value in line.split(',')]
        # print(type(line_data))
        # new_row = np.array(line_data)
        current_matrix[count, :] = line_data
        if count == 2:
            count = -1
            matrix_count = matrix_count + 1
            matrix[matrix_count, :, :] = current_matrix

    matrix = np.array(matrix)
    return matrix


def solve_T(path):
    # 打开txt文件进行读取
    line_count = 0
    with open(path, 'r') as file:
        # 读取文件内容并将其分割成行
        lines = file.read().splitlines()
        for line in lines:
            line_count = line_count + 1
    # print(type(file))

    # 初始化一个空的列表以存储数据
    num = line_count // 3
    matrix = np.zeros((num, 3, 1))
    current_matrix = np.zeros((3, 1))
    # 遍历每一行数据，并将其解析为浮点数
    count = -1
    matrix_count = -1
    for line in lines:
        count = count + 1
        line_data = [float(value) for value in line.split(',')]
        # print(type(line_data))
        # new_row = np.array(line_data)
        current_matrix[count, :] = line_data
        if count == 2:
            count = -1
            matrix_count = matrix_count + 1
            matrix[matrix_count, :, :] = current_matrix
    matrix = np.array(matrix)
    return matrix

def zhang(image):
    # 读取图像,进行图像二值化操作
    _, binary_image = cv2.threshold(image, 180, 1, cv2.THRESH_BINARY)
    # -----------------------------------------执行腐蚀操作--------------------------------------------------------
    # 定义腐蚀核大小，可根据需要调整
    kernel_size_erod = 3
    # 创建腐蚀核
    kernel_erod = np.ones((kernel_size_erod, kernel_size_erod), np.uint8)
    eroded_image = cv2.erode(binary_image, kernel_erod, iterations=1)

    # 这里的image是二值图像的01二维矩阵
    # -------------------------------------------------实施骨架算法-------------------------------------------------
    skeleton = morphology.skeletonize(eroded_image)
    # 找出值为1的像素的坐标,1或255为白色
    indices = np.where(skeleton == 1)
    coordinates = np.array(indices)
    # coordinate的第一列是像素y坐标，第二列是像素x坐标,即（v，u）坐标
    return coordinates, skeleton