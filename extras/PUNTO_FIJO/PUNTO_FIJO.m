%SCRIP ============================

clc;
clear;

fprintf('=== MÉTODO DE PUNTO FIJO ===\n');
fprintf('Forma de ecuación: x = g(x)\n');
fprintf('Ingresa la función g(x)\n\n');

g_str = input('g(x) = ', 's');
g_str = strrep(g_str, '^', '.^');  % Vectorización segura
g_str = strrep(g_str, '*', '.*');
g_str = strrep(g_str, '/', './');

try
    g = str2func(['@(x) ' g_str]);
catch
    error('La función g(x) ingresada no es válida.');
end

x0 = input('Valor inicial x0 = ');
tol = input('Tolerancia (ej: 1e-6) = ');
maxIter = input('Máximo número de iteraciones = ');

% Llamar a la función
[raiz, tabla] = funcion_punto_fijo(g, x0, tol, maxIter);

% Mostrar resultados
fprintf('\nAproximación final de la raíz: %.10f\n\n', raiz);
disp(tabla);
graficar_punto_fijo(g, tabla, g_str);
pause;



