%Esempio di applicazione della formula trapezoidale composita
%tramite la funzione trapez_comb, usata per calcolare l'integrale
%della curva f(x)=sin(x) nell'intervallo [0,pi]

a = 0; b = pi; Tol = 10^(-10); Maxsum = 50;
f = @(x) sin(x);
