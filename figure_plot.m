clc;
close all; 
load('result_1.mat');
plot(0,0);
hold on;
grid on;
set(gca,'Xtick',1:1:10);
set(gca,'Ytick',1:1:10);
axis([0,10,0,10]);

i = 1;
while i<100
    [m,index] = max(result(i,:)); %value and position of currently known best action
    action = index;
    %% take action
    if action == 1
        plot(floor(i/10)+0.5,10.5-rem(i,10), 'b^');
        next_i = i-1;
    elseif action == 2
        plot(floor(i/10)+0.5,10.5-rem(i,10), 'b>');
        next_i = i+10;
    elseif action == 3
        plot(floor(i/10)+0.5,10.5-rem(i,10), 'bv');
        next_i = i+1;
    else
        plot(floor(i/10)+0.5,10.5-rem(i,10), 'b<');
        next_i = i-10;
    end
    i = next_i;
end
title('The navigation of 100/(100+k) learning rate 0.9 ');
set(gca,'Fontsize',18);
saveas(gcf,'The navigation 2 0.9.jpg');