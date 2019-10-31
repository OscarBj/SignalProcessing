close all;
clear all;

[y,Fs] = audioread("tap.m4a");
Ts = 1/Fs; % Sample interval

noise = y(1:30000);
ts_noise = (1:30000)*Ts;

signal = [zeros(1,59012),y(30000:100000)']';
ts_signal = (30000:100000)*Ts;

signal_short = y(4000:6000)';
tss = (0:Ts:2000/Fs);
%t = (0:1/Fs:1-1/Fs)';

test_signal = sin(2*pi*60*tss)+sin(2*pi*600*tss)+sin(2*pi*1024*tss);

test_signal2 = sin(2*pi*600*tss)+sin(2*pi*440*tss)+sin(2*pi*10*tss);

%figure
%plot(abs(fft(y)));
%xlabel("measurement fft");
%figure
%signal_ft = abs(fft(signal));
%plot(signal_ft);
%xlabel("tap fft");
%tt = 0:Ts:2.2;
%test_x = cos(2*pi*1510*tt)+cos(2*pi*4249*tt)+cos(2*pi*5501*tt);
%[P1,f1] = periodogram(test_x,[],[],Fs,'power');
%figure
%plot(f1,P1,'k')

%[Cxy,f] = mscohere(signal,y,[],[],[],Fs);
%[Cxy,f] = mscohere(signal_short,test_signal,[],[],[],Fs);
[Cxy, f] = cpsd(test_signal2,test_signal,[],[],[],Fs);
%[pks,locs] = findpeaks(Cxy,'MinPeakHeight',0.80);

figure
plot(f,Cxy)
%title('Coherence Estimate')
grid on
%hgca = gca; % coherence estimate properties
%hgca.XTick = f(locs);
%hgca.YTick = 0.80;
% Frequencies that correlate 0.8 or more:
% 1) 1510
% 2) 4249
% 3) 5501