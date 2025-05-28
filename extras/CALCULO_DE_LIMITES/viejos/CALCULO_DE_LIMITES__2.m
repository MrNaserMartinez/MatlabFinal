clc;
syms x

fprintf('=== CÁLCULO DE LÍMITES ===\n');
fprintf('1. Límite en un punto\n');
fprintf('2. Límite por la izquierda\n');
fprintf('3. Límite por la derecha\n');
fprintf('4. Límite cuando x -> ∞\n');
fprintf('5. Límite cuando x -> -∞\n');

opcion = input('Elige una opción (1-5): ');
f = input('Ingresa la función f(x): ', 's');
fx = str2sym(f);

switch opcion
    case {1, 2, 3}
        x_val = input('Ingresa el valor hacia el que tiende x: ');
    otherwise
        x_val = NaN;  % No se necesita
end

% Determinar tipo de límite
switch opcion
    case 1
        tipo = 'default';
    case 2
        tipo = 'left';
    case 3
        tipo = 'right';
    case 4
        tipo = 'inf';
    case 5
        tipo = '-inf';
    otherwise
        disp('Opción inválida.');
        return;
end

% Llamada a la función
resultado = funcion_calculo_de_limites(fx, x_val, tipo);

fprintf('\n>> El resultado del límite es: ');
disp(resultado);