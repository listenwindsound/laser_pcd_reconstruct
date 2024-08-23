
function[A]=calculate_originA(x)


% x = load("data\pos_gather.txt"); 
count=size(x,1);
img_num = count/4;

pos = zeros(4,4,img_num);
% 各个点机械臂位姿变化矩阵
for i=1:1:img_num
    pos(:,:,i) = x(((4*(i-1)+1):4*i),:);
end

% 矩阵拼接
A = [];
for i=1:1:img_num
    A(:,:,i) =  pos(:,:,i);
end

