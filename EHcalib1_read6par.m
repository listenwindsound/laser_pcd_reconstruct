

pre='data_eye_hand_calib/'
% subfold='240610'
post='camcalib_robot6par.xlsx';


% foldpath=strcat(pre,subfold,post);
foldpath=strcat(pre,post);



% s=readmatrix('data_eye_hand_calib/camcalib_robot6par.xlsx','sheet','sixpar');
s=readmatrix(foldpath,'sheet','sixpar');



baocun=strcat(pre,'trans_theta.txt')


% writematrix(s,'data_eye_hand_calib\trans_theta.txt')
writematrix(s,baocun)


