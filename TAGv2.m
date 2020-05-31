

clear all;
freq=69;%kHz frecuencia de emisi�n
freqSin=1;%kHz frecuencia de se�al sinusoidal
npul=8;%n�mero de pulsos a generar
tpul=0.050;%segundos de duraci�n del pulso
tsep=0.200;%segundos de separaci�n entre tren de pulsos
binary=[];%guardar� el n�mero de pulsos codificado en binario
signalC=[];%guardar� la se�al cuadrada a la frecuencia indicada
a='1';
a1=1;%amplitud se�al sinusoidal

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
tsampler=1/(1000*freq);%tiempo en segundos por cada se�al
nsamplere=tpul/tsampler;%n�mero de sampler por escal�n 0 o 1
nsamplers=tsep/tsampler;%n�mero de sampler por silencio

while(not(isempty(binary)))
  for i=1:nsamplere
   if binary(1)=='1'
       signalC=[signalC 1];
   else
       signalC=[signalC 0];
   end
  end    
  binary(1)=[];%elimina el primer valor de la se�al para pasar al siguiente  
end

for i=1:nsamplers
    signalC=[signalC 0];
end
%%generador de vector en samplers cuadrada+separaci�n

%%generador se�al sinusoidal
f1 = 2*pi*freqSin*1000;%[rad]
Ts = tsampler;% [s]
t = 0 : Ts : 1-Ts;% Time vector 1 second.
radT=f1*t;%producto del vector tiempo por el valor en radianes
signal = a1 * sin(radT);
%%generador se�al sinusoidal

%%multiplicaci�n de se�al cuadrada por se�al sinusoidal
signal1 = a1 * sin(radT.*signalC);
%%multiplicaci�n de se�al cuadrada por se�al sinusoidal
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
