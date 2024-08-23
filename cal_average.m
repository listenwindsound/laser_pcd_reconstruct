close all;clear;clc
jishu=211
jishu=num2str(jishu);
name=strcat('data_reconstruct\one_path\',jishu,'.txt');
xyz=importdata(name);

pcd=pointCloud(xyz);
figure
pcshow(pcd)

xrange=pcd.XLimits;
zrange=pcd.ZLimits;
x_min=xrange(1);
x_max=xrange(2);

% num_min=22
% num_max=10.5
num_min=10.5
num_max=22
x_min=x_min+num_min;
x_max=x_max-num_max;
% 提取 x 坐标
x_coords = xyz(:, 1);
indices1 = (x_coords >= x_min) & (x_coords <= x_max);
indices2 = (x_coords <= x_min) ;
% indices2 = (x_coords >= x_max) ;
% 使用逻辑索引选取范围内的点
up= xyz(indices1, :);
% 计算均值和标准差
mean_value = mean(up(:,3));
std_dev = std(up(:,3));
% 计算异常值的上下界
lower_bound = mean_value - 3 * std_dev;
upper_bound = mean_value + 3 * std_dev;
% 使用逻辑索引剔除异常值
filtered_up = up(up(:,3) >= lower_bound & up(:,3) <= upper_bound,:);

figure("Name",'up')
pcshow(pointCloud(filtered_up))

base=xyz(indices2,:);
figure('name',"base")
pcshow(pointCloud(base))

averz_up=mean(filtered_up(:,3))
averz_base=mean(base(:,3))
height=abs(averz_base-averz_up)



