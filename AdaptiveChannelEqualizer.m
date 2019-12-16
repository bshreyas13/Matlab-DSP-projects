%% Starter code to generate the constellation and corrupt with ISI

% Rectanglular signal constellation
clear all; 
close all
d=1; %distance between points just pick as 1

%Create constellation
constellation=[-d d; d d; -d -d; d -d];

% figure;
% plot(constellation(:,1), constellation(:,2), 'go')  %just to check constellation
N=10000;  %number of random signals; map to integers 1:4
sent_symbol=(1+floor(4*rand(N,1)));

%map sent symbol 1:4 to constellation
for i=1:N
    sent(i,:)=constellation(sent_symbol(i),:); % assign to constellation
end

%add ISI using filter command:  filter(b,a,signal)
%for FIR filter, b=ISI elements and a=1
a=1;
ISI=[1,0,0]; %check results for an ISI free channel; should get error=0
ISI=[1, 0.75, 0.5]; %ISI vector
received=filter(ISI,a, sent);
Power_received=mean(received(:,1).^2+received(:,2).^2);
% hold on  %plot to confirm received signal

% figure;
% plot(received(:,1), received(:,2), 'rx') 

%count errors; could have also compared matrix values
error=0; 
for i=1:N
    if sign(sent(i,1)) ~= sign(received(i,1)) || sign(sent(i,2)) ~= sign(received(i,2))
        error=error+1;
    end
end



%% LMS IMPLEMENTATION

r1=received(:,1); 
s1=sent(:,1);
r2=received(:,2) 

mu = 0.005;                     % STEP SIZE
K = length(constellation)+12;   % LENGTH OF THE FILTER
f = zeros(K,1);

% ADAPTIVE FILTER FROM CHANNEL
index = 1; 
[e,x_hat]=deal(zeros(N-K+1,1));
k=0.1*N                           % TRAINING SAMPLE SIZE

for n = K:k
% SELECT PART OF THE TRAINING INPUT
in = r1(n:-1:n-K+1);
% APPLY CHANNEL ESTIMATE TO TRAINING DATA 
x_hat(index) = f'*in;
% COMPUTE ERROR
e = s1(n)-x_hat(index);
% UPDATE TAPS
f=f+mu*conj(e)*in;    
index = index + 1 
end

%% APPLY FILTER TO RECEIVED SIGNAL
Adaptive_Equalizer = f
y1= conv(Adaptive_Equalizer,r1)
y2= conv(Adaptive_Equalizer,r2)

y=[y1 y2]

% CALCULATE BIT ERROR
y_error=0; 
for i=1:N
    if sign(sent(i,1)) ~= sign(y(i,1)) || sign(sent(i,2)) ~= sign(y(i,2))
        y_error=y_error+1;
    end
end
ber=error/N     %BIT ERROR OF SIGNAL WITH ISI
y_ber=y_error/N %BIT ERROR OF SIGNAL AFTER FILTERING

%% PLOTS

figure;
plot(sent(:,1), sent(:,2),'go');
title('Input Signal'),
ylim([-2.5 2.5]);
xlim([-2.5 2.5]);
grid;
hold on

plot(received(:,1), received(:,2),'rx');
title('Input Signal(GREEN Os) with Noise marked(RED Xs'),grid;


figure;
plot(y(:,1), y(:,2),'bo');
grid;
title('Adaptive Equalized output');
ylim([-2.5 2.5]);
xlim([-2.5 2.5]);


