function a = matchSignals(Fs,inpSig,refSig,coh)

[Cxy,f] = mscohere(inpSig,refSig,[],[],[],Fs);
[pks,locs] = findpeaks(Cxy,'MinPeakHeight',coh);

a = f(locs);
