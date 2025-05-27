function funcion_potencia_gui()
    fig = uifigure('Name', 'Cálculo de Potencias', 'Position', [500 200 800 520]);

    % Título principal
    uilabel(fig, 'Text', 'CÁLCULO DE FUNCIÓN DE POTENCIA', ...
        'FontSize', 22, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', ...
        'Position', [200 470 400 30]);

    uilabel(fig, 'Text', 'Evalúa funciones de la forma f(x) = x^n u otras potencias', ...
        'FontSize', 14, 'HorizontalAlignment', 'center', ...
        'Position', [200 440 400 20]);

    % Panel de entrada
    entrada = uipanel(fig, 'Title', 'Parámetros de Entrada', 'FontWeight', 'bold', 'Position', [30 260 740 160]);

    uilabel(entrada, 'Text', 'Función f(x):', 'Position', [10 100 100 22]);
    fxField = uieditfield(entrada, 'text', 'Position', [120 100 580 22]);

    uilabel(entrada, 'Text', 'Modo de evaluación:', 'Position', [10 65 130 22]);
    modoDrop = uidropdown(entrada, 'Items', {'1. Un solo valor de x', '2. Un rango de valores'}, 'Position', [150 65 250 22]);

    xLabel = uilabel(entrada, 'Text', 'x =', 'Position', [420 65 30 22]);
    xField = uieditfield(entrada, 'numeric', 'Position', [460 65 240 22]);

    xiLabel = uilabel(entrada, 'Text', 'x inicial:', 'Position', [10 30 70 22], 'Visible', 'off');
    xiField = uieditfield(entrada, 'numeric', 'Position', [80 30 100 22], 'Visible', 'off');

    xfLabel = uilabel(entrada, 'Text', 'x final:', 'Position', [190 30 60 22], 'Visible', 'off');
    xfField = uieditfield(entrada, 'numeric', 'Position', [250 30 100 22], 'Visible', 'off');

    pasosLabel = uilabel(entrada, 'Text', 'Puntos:', 'Position', [360 30 50 22], 'Visible', 'off');
    pasosField = uieditfield(entrada, 'numeric', 'Position', [420 30 70 22], 'Visible', 'off');

    % Resultado
    resultadoArea = uitextarea(fig, 'Position', [410 100 360 140], ...
        'Editable', 'off', 'FontSize', 12, 'FontName', 'Courier New');

    % Gráfica
    ax = uiaxes(fig, 'Position', [50 20 700 80]);
    title(ax, 'Gráfica de f(x)'); xlabel(ax, 'x'); ylabel(ax, 'f(x)');
    fig.UserData.ax = ax;

    % Botones
    uibutton(fig, 'Text', 'CALCULAR', 'Position', [100 140 100 30], ...
        'BackgroundColor', [0.2 0.8 0.2], 'FontWeight', 'bold', ...
        'ButtonPushedFcn', @(btn,event) calcular_potencia(fig, fxField, modoDrop, xField, xiField, xfField, pasosField, resultadoArea));

    uibutton(fig, 'Text', 'LIMPIAR', 'Position', [220 140 100 30], ...
        'BackgroundColor', [1.0 0.8 0.2], 'FontWeight', 'bold', ...
        'ButtonPushedFcn', @(btn,event) limpiar_campos({fxField, xField, xiField, xfField, pasosField}, resultadoArea));

    % Cambio de visibilidad de campos
    modoDrop.ValueChangedFcn = @(src, event) cambiar_visibilidad(src, xLabel, xField, xiLabel, xiField, xfLabel, xfField, pasosLabel, pasosField);
end

function cambiar_visibilidad(src, xLabel, xField, xiLabel, xiField, xfLabel, xfField, pasosLabel, pasosField)
    if strcmp(src.Value, '1. Un solo valor de x')
        xLabel.Visible = 'on';  xField.Visible = 'on';
        xiLabel.Visible = 'off'; xiField.Visible = 'off';
        xfLabel.Visible = 'off'; xfField.Visible = 'off';
        pasosLabel.Visible = 'off'; pasosField.Visible = 'off';
    else
        xLabel.Visible = 'off';  xField.Visible = 'off';
        xiLabel.Visible = 'on'; xiField.Visible = 'on';
        xfLabel.Visible = 'on'; xfField.Visible = 'on';
        pasosLabel.Visible = 'on'; pasosField.Visible = 'on';
    end
end

function calcular_potencia(fig, fxField, modoDrop, xField, xiField, xfField, pasosField, resultadoArea)
    try
        f_str = fxField.Value;
        f_str = strrep(f_str, '^', '.^');
        f_str = strrep(f_str, '*', '.*');
        f_str = strrep(f_str, '/', './');
        fx = str2func(['@(x) ' f_str]);

        ax = fig.UserData.ax;
        cla(ax);

        if strcmp(modoDrop.Value, '1. Un solo valor de x')
            x = xField.Value;
            y = funcion_potencias(fx, x);
            resultadoArea.Value = {sprintf('f(%.4f) = %.4f', x, y)};
            plot(ax, x, y, 'bo', 'MarkerFaceColor', 'b');
        else
            xi = xiField.Value;
            xf = xfField.Value;
            pasos = pasosField.Value;
            x = linspace(xi, xf, pasos);
            y = funcion_potencias(fx, x);
            plot(ax, x, y, 'b-', 'LineWidth', 2);
            resultadoArea.Value = {'Gráfica generada correctamente.'};
        end
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