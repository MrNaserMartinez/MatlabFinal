%FUNCION ================================================

function [raiz, tabla] = funcion_punto_fijo(g, x0, tol, max_iter)
    % Método de punto fijo: x = g(x)
    % Devuelve la raíz aproximada y una tabla de resultados
iteraciones = zeros(max_iter, 1);
    x_n = zeros(max_iter, 1);
    gx_n = zeros(max_iter, 1);
    errores = zeros(max_iter, 1);

    for i = 1:max_iter
        x1 = g(x0);
        err = abs(x1 - x0);

        iteraciones(i) = i;
        x_n(i) = x0;
        gx_n(i) = x1;
        errores(i) = err;

        if err < tol
            raiz = x1;
            tabla = table(iteraciones(1:i), x_n(1:i), gx_n(1:i), errores(1:i), ...
                'VariableNames', {'Iteracion', 'x_n', 'g_x_n', 'Error'});
            return;
        end

        x0 = x1;
    end

    raiz = x1;
    tabla = table(iteraciones, x_n, gx_n, errores, ...
        'VariableNames', {'Iteracion', 'x_n', 'g_x_n', 'Error'});
end
