function Trigonometricas()
    fig = uifigure('Name', 'Funciones Trigonométricas', ...
                   'Position', [100, 100, 1280, 720], ...
                   'Color', [0.1, 0.1, 0.1]);

    % Barra superior azul y título
    uipanel(fig, 'Position', [0, 670, 1280, 50], ...
            'BackgroundColor', [0.22, 0.51, 0.78], 'BorderType', 'none');
    uilabel(fig, 'Text', 'FUNCIONES TRIGONOMÉTRICAS', ...
        'Position', [0, 670, 1280, 50], ...
        'FontSize', 26, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', ...
        'BackgroundColor', 'none', ...
        'FontColor', 'white');

    % Panel de explicación
    panel_explicacion = uipanel(fig, 'Title', 'EXPLICACIÓN', ...
        'Position', [30, 600, 1220, 60], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.13, 0.13, 0.13], ...
        'ForegroundColor', [0.3, 0.6, 1]);
    texto_explicacion = uitextarea(panel_explicacion, ...
        'Position', [10, 10, 1200, 30], ...
        'Editable', 'off', ...
        'FontSize', 12, ...
        'FontColor', 'white', ...
        'BackgroundColor', [0.18, 0.18, 0.18], ...
        'Value', {'Seleccione el tipo de función trigonométrica y proporcione el valor requerido.'});

    % Panel de selección de tipo de función
    panel_tipo = uipanel(fig, 'Title', 'TIPO DE FUNCIÓN', ...
        'Position', [30, 530, 400, 60], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.13, 0.13, 0.13], ...
        'ForegroundColor', [0.3, 0.6, 1]);
    tipos = {'Básicas', 'Inversas', 'Recíprocas'};
    dropdown_tipo = uidropdown(panel_tipo, ...
        'Position', [20, 10, 360, 30], ...
        'Items', tipos, ...
        'FontSize', 13, ...
        'Value', tipos{1}, ...
        'BackgroundColor', [0.2, 0.2, 0.2], ...
        'FontColor', 'white', ...
        'ValueChangedFcn', @(src,evt) actualizar_campos());

    % Panel de ingreso de datos
    panel_datos = uipanel(fig, 'Title', 'INGRESO DE DATOS', ...
        'Position', [30, 300, 600, 210], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.13, 0.13, 0.13], ...
        'ForegroundColor', [0.3, 0.6, 1]);
    campos = {};

    btn_calcular = uibutton(panel_datos, 'Text', 'CALCULAR', ...
        'Position', [300, 10, 120, 30], ...
        'FontSize', 12, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.3, 0.7, 0.3], ...
        'FontColor', 'white', ...
        'ButtonPushedFcn', @(btn,event) calcular());

    % Panel de resultados
    panel_resultados = uipanel(fig, 'Title', 'RESULTADOS', ...
        'Position', [650, 300, 570, 210], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.13, 0.13, 0.13], ...
        'ForegroundColor', [0.3, 0.6, 1]);
    texto_resultados = uitextarea(panel_resultados, ...
        'Position', [10, 10, 550, 170], ...
        'Editable', 'off', ...
        'FontSize', 13, ...
        'FontColor', 'white', ...
        'BackgroundColor', [0.18, 0.18, 0.18]);

    % Panel de gráfica
    panel_grafica = uipanel(fig, 'Title', '', ...
        'Position', [30, 30, 1220, 250], ...
        'BackgroundColor', [0.13, 0.13, 0.13], ...
        'ForegroundColor', [0.3, 0.6, 1]);
    axes_grafica = uiaxes(panel_grafica, ...
        'Position', [40, 30, 1140, 190], ...
        'BackgroundColor', [0.18, 0.18, 0.18], ...
        'XColor', 'white', 'YColor', 'white', ...
        'FontSize', 13);
    text(axes_grafica, 0.5, 0.5, 'GRAFICA', ...
        'Units', 'normalized', ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 20, 'Color', [1 1 1 0.2]);

    actualizar_campos();

    function actualizar_campos()
        if ~isempty(campos)
            for i = 1:length(campos)
                if isvalid(campos{i})
                    delete(campos{i});
                end
            end
        end
        campos = {};
        tipo = dropdown_tipo.Value;
        y = 160;
        dy = 40;

        switch tipo
            case 'Básicas'
                campos{1} = uilabel(panel_datos, 'Text', 'Ángulo (grados):', ...
                    'Position', [20, y, 120, 25], 'FontColor', 'white');
                campos{2} = uieditfield(panel_datos, 'numeric', ...
                    'Position', [150, y, 120, 25], 'FontColor', 'white', ...
                    'BackgroundColor', [0.2, 0.2, 0.2]);
            case 'Inversas'
                campos{1} = uilabel(panel_datos, 'Text', 'Seleccione función:', ...
                    'Position', [20, y, 140, 25], 'FontColor', 'white');
                campos{2} = uidropdown(panel_datos, ...
                    'Items', {'arcsin', 'arccos', 'arctan'}, ...
                    'Position', [170, y, 120, 25], ...
                    'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
                y = y - dy;
                campos{3} = uilabel(panel_datos, 'Text', 'Valor:', ...
                    'Position', [20, y, 120, 25], 'FontColor', 'white');
                campos{4} = uieditfield(panel_datos, 'numeric', ...
                    'Position', [150, y, 120, 25], 'FontColor', 'white', ...
                    'BackgroundColor', [0.2, 0.2, 0.2]);
            case 'Recíprocas'
                campos{1} = uilabel(panel_datos, 'Text', 'Ángulo (grados):', ...
                    'Position', [20, y, 120, 25], 'FontColor', 'white');
                campos{2} = uieditfield(panel_datos, 'numeric', ...
                    'Position', [150, y, 120, 25], 'FontColor', 'white', ...
                    'BackgroundColor', [0.2, 0.2, 0.2]);
        end
        cla(axes_grafica);
        texto_resultados.Value = {''};
    end

    function calcular()
        tipo = dropdown_tipo.Value;
        cla(axes_grafica);
        texto_resultados.Value = {''};

        switch tipo
            case 'Básicas'
                angulo = campos{2}.Value;
                anguloRad = angulo * pi / 180;
                valorSeno = sin(anguloRad);
                valorCoseno = cos(anguloRad);
                valorTangente = tan(anguloRad);
                texto_resultados.Value = { ...
                    sprintf('Ángulo: %.2f grados (%.4f radianes)', angulo, anguloRad), ...
                    sprintf('Seno: %.6f', valorSeno), ...
                    sprintf('Coseno: %.6f', valorCoseno), ...
                    sprintf('Tangente: %.6f', valorTangente)};
                graficarFunciones_gui('basicas', anguloRad, axes_grafica);

            case 'Inversas'
                funcion = campos{2}.Value;
                valor = campos{4}.Value;
                switch funcion
                    case 'arcsin'
                        if valor >= -1 && valor <= 1
                            resultado = asin(valor);
                            resultadoGrados = resultado * 180 / pi;
                            texto_resultados.Value = { ...
                                sprintf('arcsin(%.4f) = %.4f rad = %.2f°', valor, resultado, resultadoGrados)};
                        else
                            texto_resultados.Value = {'Error: El valor debe estar entre -1 y 1.'};
                            return;
                        end
                    case 'arccos'
                        if valor >= -1 && valor <= 1
                            resultado = acos(valor);
                            resultadoGrados = resultado * 180 / pi;
                            texto_resultados.Value = { ...
                                sprintf('arccos(%.4f) = %.4f rad = %.2f°', valor, resultado, resultadoGrados)};
                        else
                            texto_resultados.Value = {'Error: El valor debe estar entre -1 y 1.'};
                            return;
                        end
                    case 'arctan'
                        resultado = atan(valor);
                        resultadoGrados = resultado * 180 / pi;
                        texto_resultados.Value = { ...
                            sprintf('arctan(%.4f) = %.4f rad = %.2f°', valor, resultado, resultadoGrados)};
                end
                graficarFunciones_gui('inversas', 0, axes_grafica);

            case 'Recíprocas'
                angulo = campos{2}.Value;
                anguloRad = angulo * pi / 180;
                valorSeno = sin(anguloRad);
                valorCoseno = cos(anguloRad);
                valorTangente = tan(anguloRad);

                if abs(valorSeno) > 1e-10
                    valorCosecante = 1/valorSeno;
                    cosecanteStr = num2str(valorCosecante, '%.6f');
                else
                    cosecanteStr = 'Indefinido (seno = 0)';
                end
                if abs(valorCoseno) > 1e-10
                    valorSecante = 1/valorCoseno;
                    secanteStr = num2str(valorSecante, '%.6f');
                else
                    secanteStr = 'Indefinido (coseno = 0)';
                end
                if abs(valorTangente) > 1e-10 && abs(valorSeno) > 1e-10
                    valorCotangente = 1/valorTangente;
                    cotangenteStr = num2str(valorCotangente, '%.6f');
                else
                    cotangenteStr = 'Indefinido';
                end
                texto_resultados.Value = { ...
                    sprintf('Ángulo: %.2f grados (%.4f radianes)', angulo, anguloRad), ...
                    sprintf('sen(%.2f°) = %.6f', angulo, valorSeno), ...
                    sprintf('cos(%.2f°) = %.6f', angulo, valorCoseno), ...
                    sprintf('tan(%.2f°) = %.6f', angulo, valorTangente), ...
                    sprintf('csc(%.2f°) = %s', angulo, cosecanteStr), ...
                    sprintf('sec(%.2f°) = %s', angulo, secanteStr), ...
                    sprintf('cot(%.2f°) = %s', angulo, cotangenteStr)};
                graficarFunciones_gui('reciprocas', anguloRad, axes_grafica);
        end
    end

    function graficarFunciones_gui(tipo, angulo, ax)
        % Esta función es una versión adaptada para graficar en el uiaxes del GUI
        axes(ax);
        cla(ax);
        switch tipo
            case 'basicas'
                x = linspace(-2*pi, 2*pi, 1000);
                plot(ax, x, sin(x), 'b-', 'LineWidth', 2); hold(ax, 'on');
                plot(ax, angulo, sin(angulo), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
                title(ax, 'Función Seno');
                xlabel(ax, 'x (radianes)');
                ylabel(ax, 'sen(x)');
                grid(ax, 'on');
                % Coseno
                figure; % Nueva figura para coseno y tangente
                subplot(2,1,1);
                plot(x, cos(x), 'g-', 'LineWidth', 2); hold on;
                plot(angulo, cos(angulo), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
                title('Función Coseno');
                xlabel('x (radianes)');
                ylabel('cos(x)');
                grid on;
                subplot(2,1,2);
                y = tan(x); y(abs(y) > 10) = NaN;
                plot(x, y, 'r-', 'LineWidth', 2); hold on;
                plot(angulo, tan(angulo), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
                title('Función Tangente');
                xlabel('x (radianes)');
                ylabel('tan(x)');
                ylim([-10 10]);
                grid on;
            case 'inversas'
                x1 = linspace(-1, 1, 1000);
                plot(ax, x1, asin(x1), 'b-', 'LineWidth', 2);
                title(ax, 'Función Arcoseno');
                xlabel(ax, 'x');
                ylabel(ax, 'arcsin(x)');
                grid(ax, 'on');
                % Coseno y tangente inversa en nueva figura
                figure;
                subplot(2,1,1);
                plot(x1, acos(x1), 'g-', 'LineWidth', 2);
                title('Función Arcocoseno');
                xlabel('x');
                ylabel('arccos(x)');
                grid on;
                x2 = linspace(-5, 5, 1000);
                subplot(2,1,2);
                plot(x2, atan(x2), 'r-', 'LineWidth', 2);
                title('Función Arcotangente');
                xlabel('x');
                ylabel('arctan(x)');
                grid on;
            case 'reciprocas'
                x = linspace(-2*pi, 2*pi, 1000);
                y1 = 1./sin(x); y1(abs(y1) > 10) = NaN;
                plot(ax, x, y1, 'b-', 'LineWidth', 2); hold(ax, 'on');
                if abs(sin(angulo)) > 1e-10
                    plot(ax, angulo, 1/sin(angulo), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
                end
                title(ax, 'Función Cosecante (csc = 1/sen)');
                xlabel(ax, 'x (radianes)');
                ylabel(ax, 'csc(x)');
                ylim(ax, [-10 10]);
                grid(ax, 'on');
                % Secante y cotangente en nueva figura
                figure;
                subplot(2,1,1);
                y2 = 1./cos(x); y2(abs(y2) > 10) = NaN;
                plot(x, y2, 'g-', 'LineWidth', 2); hold on;
                if abs(cos(angulo)) > 1e-10
                    plot(angulo, 1/cos(angulo), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
                end
                title('Función Secante (sec = 1/cos)');
                xlabel('x (radianes)');
                ylabel('sec(x)');
                ylim([-10 10]);
                grid on;
                subplot(2,1,2);
                y3 = 1./tan(x); y3(abs(y3) > 10) = NaN;
                plot(x, y3, 'r-', 'LineWidth', 2); hold on;
                if abs(tan(angulo)) > 1e-10 && abs(sin(angulo)) > 1e-10
                    plot(angulo, 1/tan(angulo), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
                end
                title('Función Cotangente (cot = 1/tan)');
                xlabel('x (radianes)');
                ylabel('cot(x)');
                ylim([-10 10]);
                grid on;
        end
    end
end