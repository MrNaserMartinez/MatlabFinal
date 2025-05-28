
%SCRIP =======================================

clc;
fprintf('\n=== CÁLCULO DE ÁREAS ===\n');

% Leer la función principal
f = input('Ingresa la función f(x): ', 's');

% Limpiar operadores para funciones vectorizadas
f = strrep(f, '^', '.^');
f = strrep(f, '*', '.*');
f = strrep(f, '/', './');

% Convertir a función anónima
try
    fx = str2func(['@(x) ' f]);
catch
    disp('Error al procesar la función f(x). Verifica la sintaxis.');
    return;
end

% Leer límites de integración
a = input('Ingresa el límite inferior: ');
b = input('Ingresa el límite superior: ');

% Leer segunda función opcional
g_input = input('Ingresa la segunda función g(x) (opcional, ENTER si no aplica): ', 's');

if isempty(g_input)
    gx = [];  % No hay segunda función
else
    g_input = strrep(g_input, '^', '.^');
    g_input = strrep(g_input, '*', '.*');
    g_input = strrep(g_input, '/', './');
    try
        gx = str2func(['@(x) ' g_input]);
    catch
        disp('Error al procesar g(x). Verifica la sintaxis.');
        return;
    end
end

% Llamar a la función de cálculo
area = funcion_calculo_de_areas(fx, a, b, gx);
tituloGrafica = NaN;
graficar_area(fx, a, b, gx, tituloGrafica)

fprintf('\n>> El área aproximada es: %.6f\n', area);
pause;

