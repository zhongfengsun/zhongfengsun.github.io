%---------------------------------------------------------------
% Copyright (C) 2021.8  Zhongfeng Sun(SDUT)
%---------------------------------------------------------------
% A_{m*n}(m<<n) is a measurement matrix
% y is the acquired information(measurements) of the unknown signal to recover.
% x_exact is the exact sparse solution
% parameters: 0.3<alpha<1.6, 0<=beta<0.6
% N is the maximum number of iterations
% rel_er is the relative error of x
% x0,x1 are the initial values
% k is a prescribed integer number reflecting the sparsity level
 %suc_idx=1  indicate "Success or recovery"(0--false)
%--------------------------------------------------------
function [residual,xp_new,p,suc_idx,tEnd]=HBHTP(A,y,x_exact,x0,k,Max_iter,rel_er,resi_er,parameter)
%------------------------------initial information-----------------------------------
tStart = cputime;
format long;
alpha=parameter(1);
beta=parameter(2);
[m,n]=size(A);%the row and column numbers of A
x1=x0;
xp_old=x0;%xp_old is x^{p-1},xp_new is x^{p+1},
xp=x1;
p=1;
residual(1)=norm(y);
%---------------------------------
B=alpha*A.'*A;
Y=alpha*A.'*y;
nm_exact=norm(x_exact);
 suc_idx=0;%Index of  Success for recovery,0-false
 S=[];
%------------------------------
while(p<=Max_iter)
    %-----Step 1-------------
    up=xp-B*xp+Y+beta*(xp-xp_old);
    %-----Step 2--x^{p+1}=H_k(up)--Hard thresholding-------------
    abs_up=abs(up);
    [~,sort_idx]=sort(abs_up,'descend');%sort_idx is the rearrangement  of index, while ~ is the rearrangement  of abs_up
    %-------------------------------
    xp_new=zeros(n,1);
    S=sort_idx(1:k);
    %----------Replacing $xp_new(S)=A(:,S)\y$ by the following code--------------------
    SD=numel(S);
    Id_M=eye(SD);
    Q=A(:,S);
    M1=Q.'*Q;
    b1=Q.'*y;
    if SD>=m 
       M1=M1+(1e-9)*Id_M;
    end
    xp_new(S)=M1\b1; 
    %------------relative error-------------------------
    error=norm(xp_new-x_exact)/nm_exact;
    if(error<rel_er) 
         suc_idx=1;%Index of  Success for recovery
         break;
    end
    p=p+1;
%    residual(p)=norm(y-A*xp_new);
%     if(residual(p)<resi_er)
%         break;
%     end 
    %----------------------------------------------------
    xp_old=xp;
    xp=xp_new;
end
tEnd = cputime - tStart;
end

