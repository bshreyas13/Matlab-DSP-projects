clc
close all
clear all

%read audio
[y,Fs]= audioread ('C:\Users\shrey\OneDrive\Documents\DSP\Project 1\testm.wav');
y1 = 0.03*y ; 
t=(0:length(y)-1)*(1/Fs);
 

figure;
subplot(3,1,1)
stem(t,y,'Marker','none');
axis([0,12, -1, 1]);
xlabel('Time(sec)');
ylabel('Amplitude');
title('Anechoic Chamber audio');


%impulse reponse
nvalues = 0:200;
Ufs = 44;
nup= 0:((Ufs*length(nvalues))-1);
yvalues = x(nvalues);
y_upsample= interp(yvalues,Ufs); % alternatively 'resample' maybe used 


%covolution of IR and audio file
convol = conv(y_upsample, y1);
C2 = convol / max(abs(convol));
%soundsc (convol, Fs);
filename = 'C:\Users\shrey\OneDrive\Documents\DSP\Project 1\testo.wav';
audiowrite (filename,C2,Fs);
n3= -200:length(convol)-1-200; %vector length adjustment
t1=(0:length(n3)-1)*(1/Fs);        


subplot(3,1,2)
stem(nup,y_upsample,'red','Marker','none');
xlabel('Time(millisec)');
axis([0,10000, 0, 1]);
ylabel('Amplitude');
title('Impulse Response of Hall');

subplot(3,1,3)
stem(t1,convol,'black','Marker','none');
axis([0,12, -1, 1]);
xlabel('Time(sec)');
ylabel('Amplitude');
title('Treated Audio');




function y = x(n) %The function for IR
    % Setting all outputs to 0
    y = zeros(size(n));

    % Replacing the values  as per problem definition
    y(n==20) = 10^(-18/20);
    y(n==24) = 10^(-19.5/20);
    y(n==25) = 10^(-6/20);
    y(n>=26 & n <=27 ) = 10^(-9.5/20);
    y(n==28) = 10^(-14/20);
    y(n==29) = 10^(-8.5/20);
    y(n==30) = 10^(-10.5/20);
    y(n==31) = 10^(-8/20);
    y(n==32) = 10^(-10/20);
    y(n==33) = 10^(-10/20);
    y(n==34) = 10^(-15.75/20);
    y(n==35) = 10^(-8/20);
    y(n==36) = 10^(-16/20);
    y(n==37) = 10^(-19/20);
    y(n==38) = 10^(-19/20);
    y(n==39) = 10^(-16.75/20);
    y(n==40) = 10^(-18/20);
    y(n==41) = 10^(-12.25/20);
    y(n==42) = 10^(-13/20);
    y(n>=43 & n <=44 ) = 10^(-3.75/20);
    y(n==45) = 10^(-7.65/20);
    y(n==46) = 10^(-9.5/20);
    y(n==47) = 10^(-9.5/20);
    y(n==48) = 10^(-9.5/20);
    y(n==49) = 10^(-9.5/20);
    y(n==50) = 10^(-8.8/20);
    y(n==51) = 10^(-11/20);
    y(n==52) = 10^(-12.5/20);
    y(n==53 ) = 10^(-15.75/20);
    y(n==54) = 10^(-13/20);
    y(n==55) = 10^(-13/20);
    y(n==56) = 10^(-15/20);
    y(n==57) = 10^(-16/20);
    y(n==58) = 10^(-14/20);
    y(n==59) = 10^(-13/20);
    y(n==60) = 10^(-9/20);
    y(n==61) = 10^(-13/20);
    y(n==62) = 10^(-13/20);
    y(n==63) = 10^(-13/20);
    y(n==64) = 10^(-13/20);
    y(n==65) = 10^(-19/20);
    y(n>=66 & n <=67 ) = 10^(-18.25/20);
    y(n>=68 & n <=69 ) = 10^(-17/20);
    y(n>=72 & n <=73 ) = 10^(-19/20);
    y(n>=73 & n <=75 ) = 10^(-19.25/20);
    y(n==78) = 10^(-19/20);
    y(n==79) = 10^(-15/20);
    y(n==80) = 10^(-16.75/20);
    y(n==83) = 10^(-17/20);
    y(n==85) = 10^(-18.5/20);
    y(n==91) = 10^(-19/20);
    y(n==92) = 10^(-12/20);
    y(n>=95 & n <=96 ) = 10^(-18.5/20);
    y(n==97) = 10^(-18/20);
    y(n==98) = 10^(-17.75/20);
    y(n==102) = 10^(-18.75/20);
    y(n==103) = 10^(-18/20);
    y(n>=104 & n <=105 ) = 10^(-15/20);
    y(n==106) = 10^(-17.85/20);
    y(n==121) = 10^(-17.5/20);
    y(n==122) = 10^(-19/20);
    y(n==124) = 10^(-18/20);
    y(n==125) = 10^(-18.5/20);
    y(n==127) = 10^(-16/20);
    y(n==130) = 10^(-18.75/20);
    y(n==131) = 10^(-17.75/20);
    y(n==140) = 10^(-19/20);
    y(n==155) = 10^(-20/20);
    y(n==165) = 10^(-19/20);
    y(n==185) = 10^(-17.75/20);
    
end

