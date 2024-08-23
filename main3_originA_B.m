clear;close all ;clc
pos=importdata("data_eye_hand_calib/trans_theta.txt");
posA_gather(pos)
a = load("data_eye_hand_calib/pos_gather.txt"); %机器人6参数 ，base2tool
A=calculate_originA(a);

% 相机到标定板（目标），camera2target,导入相机标定的外参（激光标定已完成，无需再用)
% b=load("APP/correct/camera_calib_campar.mat");
% b=load("APP/240610/cam_calib.mat");
b=load("APP/240610/cameraParams.mat");
% b=load("APP/correct/113.mat"); 
B=calculate_originB(b);

%%  A矩阵的处理

foldname="data_eye_hand_calib/";
% 获取矩阵的行数
numRows = size(A, 3);
filename1=strcat(foldname,'A.txt');
filename2=strcat(foldname,'A_R.txt');
filename3=strcat(foldname,'A_T.txt');
matrixA=[];
matrixA_R=[];
matrixA_T=[];


% 遍历每一行
for row = 1:numRows
    % 获取当前行数据
    currentMatrix = A(:,:,row);
    currentMatrix_R=A(1:3,1:3,row);
    currentMatrix_T=A(1:3,4,row);
    matrixA=vertcat(matrixA,currentMatrix);
    matrixA_R=vertcat(matrixA_R,currentMatrix_R);
    matrixA_T=vertcat(matrixA_T,currentMatrix_T);
    % writematrix(currentMatrix,filename1,'WriteMode','append')
    % writematrix(currentMatrix_R,filename2,'WriteMode','append')
    % writematrix(currentMatrix_T,filename3,'WriteMode','append')
    
end
writematrix(matrixA,filename1)
writematrix(matrixA_R,filename2)
writematrix(matrixA_T,filename3)
%%    B矩阵的处理
% 获取矩阵的行数
B_numRows = size(B, 3);
filename11=strcat(foldname,'B.txt');
filename22=strcat(foldname,'B_R.txt');
filename33=strcat(foldname,'B_T.txt');
matrixB=[];
matrixB_R=[];
matrixB_T=[];

% 遍历每一行
for row = 1:B_numRows
    % 获取当前行数据
    currentMatrix = B(:,:,row);
    currentMatrix_R=B(1:3,1:3,row);
    currentMatrix_T=B(1:3,4,row);
    matrixB=vertcat(matrixB,currentMatrix);
    matrixB_R=vertcat(matrixB_R,currentMatrix_R);
    matrixB_T=vertcat(matrixB_T,currentMatrix_T);
    % writematrix(currentMatrix,filename11,'WriteMode','append')
    % writematrix(currentMatrix_R,filename22,'WriteMode','append')
    % writematrix(currentMatrix_T,filename33,'WriteMode','append')
end
writematrix(matrixB,filename11)
writematrix(matrixB_R,filename22)
writematrix(matrixB_T,filename33)





