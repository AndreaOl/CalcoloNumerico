m = 2;
N = 3^m;
%Applichiamo l'algoritmo FFT -radix3
%Invece di calcolare una DFT di lunghezza N
%l'algoritmo calcolerà 3^(m-1) DFT di lunghezza 3

x = randi([-50, 50], N, 1);
y = fft(x);
inverse_y = ifft(y);
stem(abs(y))
%Non specificando l'intervallo di rappresentazione
%viene automaticamente usato l'intervallo [1, length(y)]

