function result_limites = funcion_calculo_de_limites(fx, x_val, tipo)
  
    % fx: función simbólica
    % x_val: valor al que x tiende
    % tipo: 'default', 'left', 'right', 'inf', '-inf'

    syms x

    switch tipo
        case 'default'
            result_limites = limit(fx, x, x_val);
        case 'left'
            result_limites = limit(fx, x, x_val, 'left');
        case 'right'
            result_limites = limit(fx, x, x_val, 'right');
        case 'inf'
            result_limites = limit(fx, x, inf);
        case '-inf'
            result_limites = limit(fx, x, -inf);
        otherwise
            error('Tipo de límite no reconocido.');

            
    end
end

