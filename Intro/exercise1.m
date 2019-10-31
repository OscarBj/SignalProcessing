% SIGBE/17/1 - Oscar Björkgren
	% A
fs=8000 % samplings frekvens
ts=1/fs % samplings intervall
tf=2 % tid
tt=0:ts:2; % vektorn från 0 till tiden 2
f=440 % frekvens
phi = 0; % phi

x=cos(2*pi*f*tt+phi);

soundsc(x,fs)

figure,plot(tt(1:200),x(1;200))

%--------------------------------------------%
	% B
fs=8000
Ts=1/fs
f=440

y0 = cos(2*pi*f*Ts*0); % y(0) första rekursion
y1 = cos(2*pi*f*Ts*1); % y(1) andra rekursion

omega = 2*pi*f*Ts
A = [1 -2*cos(omega) 1] % värden framför y, berättar åt filtret hur serien fortsätter
B = 1 % amplitud
XX = [y0 y1 zeros(1,15990)]; % serien fortsätter rekursivt

YY = filter(B,A,XX);

figure,plot([0:200]*Ts,YY(1:201))

%--------------------------------------------%
	% C
f = 110; % frekvens 1
fm = 220; % modulerade frekvens 1
A0 = 1 
I0 = 10;
%
f = 220 % frekvens 1
fm = 440; % modulerade frekvens 2
A0 = 1; 
I0 = 5; 

tau = 2;
fs = 11025; %samplings frekvens
t = 6.0; % tid
ts = 1/fs % samplings intervall
T = [0:ts:t-ts];

%euler
e = exp(-T/tau);

A = A0*e;
I = I0*e;

xx = A.*cos(2*pi*f*T+I.*cos(2*pi*fm*T)); % .* matris multiplikation

%--------------------------------------------%
	% D
%1
F0 = 200;
F1 = 500;
fs = 8000;
t = 3;
ts = 1/fs;
tt = 0:ts:t;
A = 1;
x = A.*cos(2*pi.*(F0+F1.*tt).*tt);
soundsc(x,fs);
%2
F0 = 200;
F1 = 15200;
fs = 8000;
t = 3;
ts = 1/fs;
tt = 0:ts:t;
A = 1;
x = A.*cos(2*pi.*(F0+F1.*tt).*tt);
soundsc(x,fs);

%--------------------------------------------%
	% E 
F0 = 100;
F1 = 5000;
fs = 8000;
t = 0.04;
ts = 1/fs;
tt = 0:ts:t;
A = 1;
x = A.*cos(2*pi.*(F0+F1.*tt).*tt);

xt = cos(2*pi*300*tt);

plot(tt,x);
hold,plot(tt,xt,'r--');
% vid t = 0.02 är frekvenserna samma
