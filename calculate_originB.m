function[B]=calculate_originB(x)
%% 相机标定数据导入
% x=load('APP/cameraParams20.mat');

% out_par=x.PatternExtrinsics;
% out_par=x.cameraParams0125.PatternExtrinsics;
out_par=x.cameraParams.PatternExtrinsics;


% Rr1 = calibrationSession.CameraParameters.RotationMatrices(:,:,1);
img_num=size(out_par,1);

for i=1:1:img_num
    A=out_par(i).A;
    B(:,:,i) = A;
end

