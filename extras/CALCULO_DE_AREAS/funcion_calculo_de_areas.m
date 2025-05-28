
% FUNCION ============================

function result_area = funcion_calculo_de_areas(f, a, b, g)
    % Calcula el área bajo una curva (o entre dos)
    % f: función superior
    % a, b: límites
    % g: función inferior (opcional)

    if nargin < 4 || isempty(g)
        integrando = f;
    else
        integrando = @(x) f(x) - g(x);  % Área entre dos curvas
    end

    try
        result_area = integral(integrando, a, b);
    catch
        warning('Error al calcular el área. Verifica que las funciones estén bien definidas en el intervalo.');
        result_area = NaN;
    end
end
