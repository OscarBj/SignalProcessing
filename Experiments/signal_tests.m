close all;
clear all;

Xs = 8000; % sample freq
Ts = 1/Xs; % sample interval
t = 2; % seconds
X = 0:Ts:t;
f = 440;
% array from 0 to 1000, sample interval 1
%x = (-1000:1:1000);
%x = x';
%y = x.^3+2*x.^2+17.*x+60;
%y_sin = sin(y);
%soundsc(y_sin);
%plot(abs(fft(y_sin)));
% calculate freq with help of formula in pdf

x=cos(2*pi*f*X);
figure
plot((1:500)*Ts,x(1:500));
figure
plot(abs(fft(x)));
xft = abs(fft(x));

figure
plot(xft(xft>100)) % plot peaks (amplitude)
% TODO, retreive the original signal -> 440Hz, formula for fft to Hz:
% n*fs/N




