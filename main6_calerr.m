close all;clc;clear
% currentRow=[1034.05,-913.355,-80.133,-176.834,-0.763,-11.669]
%  T=[currentRow(1),currentRow(2),currentRow(3)];
%     theta=[currentRow(4),currentRow(5),currentRow(6)];
%     R=posA_R(theta);
%     base2tool=R_T_combination(R,T);


tool2camera = importdata('data_eye_hand_calib\eye_hand_matrix.txt');
data_name='20240125';
pixelfold_name='0228scan';
filePrefix=strcat('pixel_vu\',pixelfold_name,'\surface_vu');

% pos=importdata("data\trans_theta.txt");
% pos=importdata("data_reconstruct\20231228\trans_theta.txt");

% posfile_path=strcat('data_reconstruct\',date_name,'\trans_theta.txt');
posfile_path=strcat('data_reconstruct\trans_theta.txt');

pos=importdata(posfile_path);
% theta2rad(pos)
theta=pos(:,4:6);
rad=theta*pi/180;
pos(:,4:6)=rad;
% par=importdata("reconstruct_data\trans_rad.txt");
par=pos;
% 获取矩阵的行数
numRows = size(par, 1);

threeD=[];
z_all=[];
% 遍历每一行
for row = 1:10:numRows
    % row=20时的横截面形貌比较好看
    % row = 80;
    % 获取当前行数据
    currentRow = par(row, :);
    T=[currentRow(1),currentRow(2),currentRow(3)];
    theta=[currentRow(4),currentRow(5),currentRow(6)];
    R=posA_R(theta);
    base2tool=R_T_combination(R,T);

    % filePrefix="result\pixel_cor\jg_vu";
    % counter = sprintf('%03.2f', numRows);  % '03' 表示总宽度为3位，'2' 表示小数点后2位
    correct_jishu=row+21; % '因为前置的照片不可用，从有激光条纹的序号开始，自己查看
    if correct_jishu>240
        break
    end
    counter = sprintf('%d', correct_jishu);  
    filePostfix=".txt";
    pixel_pic_path = sprintf('%s%s%s', filePrefix,counter,filePostfix);
    line=importdata(pixel_pic_path);
    one_pic_point=pixel2camera(line);
    % one_pic_point=lvbo_gauss(one_pic_point);
    one_pic_point=lvbo_median(one_pic_point,1.5);
    % jj=num2str(row);
    % one_pcd_path=strcat('data_reconstruct\one_path\',jj,'.txt');
    % writematrix(one_pic_point,one_pcd_path)
    add_num=size(one_pic_point,1);
    one2add_row=ones(1,add_num);
    norm_one_pic_point=[one_pic_point';one2add_row];
    base_point=base2tool*tool2camera*norm_one_pic_point;
    % base_point=inv(tool2camera)*inv(base2tool)*norm_one_pic_point;
    % threeD=vertcat(threeD,base_point);
    one_z=mean(base_point(:,3));
    threeD=horzcat(threeD,base_point);
    z_all=[z_all,one_z];
end

z_all


disp_threeD=threeD(1:3,:)';
% done_pcd_path=strcat('data_reconstruct/',date_name,'/poins.txt');
done_pcd_path=strcat('data_reconstruct/poins.txt');
writematrix(disp_threeD,done_pcd_path)
figure()
pcshow(disp_threeD)
















