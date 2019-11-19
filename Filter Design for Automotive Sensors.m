clc
close all
clear all

Fs = 400;
fp=50;
fs=75;
Wp= 2*pi*fp
Ws= 2*pi*fs
Rp= 3
Rs= 25
wp= Wp/Fs/2
ws= Ws/Fs/2

% Analog Maximally Flat 3 dB ripple filter

[n,Ws] = buttord(Wp,Ws,Rp,Rs,'s')
[b,a] = butter(n,Ws,'s');
[h,w]=freqs(b,a)

%element Values un-normalized for butterworth filter
C1= 0.3902/(2*pi*1000*50)
L2= (50*1.111)/(2*pi*1000)
C3= 1.6629/(2*pi*1000*50)
L4= (50*1.9615)/(2*pi*1000)
C5= 1.9615/(2*pi*1000*50)
L6= (50*1.6629)/(2*pi*1000)
C7= 1.111/(2*pi*1000*50)
L8= (50*0.3902)/(2*pi*1000)

%covert to DSP implementation by bilinear transformation
[num , dend]=bilinear(b,a,Fs,fp)
[h1,w1]=freqz(num,dend,512,Fs)

%Digital FIR filter by windowing
fcuts = [wp ws]*pi;
mags = [1 0];
devs = [0.1 0.01];

[nk,Wnk,beta,ftype] = kaiserord(fcuts,mags,devs,2*pi);

bd = fir1(nk+2,Wnk,bartlett(nk+3));
[hd,wd]=freqz(bd,1,Fs)


%plots of magnitude response

figure;
plot(w/(2*pi),mag2db(abs(h)));
grid on;
axis([0, 100,-30,20]);
xlabel('Freq(kHz)');
ylabel('Mag(dB)');
title('Analog LPF')

figure;
plot(w1,mag2db(abs(h1)));
grid on;
axis([0, 100,-30,20]);
xlabel('Freq(kHz)');
ylabel('Mag(dB)');
title('Digital Implementation by transformation')

figure;
plot(wd*Fs/10,mag2db(abs(hd)));
grid on;
axis([0, 100,-30,20]);
xlabel('Freq(kHz)');
ylabel('Mag(dB)');
title('Digital FIR filter by windowing')

