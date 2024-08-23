
function[line_points]=one_line_camera_xyz(line,fx,fy,cx,cy,A)



% line=importdata("pixel_vu\pixel_cor\jg_vu1.txt");
% load("APP\cameraParams20.mat")
% out_par=cameraParams.PatternExtrinsics;
% iner_par=cameraParams.Intrinsics;
% fx=iner_par.FocalLength(1);
% fy=iner_par.FocalLength(2);
% cx=iner_par.PrincipalPoint(1);
% cy=iner_par.PrincipalPoint(2);
% A=out_par(10).A;
% for i=1:20
% 
%     A44=out_par(i).A;
% end
% i=5;


%% 
v=line(:,1);
u=line(:,2);
[number,~]=size(v);


xc2=(u-cx)/fx;
yc2=(v-cy)/fy;
zc2=1;

row_vector=[0,0,1,0]/A;

a1=row_vector(1);
b1=row_vector(2);
c1=row_vector(3);
d1=row_vector(4);

xc=(-d1*xc2)./(a1*xc2+b1*yc2+c1);
yc=(-d1*yc2)./(a1*xc2+b1*yc2+c1);

% 使用 ones 函数创建 n 维列向量
d1_vector = d1 * ones(number, 1);
zc=(-d1_vector)./(a1*xc2+b1*yc2+c1);

line_points=[xc,yc,zc];


% end









