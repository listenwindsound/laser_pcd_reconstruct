clear
pos=importdata("data_reconstruct\start_end.txt");
% 相册文件夹
this_time_name='0228scan'
folderPath = strcat('picture_for_reconstruct/',this_time_name);

start_row=pos(1,:);
x=pos(:,1);
y=pos(:,2);
x_start=x(1);
y_start=y(1);
% 使用 dir 函数获取文件夹中的信息
filesInfo = dir(folderPath);
% 初始化文件计数器
fileCount = 0;
% 遍历文件夹中的信息
for i = 1:numel(filesInfo)
    % 检查每个元素是否是文件（而不是文件夹）
    if ~filesInfo(i).isdir
        fileCount = fileCount + 1;
    end
end


delt_x=(x(2)-x(1))/(fileCount-1);
delt_y=(y(2)-y(1))/(fileCount-1);

sixpos=[];
% filename=strcat('data_reconstruct/',baocun_name,'/trans_theta.txt');
filename=strcat('data_reconstruct/trans_theta.txt');
for i =0:(fileCount-1)
    xi=x_start+delt_x*i;
    yi=y_start+delt_y*i;
    start_row(1)=xi;
    start_row(2)=yi;
    add_row=start_row;
    sixpos=vertcat(sixpos,add_row);
    
end

writematrix(sixpos,filename)










