
function[R]=posA_R(theta)

% theta为欧拉角,弧度制
% 绕 x 轴旋转矩阵
R_x = [1,       0,          0    ; 
       0, cos(theta(1)), -sin(theta(1));
       0, sin(theta(1)), cos(theta(1))];


%绕y轴旋转矩阵
R_y = [cos(theta(2)), 0, sin(theta(2));
       0,        1,      0;
       -sin(theta(2)), 0, cos(theta(2))];


% % 构建绕 z 轴旋转矩阵
R_z = [cos(theta(3)), -sin(theta(3)), 0; 
       sin(theta(3)), cos(theta(3)), 0; 
       0,          0,      1];

R=R_z*(R_y*(R_x));

end