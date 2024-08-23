


function[xyz_filter]=lvbo_median(xyz,lvbo_radius)

ptCloud=pointCloud(xyz);


%%
% close all;clc;clear
% ptCloud = pcread('extract\baizhen_eva_seu.pcd'); 
% xyz=ptCloud.Location;
% lvbo_radius=4.5;
% % pcshow(ptCloud.Location,ptCloud.Location(:,1))
% pcshow(ptCloud,'BackgroundColor',[1 1 1])
% view(180,0)
% title('Original Point Cloud')
% colormap("Turbo")

%%


FilterptCloud = pcmedian(ptCloud,'Dimensions',3,'Radius',lvbo_radius);%中值滤波
xyz_filter=FilterptCloud.Location;
% figure("name","2")
% % pcshow(ptCloudB.Location, ptCloudB.Location(:,1))
% pcshow(ptCloudB,'BackgroundColor',[1 1 1])
% view(180,0)
% title('Filtered Point Cloud')
% colormap("Turbo")

% fig2_out = gcf; % current figure handle
% fig2_in = gca;
% fig2_out.Color = [1 1 1];
% fig_in.Color=[1 1 1];
%% 保存图片

filePrefix1 = "picture1018/median/中值滤波前后xz视角_滤波半径";
filePrefix2 = 'picture1018/median/中值滤波前点云轴测视角图_滤波半径';
filePrefix3 = "picture1018/median/中值滤波后点云轴测视角图_滤波半径";
counter = num2str(lvbo_radius);

    % 检查字符串中是否包含小数点
% if contains(counter, '.')
%     % 如果包含小数点，则替换小数点为下划线
%     counter= strrep(counter, '.', '_');
% end


% filePostfix="原角度";
% fileName1 = sprintf('%s%s.png', filePrefix1, counter);
% fileName2 = sprintf('%s%s.png', filePrefix2, counter);
% fileName3 = sprintf('%s%s.png', filePrefix3, counter);
%% ----------------------------可视化结果--------------------------------
% figure("name","滤波前后点云")
% % subplot(2,1,1)
% subplot('Position',[0.05 0.5 0.9 0.3])
% pcshow(ptCloud,'BackgroundColor',[1 1 1])
% view(180,0)
% title('Point cloud before median filtering');
% colormap("Turbo");
% colorbar('Location', 'southoutside');

% 
% figure("name","滤波前后点云")
% % subplot(2,1,2)
% % subplot('Position',[0.05 0.2 0.9 0.3])
% pcshow(FilterptCloud ,'BackgroundColor',[1 1 1])
% view(180,0)
% title('Point cloud after median filtering');
% colormap("Turbo");
% % colorbar('Location', 'southoutside');
% colorbar('Position', [0.08, 0.25, 0.02, 0.5]);
% % saveas(gcf, 'picture1226/lvbo_xz/median','png');
% % saveas(gcf, fileName1,'png');
% 
% 
% figure("name","中值滤波前轴测点云")
% pcshow(ptCloud,'BackgroundColor',[1 1 1])
% view(30,30)
% zoom(1.2)
% title('Point cloud before median filtering');
% colormap("Turbo");
% c1=colorbar('Location', 'southoutside');
% c1.Position = [0.2 0.1 0.6 0.02]; % [left, bottom, width, height]
% % 使用saveas函数保存图像
% % saveas(gcf,  fileName2,'png');
% 
% 
% figure("name","中值滤波后轴测点云")
% % subplot(2,1,2)
% pcshow(FilterptCloud ,'BackgroundColor',[1 1 1])
% view(30,30)
% zoom(1.2)
% title('Point cloud after median filtering');
% colormap("Turbo");
% c2=colorbar('Location', 'southoutside');
% c2.Position = [0.2 0.1 0.6 0.02]; % [left, bottom, width, height]
% 使用saveas函数保存图像
% saveas(gcf, fileName3,'png');





% end



