

function[xyz]=lvbo_gauss(xyz,wins)

% 加载点云数据
% ptCloud = pcread('extract\baizhen_eva_seu.pcd'); 
% xyz=ptCloud.Location;

ptCloud=pointCloud(xyz);
%%



% x = 1;
% phi_x = normcdf(x);
% disp(['标准正态分布函数在 x = 1 的值为：', num2str(phi_x)]);


% % 正态分布函数表达式
% probability = (1 / (sigma*sqrt(2*pi))) * e^(-(x-u)^2 / (2*sigma^2));
% probability = (1 / (sigma*sqrt(2*pi))) * e^(-(x)^2 / (2*sigma^2));
% 设置高斯过滤器（球体）半径
% radius=3;   %  单位mm
% 设置高斯滤波参数
% sigma = 0.01; % 高斯函数标准差，根据点云密度和噪声水平进行调整

%取均值周围3倍标准差内的值，3倍sigmaz分位点占比99%以上

%%


% 通过中值滤波实现平滑处理
% 针对x坐标平滑
% p1 = smoothdata(xyz(:,1),'gaussian');
% p1 = smoothdata(xyz(:,1),'rloess');
% p1 = smoothdata(xyz(:,1),'rlowess');
% p1 = smoothdata(xyz(:,1),'sgolay');
% 针对y坐标平滑
% p2 = smoothdata(xyz(:,2),'gaussian');
% p2 = smoothdata(xyz(:,1),'rloess');
% p2 = smoothdata(xyz(:,1),'rlowess');
% p2 = smoothdata(xyz(:,1),'sgolay');
% 针对z坐标平滑


%% Switch
% p3 = smoothdata(xyz(:,3),'gaussian',wins);%窗口长度可调参数，需为正整数
[p3,windows] = smoothdata(xyz(:,3),'gaussian');





% p3 = smoothdata(xyz(:,1),'rloess');
% p3 = smoothdata(xyz(:,1),'rlowess');
% p3 = smoothdata(xyz(:,1),'sgolay');
% pp为平滑后的xyz组合
xyz(:,3)=p3;
% xyz(:,2)=p2;
% xyz(:,1)=p1;

smoothedPtCloud=pointCloud(xyz);

%% ----------------------------可视化结果--------------------------------
% % 显示原始点云和平滑后的点云
% figure(1);
% pcshow(ptCloud, 'MarkerSize', 50);
% view(180,0)
% figure(2)
% pcshow(smoothedPtCloud, 'MarkerSize', 50,'BackgroundColor',[1 1 1]);
% view(180,0)
% legend('原始点云', '平滑后的点云');
% title('点云高斯滤波去噪示例');







filePrefix1 = "picture1018/gauss/高斯滤波前后xz视角_窗口";
filePrefix2 = 'picture1018/gauss/高斯滤波前点云轴测视角图_窗口';
filePrefix3 = "picture1018/gauss/高斯滤波后点云轴测视角图_窗口";
%% Switch
% counter = num2str(wins);
% filePostfix="原角度";
% fileName1 = sprintf('%s%s%s.png', filePrefix1, counter);
% fileName2 = sprintf('%s%s%s.png', filePrefix2, counter);
% fileName3 = sprintf('%s%s%s.png', filePrefix3, counter);

% %% 可视化
% figure("name",'滤波前xz视角')
% % subplot(2,1,1)
% % subplot('Position',[0.05 0.5 0.9 0.3])
% pcshow(ptCloud,'BackgroundColor',[1 1 1])
% view(180,0)%xz视角
% title('Origin Point cloud');
% colormap("Turbo");
% colorbar('Position', [0.08, 0.25, 0.02, 0.5]);
% % saveas(gcf, 'picture1226/lvbo_xz/origin','png');
% 
% figure("name",'滤波后xz视角')
% % subplot(2,1,2)
% % subplot('Position',[0.05 0.2 0.9 0.3])
% pcshow(smoothedPtCloud ,'BackgroundColor',[1 1 1])
% view(180,0)
% title('Point cloud after Gaussian filtering');
% colormap("Turbo");
% colorbar('Position', [0.08, 0.25, 0.02, 0.5]);
% % 指定保存路径和文件名
% % save_folder = 'picture/gauss'; 
% % 使用saveas函数保存图像
% % saveas(gcf, fileName1,'png');
% saveas(gcf, 'picture1226/lvbo_xz/gauss','png');
% 
% 
% figure("name","高斯滤波前轴测点云")
% % subplot(2,1,1)
% pcshow(ptCloud,'BackgroundColor',[1 1 1])
% view(30,30)%轴测视角
% zoom(1.2)
% % title('未滤波前点云');
% title('Origin point cloud');
% colormap("Turbo");
% c1=colorbar('Location', 'southoutside');
% c1.Position = [0.2 0.1 0.6 0.02]; % [left, bottom, width, height]
% % 指定保存路径和文件名
% % save_folder = 'picture/gauss/'; 
% % 使用saveas函数保存图像
% % saveas(gcf,  fileName2,'png');
% % saveas(gcf,  'picture1226/origin','png');
% 
% figure("name","高斯滤波后轴测点云")
% % subplot(2,1,2)
% pcshow(smoothedPtCloud ,'BackgroundColor',[1 1 1])
% view(30,30)
% zoom(1.2)
% % title('高斯滤波后点云');
% title('Point cloud after Gaussian filtering');
% colormap("Turbo");
% c2=colorbar('Location', 'southoutside');
% c2.Position = [0.2 0.1 0.6 0.02]; % [left, bottom, width, height]
% 指定保存路径和文件名
% save_folder = 'picture/gauss'; 
% file_name = '高斯滤波后点云轴测视角图.png'; 
% 使用saveas函数保存图像
% saveas(gcf, fileName3,'png');

% end


