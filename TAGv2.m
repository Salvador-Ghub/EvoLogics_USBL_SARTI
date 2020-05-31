

clear all;
freq=69;%kHz frecuencia de emisión
freqSin=1;%kHz frecuencia de señal sinusoidal
npul=8;%número de pulsos a generar
tpul=0.050;%segundos de duración del pulso
tsep=0.200;%segundos de separación entre tren de pulsos
binary=[];%guardará el número de pulsos codificado en binario
signalC=[];%guardará la señal cuadrada a la frecuencia indicada
a='1';
a1=1;%amplitud señal sinusoidal

%%generador de codigo binario 
for i=1:npul*2
    binary=[binary a];
    if a=='1'
        a='0';
    else
        a='1';
    end
end
%%generador de codigo binario 

%%generador de vector en samplers
tsampler=1/(1000*freq);%tiempo en segundos por cada señal
nsamplere=tpul/tsampler;%número de sampler por escalón 0 o 1
nsamplers=tsep/tsampler;%número de sampler por silencio

while(not(isempty(binary)))
  for i=1:nsamplere
   if binary(1)=='1'
       signalC=[signalC 1];
   else
       signalC=[signalC 0];
   end
  end    
  binary(1)=[];%elimina el primer valor de la señal para pasar al siguiente  
end

for i=1:nsamplers
    signalC=[signalC 0];
end
%%generador de vector en samplers cuadrada+separación

%%generador señal sinusoidal
f1 = 2*pi*freqSin*1000;%[rad]
Ts = tsampler;% [s]
t = 0 : Ts : 1-Ts;% Time vector 1 second.
radT=f1*t;%producto del vector tiempo por el valor en radianes
signal = a1 * sin(radT);
%%generador señal sinusoidal

%%multiplicación de señal cuadrada por señal sinusoidal
signal1 = a1 * sin(radT.*signalC);
%%multiplicación de señal cuadrada por señal sinusoidal
save('C:\Users\Salvador\Desktop\TFM\Ubuntu\Examples\signal.dat','signal1','-ascii');
figure();

subplot(3,1,1);
plot(t, signal);
ylim([-1.5 1.5]);

subplot(3,1,2);
plot(t, signalC);
ylim([-1.5 1.5]);

subplot(3,1,3);
plot(t, signal1);
ylim([-1.5 1.5]);
