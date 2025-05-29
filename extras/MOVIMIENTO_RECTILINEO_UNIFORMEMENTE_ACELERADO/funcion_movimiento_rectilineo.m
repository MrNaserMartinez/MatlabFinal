%FUNCION ============================================

function result_mrua = funcion_movimiento_rectilineo(x0, x, v0, v, a, t)
    datos = [x0, x, v0, v, a, t];
    if sum(~isnan(datos)) < 3
        error('Se requieren al menos 3 valores conocidos para calcular el resto.');
    end

    % Ecuación 1: v = v0 + a*t
    if isnan(v) && ~isnan(v0) && ~isnan(a) && ~isnan(t)
        v = v0 + a*t;
    elseif isnan(v0) && ~isnan(v) && ~isnan(a) && ~isnan(t)
        v0 = v - a*t;
    elseif isnan(a) && ~isnan(v) && ~isnan(v0) && ~isnan(t)
        a = (v - v0)/t;
    elseif isnan(t) && ~isnan(v) && ~isnan(v0) && ~isnan(a)
        t = (v - v0)/a;
    end

    % Ecuación 2: x = x0 + v0*t + 0.5*a*t^2
    if isnan(x) && ~isnan(x0) && ~isnan(v0) && ~isnan(t) && ~isnan(a)
        x = x0 + v0*t + 0.5*a*t^2;
    elseif isnan(x0) && ~isnan(x) && ~isnan(v0) && ~isnan(t) && ~isnan(a)
        x0 = x - v0*t - 0.5*a*t^2;
    elseif isnan(t) && ~isnan(x) && ~isnan(x0) && ~isnan(v0) && ~isnan(a)
        % Resolver cuadrática en t
        A = 0.5 * a;
        B = v0;
        C = x0 - x;
        D = B^2 - 4*A*C;
        if D < 0
            error('No hay solución real para el tiempo.');
        end
        t1 = (-B + sqrt(D)) / (2*A);
        t2 = (-B - sqrt(D)) / (2*A);
        t = max([t1, t2]); % Tomar tiempo positivo
    end

    % Ecuación 3: v^2 = v0^2 + 2*a*(x - x0)
    if isnan(v) && ~isnan(v0) && ~isnan(a) && ~isnan(x) && ~isnan(x0)
        v = sqrt(v0^2 + 2*a*(x - x0));
    elseif isnan(a) && ~isnan(v) && ~isnan(v0) && ~isnan(x) && ~isnan(x0)
        a = (v^2 - v0^2) / (2*(x - x0));
    elseif isnan(x) && ~isnan(x0) && ~isnan(v) && ~isnan(v0) && ~isnan(a)
        x = x0 + (v^2 - v0^2)/(2*a);
    end

    % Retornar resultados
    result_mrua = struct('x0', x0, 'x', x, 'v0', v0, 'v', v, 'a', a, 't', t);
end
