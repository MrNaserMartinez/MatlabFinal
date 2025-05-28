%FUNCION ==================================

function result_limites = funcion_calculo_de_limites(fx, x_val, tipo)

    n = 100;     % número de puntos
    h = 1e-6;    % paso pequeño

    switch tipo
        case 'default'
            x = linspace(x_val - h, x_val + h, n);
        case 'left'
            x = linspace(x_val - h, x_val - h/10, n);
        case 'right'
            x = linspace(x_val + h/10, x_val + h, n);
        case 'inf'
            x = linspace(1e3, 1e6, n);
        case '-inf'
            x = linspace(-1e6, -1e3, n);
        otherwise
            error('Tipo de límite no reconocido.');
    end

    % Evaluar la función
    try
        y = fx(x);
    catch
        warning('Error al evaluar la función con los valores x.');
        result_limites = NaN;
        return;
    end

    % Filtrar valores no válidos
    y_val = y(~isnan(y) & ~isinf(y) & abs(y) < 1e10);

    if isempty(y_val)
        result_limites = NaN;
    else
        % Tomamos el promedio de los últimos valores para más precisión
        k = min(10, length(y_val));
        result_limites = mean(y_val(end-k+1:end));
    end
end
