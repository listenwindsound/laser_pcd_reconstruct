% function [] = distort_correct_v2(folderPath,par)
clear;clc
% 指定文件夹路径
% folderPath = 'picture/cam_calib/';  % 替换为你的文件夹路径
% folderPath = 'picture/laser_calib/';  % 替换为你的文件夹路径
folderPath = 'picture/laser/';  % 替换为你的文件夹路径
% folderPath = 'picture/surface/';  % 替换为你的文件夹路径
type='laser_only';
load("APP\laser_calib_campar.mat");
% load("APP\cam_par_glass.mat");

%%


% 使用 dir 函数获取文件夹中的文件列表
files = dir(fullfile(folderPath, '*.png'));  % 可根据需要更改文件扩展名

% 获取文件数目
numFiles = length(files);


for ci=1:numFiles
    % 循环遍历文件列表并逐个读取以特定字符开头的 Excel 表格
    for i = 1:numFiles
        
        % 获取文件名
        fileName = files(i).name;
        fullpath=fullfile(folderPath,fileName);
        % 使用正则表达式提取数字
        numbers = regexp(fileName, '\d+(\.\d+)?', 'match');
        % 将提取的数字转换为数值
        numericValues = str2double(numbers);
        if  numericValues==ci
       
            I = imread(fullpath);
            J = undistortImage(I,cameraParams,'OutputView','full');
            % 保存图像到新文件夹
            count=num2str(ci);
            imageName = [type,'_',count,'.png'];  % 新图像的文件名,超过三个组成部分就不能用strcat了，可以直接用[]
            perfix=['picture_correct/correct_',type,'_3xishu/'];
            outputPath = fullfile(perfix, imageName);
            % 使用 exist 函数检查文件夹是否存在
            if exist(perfix, 'dir') ~= 7
            mkdir(perfix);
            end
            imwrite(J, outputPath);
        else
            continue
        end
            
        
    end
end

















% I = images.readimage(1);
% J1 = undistortImage(I,cameraParams);
% figure; imshowpair(I,J1,'montage');
% title('Original Image (left) vs. Corrected Image (right)');
 

 
