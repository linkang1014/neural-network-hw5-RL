tic;
%% INPUT
clc;
close all;
load('qeval.mat');
% load('task1.mat');
%% 
Q = zeros(100,4,3001); %initialize Q-function 
discount_rate = 0.90;
for i = 1:3000 %number of iterations
    n = 1; %initial state S0
    k = 1; %initial step k
    while n<100
        exploration_probalility = 2000/(2000+k);
        learning_rate = 2000/(2000+k);
        judgement = rand(1);
        [m,index] = max(qevalreward(n,:)); 
%         [m,index] = max(reward(n,:)); %value and position of currently known best action
        proper_action = [1,2,3,4];
        if judgement >= exploration_probalility %exploitation
            action = index;
        else %exploration
            [m,boundary] = find(qevalreward(n,:)==-1);
%             [m,boundary] = find(reward(n,:)==-1);
            eliminate = [index,boundary];
            proper_action(eliminate) = [];
            action = proper_action(floor(rand(1)*length(proper_action))+1);
        end
       %% take action
        if action == 1
            next_i = n-1;
        elseif action == 2
            next_i = n+10;
        elseif action == 3
            next_i = n+1;
        else
            next_i = n-10;
        end
        Q(n,action,i) = Q(n,action,i)+ learning_rate*(qevalreward(n,action)+discount_rate*max(Q(next_i,:,i))-Q(n,action,i));
%         Q(n,action,i) = Q(n,action,i)+ learning_rate*(reward(n,action)+discount_rate*max(Q(next_i,:,i))-Q(n,action,i)); % Update Q-function
        n = next_i;        
        k = k+1;
        if learning_rate<0.005
            break
        end
    end
    %% stop the iteration
    if i>1
        if max(Q(:,:,i)-Q(:,:,i-1))<1
            break
        end
    end
    Q(:,:,i+1) =  Q(:,:,i);
end
result = Q(:,:,i);
toc;

plot(0,0);
hold on;
grid on;
set(gca,'Xtick',1:1:10);
set(gca,'Ytick',1:1:10);
axis([0,10,0,10]);
n = 1;
k = 1;
qevalstates(1) = 1;
total_reward = 0;
while n<100
    [m,index] = max(result(n,:)); %value and position of currently known best action
    action = index;
    total_reward = total_reward+m;
    %% take action
    if action == 1
        plot(floor(n/10)+0.5,10.5-rem(n,10), 'b^');
        next_i = n-1;
    elseif action == 2
        plot(floor(n/10)+0.5,10.5-rem(n,10), 'b>');
        next_i = n+10;
    elseif action == 3
        plot(floor(n/10)+0.5,10.5-rem(n,10), 'bv');
        next_i = n+1;
    else
        plot(floor(n/10)+0.5,10.5-rem(n,10), 'b<');
        next_i = n-10;
    end
    n = next_i;
    k = k+1;
    qevalstates(k) = n;
    if k>20
        break
    end
end
qevalstates
discription=sprintf('Total reward = %d',total_reward);
title(discription);
set(gca,'Fontsize',18);



