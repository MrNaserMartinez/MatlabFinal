%SCRIP ======================================

clc;
clear;

fprintf('=== MÉTODO DE RAÍCES MÚLTIPLES ===\n\n');
fprintf('Ingresa la función\n\n');

f_str = input('f(x) = ', 's');

% Reemplazar operadores
f_str = strrep(f_str, '^', '.^');
f_str = strrep(f_str, '*', '.*');
f_str = strrep(f_str, '/', './');

% Convertir a función anónima
try
    f = str2func(['@(x) ' f_str]);
catch
    disp('Error en la definición de la función.');
    return;
end

% Parámetros
x0 = input('Ingresa el valor inicial x0: ');
tol = input('Ingresa la tolerancia (ej: 1e-6): ');
maxIter = input('Número máximo de iteraciones: ');

% Llamar a la función
[root, success, iter_data] = funcion_mrm(f, x0, tol, maxIter);

% Mostrar resultados
if success
    fprintf('\nRaíz aproximada encontrada: %.10f\n', root);
    fprintf('Iteraciones realizadas: %d\n', size(iter_data, 1));
    disp(array2table(iter_data, 'VariableNames', {'Iter', 'x', 'f(x)', 'Error'}));
    graficar_mrm(f, iter_data, f_str);
else
    fprintf('\nNo se alcanzó la convergencia en %d iteraciones.\n', maxIter);
    disp(array2table(iter_data, 'VariableNames', {'Iter', 'x', 'f(x)', 'Error'}));
    graficar_mrm(f, iter_data, f_str);

end
pause;

