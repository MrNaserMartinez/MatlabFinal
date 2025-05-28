function graficar_potencia( x, y, f_texto)
% GRAFICAR_FUNCION_POTENCIA - Grafica la función fx evaluada en x
%
% fx      → función anónima @(x)
% x       → vector de valores
% y       → resultado de fx(x)
% f_texto → texto original que el usuario ingresó (para título)

    figure;
    plot(x, y, 'm-', 'LineWidth', 2);
    grid on;
    xlabel('x');
    ylabel('f(x)');
    title(['f(x) = ', f_texto]);


end

