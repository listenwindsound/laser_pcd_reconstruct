function[]= posA_gather(pos)
% pos=importdata("data_calib/trans_theta19.txt");
theta2rad(pos)
theta=pos(:,4:6);
rad=theta*pi/180;
pos(:,4:6)=rad;
par=pos;
% par=importdata("data_calib/trans_rad19.txt");
% 获取矩阵的行数
numRows = size(par, 1);
filename='data_eye_hand_calib/pos_gather.txt';

all_A=[];
% 遍历每一行
for row = 1:numRows
    % 获取当前行数据
    currentRow = par(row, :);
    T=[currentRow(1),currentRow(2),currentRow(3)];
    theta=[currentRow(4),currentRow(5),currentRow(6)];
    R=posA_R(theta);
    A=R_T_combination(R,T);
    all_A=vertcat(all_A,A);  
end

% writematrix(A,filename,'WriteMode','append')
writematrix(all_A,filename)
end