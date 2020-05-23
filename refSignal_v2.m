%Name: refSignal
%Version: 2
%Description: Generates reference signal at frequence and silence
%configurable times


clear all; close all;
freq=18; %frecuencia del USBL [kHz]
freqSignal=1; %frecuencia de señal [kHz]
tsilence0=0.100; %seg [s]
tsilence1=0.150; %seg [s]   

%z>4/(freq/freqSignal)
fs = freq*1000;  % [Hz] Fs>2Fmax Nyquist-Shannon
samplerSilence0=tsilence0/(1/(fs)); %cálculo para el 
samplerSilence1=tsilence1/(1/(fs));

Ts = 1/fs;  % [s]

t = 0 : Ts : 1-Ts;     % Time vector 1 second.

% Signals' amplitudes.
a1 = 1;

% Signals' frequencies [rad].
f1 = 2*pi*freqSignal*1000;

% Signals' phase [rad].
theta1 = 0;

% Create the signals.
cadena='Hello world!';

binary = reshape(dec2bin(cadena, 8).'-'0',1,[]);
binary=[1 binary]; %introduce un uno por delante
binary(length(binary)+1)=1;%introduce un uno por detrás
silence1 = zeros(1, numel(t));
s=1;
sAnt=s;
c=1;

while not(isempty(binary))
%while numel(silence1)>s
    if c==0
        if binary(1)==0
            samplerSilence=samplerSilence0;
        else
            samplerSilence=samplerSilence1;
        end
    else
        samplerSilence=samplerSilence0;
    end
    
    if sAnt+samplerSilence<s
        sAnt=s;
        
        if c==0
           c=1;
        else
           c=0;
           binary(1)=[];
        end
    end
    silence1(s) = c;
    s=s+1;
if numel(silence1)<s
    t(length(t)+1)=t(length(t))+Ts;
end
end
silence1(length(silence1)+1) = 1;
signal = a1 * sin((f1.*t) + theta1);
signal1 = a1 * sin((f1.*t).*silence1 + theta1);
save('C:\Users\Salvador\Desktop\TFM\Ubuntu\Examples\signal.dat','signal1','-ascii');

% Plots
figure();

subplot(3,1,1);
plot(t, signal);
ylim([-1.5 1.5]);

subplot(3,1,2);
plot(t, silence1);
ylim([-1.5 1.5]);

subplot(3,1,3);
plot(t, signal1);
ylim([-1.5 1.5]);


