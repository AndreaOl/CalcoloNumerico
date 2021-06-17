function [Int,Err,Iflag] = trapez_comp(a,b,Tol,f,Maxsum)
%TRAPEZ_COMP calcola l'integrale definito nell'intervallo [a,b] di f
%   con la formula trapezoidale composita a meno di una tolleranza
%   Tol ed effettuando un limite massimo di somme Maxsum.
%   L'output è composto dall'integrale, l'approssimazione dell'errore
%   e un flag che indica se abbiamo raggiunto Maxsum somme

m = 2;                      %Numero iniziale di segmenti 
h = (b-a)/m;                %Grandezza di ogni segmento
x = (a+b)/m;                %Punto medio dell'intervallo
oldint = h*(f(a)+f(b));     %Integrale calcolato precedentemente,
                            %   in questo caso su un unico trapezio
Int = oldint/2 + h*f(x);    %Integrale tramite formula trapezoidale 
                                %composta con due trapezi
nsum = 3;                   %Numero corrente di somme effettuate
Err = abs(Int-oldint)/3;    %Stima dell'errore di discretizzazione della
                            %   formula con m sottointervalli
                            
while Err > Tol && nsum < Maxsum
   m = 2*m;                 %Raddoppiamo il numero di intervalli...
   h = h/2;                 %...si dimezza la grandezza degli intervalli...
                            %...e riduciamo di circa 4 volte l'errore
   sum = 0;                 %Valore temporaneo della somma
   
   for k = 1:2:m-1          %Valutiamo la funzione nei punti non
                            %   non ancora valutati
        x = a + k*h;
        sum = sum + f(x);
        nsum = nsum + 1;
   end
   oldint = Int;
   Int = oldint/2 + h*sum;  %oldint viene dimezzato proprio come h
   Err = abs(Int-oldint)/3;
end

if nsum < Maxsum
    Iflag = 0;              %Flag che indica se abbiamo superato il
                            %   numero massimo di somme
else
    Iflag = 1;
end                            
end

