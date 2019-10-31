from scipy import signal, io
import numpy as np
import matplotlib.pyplot as plt
import math

def performCSD(fs,inpSig,refSig, minCoh, seg):
	f, Cxy = signal.csd(inpSig, refSig, fs, nperseg=seg, noverlap=seg/2, nfft=seg)
	plt.plot(f,Cxy)
	plt.show()

def matchFrequencies(fs, inpSig, comps, minCoh, seg):
	generated_signal = 0
	l = len(inpSig)
	for comp in comps:
		generated_signal += getSine(fs,comp[1],comp[0], l)
		#print(comp[1])
	
	#f, Cxy = signal.coherence(inpSig, generated_signal, fs, nperseg=seg, noverlap=seg/2,nfft=seg)#,noverlap=math.floor(seg/2))
	f, Cxy = signal.csd(inpSig, generated_signal, fs, nperseg=seg, noverlap=seg/2, nfft=seg)
	
	#pks, prop = signal.find_peaks(np.nan_to_num(np.abs(Cxy)), height=minCoh)
	frq = []
	
	#for i in pks:
	#	frq.append(f[i])
	#	print(f[i])
	#print(str(len(frq)))
	
	plt.plot(f,Cxy)
	plt.show()
	#print(str(np.abs(Cxy)))	
	#plt.plot(pks, f[pks], "x")
	#plt.show()
	#return frq
	return len(frq)>0

def matchSignals(fs, inpSig, refSig, minCoh, seg):	
	f, Cxy = signal.coherence(inpSig, refSig, fs, nperseg=seg, noverlap=seg/2,nfft=seg)#,noverlap=math.floor(seg/2))
	#f, Cxy = signal.csd(inpSig, refSig, fs, nperseg=seg)
	#plt.plot(Cxy)
	#plt.plot(f)
	#plt.show()
	#plt.plot(np.nan_to_num(f.flatten()),np.nan_to_num(Cxy.flatten()))
	#plt.semilogy(f,Cxy)
	#plt.show()
	#print(len(Cxy.flatten()))
	#print(len(f.flatten()))
	pks, prop = signal.find_peaks(np.nan_to_num(np.abs(Cxy)), height=minCoh)
	frq = []
	#print(pks)
	#print(np.nan_to_num(Cxy.flatten()[0]))
	for i in pks:
		frq.append(f[i])
		print(f[i])
	print(str(len(frq)))

	#print(str(np.abs(Cxy)))	
	#plt.plot(pks, f[pks], "x")
	#plt.show()
	#return frq
	return len(frq)>0
	
def getSine(Fs,frq,A,l):
	ts = 1/Fs
	t = l/Fs
	x = np.arange(0,t,ts)
	y = A*np.sin(2*np.pi*frq*x)
	#plt.plot(x,y)
	#plt.show()
	return y
	
	
def matchFrequencies_tester():
	fs = 16000
	c=0.9
	ref = io.loadmat("ref.mat")
	ref = ref['signal']
	ref = ref[69000:71000]
	
	inp = io.loadmat("inp.mat")
	inp = inp['y']
	inp_noise = inp[5000:7000]
	inp_sig = inp[69000:71000]
	seg = math.floor(len(inp_sig)/2)
	ss = getSine(fs,440,100,1000)
	#component1 = getSine(16000,440,200)
	components = [
				[400,6040],
				[200,440]
				]
	#matchFrequencies(fs, inpSig, frqs, minCoh, seg):
	
	#plt.plot(component1*2)
	#plt.plot()
	#plt.show()
	#print("Matches with signal similarity "+str(c)+": "+str(matchFrequencies(fs, inp.flatten(), components, c, seg)))
	#print("Matches with signal similarity "+str(c)+": "+str(matchFrequencies(fs, ss, components, c, seg)))
	performCSD(fs,inp_sig.flatten(), inp_noise.flatten(), c, seg)

def matchSignals_tester():
	fs = 16000
	#c = 1e-8*6
	c=0.9
	inp = io.loadmat("inp.mat")
	inp = inp['y']
	#plt.plot(inp)
	ref = io.loadmat("ref.mat")
	ref = ref['signal']
	# len = 129013
	gs2 = 0
	for i in range(600,800):
		gs2+=getSine(fs,i,1,129013)
	
	#ft_test = fftpack.fft(gs2)
	#ft_test = np.abs(ft_test)
	#ft_test = ft_test[:1000]

	#ref = getSine(fs,40, 129013)
	#ref = ref[30000:]
	seg = math.floor(len(inp)/2)
	#print(str(seg))
	#plt.plot(ref)
	#plt.show()
	
	#s1 = getSine(fs,440,4000)+ getSine(fs,800,4000)
	#s2 = getSine(fs,40,4000)+ getSine(fs,800,4000)
	#print(str(len(s2))) 16000
	#s2 = s2[4000:8000]
	#zz = np.zeros(8000)
	#np.concatenate(s2,zz)
	#print(str(lens2))
	#seg = math.floor(len(s2)/8)
	#seg = 1000
	#seg=2
	#print(matchSignals(fs,inp['y'].flatten(),ref['signal'].flatten(),c))
	#plt.show()
	#print("Matches with signal similarity "+str(c)+": "+str(matchSignals(fs,s1,s2,c,seg)))
	print("Matches with signal similarity "+str(c)+": "+str(matchSignals(fs,inp.flatten(),ref.flatten(),c,seg)))
	#print("Matches with signal similarity "+str(c)+": "+str(matchSignals(fs,gs2,ref.flatten(),c,seg)))
	
#matchSignals_tester()
matchFrequencies_tester()
