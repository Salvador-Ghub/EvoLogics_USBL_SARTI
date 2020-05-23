# -*- coding: utf-8 -*-
"""
Created on Fri May 22 20:56:35 2020
Signal generator
@author: Salvador
Python version: 3.7
Using Spyder(Python 3.7) from Anaconda 
"""
import numpy as np
import math 
import matplotlib.pyplot as plt
#import matplotlib.dates as mdate

freq=18 #sampling frequence in kHz
freqSignal=1 #sinus frequence in kHz
tsilence0=0.100 #duration of 0s in seconds
tsilence1=0.150 #duration of 1s in seconds

fs=freq*1000
samplerSilence0=tsilence0/(1/(fs))
samplerSilence1 =tsilence1/(1/(fs))

#time vector
Ts = 1/fs
t=np.arange(0,1-Ts,Ts)


#signal amplitude
a1=1

#function form
f1=2*math.pi*freqSignal*1000

#theta
theta1=0

#string to be coded
cadena='Gel'

#string to binary
binary=''.join(format(i, 'b') for i in bytearray(cadena, encoding ='utf-8'))
binary='1'+binary+'1'
binary=list(binary)
#silence1=np.zeros(len(binary))
silence1=[]
s=0
sAnt=s
c=1

#bucle generador de los silencios a tiempos configurados
while not not binary:
    if (c==0):
        if (binary[0]==0):
            samplerSilence=samplerSilence0
        else:
            samplerSilence=samplerSilence1
    else:
        samplerSilence=samplerSilence0
        
    if (sAnt+samplerSilence<s):
        sAnt=s;
        if (c==0):
            c=1;
        else:
            c=0
            del binary[0]
            
    silence1=np.append(silence1,c)
    s=s+1
    if len(t)<s:
        t=np.append(t,t[len(t)-1]+Ts)
        
#Aplicamos función por el vector tiempo y por el vector silencio
f1vector=f1*t
signal=[]
for pointer in f1vector:
    signal=np.append(signal,a1*math.sin(pointer+theta1))
    
signal1=[]
i=0
for pointer in f1vector:
    signal1=np.append(signal1,a1*math.sin(pointer*silence1[i]+theta1))
    i+=1


#plot generator  
#Para ampliar modificar imagen (Herramientas>Preferencias>Terminal de |Python>Gráficas>Salida gráfica>Automático)
plt.close()							#cerrar plots abiertos
plt.style.use('ggplot')						#estilo de plot

ax1 = plt.subplot(3,1,1)					# plot de señal
ax1.plot(t,signal,'b-',label='Sinusoidal signal',linewidth=1.5,color='g',linestyle='solid')	
ax1.grid(True,which='both',axis='both',color='black',linewidth=0.5,linestyle='solid')		
ax1.set_ylim([-a1-0.2, a1+0.2])
ax1.set_xlim([0,t[len(t)-1]])

#formato de tiempo
#date_fmt = "%Y-%m-%d"
#date_formatter = mdate.DateFormatter(date_fmt)
#ax1.xaxis.set_major_formatter(date_formatter)

#legend, axis and title name for 1st subplot
ax1.legend(loc='lower left')
ax1.set_xlabel('Time [s]')
ax1.set_ylabel('Amplitude []')

ax2 = plt.subplot(3,1,2, sharex=ax1)
ax2.plot(t,silence1,'b-',label='Silences signal',linewidth=1.5,color='g',linestyle='solid')
ax2.grid(True,which='both',axis='both',color='black',linewidth=0.5,linestyle='solid')	
ax2.set_ylim([-a1-0.2, a1+0.2])
ax2.set_xlim([0,t[len(t)-1]])

#formato de tiempo
# date_fmt = "%S"
# date_formatter = mdate.DateFormatter(date_fmt)
# ax2.xaxis.set_major_formatter(date_formatter)

#legend, axis and title name for 1st subplot
ax2.legend(loc='lower left')
ax2.set_xlabel('Time [s]')
ax2.set_ylabel('Amplitude []')

ax3 = plt.subplot(3,1,3, sharex=ax1)
ax3.plot(t,signal1,'b-',label='Coded message',linewidth=1.5,color='g',linestyle='solid')
ax3.grid(True,which='both',axis='both',color='black',linewidth=0.5,linestyle='solid')	
ax3.set_ylim([-a1-0.2, a1+0.2])
ax3.set_xlim([0,t[len(t)-1]])

#formato de tiempo
# date_fmt = "%S"
# date_formatter = mdate.DateFormatter(date_fmt)
# ax3.xaxis.set_major_formatter(date_formatter)

#legend, axis and title name for 1st subplot
ax3.legend(loc='lower left')
ax3.set_xlabel('Time [s]')
ax3.set_ylabel('Amplitude []')


#Headers and colors
plt.suptitle('Reference signal')


plt.tight_layout()
figManager = plt.get_current_fig_manager()
figManager.full_screen_toggle
  
   