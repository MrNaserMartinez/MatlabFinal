function raices_multiples_gui()
    fig = uifigure('Name', 'Método de Raíces Múltiples', 'Position', [500 200 800 600]);

    % Título principal
    uilabel(fig, 'Text', 'MÉTODO DE RAÍCES MÚLTIPLES', ...
        'FontSize', 22, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', 'Position', [200 550 400 30]);

    % Panel de entrada
    entrada = uipanel(fig, 'Title', 'Parámetros de Entrada', 'FontWeight', 'bold', 'Position', [30 300 350 160]);

    uilabel(entrada, 'Text', 'f(x):', 'Position', [10 100 80 22]);
    fxField = uieditfield(entrada, 'text', 'Position', [90 100 230 22]);

    uilabel(entrada, 'Text', 'x₀:', 'Position', [10 70 80 22]);
    x0Field = uieditfield(entrada, 'numeric', 'Position', [90 70 230 22]);

    uilabel(entrada, 'Text', 'Tolerancia:', 'Position', [10 40 80 22]);
    tolField = uieditfield(entrada, 'numeric', 'Position', [90 40 230 22]);

    uilabel(entrada, 'Text', 'Máx. iteraciones:', 'Position', [10 10 110 22]);
    iterField = uieditfield(entrada, 'numeric', 'Position', [130 10 190 22]);

    % Panel de resultados numéricos
    resultadoPanel = uitextarea(fig, 'Position', [410 410 360 50], ...
        'Editable', 'off', 'FontSize', 12, 'FontName', 'Courier New');
    fig.UserData.resultadoPanel = resultadoPanel;

    % Tabla de resultados
    tablaResultados = uitable(fig, 'Position', [410 240 360 160], ...
        'ColumnName', {'Iter', 'x', 'f(x)', 'Error'}, 'RowName', []);
    fig.UserData.tablaResultados = tablaResultados;

    % Gráfica
    ax = uiaxes(fig, 'Position', [50 20 700 180]);
    title(ax, 'Visualización del Método');
    xlabel(ax, 'Iteración'); ylabel(ax, 'Valor');
    fig.UserData.ax = ax;

    % Botones
    uibutton(fig, 'Text', 'CALCULAR', 'Position', [100 250 100 30], ...
        'BackgroundColor', [0.2 0.8 0.2], 'FontWeight', 'bold', ...
        'ButtonPushedFcn', @(btn,event) calcular_mrm(fxField, x0Field, tolField, iterField, fig));

    uibutton(fig, 'Text', 'LIMPIAR', 'Position', [220 250 100 30], ...
        'BackgroundColor', [1.0 0.8 0.2], 'FontWeight', 'bold', ...
        'ButtonPushedFcn', @(btn,event) limpiar_campos({fxField, x0Field, tolField, iterField}, fig.UserData.tablaResultados, fig.UserData.resultadoPanel));
end

function calcular_mrm(fxField, x0Field, tolField, iterField, fig)
    try
        f_str = lower(fxField.Value);
        f_str = strrep(f_str, '^', '.^');
        f_str = strrep(f_str, '*', '.*');
        f_str = strrep(f_str, '/', './');
        f = str2func(['@(x) ' f_str]);

        x0 = x0Field.Value;
        tol = tolField.Value;
        maxIter = iterField.Value;

        [root, success, iter_data] = funcion_mrm(f, x0, tol, maxIter);

        % Mostrar tabla en el componente visual
        tablaCell = num2cell(iter_data);
        fig.UserData.tablaResultados.Data = tablaCell;

        % Mostrar resultado
        if success
            fig.UserData.resultadoPanel.Value = {
                sprintf('Raíz aproximada: %.10f', root)
                sprintf('Iteraciones: %d', size(iter_data, 1))
            };
        else
            fig.UserData.resultadoPanel.Value = {
                sprintf('No convergió en %d iteraciones.', maxIter)
            };
        end

        % Graficar
        graficar_mrm(f, iter_data, f_str, fig.UserData.ax);

    catch ME
        uialert(fig, ['Error: ', ME.message], 'Error');
    end
end

function limpiar_campos(campos, tablaResultados, resultadoPanel)
    for i = 1:numel(campos)
        campos{i}.Value = '';
    end
    tablaResultados.Data = {};
    resultadoPanel.Value = {};
end
