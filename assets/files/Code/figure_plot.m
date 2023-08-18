clear;clc;
load suc.xls;
plot(suc(:,1),suc(:,2),'ks-',suc(:,1),suc(:,3),'ro-',suc(:,1),suc(:,4),'gd-',suc(:,1),suc(:,5),'b^-','LineWidth',1,'MarkerSize',6),
ylabel('Succcess  frequencies  for  recovery'),xlabel('Sparsity  level'),
legend('HBIHT','HBHTP','IHT','HTP')
%axis([0, 300,0,100]),%set(gca,'XTick',0:30:300)

