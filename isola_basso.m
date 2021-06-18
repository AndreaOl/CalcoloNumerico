% Questo esempio mira a dimostrare come manipolare un segnale nel
% dominio della frequenza per isolare alcune frequenze dalle altre.
% Queste tecniche sono molto utili in ambito musicale per isolare
% la voce o gli strumenti di una canzone. Qui vogliamo isolare l'iconica
% linea di basso della canzone Another One Bites The Dust dei Queen.

 
[audio_in,Fs] = audioread('Another One Bites The Dust.mp3');
 
%ALLIGNING THE VALUES TO LENGTH OF AUDIO, AND DF IS THE MINIMUM FREQUENCY RANGE
n = length(audio_in);
df = Fs/n;
 
%CALCULATING FREQUENCY VALUES TO BE ASSIGNED ON THE X-AXIS OF THE GRAPH
frequenze = -Fs/2:df:Fs/2-df;
 
%BY APPLYING FOURIER TRANSFORM TO THE AUDIO FILE
FFT_audio_in = fftshift(fft(audio_in)/length(fft(audio_in)));
 
% PLOTTING
figure
plot(frequenze,abs(FFT_audio_in));
title("FFT dell'input audio");
xlabel('Frequenze(HZ)');
ylabel('Ampiezza');
 
%NOW LETS SEPARATE THE VARIOUS COMPONENTS BY CUTTING IT IN FREQUENCY RANGE
freq_taglio_inf_ins = 60;
freq_taglio_sup_ins = 600;

freq_taglio_inf_bass = 150;
freq_taglio_sup_bass = 300;
% WHEN THE VALUES IN THE ARRAY ARE IN THE FREQUENCY RANGE THEN WE HAVE 1 AT
% THAT INDEX AND O FOR OTHERS I.E; CREATING AN BOOLEAN INDEX ARRAY
 
val_ins = abs(frequenze)<freq_taglio_sup_ins & abs(frequenze)>freq_taglio_inf_ins;
val_bass = abs(frequenze)<freq_taglio_sup_bass & abs(frequenze)>freq_taglio_inf_bass;

FFT_ins = FFT_audio_in(:,1);
FFT_bass = FFT_audio_in(:,1);
%BY THE LOGICAL ARRAY THE FOURIER IN FREQUENCY RANGE IS KEPT IN VOCALS;AND
%REST IN INSTRUMENTAL AND REST OF THE VALUES TO ZERO
FFT_ins(val_ins) = 0;
FFT_bass(~val_bass) = 0;
FFT_bass(val_bass) = FFT_bass(val_bass)*2;

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
 
%NOW WE PERFORM THE INVERSE FOURIER TRANSFORM TO GET BACK THE SIGNAL
FFT_a = ifftshift(FFT_audio_in);
FFT_a11 = ifftshift(FFT_ins);
FFT_a31 = ifftshift(FFT_bass);
 
%CREATING THE TIME DOMAIN SIGNAL
s1 = ifft(FFT_a11*length(fft(audio_in)));  
s3 = ifft(FFT_a31*length(fft(audio_in)));
 
%LISTENING
player_ins = audioplayer(s1, Fs);
player_bass = audioplayer(s3, Fs);