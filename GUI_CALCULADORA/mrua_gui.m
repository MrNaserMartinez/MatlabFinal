function mrua_gui()
    fig = uifigure('Name', 'Calculadora MRUA', 'Position', [500 200 800 550]);

    % Título principal
    uilabel(fig, 'Text', 'CÁLCULO DE MRUA', ...
        'FontSize', 22, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', 'Position', [200 500 400 30]);

    uilabel(fig, 'Text', 'Ingresa los datos conocidos. Deja en blanco los que no sepas.', ...
        'FontSize', 14, 'HorizontalAlignment', 'center', ...
        'Position', [200 470 400 20]);

    % Panel de entrada (aumentado en altura)
    entrada = uipanel(fig, 'Title', 'Parámetros de Entrada', ...
        'FontWeight', 'bold', 'Position', [30 240 350 200]);

    labels = {'x₀:', 'x:', 'v₀:', 'v:', 'a:', 't:'};
    campos = cell(1, numel(labels));
    y = 150;
    for i = 1:numel(labels)
        uilabel(entrada, 'Text', labels{i}, 'Position', [10 y 40 22]);
        campos{i} = uieditfield(entrada, 'text', 'Position', [60 y 260 22]);
        y = y - 30;
    end

    % Resultado
    resultadoPanel = uitextarea(fig, 'Position', [410 240 360 160], ...
        'Editable', 'off', 'FontSize', 12, 'FontName', 'Courier New');

    % Gráfica
    ax = uiaxes(fig, 'Position', [50 20 700 100]);
    title(ax, 'Visualización de Movimiento');
    xlabel(ax, 't'); ylabel(ax, 'posición / velocidad');
    fig.UserData.ax = ax;

    % Botones
    uibutton(fig, 'Text', 'CALCULAR', 'Position', [100 180 100 30], ...
        'BackgroundColor', [0.2 0.8 0.2], 'FontWeight', 'bold', ...
        'ButtonPushedFcn', @(btn,event) calcular_mrua(campos, resultadoPanel, fig));

    uibutton(fig, 'Text', 'LIMPIAR', 'Position', [220 180 100 30], ...
        'BackgroundColor', [1.0 0.8 0.2], 'FontWeight', 'bold', ...
        'ButtonPushedFcn', @(btn,event) limpiar_campos(campos, resultadoPanel));
end

function calcular_mrua(campos, resultadoPanel, fig)
    try
        valores = NaN(1,6);
        for i = 1:6
            texto = campos{i}.Value;
            if ~isempty(texto)
                valores(i) = str2double(texto);
            end
        end
        x0 = valores(1); x = valores(2); v0 = valores(3);
        v  = valores(4); a  = valores(5); t  = valores(6);

        resultado = funcion_movimiento_rectilineo(x0, x, v0, v, a, t);

        camposStr = fieldnames(resultado);
        txt = "";
        for i = 1:numel(camposStr)
            val = resultado.(camposStr{i});
            if ~isnan(val)
                txt = txt + sprintf('%s = %.5f\n', camposStr{i}, val);
            end
        end
        resultadoPanel.Value = splitlines(strtrim(txt));

        graficar_mrua_general(resultado, fig.UserData.ax);

    catch ME
        uialert(fig, ['Error: ', ME.message], 'Error');
    end
end

function limpiar_campos(campos, resultadoPanel)
    for i = 1:numel(campos)
        campos{i}.Value = '';
    end
    resultadoPanel.Value = {};
end
