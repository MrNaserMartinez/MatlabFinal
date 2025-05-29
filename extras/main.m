clc;
clear;

% Menú principal -- parte EDGAR
% En este menú nos va a permitir seleccionar el tipo de funcion que
% querramos usar.

while true
    fprintf('\n=== CALCULADORA ===\n');
    fprintf('\n=== ELIJA UNA OPCIÓN ===\n');
    fprintf('24. CÁLCULO DE ÁREAS\n');
    fprintf('25. FUNCIONES DE POTENCIA\n');
    fprintf('26. MOVIMIENTO RECTILÍNEO UNIFORMEMENTE ACELERADO\n');
    fprintf('27. CÁLCULO DE LÍMITES\n');
    fprintf('28. MÉTODO DE RAÍCES MÚLTIPLES\n');
    fprintf('29. MÉTODO DE PUNTO FIJO\n');
    fprintf('0. SALIR\n');

    opcion1 = input('INGRESE UNA OPCIÓN:\n');

    switch opcion1
        case 24
            CALCULO_DE_AREAS;

        case 25
            FUNCIONES_DE_POTENCIA;

        case 26
            MOVIMIENTO_RECTILINEO_UNIFORMEMENTE_ACELERADO;

        case 27
            CALCULO_DE_LIMITES;

        case 28
            METODOS_DE_RAICES_MULTIPLES;  % Método de raíces múltiples

        case 29
            PUNTO_FIJO;

        case 0
            fprintf('\nEstás saliendo del menú.\n');
            break;

        otherwise
            fprintf('\n=== Opción no válida, intente otra. ===\n');
    end
end
