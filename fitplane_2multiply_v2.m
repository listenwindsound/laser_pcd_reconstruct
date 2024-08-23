function [a, b, c,d] = fitplane_2multiply_v2(xyz)
%% --------------------------获取xyz坐标---------------------------
x=xyz(:,1);
y=xyz(:,2);
z=xyz(:,3);
planeData=[x,y,z];
%% --------------------------可视化点云----------------------------
% figure(1)
% pcshow(xyz,[1,0,0],'MarkerSize' ,100);
%% -------------------------SVD拟合平面----------------------------
% 1、计算点云质心
centroid=mean(planeData,1);
% 2、去质心化
deMean=bsxfun(@minus,planeData,centroid);
% 3、矩阵奇异值分解
[U,S,V]=svd(deMean,"econ");
% 4、获取最小特征值对应的特征向量 
a=double(V(1,3));
b=double(V(2,3));
c=double(V(3,3));
% 5、计算原点到拟合平面的距离
d = double(-dot([a b c],centroid'));
%% -----------------------可视化拟合结果--------------------------
            % figure(101)
            % % 图形绘制
            % scatter3(x,y,z,'filled')
            % hold on;
            % xfit = min(x):0.1:max(x);
            % yfit = min(y):0.1:max(y);
            % [XFit,YFit]= meshgrid (xfit,yfit);
            % ZFit = -(d + a * XFit + b * YFit)/c;
            % mesh(XFit,YFit,ZFit);
            % title('最小二乘拟合平面(SVD法)');

            
            % 打印平面参数
            % disp('平面方程：');
            % fprintf('%fx + %fy + %fz + %f = 0\n', a, b, c, d);
end
