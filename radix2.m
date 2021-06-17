m = 3;
N = 2^m;
%Applichiamo l'algoritmo FFT -radix2
%Invece di calcolare una DFT di lunghezza N
%l'algoritmo calcolerà N/2 DFT di lunghezza 2

x = randi([-50, 50], N, 1);
y = fft(x);
inverse_y = ifft(y);

