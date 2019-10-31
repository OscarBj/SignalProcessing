from scipy import signal, io, fftpack
import numpy as np
import matplotlib.pyplot as plt
import math


def matchFrequencies(signal, fs, freqs, treshold=-1):
	ft = fftpack.fft(signal)
	l = len(signal)
	x = np.abs(ft)

	m = []
	
	max = np.argpartition(x[0:math.floor(l/2)], -3)[-3:]
	
	if (treshold!=-1): 
		th = treshold
	else: 
		th = x[max[-1]]/4
	#print(th)
	for f in freqs:
		n = math.floor(f*l/fs)
		xn1 = x[n+1]
		xn2 = x[n+2]
		xn_1 = x[n-1]
		xn_2 = x[n-2]
		print(xn1)
		print(xn2)
		print(xn_1)
		print(xn_2)
		if(x[n]>th):
			# map frequency to amplitude
			m.append([f,x[n]])
			print(n)
			#print("Matched component: "+str(f)+" with "+str((x[n]/th*4)*10)+"% of max amplitude/power ("+str(th*4)+")")
	plt.plot(x)
	plt.show()	
	return m

	
def getTopNfrequencies(fs,signal,N):
	ft = fftpack.fft(signal)
	N = -1*N
	l = len(signal)
	x = np.abs(ft)
	
	m = []
	for i in np.argpartition(x[0:math.floor(l/2)], N)[N:]:
		 m.append(i*fs/l)
		 print("sample: "+str(i)+ " amp: "+str(x[i]))
	plt.plot(x)
	plt.show()
	return m
	
def getSine(Fs,frq,l):
	ts = 1/Fs
	t = l/Fs
	x = np.arange(0,t,ts)
	y = np.sin(2*np.pi*frq*x)
	return y
	
def main():
	fs = 16000
	inp = io.loadmat("inp.mat")
	ref = io.loadmat("ref.mat")
	s1 = inp['y'].flatten()
	s2 = ref['signal'].flatten()
	
	ss = getSine(fs,440,1000)+ getSine(fs,56,1000)
	print(getTopNfrequencies(fs,s1,5))
	#print(getTopNfrequencies(fs,s2,5))
	print(str(matchFrequencies(s1,fs,[5880,5602])))
	#method 1) ref signal -> fft -> avg fft -> compare to input
	#method 2) delta freq -> fft of signal, match for frequencies within delta
main()
	