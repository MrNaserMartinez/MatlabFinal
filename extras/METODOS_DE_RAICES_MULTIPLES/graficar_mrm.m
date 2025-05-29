function graficar_mrm(f, iter_data, f_str, ax)
% GRAFICAR_RAICES_MULTIPLES Visualiza la función y el proceso iterativo en una GUI
%
% f         → función anónima @(x)
% iter_data → matriz con columnas: [iter, x, f(x), error]
% f_str     → cadena de texto original, usada como título
% ax        → objeto uiaxes donde se graficará

    % Obtener el rango de x desde el historial
    x_vals = iter_data(:, 2);
    x_min = min(x_vals) - 1;
    x_max = max(x_vals) + 1;

    x = linspace(x_min, x_max, 400);
    y = f(x);

    cla(ax);
    plot(ax, x, y, 'b-', 'LineWidth', 2); hold(ax, 'on');
    plot(ax, x_vals, iter_data(:,3), 'ro-', 'LineWidth', 1.5);  % puntos de iteración

    yline(ax, 0, '--k');  % línea horizontal en y=0
    xlabel(ax, 'x');
    ylabel(ax, 'f(x)');
    title(ax, ['Iteraciones del Método de Raíces Múltiples para f(x) = ', f_str]);
    legend(ax, 'f(x)', 'Iteraciones', 'Ubicación raíz (aprox)', 'Location', 'best');
    grid(ax, 'on');
    hold(ax, 'off');
end
