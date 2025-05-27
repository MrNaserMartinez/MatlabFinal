function calculo_limites_gui()
    fig = uifigure('Name', 'Cálculo de Límites', 'Position', [500 200 800 500]);

    % Título principal
    uilabel(fig, 'Text', 'CÁLCULO DE LÍMITES', ...
        'FontSize', 22, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', ...
        'Position', [200 440 400 30]);

    uilabel(fig, 'Text', 'Calcula el valor del límite para funciones reales', ...
        'FontSize', 14, 'HorizontalAlignment', 'center', ...
        'Position', [200 410 400 20]);

    % Panel de entrada
    entrada = uipanel(fig, 'Title', 'Parámetros de Entrada', ...
        'FontWeight', 'bold', 'Position', [30 240 350 160]);

    uilabel(entrada, 'Text', 'Tipo de Límite:', 'Position', [10 100 100 22]);
    tipoDrop = uidropdown(entrada, 'Items', {...
        '1. En un punto', '2. Por la izquierda', '3. Por la derecha', '4. x → ∞', '5. x → -∞'}, ...
        'Position', [120 100 200 22]);

    uilabel(entrada, 'Text', 'Función f(x):', 'Position', [10 65 100 22]);
    fxField = uieditfield(entrada, 'text', 'Position', [120 65 200 22]);

    uilabel(entrada, 'Text', 'x →', 'Position', [10 30 100 22]);
    xField = uieditfield(entrada, 'numeric', 'Position', [120 30 200 22]);

    % Resultado
    resultadoArea = uitextarea(fig, 'Position', [410 240 360 160], ...
        'Editable', 'off', 'FontSize', 12, 'FontName', 'Courier New');

    % Gráfica
    ax = uiaxes(fig, 'Position', [50 20 700 140]);
    title(ax, 'Visualización de f(x)');
    xlabel(ax, 'x'); ylabel(ax, 'f(x)');
    fig.UserData.ax = ax;

    % Botones
    uibutton(fig, 'Text', 'CALCULAR', 'Position', [100 180 100 30], ...
        'BackgroundColor', [0.2 0.8 0.2], 'FontWeight', 'bold', ...
        'ButtonPushedFcn', @(btn,event) calcular_limite_callback(fig, tipoDrop, fxField, xField, resultadoArea));

    uibutton(fig, 'Text', 'LIMPIAR', 'Position', [220 180 100 30], ...
        'BackgroundColor', [1.0 0.8 0.2], 'FontWeight', 'bold', ...
        'ButtonPushedFcn', @(btn,event) limpiar_campos({fxField, xField}, resultadoArea));
end

function calcular_limite_callback(fig, tipoDrop, fxField, xField, resultadoArea)
    try
        f_str = fxField.Value;
        f_str = strrep(f_str, '^', '.^');
        f_str = strrep(f_str, '*', '.*');
        f_str = strrep(f_str, '/', './');
        f_str = strrep(f_str, '\\', '.\\');
        fx = str2func(['@(x) ' f_str]);

        opcion = str2double(tipoDrop.Value(1));
        tipos = {'default', 'left', 'right', 'inf', '-inf'};

        if opcion >= 1 && opcion <= 5
            tipo = tipos{opcion};
        else
            uialert(fig, 'Opción inválida.', 'Error');
            return;
        end

        if ismember(opcion, [1,2,3])
            x_val = xField.Value;
        else
            x_val = NaN;
        end

        resultado = funcion_calculo_de_limites(fx, x_val, tipo);
        resultadoArea.Value = {
            'Estado: Cálculo exitoso'
            sprintf('Resultado del límite: %.10f', resultado)
            sprintf('Función: f(x) = %s', fxField.Value)
        };

        % Graficar
        ax = fig.UserData.ax;
        cla(ax);
        x = linspace(-10, 10, 1000);
        y = fx(x);
        plot(ax, x, y, 'b', 'LineWidth', 2);

    catch ME
        uialert(fig, ['Error: ', ME.message], 'Error');
    end
end

function limpiar_campos(campos, resultadoArea)
    for i = 1:numel(campos)
        campos{i}.Value = '';
    end
    resultadoArea.Value = {};
end