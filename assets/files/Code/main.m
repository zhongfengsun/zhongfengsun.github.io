%==============================================================
% Use of this code is free for research purposes only.
%================Reference==============================================
% Z.F. Sun, J.C. Zhou, Y.B. Zhao, and N. Meng. Heavy-ball-based hard thresholding
% algorithms for sparse signal recovery. accepted by J. Comput. Appl. Math., 2023.
%===============================================================
% This main code is associated with the comparison of success frequencies of algorithms with accurate  measurements.
% The parameters alpha=0.6,beta= 0.1 are set in HBHT, and alpha= 1.7,beta= 0.7 are set in HBHTP. 
% The results for average number of iterations and time can be obtained after revising this main code.
%================================================================
%sprandn(m,n,density)--returns a vector containing the linear indices of each nonzero element in array X.
%with approximately density*m*n normally distributed nonzero 
%entries for density in the interval [0,1].
%S=find(x_exact);%return the location of the nonzero elements of a vector
%=================================================================================
clear;
format long;
tic
%------Initialization-------{A*x=y,norm(x,0)<=k}--A is an m by n matrix---
m=400;n=800;
Max_iter=50;%Max iteration number
rel_er=1e-3;%relative error/prescribe tolerance
resi_er=1.0e-8;%residual error
x0=zeros(n,1);
x1=x0;
Nb_test=100;
%--------------------------------------
% HBHT: 0.3+2*beta<=alpha<=1.6, 0<=beta<=0.6
% HBHTP: 0.4+2*beta<=alpha<=1.7, 0<=beta<=0.7
k=1:4:297;
Nb_k=length(k);
Nb_alg=4;
Nbsuc=zeros(Nb_k,Nb_alg);
Nm_alg=["HBHT","HBHTP","HBHT","HBHTP"];
parameter=[0.6,0.1;1.7,0.7;1,0;1,0];%parameter=[alpha,beta],
% If beta=0, then HBHTP,HBHT reduce to HTP,IHT, respectively.
Fun=cell(1,Nb_alg);%cell array,Fun{1,i_alg}is the Function handle
for i_alg=1:Nb_alg
    Fun{1,i_alg}=str2func(Nm_alg(i_alg));
end
for i=1:Nb_k
    k(i)
    for j=1:Nb_test%100 random data
        %-----------------
        A=randn(m,n);%identically distributed random variables folloes N(0,1)
        x_exact=sprandn(n,1,k(i)/n);   %Exact solution: x_exact is a k-sparse vector -   
        A=A/sqrt(m);%--A~N(0,1/m)---
        y=A*x_exact; %---accurate measurements----------------
        %-----------------------------------------
        suc_id=zeros(Nb_alg,1);
       for i_alg=1:Nb_alg          
           [~,~,~,suc_id(i_alg),~]=Fun{1,i_alg}(A,y,x_exact,x0,k(i),Max_iter,rel_er,resi_er,parameter(i_alg,:));
       end
       for q=1:Nb_alg    
           Nbsuc(i,q)=Nbsuc(i,q)+suc_id(q);
       end
    end
end
 %----------write the infromation to excel---------------------
fid= fopen('suc.xls','w');
for i=1:Nb_k
    fprintf(fid,'%d\t%f \t%f \t%f \t%f\r',k(i),Nbsuc(i,:));
end
fclose(fid);
toc
figure_plot;

