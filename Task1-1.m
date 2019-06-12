tic;
%% INPUT
clc;
close all;
load('task1.mat');
%% 
Q = zeros(100,4,3001); %initialize Q-function 
discount_rate = 0.9;
for k = 1:3000 %number of iterations
    i = 1; %initial state S0
%     exploration_probalility = 1/k;
%     learning_rate = 1/k;
    exploration_probalility = 100/(100+k);
    learning_rate = 100/(100+k);
%     exploration_probalility = (1+log(k))/k;
%     learning_rate = (1+log(k))/k;
%     exploration_probalility = (1+5*log(k))/k;
%     learning_rate = (1+5*log(k))/k;
    while i<100
    judgement = rand(1);
    [m,index] = max(reward(i,:)); %value and position of currently known best action
    proper_action = [1,2,3,4];
    if judgement >= exploration_probalility %exploitation
        action = index;
    else %exploration
        [m,boundary] = find(reward(i,:)==-1);
        eliminate = [index,boundary];
        proper_action(eliminate) = [];
        action = proper_action(floor(rand(1)*length(proper_action))+1);
    end
%     if k==1&&i==99
%         action = 3;
%     elseif k==1&&i==90    
%         action = 2;
%     end
    %% take action
    if action == 1
        next_i = i-1;
    elseif action == 2
        next_i = i+10;
    elseif action == 3
        next_i = i+1;
    else
        next_i = i-10;
    end
    Q(i,action,k) = Q(i,action,k)+ learning_rate*(reward(i,action)+discount_rate*max(Q(next_i,:,k))-Q(i,action,k)); % Update Q-function
    i = next_i;
    end
    %% stop the iteration
    if learning_rate<0.005
        break
    end
    if k>1
        if max(Q(:,:,k)-Q(:,:,k-1))<0.001
        break
        end
    end
     Q(:,:,k+1) =  Q(:,:,k);
end
result = Q(:,:,k);
save('result_1.mat','result');
toc;


