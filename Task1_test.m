x = 0:1:200;
y1 = 100./(100+x);
y2 = 300./(300+x);
y3 = 500./(500+x);
y4 = 1000./(1000+x);
y5 = 2000./(2000+x);
y6 = 5000./(5000+x);
y7 = (1+5.*log(x))./x;
plot(x,y1);
hold on
plot(x,y2);
plot(x,y3);
plot(x,y4);
plot(x,y5);
plot(x,y6);
plot(x,y7);
legend('100/(100+k)','300/(300+k)','500/(500+k)','1000/(1000+k)','2000/(2000+k)','5000/(5000+k)','(1+5log(x))./x');
title('The comparation of each function');
xlabel('Number of time step');
ylabel('Probability');
set(gca,'Fontsize',18);



%         exploration_probalility = 1/k;
%         learning_rate = 1/k;
%         exploration_probalility = 100/(100+k);
%         learning_rate = 100/(100+k);
%         exploration_probalility = (1+log(k))/k;
%         learning_rate = (1+log(k))/k;
%         exploration_probalility = (1+5*log(k))/k;
%         learning_rate = (1+5*log(k))/k;     


