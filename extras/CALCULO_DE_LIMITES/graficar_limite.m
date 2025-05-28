function graficar_limite(fx, x_val, tipo)
% GRAFICAR_LIMITE Visualiza el comportamiento de f(x) cerca de un punto
%
% fx: función anónima @(x)
% x_val: valor al que x tiende
% tipo: 'default', 'left', 'right', 'inf', '-inf'

n = 400;    % número de puntos
h = 1e-1;   % paso para intervalo

    switch tipo
        case 'default'
            x = linspace(x_val - h, x_val + h, n);
            titulo = ['Límite en x → ', num2str(x_val)];
        case 'left'
            x = linspace(x_val - h, x_val - h/10, n);
            titulo = ['Límite por la izquierda x → ', num2str(x_val), '⁻'];
        case 'right'
            x = linspace(x_val + h/10, x_val + h, n);
            titulo = ['Límite por la derecha x → ', num2str(x_val), '⁺'];
        case 'inf'
            x = linspace(1000, 100000, n);
            titulo = 'Límite cuando x → ∞';
        case '-inf'
            x = linspace(-100000, -1000, n);
            titulo = 'Límite cuando x → -∞';
        otherwise
            warning('Tipo de límite no reconocido.');
            return;
    end


    try
        y = fx(x);
    catch
        warning('No se pudo evaluar f(x) en el rango definido.');
        return;
    end

    % Filtrar valores válidos para graficar
    y(~isfinite(y)) = NaN;

    figure;
    plot(x, y, 'b', 'LineWidth', 2);
    grid on;
    xlabel('x');
    ylabel('f(x)');
    title(titulo);
    ylim padded;

end

