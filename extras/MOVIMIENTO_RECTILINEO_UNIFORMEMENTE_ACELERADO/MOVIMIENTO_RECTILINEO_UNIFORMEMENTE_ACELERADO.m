%SCRIP =====================================

clc;
clear;

fprintf('=== CALCULADORA MRUA ===\n');
fprintf('Ingresa los datos conocidos. Deja en blanco los que no sepas.\n\n');

% Ingreso seguro de datos (como texto)
x0_str = input('Posición inicial (x0): \n', 's');
x_str  = input('Posición final (x): \n', 's');
v0_str = input('Velocidad inicial (v0): \n', 's');
v_str  = input('Velocidad final (v): \n', 's');
a_str  = input('Aceleración (a): \n', 's');
t_str  = input('Tiempo (t): \n', 's');

% Convertir texto a número, o NaN si está vacío
x0 = str2double(x0_str); if isempty(x0_str), x0 = NaN; end
x  = str2double(x_str);  if isempty(x_str),  x  = NaN; end
v0 = str2double(v0_str); if isempty(v0_str), v0 = NaN; end
v  = str2double(v_str);  if isempty(v_str),  v  = NaN; end
a  = str2double(a_str);  if isempty(a_str),  a  = NaN; end
t  = str2double(t_str);  if isempty(t_str),  t  = NaN; end


% Llamar a la función
try
    resultado = funcion_movimiento_rectilineo(x0, x, v0, v, a, t);

    fprintf('\n=== RESULTADOS ===\n');
    disp(resultado);
    graficar_mrua_general(resultado);
catch ME
    fprintf('\nError: %s\n', ME.message);
end
pause;

