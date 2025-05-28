% SCRIP ===========================

clc;
fprintf('=== CÁLCULO DE LÍMITES ===\n');
fprintf('1. Límite en un punto\n');
fprintf('2. Límite por la izquierda\n');
fprintf('3. Límite por la derecha\n');
fprintf('4. Límite cuando x → ∞\n');
fprintf('5. Límite cuando x → -∞\n');

opcion = input('Elige una opción (1-5): \n');

% Leer la función como texto
f = input('Ingresa la función f(x): \n', 's');

% Reemplazar operadores para vectores
f = strrep(f, '^', '.^');
f = strrep(f, '*', '.*');
f = strrep(f, '/', './');
f = strrep(f, '\', '.\');

% Convertir a función anónima segura
try
    fx = str2func(['@(x) ' f]);
catch
    disp('Error al procesar la función. Verifica la sintaxis.');
    return;
end

% Leer punto si es necesario
if ismember(opcion, [1, 2, 3])
    x_val = input('Ingresa el valor hacia el que tiende x: \n');
else
    x_val = NaN;
end

% Determinar el tipo de límite
tipos = {'default', 'left', 'right', 'inf', '-inf'};
if opcion >= 1 && opcion <= 5
    tipo = tipos{opcion};
else
    disp('Opción inválida.');
    return;
end

% Llamar a la función
resultado = funcion_calculo_de_limites(fx, x_val, tipo);

fprintf('\n>> Resultado aproximado del límite: ');
disp(resultado);
graficar_limite(fx, x_val, tipo);
pause;

