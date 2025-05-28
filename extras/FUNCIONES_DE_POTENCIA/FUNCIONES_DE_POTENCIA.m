%SCRIP ===========================

clc;
clear;

fprintf('=== CALCULADORA DE FUNCIÓN DE POTENCIA ===\n');

% Pedir función como texto normal (sin puntos)
f = input('Ingresa la función de potencia: ', 's');

% Reemplazar operadores para vectores automáticamente
f = strrep(f, '^', '.^');
f = strrep(f, '*', '.*');
f = strrep(f, '/', './');

% Convertir en función anónima segura
try
    fx = str2func(['@(x) ' f]);
catch
    disp('Error: La función ingresada no es válida.');
    return;
end

% Preguntar por el valor o rango de x
modo = input('¿Deseas evaluar:\n1. Un solo valor de x\n2. Un rango de valores?\nElige (1 o 2): ');

switch modo
    case 1
        x = input('Ingresa el valor de x: ');
    case 2
        xi = input('Límite inferior del intervalo x: ');
        xf = input('Límite superior del intervalo x: ');
        pasos = input('Cantidad de puntos: ');
        x = linspace(xi, xf, pasos);
    otherwise
        disp('Opción inválida.');
        return;
end

% Llamar a la función de cálculo
y = funcion_potencias(fx, x);

if modo == 1
    fprintf('\nEl resultado de f(%.4f) es: %.4f\n', x, y);
else
    disp(table(x(:), y(:), 'VariableNames', {'x', 'f(x)'}));

    % Mostrar gráfica
    graficar_potencia( x, y, f);
end
pause;

