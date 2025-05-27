function calculo_areas_gui()
    fig = uifigure('Name', 'Cálculo de Áreas', 'Position', [500 200 800 500]);

    % Título principal
    uilabel(fig, 'Text', 'CÁLCULO DE ÁREAS', ...
        'FontSize', 22, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', ...
        'Position', [200 440 400 30]);

    uilabel(fig, 'Text', 'Encuentra el área bajo una curva o entre dos funciones', ...
        'FontSize', 14, ...
        'HorizontalAlignment', 'center', ...
        'Position', [200 410 400 20]);

    % Panel de entrada
    entrada = uipanel(fig, 'Title', 'Parámetros de Entrada', ...
        'FontWeight', 'bold', ...
        'Position', [30 240 350 160]);

    uilabel(entrada, 'Text', 'Función f(x):', 'Position', [10 100 100 22]);
    fxField = uieditfield(entrada, 'text', 'Position', [120 100 200 22]);

    uilabel(entrada, 'Text', 'Límite inferior (a):', 'Position', [10 70 120 22]);
    aField = uieditfield(entrada, 'numeric', 'Position', [120 70 200 22]);

    uilabel(entrada, 'Text', 'Límite superior (b):', 'Position', [10 40 120 22]);
    bField = uieditfield(entrada, 'numeric', 'Position', [120 40 200 22]);

    uilabel(entrada, 'Text', 'Función g(x) (opcional):', 'Position', [10 10 140 22]);
    gxField = uieditfield(entrada, 'text', 'Position', [150 10 170 22]);

    % Resultado
    resultadoArea = uitextarea(fig, ...
        'Position', [410 240 360 160], ...
        'Editable', 'off', ...
        'FontSize', 12, ...
        'FontName', 'Courier New');

    % Gráfica
    ax = uiaxes(fig, 'Position', [50 20 700 140]);
    title(ax, 'Visualización del Área');
    xlabel(ax, 'x');
    ylabel(ax, 'f(x)');
    fig.UserData.ax = ax;

    % Botones
    uibutton(fig, 'Text', 'CALCULAR', ...
        'Position', [100 180 100 30], ...
        'BackgroundColor', [0.2 0.8 0.2], ...
        'FontWeight', 'bold', ...
        'ButtonPushedFcn', @(btn,event) calcular_area_callback(fig, fxField, aField, bField, gxField, resultadoArea));

    uibutton(fig, 'Text', 'LIMPIAR', ...
        'Position', [220 180 100 30], ...
        'BackgroundColor', [1.0 0.8 0.2], ...
        'FontWeight', 'bold', ...
        'ButtonPushedFcn', @(btn,event) limpiar_campos({fxField, aField, bField, gxField}, resultadoArea));
end

function calcular_area_callback(fig, fxField, aField, bField, gxField, resultadoArea)
    try
        f_str = fxField.Value;
        a = aField.Value;
        b = bField.Value;
        g_str = gxField.Value;

        % Vectorizar operadores
        f_str = strrep(f_str, '^', '.^');
        f_str = strrep(f_str, '*', '.*');
        f_str = strrep(f_str, '/', './');
        fx = str2func(['@(x) ' f_str]);

        % Función g(x) opcional
        if isempty(g_str)
            gx = [];
        else
            g_str = strrep(g_str, '^', '.^');
            g_str = strrep(g_str, '*', '.*');
            g_str = strrep(g_str, '/', './');
            gx = str2func(['@(x) ' g_str]);
        end

        % Calcular área
        area = funcion_calculo_de_areas(fx, a, b, gx);
        resultadoArea.Value = {
            sprintf('Estado: Cálculo exitoso')
            sprintf('Área aproximada = %.10f', area)
            sprintf('Límites: a = %.4f, b = %.4f', a, b)
            sprintf('Función: f(x) = %s', fxField.Value)
        };

        % Graficar
        ax = fig.UserData.ax;
        cla(ax);
        x = linspace(a, b, 1000);
        y1 = fx(x);

        plot(ax, x, y1, 'b', 'LineWidth', 2); hold(ax, 'on');

        if ~isempty(gx)
            y2 = gx(x);
            plot(ax, x, y2, 'r--', 'LineWidth', 2);
            fill(ax, [x, fliplr(x)], [y1, fliplr(y2)], 'c', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
        else
            fill(ax, [x, fliplr(x)], [zeros(size(y1)), fliplr(y1)], 'c', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
        end

        hold(ax, 'off');

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
