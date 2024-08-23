from function_package import *
import cv2 as cv
import numpy as np
import pandas as pd
from scipy.spatial.transform import Rotation as R
from math import *

path = "data_eye_hand_calib/"
path_A_R = f'{path}A_R.txt'
path_A_T = f'{path}A_T.txt'
path_B_R = f'{path}B_R.txt'
path_B_T = f'{path}B_T.txt'

# path_A_R = 'data/deltA_R.txt'
# path_A_T = 'data/deltA_T.txt'
# path_B_R = 'data/deltB_R.txt'
# path_B_T = 'data/deltB_T.txt'


A_R = solve_R(path_A_R)
A_T = solve_T(path_A_T)
B_R = solve_R(path_B_R)
B_T = solve_T(path_B_T)

# print(A_R)
# print(A_T)
# print(B_R)
# print(B_T)

# 夹爪坐标系（gripper）到基座坐标系（base）的平移向量; 标定板坐标系（target）到相机坐标系（camera）的平移向量,g2b为A，t2c为B
# [R_c2g, t_c2g] = cv.calibrateHandEye(R_g2b, t_g2b, R_t2c, t_t2c, cv.CALIB_HAND_EYE_TSAI)
# [R_c2g, t_c2g] = cv.calibrateHandEye(A_R, A_T, B_R, B_T, cv.CALIB_HAND_EYE_TSAI)
[R_c2g, t_c2g] = cv.calibrateHandEye(A_R, A_T, B_R, B_T)
T_c2g = np.hstack([R_c2g, t_c2g])
T_c2g = np.vstack([T_c2g, [0, 0, 0, 1]])
print("相机到抓手的转换矩阵： \n", T_c2g)

# ---------------------------------------指定保存文件的路径
file_path = f"{path}eye_hand_matrix.txt"
# 使用np.savetxt()保存矩阵为文本文件
np.savetxt(file_path, T_c2g)
print(f"矩阵已保存到 '{file_path}' 文件中。")


# A_R结构18*3*3
posenum=A_R.shape[0]
print(posenum)
rotation_error = 0
translation_error = 0
for idx in range(posenum-1):
    R_A = A_R[idx+1,:,:].T @ A_R[idx,:,:]
    R_B = B_R[idx+1,:,:] @ B_R[idx,:,:].T
    R_X = R_c2g
    deltaR = (R_A@R_X).T @ (R_X@R_B)
    deltaR = R.from_matrix(deltaR).as_euler('ZYX', degrees=False)
    rotation_error = rotation_error + np.linalg.norm(deltaR)**2

    t_A = A_R[idx+1,:,:].T @ (A_T[idx,:,:] - A_T[idx+1,:,:])
    t_B = B_T[idx+1,:,:] - B_R[idx+1,:,:] @ B_R[idx,:,:].T @ B_T[idx,:,:]
    t_X = t_c2g
    translation_error = translation_error + np.linalg.norm(R_A@t_X + t_A - R_X@t_B - t_X)**2

rotation_error = rotation_error/(posenum-1)
translation_error = translation_error/(posenum-1)

print("平均旋转误差(rad)为：\n", rotation_error)
print("平均平移误差为：\n", translation_error)