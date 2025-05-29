%FUNCION =======================================

function [raiz, success, historial] = funcion_mrm(f, x0, tol, maxIter)

    E = 1e-5;  % paso pequeño para derivadas
    historial = zeros(maxIter, 4);  % columnas: iter, x, f(x), error
    success = false;

    for i = 1:maxIter
        fx = f(x0);
        dfx = (f(x0 + E) - f(x0 - E)) / (2 * E);
        d2fx = (f(x0 + E) - 2 * fx + f(x0 - E)) / (E^2);

        denom = dfx^2 - fx * d2fx;
        if denom == 0
            error('División por cero en la iteración %d. Método fallido.', i);
        end

        x1 = x0 - (fx * dfx) / denom;
        err = abs(x1 - x0);

        historial(i, :) = [i, x1, f(x1), err];

        if err < tol
            raiz = x1;
            success = true;
            return;
        end

        x0 = x1;
    end

    raiz = x1;
end
