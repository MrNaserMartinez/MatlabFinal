function graficar_area(fx, a, b, gx, tituloGrafica)
% GRAFICAR_AREA Grafica el área bajo una curva o entre dos curvas
%
% graficar_area(fx, a, b) → área bajo fx(x)
% graficar_area(fx, a, b, gx) → área entre fx(x) y gx(x)
% graficar_area(fx, a, b, gx, tituloGrafica) → título personalizado
%
% fx, gx deben ser funciones anónimas: fx = @(x) x.^2

    % Valores por defecto
    if nargin < 5
        tituloGrafica = 'Área calculada';
    end

    if nargin < 4
        gx = [];
    end

    % Generar valores de x para graficar
    x = linspace(a - 1, b + 1, 400);
    y_f = fx(x);

    figure;
    hold on;

    if isempty(gx)
        % Área bajo una sola curva
        plot(x, y_f, 'b', 'LineWidth', 2);
        x_fill = linspace(a, b, 400);
        y_fill = fx(x_fill);
        fill([x_fill fliplr(x_fill)], [y_fill zeros(size(y_fill))], ...
             [0.9 0.6 0.2], 'FaceAlpha', 0.5, 'EdgeColor', 'none');
        legend('f(x)', 'Área bajo f(x)', 'Location', 'best');
    else
        % Área entre dos curvas
        y_g = gx(x);
        plot(x, y_f, 'b', x, y_g, 'r', 'LineWidth', 2);
        x_fill = linspace(a, b, 400);
        y1 = fx(x_fill);
        y2 = gx(x_fill);
        fill([x_fill fliplr(x_fill)], [y1 fliplr(y2)], ...
             [0.2 0.7 0.3], 'FaceAlpha', 0.5, 'EdgeColor', 'none');
        legend('f(x)', 'g(x)', 'Área entre f(x) y g(x)', 'Location', 'best');
    end

    % Estética
    xlabel('x');
    ylabel('y');
    title(tituloGrafica);
    grid on;
    ax = gca;
    ax.FontSize = 12;
    hold off;




end

