%FUNCION =============================

function result_potencia = funcion_potencias(fx, x)
%funcion

    try
            result_potencia = fx(x);
        
    catch
            warning('No se pudo evaluar la función en los valores de x.');
            result_potencia = NaN;
    end
end


