% Questo esempio mira a dimostrare come manipolare un segnale nel
% dominio della frequenza per isolare alcune frequenze dalle altre.
% Queste tecniche sono molto utili in ambito musicale per isolare
% la voce o gli strumenti di una canzone. Qui vogliamo isolare l'iconica
% linea di basso della canzone Another One Bites The Dust dei Queen.
% Lo script crea due player, uno per ascoltare solo il basso, l'altro
% per ascoltare il brano senza basso.
% Usage: play(player_ins) per ascoltare il brano senza basso
%        stop(player_ins) per interrompere la riproduzione
%        ---------------------------------------------------
%        play(player_bass) per ascoltare solo il basso
%        stop(player_bass) per interrompere la riproduzione

 
[audio_in,Fs] = audioread('Another One Bites The Dust.mp3');
 
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
 
%Range di frequenze per isolare il basso ed il resto del brano
freq_taglio_inf_ins = 60;
freq_taglio_sup_ins = 600;

freq_taglio_inf_bass = 150;
freq_taglio_sup_bass = 300;

%Tramite operazioni booleane applichiamo un filtro passa-banda 
val_ins = abs(frequenze)<freq_taglio_sup_ins & abs(frequenze)>freq_taglio_inf_ins;
val_bass = abs(frequenze)<freq_taglio_sup_bass & abs(frequenze)>freq_taglio_inf_bass;

FFT_ins = FFT_audio_in(:,1);        %Prendiamo un solo canale (essendo stereo)
FFT_bass = FFT_audio_in(:,1);
FFT_ins(val_ins) = 0;
FFT_bass(~val_bass) = 0;
FFT_bass(val_bass) = FFT_bass(val_bass)*2;

%Plotting dei segnali dopo l'applicazione del filtro
figure
plot(frequenze,abs(FFT_ins));
title("FFT escluso il basso");
xlabel('Frequenze(HZ)');
ylabel('Ampiezza');

figure
plot(frequenze,abs(FFT_bass));
title("FFT isolando il basso");
xlabel('Frequenze(HZ)');
ylabel('Ampiezza');
 
%Applichiamo la trasformata inversa di Fourier
FFT_a = ifftshift(FFT_audio_in);
FFT_a11 = ifftshift(FFT_ins);
FFT_a31 = ifftshift(FFT_bass);
 
%Creiamo i segnali nel dominio del tempo
s1 = ifft(FFT_a11*length(fft(audio_in)));  
s3 = ifft(FFT_a31*length(fft(audio_in)));
 
%Creiamo i player
player_ins = audioplayer(s1, Fs);
player_bass = audioplayer(s3, Fs);