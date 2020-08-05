%                                       Sistema varolizador de PC´s                                                        %

%   Sistema de inferencia difusa tipo Mamdani %

%   TP - FINAL - Inteligencia Artificial 1 - Lic. en Informática %

%   Universidad Atlántida Argentina %

%   Fecha de inicio = Julio 2020 || Fecha de entrega =  3 de Agosto de 2020 %

%   Alumno = Giacalone Juan Pablo || DNI = 40.666.502 %

%   INPUTS %


   % [ %VALOR_PSU %ANTIGUEDAD %NUCLEOS; ] %
        
    
ENTRADAS =  [   50 0 4;  
                50 4 2;    
                100 0 8;    
                         ];  



sistema_valorizador = readfis('sistema_valorizador_v0.24'); % ( se debe ubicar el archivo.fis en la raiz del script. )

VALOR = evalfis(ENTRADAS,sistema_valorizador); % a la variable de salida VALOR se le asignan las salidas del sistema. )



%   INPUTS %

% FUNCIONES %


