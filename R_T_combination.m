

function[transform]=R_T_combination(R,T)


transform0=[R,T'];
newRow=[0,0,0,1];
transform = vertcat(transform0, newRow);


end

