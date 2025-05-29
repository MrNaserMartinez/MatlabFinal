function graficar_mrua(result)
% GRAFICAR_MRUA - Grafica la posición en función del tiempo (x vs t)

    x0 = result.x0;
    v0 = result.v0;
    a  = result.a;
    t_total = result.t;

    if isnan(x0) || isnan(v0) || isnan(a) || isnan(t_total)
        warning('No se puede graficar. Faltan datos esenciales.');
        return;
    end

    t = linspace(0, t_total, 100);
    x = x0 + v0 * t + 0.5 * a * t.^2;

    figure;
    plot(t, x, 'b-', 'LineWidth', 2);
    grid on;
    xlabel('Tiempo (t)');
    ylabel('Posición (x)');
    title('Movimiento Rectilíneo Uniformemente Acelerado');
end
