X = importdata('q2x.dat');
m = size(X,1);
X = [ones(m,1) X]';


Y = importdata('q2y.dat');
theta = [0;0;0];

for k = 1:1000
%creating Hessian Matrix
H = 0;
for i = 1:m
    %calculate htheta(x)
    temp = 1 / (1 + exp( -1 *  (theta' * X(:,i))));
    Htemp = X(:,i) * X(:,i)' ;
    H = H + (temp ) * (1 - temp) * Htemp;  
end

H = -1 * H;
%calculating first order derivative
dofjtheta = 0;
for i = 1:m
    %calculate htheta(x)
    temp = 1 / (1 + exp( -1 *  (theta' * X(:,i))));
    dofjtheta = dofjtheta  + (Y(i) - temp) * X(:,i);
end

theta = theta - inv(H) * dofjtheta;
end

%equation of decision boundary is theta'X = 0 

a=40;
figure
xA=0;
xC=0;
countA=1;
countC=1;
for i =1:m
    if Y(i,1) == 0
        %scatter(X(2,i),X(3,i),a, 'MarkerEdgeColor',[0 .5 .5],...
        %'MarkerFaceColor',[0 .7 .7],...
        %'LineWidth',1.5);
        xA(countA,1)=X(2,i);
        xA(countA,2)=X(3,i);
        countA = countA + 1;
    else
        %scatter(X(2,i),X(3,i),a, 'MarkerEdgeColor',[0 .1 .1],...
        %'MarkerFaceColor',[0 .2 .2],...
        %'LineWidth',1.5);
        xC(countC,1)=X(2,i);
        xC(countC,2)=X(3,i);
        countC = countC + 1;
     
    end
    hold on;
end
plot(xA(:,1), xA(:,2),'r+',xC(:,1), xC(:,2),'bo');
xlabel('X0')
ylabel('X1')
title('Logistic Regression') 
legend('Y=0','y=1')
hold on;
Y =  - (theta(2) * X(2,:))/theta(3) - theta(1)/theta(3);
plot(X(2,:),Y);
hold off;

