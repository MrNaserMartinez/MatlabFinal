function graficar_punto_fijo(g, tabla, g_str, ax)
% GRAFICAR_PUNTO_FIJO - Muestra la convergencia visual del método en un uiaxes
%
% g       → función @(x)
% tabla   → tabla de iteraciones del método
% g_str   → string original de g(x) (para el título)
% ax      → objeto uiaxes donde graficar

    % Extraer los valores usados en las iteraciones
    x_vals = tabla.x_n;
    gx_vals = tabla.g_x_n;

    % Definir rango gráfico alrededor de los valores iterados
    x_min = min([x_vals; gx_vals]) - 1;
    x_max = max([x_vals; gx_vals]) + 1;
    x = linspace(x_min, x_max, 400);
    y = g(x);

    cla(ax);
    hold(ax, 'on');
    plot(ax, x, y, 'b-', 'LineWidth', 2);         % g(x)
    plot(ax, x, x, 'k--', 'LineWidth', 1.5);      % y = x

    % Graficar las líneas de convergencia (cobweb)
    for i = 1:height(tabla)
        x_n = tabla.x_n(i);
        y_n = tabla.g_x_n(i);

        plot(ax, [x_n x_n], [x_n y_n], 'r-');      % Línea vertical
        plot(ax, [x_n y_n], [y_n y_n], 'r-');      % Línea horizontal
    end

    % Marcar la raíz aproximada
    raiz = tabla.g_x_n(end);
    plot(ax, raiz, raiz, 'ko', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
    text(ax, raiz, raiz, '  \leftarrow Raiz encontrada', 'VerticalAlignment', 'bottom', 'FontSize', 10);

    xlabel(ax, 'x');
    ylabel(ax, 'y');
    title(ax, ['Convergencia del método de punto fijo para g(x) = ', g_str]);
    legend(ax, 'g(x)', 'y = x', 'Iteraciones', 'Raíz encontrada', 'Location', 'best');
    grid(ax, 'on');
    hold(ax, 'off');
end
