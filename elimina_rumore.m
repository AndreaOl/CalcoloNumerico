% Questo esempio elimina il rumore a frequenza elevata da una
% registrazione.
% Usage: play(player) per ascoltare il brano senza basso
%        stop(player) per interrompere la riproduzione

 
[audio_in,Fs] = audioread('Registrazione con rumore.wav');
 
%df è il range minimo di frequenze
n = length(audio_in);
df = Fs/n;
 
%Scegliamo i valori di frequenze che comporranno le ascisse del grafico
frequenze = -Fs/2:df:Fs/2-df;
 
%Applichiamo la trasformata di Fourier
FFT_audio_in = fftshift(fft(audio_in)/length(fft(audio_in)));
 
%Plotting della trasformata
figure
plot(frequenze,abs(FFT_audio_in));
title("FFT dell'input audio");
xlabel('Frequenze(HZ)');
ylabel('Ampiezza');
 
%Range di frequenze per isolare la registrazione dal rumore
freq_taglio_inf = 150;
freq_taglio_sup = 10000;

%Tramite operazioni booleane applichiamo un filtro passa-banda 
val = abs(frequenze)<freq_taglio_sup & abs(frequenze)>freq_taglio_inf;

FFT_voc = FFT_audio_in(:,1);
FFT_voc(~val) = 0;

%Plotting del segnale dopo l'applicazione del filtro
figure
plot(frequenze,abs(FFT_voc));
title("FFT eliminando il rumore");
xlabel('Frequenze(HZ)');
ylabel('Ampiezza');
 
%Applichiamo la trasformata inversa di Fourier
FFT_a = ifftshift(FFT_voc);
 
%Creiamo il segnale nel dominio del tempo
s = ifft(FFT_a*length(fft(audio_in)));
 
%Creiamo il player
player = audioplayer(s3, Fs);