[audio,Fs] = audioread('Stayin Alive.mp3');
audio = audio(:,1);
n = length(audio);

dt = 1/Fs;

%t = 0:dt:20-dt;

%plot(t, audio_in(1:length(t)))

F = fft(audio);

freq = (0:n/2)*Fs/n;

freqq = (0:n-1)*Fs/n;
H = ones(length(freq), 1);
H(freqq < 2000) = 0;
H(freqq > 40000) = 0;
H(n/2+1:n)=fliplr(H(1:n/2));

filtered = F.*H;

plot(freq, abs(filtered(1:n/2+1)))

player = audioplayer(ifft(filtered, n), Fs);
play(player)