% SIGBE/17/3 - Oscar BjÃ¶rkgren
	% i
clear all;
close all;

y = load('signal3.dat');
Fs = 11025;
soundsc(y,Fs);

N = length(y);

B = 1/N;
A = 1;

ymedel = filter(B,A,y);
figure,plot(abs(fft(ymedel)));
title('FFT av filtrerad');
figure,plot(abs(fft(y)));
title('FFT av ofiltrerad');
%Frekvenssvaret av medeltalsfiltret
figure,freqz(y);
% Enligt figurerna filtreras bruset inte bort m.h.a.
% medeltalsfiltret

% Lowpass FIR filter m.h.a. Kaiser fonsterfunktion, beta=4.54
fcuts = [2500 2750];
mags = [1 0];
devs = [0.003 0.1];
disp('Filtrets koefficienter:'); %obs beta valjs till filtret enligt passbandsavvikelsen
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,Fs)
B = fir1(n,Wn,ftype,kaiser(n+1,4.54)); % 0.0274dB avvikelse, 50dB damp i cutband
%Filtrets frekvenssvar
figure, freqz(B,1,[],Fs);

%--------------------------------------------%
	% ii
	
yfir = filter(B,1,y);
figure,plot(abs(fft(yfir)));
title('FFT av FIR filtrerad signal');
soundsc(yfir,Fs); % hogfrekventa bruset har filtrerats bort

Ts = 1/Fs;
t = [1001:Ts:1100];
L = round((N-1)/2); % Tidsfordrojning
yfir_ = yfir(1001:1100);
y_ = y(1001+L:1100+L); % Fordrjojer ursprungs signalen lika mycket som filtrerade
figure,plot(yfir_),hold on,plot(y_); 

%--------------------------------------------%
	% B
close all;
clear all;

x = load('x.dat');
Fs = 8192;

soundsc(x,Fs); 
figure,plot(x);
title('Ofiltrerad signal');
figure,plot(abs(fft(x)));

% storsta delen av bruset koncentrerat vid elementen 5801-5804
N = length(x);
fnotch = 5802/N;
fb = 10/Fs; % sparrbandets bredd
r = 1-fb*pi; % approximering av r då sparrbandet ar 3dB

% Overforingsfunktionen for notch filtret:
% koefficienter for taljaren
B = [1 -2*cos(2*pi*fnotch) 1];

% koefficienter for namnaren
A = [1 -2*r*cos(2*pi*fnotch) r^2];

y = filter(B,A,x);
figure,plot(y);
title('Filtrerad signaln');
figure,plot(abs(fft(y)));
soundsc(y,Fs);
% Figuren och uppspelningen tyder pa att den storande tonen har
% for det mesta filtrerats bort ur signalen.
