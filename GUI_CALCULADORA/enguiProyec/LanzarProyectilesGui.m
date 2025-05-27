function LanzarProyectilesGui()
    fig = uifigure('Name', 'Calculadora de Lanzamiento de Proyectiles', ...
                   'Position', [100, 100, 1280, 720], ...
                   'Color', [0.1, 0.1, 0.1]);

    % Barra superior azul y título
    uipanel(fig, 'Position', [0, 670, 1280, 50], ...
            'BackgroundColor', [0.22, 0.51, 0.78], 'BorderType', 'none');
    uilabel(fig, 'Text', 'CALCULADORA DE LANZAMIENTO DE PROYECTILES', ...
        'Position', [0, 670, 1280, 50], ...
        'FontSize', 26, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', ...
        'BackgroundColor', 'none', ...
        'FontColor', 'white');

    % Panel de explicación
    panel_explicacion = uipanel(fig, 'Title', 'EXPLICACION DE LA FUNCION O METODO', ...
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
        'Value', {'Seleccione una opción y complete los datos para calcular el movimiento parabólico de un proyectil.'});

    % Panel de selección de opción
    panel_opciones = uipanel(fig, 'Title', 'OPCIONES', ...
        'Position', [30, 530, 400, 60], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.13, 0.13, 0.13], ...
        'ForegroundColor', [0.3, 0.6, 1]);
    opciones = {'Calcular alcance horizontal', ...
                'Calcular altura máxima', ...
                'Calcular tiempo de vuelo', ...
                'Calcular posición en un instante dado'};
    dropdown_opciones = uidropdown(panel_opciones, ...
        'Position', [20, 10, 360, 30], ...
        'Items', opciones, ...
        'FontSize', 13, ...
        'Value', opciones{1}, ...
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
        'Position', [20, 10, 120, 30], ...
        'FontSize', 12, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.3, 0.7, 0.3], ...
        'FontColor', 'white', ...
        'ButtonPushedFcn', @(btn,event) calcular());

    % Panel de resultados
    panel_resultados = uipanel(fig, 'Title', 'RESULTADOS', ...
        'Position', [650, 300, 400, 210], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.13, 0.13, 0.13], ...
        'ForegroundColor', [0.3, 0.6, 1]);
    texto_resultados = uitextarea(panel_resultados, ...
        'Position', [10, 10, 380, 170], ...
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
        opcion = dropdown_opciones.Value;
        y = 160;
        dy = 40;

        campos{1} = uilabel(panel_datos, 'Text', 'Velocidad inicial (m/s):', ...
            'Position', [20, y, 150, 25], 'FontColor', 'white');
        campos{2} = uieditfield(panel_datos, 'numeric', ...
            'Position', [180, y, 100, 25], 'Value', 10, ...
            'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
        y = y - dy;
        campos{3} = uilabel(panel_datos, 'Text', 'Ángulo (grados):', ...
            'Position', [20, y, 150, 25], 'FontColor', 'white');
        campos{4} = uieditfield(panel_datos, 'numeric', ...
            'Position', [180, y, 100, 25], 'Value', 45, ...
            'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
        y = y - dy;
        campos{5} = uilabel(panel_datos, 'Text', 'Altura inicial (m):', ...
            'Position', [20, y, 150, 25], 'FontColor', 'white');
        campos{6} = uieditfield(panel_datos, 'numeric', ...
            'Position', [180, y, 100, 25], 'Value', 0, ...
            'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
        if strcmp(opcion, 'Calcular posición en un instante dado')
            y = y - dy;
            campos{7} = uilabel(panel_datos, 'Text', 'Tiempo (s):', ...
                'Position', [20, y, 150, 25], 'FontColor', 'white');
            campos{8} = uieditfield(panel_datos, 'numeric', ...
                'Position', [180, y, 100, 25], 'Value', 1, ...
                'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
        end
    end

    function calcular()
        opcion = dropdown_opciones.Value;
        v0 = campos{2}.Value;
        angulo_grad = campos{4}.Value;
        h0 = campos{6}.Value;
        g = 9.8;
        angulo = angulo_grad * pi / 180;
        v0x = v0 * cos(angulo);
        v0y = v0 * sin(angulo);
        cla(axes_grafica);
        texto_resultados.Value = {''};

        switch opcion
            case 'Calcular alcance horizontal'
                if h0 == 0
                    alcance = (v0^2 * sin(2*angulo)) / g;
                    tiempo_vuelo = 2 * v0y / g;
                else
                    a = 0.5 * g;
                    b = -v0y;
                    c = h0;
                    discriminante = b^2 - 4*a*c;
                    t1 = (-b + sqrt(discriminante))/(2*a);
                    t2 = (-b - sqrt(discriminante))/(2*a);
                    tiempos_positivos = [t1, t2];
                    tiempos_positivos = tiempos_positivos(tiempos_positivos > 0);
                    if isempty(tiempos_positivos)
                        texto_resultados.Value = {'No hay solución con tiempo positivo.'};
                        return;
                    end
                    tiempo_vuelo = max(tiempos_positivos);
                    alcance = v0x * tiempo_vuelo;
                end
                texto_resultados.Value = {sprintf('Alcance horizontal: %.2f m', alcance), ...
                                          sprintf('Tiempo de vuelo: %.2f s', tiempo_vuelo)};
                t = linspace(0, tiempo_vuelo, 100);
                x = v0x * t;
                y_tray = h0 + v0y * t - 0.5 * g * t.^2;
                plot(axes_grafica, x, y_tray, 'b-', 'LineWidth', 2);
                xlabel(axes_grafica, 'Distancia X (m)');
                ylabel(axes_grafica, 'Altura Y (m)');
                title(axes_grafica, 'Trayectoria del proyectil', 'Color', 'white');
                grid(axes_grafica, 'on');

            case 'Calcular altura máxima'
                tiempo_altura_maxima = v0y / g;
                if h0 == 0
                    tiempo_vuelo = 2 * v0y / g;
                else
                    a = 0.5 * g;
                    b = -v0y;
                    c = h0;
                    discriminante = b^2 - 4*a*c;
                    t1 = (-b + sqrt(discriminante))/(2*a);
                    t2 = (-b - sqrt(discriminante))/(2*a);
                    tiempos_positivos = [t1, t2];
                    tiempos_positivos = tiempos_positivos(tiempos_positivos > 0);
                    if isempty(tiempos_positivos)
                        texto_resultados.Value = {'No hay solución con tiempo positivo.'};
                        return;
                    end
                    tiempo_vuelo = max(tiempos_positivos);
                end
                if tiempo_altura_maxima > 0 && tiempo_altura_maxima < tiempo_vuelo
                    altura_maxima = h0 + v0y^2 / (2*g);
                    x_altura_maxima = v0x * tiempo_altura_maxima;
                else
                    altura_maxima = h0;
                    x_altura_maxima = 0;
                end
                texto_resultados.Value = {sprintf('Altura máxima: %.2f m', altura_maxima), ...
                                         sprintf('Tiempo hasta altura máxima: %.2f s', tiempo_altura_maxima), ...
                                         sprintf('Posición horizontal en altura máxima: %.2f m', x_altura_maxima)};
                t = linspace(0, tiempo_vuelo, 100);
                x = v0x * t;
                y_tray = h0 + v0y * t - 0.5 * g * t.^2;
                plot(axes_grafica, x, y_tray, 'g-', 'LineWidth', 2);
                hold(axes_grafica, 'on');
                plot(axes_grafica, x_altura_maxima, altura_maxima, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
                hold(axes_grafica, 'off');
                xlabel(axes_grafica, 'Distancia X (m)');
                ylabel(axes_grafica, 'Altura Y (m)');
                title(axes_grafica, 'Trayectoria y altura máxima', 'Color', 'white');
                grid(axes_grafica, 'on');

            case 'Calcular tiempo de vuelo'
                if h0 == 0 && v0y <= 0
                    tiempo_vuelo = 0;
                elseif h0 == 0
                    tiempo_vuelo = 2 * v0y / g;
                else
                    a = 0.5 * g;
                    b = -v0y;
                    c = h0;
                    discriminante = b^2 - 4*a*c;
                    t1 = (-b + sqrt(discriminante))/(2*a);
                    t2 = (-b - sqrt(discriminante))/(2*a);
                    tiempos_positivos = [t1, t2];
                    tiempos_positivos = tiempos_positivos(tiempos_positivos > 0);
                    if isempty(tiempos_positivos)
                        texto_resultados.Value = {'No hay solución con tiempo positivo.'};
                        return;
                    end
                    tiempo_vuelo = max(tiempos_positivos);
                end
                alcance = v0x * tiempo_vuelo;
                tiempo_altura_maxima = v0y / g;
                if tiempo_altura_maxima > 0 && tiempo_altura_maxima < tiempo_vuelo
                    altura_maxima = h0 + v0y^2 / (2*g);
                else
                    altura_maxima = h0;
                end
                texto_resultados.Value = {sprintf('Tiempo de vuelo: %.2f s', tiempo_vuelo), ...
                                         sprintf('Alcance horizontal: %.2f m', alcance), ...
                                         sprintf('Altura máxima: %.2f m', altura_maxima)};
                t = linspace(0, tiempo_vuelo, 100);
                x = v0x * t;
                y_tray = h0 + v0y * t - 0.5 * g * t.^2;
                plot(axes_grafica, x, y_tray, 'm-', 'LineWidth', 2);
                xlabel(axes_grafica, 'Distancia X (m)');
                ylabel(axes_grafica, 'Altura Y (m)');
                title(axes_grafica, 'Trayectoria del proyectil', 'Color', 'white');
                grid(axes_grafica, 'on');

            case 'Calcular posición en un instante dado'
                t = campos{8}.Value;
                x = v0x * t;
                y = h0 + v0y * t - 0.5 * g * t^2;
                texto_resultados.Value = {sprintf('Posición en t = %.2f s:', t), ...
                                         sprintf('Coordenada X: %.2f m', x), ...
                                         sprintf('Coordenada Y: %.2f m', y)};
                % Trayectoria hasta ese instante
                t_vec = linspace(0, t, 100);
                x_vec = v0x * t_vec;
                y_vec = h0 + v0y * t_vec - 0.5 * g * t_vec.^2;
                plot(axes_grafica, x_vec, y_vec, 'c-', 'LineWidth', 2);
                hold(axes_grafica, 'on');
                plot(axes_grafica, x, y, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
                hold(axes_grafica, 'off');
                xlabel(axes_grafica, 'Distancia X (m)');
                ylabel(axes_grafica, 'Altura Y (m)');
                title(axes_grafica, 'Posición en el tiempo dado', 'Color', 'white');
                grid(axes_grafica, 'on');
        end
    end
end