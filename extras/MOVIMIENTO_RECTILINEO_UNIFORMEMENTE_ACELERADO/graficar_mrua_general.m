function graficar_mrua_general(result, ax)
% GRAFICAR_MRUA_GENERAL - Grafica automáticamente según los datos disponibles
% Puede graficar:
%   - Posición vs tiempo (x vs t)
%   - Velocidad vs tiempo (v vs t)
%   - Velocidad vs posición (v vs x)

    x0 = result.x0;
    x  = result.x;
    v0 = result.v0;
    v  = result.v;
    a  = result.a;
    t_total = result.t;

    cla(ax);
    hold(ax, 'on');
    legendEntries = {};

    % 1. Posición vs tiempo (x vs t)
    if ~isnan(x0) && ~isnan(v0) && ~isnan(a) && ~isnan(t_total)
        t = linspace(0, t_total, 100);
        x_t = x0 + v0 * t + 0.5 * a * t.^2;
        plot(ax, t, x_t, 'b-', 'LineWidth', 2);
        legendEntries{end+1} = 'x vs t';
    end

    % 2. Velocidad vs tiempo (v vs t)
    if ~isnan(v0) && ~isnan(a) && ~isnan(t_total)
        t = linspace(0, t_total, 100);
        v_t = v0 + a * t;
        plot(ax, t, v_t, 'r--', 'LineWidth', 2);
        legendEntries{end+1} = 'v vs t';
    end

    % 3. Velocidad vs posición (v vs x)
    if ~isnan(v0) && ~isnan(a) && ~isnan(x0) && ~isnan(x)
        x_vals = linspace(x0, x, 100);
        v_sq = v0^2 + 2 * a * (x_vals - x0);
        v_vals = sqrt(max(v_sq, 0));
        plot(ax, x_vals, v_vals, 'g-.', 'LineWidth', 2);
        legendEntries{end+1} = 'v vs x';
    end

    if isempty(legendEntries)
        title(ax, 'No hay suficientes datos para graficar MRUA');
    else
        legend(ax, legendEntries, 'Location', 'best');
        title(ax, 'Visualización del Movimiento');
    end

    xlabel(ax, 'Eje horizontal');
    ylabel(ax, 'Eje vertical');
    grid(ax, 'on');
    hold(ax, 'off');
end