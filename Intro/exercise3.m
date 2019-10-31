% SIGBE/17/3 - Oscar BjÃ¶rkgren
	% i
clear all;
close all;

Fs=11025
ws0 = 2*pi*Fs;
y = load('signal2.dat');
Y = fft(y);
Y_abs = abs(Y);
N = length(y); % längden av signalen
k = [1:N]; % vektor av samma längd som signalen
n = (k./N).*Fs; % vektorn normaliserad till Hz, k = (N/2)-1

figure,plot(n(1:((N/2)-1)),Y_abs(1:((N/2)-1)));
f0 = 0;
for i = 1:N
  if(Y_abs(i) < 0.00069272) % Liten tolerans
    f0 = n(i);
    break
   endif
endfor

wmax = 2*pi*f0;
disp('max < ws0/8:')
if(wmax < ws0/8)
  disp('true')
else 
  disp('false')
endif
%--------------------------------------------%
	% ii
clear all;
close all;
% normal
Fs0=11025;
Ts0=1/Fs0;
% reducerad
Fs=Fs0/4;
Ts=1/Fs;

x0 = load('signal2.dat');
X0 = fft(x0);
X0_abs = abs(X0);

N = length(x0);
x = [];

for i=1:4:N
  x = [x x0(i)];  
endfor

X = fft(x);
X_abs = abs(X);
figure,plot(abs(X));
title('FFT av X(k)');
figure,plot(X0_abs);
title('FFT av X0(k)');

soundsc(x0,Fs0);
soundsc(x,Fs);

% Kollar ifall X0=Ts/Ts0*X i intervallet w < w0/8
for i=1:(length(X)/2)
  if (X0_abs(i)-((Ts/Ts0)*X_abs(i))>0.0001) % Liten tolerans
    disp('False');
   endif
endfor
%--------------------------------------------%
	% iii
clear all;
close all;

y = load('signal2.dat');

% nersampling av signalen
x = y(1:4:length(y));
X = fft(x);
X0 = zeros((4*length(X)),1);
% Beraknar fourier transformen for x0 
for i = 1:length(X0)
    if i <= (length(X)/2)
      X0(i) = (4*X(i));
    elseif i > (length(X0)-(length(X)/2))
      ii = i-(length(X0)-length(X));
      X0(i) = (4*X(ii));
    end
endfor

Fs0 = 11025;    
Fs = Fs0/4;
Ts = 1/Fs0;
t = 0:Ts:(size(y,1)*Ts-Ts);
x0 = ifft(X0);
figure,plot(t,y);
title("Ursprunglig signal");
figure,plot(t,x0);
title("Rekonstruerad signal");
