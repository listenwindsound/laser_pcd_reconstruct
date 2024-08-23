
function[]=theta2rad(pos)
% pos=importdata("data\trans_theta.txt");
% format long  % 更改为显示15 位小数
theta=pos(:,4:6);

rad=theta*pi/180;


pos(:,4:6)=rad;

% filename1 = 'data/trans_rad.txt';
filename1 = 'data_reconstruct/trans_rad.txt';

writematrix( pos, filename1,'delimiter', ','); % 使用分隔符

% filename2 = 'data/rad.txt';
filename2 = 'data_reconstruct/rad.txt';
writematrix( rad, filename2,'delimiter', ','); % 使用分隔符

end