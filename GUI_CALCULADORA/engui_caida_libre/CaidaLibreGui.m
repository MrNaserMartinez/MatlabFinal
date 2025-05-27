function CaidaLibreGui()
    % GUI para la calculadora de caída libre y tiro vertical

    fig = uifigure('Name', 'Calculadora de Caída Libre y Tiro Vertical', ...
                   'Position', [100, 100, 1280, 720], ...
                   'Color', [0.1, 0.1, 0.1]);

    % Barra superior azul y título
    uipanel(fig, 'Position', [0, 670, 1280, 50], ...
            'BackgroundColor', [0.22, 0.51, 0.78], 'BorderType', 'none');
    uilabel(fig, 'Text', 'CALCULADORA DE CAÍDA LIBRE Y TIRO VERTICAL', ...
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
        'Value', {'Seleccione una opción y complete los datos para calcular caída libre o tiro vertical.'});

    % Panel de selección de opción
    panel_opciones = uipanel(fig, 'Title', 'OPCIONES', ...
        'Position', [30, 530, 400, 60], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.13, 0.13, 0.13], ...
        'ForegroundColor', [0.3, 0.6, 1]);
    opciones = {'Calcular tiempo de caída', ...
                'Calcular velocidad de impacto', ...
                'Calcular altura máxima (tiro vertical)', ...
                'Calcular altura después de cierto tiempo'};
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
        'Position', [30, 300, 600, 210], ... % <-- Ampliado y desplazado hacia abajo
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.13, 0.13, 0.13], ...
        'ForegroundColor', [0.3, 0.6, 1]);
    campos = {}; % Para almacenar los campos dinámicos

    btn_calcular = uibutton(panel_datos, 'Text', 'CALCULAR', ...
        'Position', [20, 10, 120, 30], ...
        'FontSize', 12, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.3, 0.7, 0.3], ...
        'FontColor', 'white', ...
        'ButtonPushedFcn', @(btn,event) calcular());

    % Panel de resultados
    panel_resultados = uipanel(fig, 'Title', 'RESULTADOS', ...
        'Position', [650, 300, 400, 210], ... % <-- Ajustado para alinearse con el panel de datos
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
        'Position', [30, 30, 1220, 250], ... % <-- Más pequeño y abajo
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

    % Inicializar campos
    actualizar_campos();

    % --- Función para actualizar los campos de entrada según la opción ---
    function actualizar_campos()
        % Eliminar campos anteriores
        if ~isempty(campos)
            for i = 1:length(campos)
                if isvalid(campos{i})
                    delete(campos{i});
                end
            end
        end
        campos = {};
        opcion = dropdown_opciones.Value;
        y = 160; % Start near the top of the panel (panel height is 210)
        dy = 40; % Vertical spacing between fields

        switch opcion
            case 'Calcular tiempo de caída'
                campos{1} = uilabel(panel_datos, 'Text', 'Altura inicial (m):', ...
                    'Position', [20, y, 120, 25], 'FontColor', 'white');
                campos{2} = uieditfield(panel_datos, 'numeric', ...
                    'Position', [150, y, 100, 25], 'Value', 10, ...
                    'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
                y = y - dy;
                campos{3} = uilabel(panel_datos, 'Text', '¿Velocidad inicial?', ...
                    'Position', [20, y, 120, 25], 'FontColor', 'white');
                campos{4} = uidropdown(panel_datos, 'Items', {'No', 'Sí'}, ...
                    'Position', [150, y, 60, 25], 'Value', 'No', ...
                    'BackgroundColor', [0.2, 0.2, 0.2], 'FontColor', 'white', ...
                    'ValueChangedFcn', @(src,evt) actualizar_campos());
                if strcmp(campos{4}.Value, 'Sí')
                    y = y - dy;
                    campos{5} = uilabel(panel_datos, 'Text', 'Velocidad inicial (m/s):', ...
                        'Position', [20, y, 140, 25], 'FontColor', 'white');
                    campos{6} = uieditfield(panel_datos, 'numeric', ...
                        'Position', [170, y, 100, 25], 'Value', 0, ...
                        'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
                end
            case 'Calcular velocidad de impacto'
                campos{1} = uilabel(panel_datos, 'Text', 'Altura inicial (m):', ...
                    'Position', [20, y, 120, 25], 'FontColor', 'white');
                campos{2} = uieditfield(panel_datos, 'numeric', ...
                    'Position', [150, y, 100, 25], 'Value', 10, ...
                    'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
                y = y - dy;
                campos{3} = uilabel(panel_datos, 'Text', '¿Velocidad inicial?', ...
                    'Position', [20, y, 120, 25], 'FontColor', 'white');
                campos{4} = uidropdown(panel_datos, 'Items', {'No', 'Sí'}, ...
                    'Position', [150, y, 60, 25], 'Value', 'No', ...
                    'BackgroundColor', [0.2, 0.2, 0.2], 'FontColor', 'white', ...
                    'ValueChangedFcn', @(src,evt) actualizar_campos());
                if strcmp(campos{4}.Value, 'Sí')
                    y = y - dy;
                    campos{5} = uilabel(panel_datos, 'Text', 'Velocidad inicial (m/s):', ...
                        'Position', [20, y, 140, 25], 'FontColor', 'white');
                    campos{6} = uieditfield(panel_datos, 'numeric', ...
                        'Position', [170, y, 100, 25], 'Value', 0, ...
                        'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
                end
            case 'Calcular altura máxima (tiro vertical)'
                campos{1} = uilabel(panel_datos, 'Text', 'Altura inicial (m):', ...
                    'Position', [20, y, 120, 25], 'FontColor', 'white');
                campos{2} = uieditfield(panel_datos, 'numeric', ...
                    'Position', [150, y, 100, 25], 'Value', 0, ...
                    'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
                y = y - dy;
                campos{3} = uilabel(panel_datos, 'Text', 'Velocidad inicial (m/s):', ...
                    'Position', [20, y, 140, 25], 'FontColor', 'white');
                campos{4} = uieditfield(panel_datos, 'numeric', ...
                    'Position', [170, y, 100, 25], 'Value', 10, ...
                    'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
            case 'Calcular altura después de cierto tiempo'
                campos{1} = uilabel(panel_datos, 'Text', 'Altura inicial (m):', ...
                    'Position', [20, y, 120, 25], 'FontColor', 'white');
                campos{2} = uieditfield(panel_datos, 'numeric', ...
                    'Position', [150, y, 100, 25], 'Value', 0, ...
                    'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
                y = y - dy;
                campos{3} = uilabel(panel_datos, 'Text', 'Velocidad inicial (m/s):', ...
                    'Position', [20, y, 140, 25], 'FontColor', 'white');
                campos{4} = uieditfield(panel_datos, 'numeric', ...
                    'Position', [170, y, 100, 25], 'Value', 0, ...
                    'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
                y = y - dy;
                campos{5} = uilabel(panel_datos, 'Text', 'Tiempo (s):', ...
                    'Position', [20, y, 100, 25], 'FontColor', 'white');
                campos{6} = uieditfield(panel_datos, 'numeric', ...
                    'Position', [130, y, 100, 25], 'Value', 1, ...
                    'FontColor', 'white', 'BackgroundColor', [0.2, 0.2, 0.2]);
        end
    end

    % --- Función para calcular según la opción seleccionada ---
    function calcular()
        opcion = dropdown_opciones.Value;
        g = 9.8;
        cla(axes_grafica);
        texto_resultados.Value = {''};
        switch opcion
            case 'Calcular tiempo de caída'
                h0 = campos{2}.Value;
                tiene_v0 = strcmp(campos{4}.Value, 'Sí');
                if tiene_v0
                    v0 = campos{6}.Value;
                else
                    v0 = 0;
                end
                if h0 <= 0
                    texto_resultados.Value = {'Error: La altura inicial debe ser positiva.'};
                    return;
                end
                if v0 == 0
                    t_caida = sqrt(2*h0/g);
                else
                    a = 0.5*g;
                    b = -v0;
                    c = -h0;
                    discriminante = b^2 - 4*a*c;
                    if discriminante < 0
                        texto_resultados.Value = {'No hay solución real para el tiempo de caída.'};
                        return;
                    end
                    t1 = (-b + sqrt(discriminante))/(2*a);
                    t2 = (-b - sqrt(discriminante))/(2*a);
                    tiempos_validos = [t1, t2];
                    tiempos_validos = tiempos_validos(tiempos_validos > 0);
                    if isempty(tiempos_validos)
                        texto_resultados.Value = {'No hay tiempos positivos de caída.'};
                        return;
                    end
                    t_caida = min(tiempos_validos);
                end
                texto_resultados.Value = {sprintf('Tiempo de caída: %.2f s', t_caida)};
                % Gráfica altura vs tiempo
                t = linspace(0, t_caida, 100);
                h = h0 + v0*t - 0.5*g*t.^2;
                plot(axes_grafica, t, h, 'c-', 'LineWidth', 2);
                xlabel(axes_grafica, 'Tiempo (s)');
                ylabel(axes_grafica, 'Altura (m)');
                title(axes_grafica, 'Altura vs Tiempo', 'Color', 'white');
                grid(axes_grafica, 'on');

            case 'Calcular velocidad de impacto'
                h0 = campos{2}.Value;
                tiene_v0 = strcmp(campos{4}.Value, 'Sí');
                if tiene_v0
                    v0 = campos{6}.Value;
                else
                    v0 = 0;
                end
                if h0 <= 0
                    texto_resultados.Value = {'Error: La altura inicial debe ser positiva.'};
                    return;
                end
                v_impacto_abs = sqrt(v0^2 + 2*g*h0);
                v_impacto = -v_impacto_abs;
                energia_cinetica = 0.5 * 1 * v_impacto^2;
                texto_resultados.Value = {sprintf('Velocidad de impacto: %.2f m/s', abs(v_impacto)), ...
                                         sprintf('Energía cinética (por unidad de masa): %.2f J/kg', abs(energia_cinetica))};
                % Gráfica velocidad vs tiempo
                if v0 == 0
                    t_caida = sqrt(2*h0/g);
                else
                    a = 0.5*g;
                    b = -v0;
                    c = -h0;
                    discriminante = b^2 - 4*a*c;
                    t1 = (-b + sqrt(discriminante))/(2*a);
                    t2 = (-b - sqrt(discriminante))/(2*a);
                    tiempos_validos = [t1, t2];
                    tiempos_validos = tiempos_validos(tiempos_validos > 0);
                    t_caida = min(tiempos_validos);
                end
                t = linspace(0, t_caida, 100);
                v = v0 - g*t;
                plot(axes_grafica, t, v, 'm-', 'LineWidth', 2);
                xlabel(axes_grafica, 'Tiempo (s)');
                ylabel(axes_grafica, 'Velocidad (m/s)');
                title(axes_grafica, 'Velocidad vs Tiempo', 'Color', 'white');
                grid(axes_grafica, 'on');

            case 'Calcular altura máxima (tiro vertical)'
                h0 = campos{2}.Value;
                v0 = campos{4}.Value;
                if h0 < 0
                    texto_resultados.Value = {'Error: La altura inicial no puede ser negativa.'};
                    return;
                end
                if v0 <= 0
                    h_max = h0;
                    texto_resultados.Value = {sprintf('Altura máxima: %.2f m', h_max)};
                else
                    h_max = h0 + (v0^2)/(2*g);
                    t_max = v0/g;
                    texto_resultados.Value = {sprintf('Altura máxima: %.2f m', h_max), ...
                                             sprintf('Tiempo hasta la altura máxima: %.2f s', t_max)};
                end
                % Gráfica altura vs tiempo
                t = linspace(0, 2*v0/g, 100);
                h = h0 + v0*t - 0.5*g*t.^2;
                plot(axes_grafica, t, h, 'g-', 'LineWidth', 2);
                xlabel(axes_grafica, 'Tiempo (s)');
                ylabel(axes_grafica, 'Altura (m)');
                title(axes_grafica, 'Altura vs Tiempo (Tiro vertical)', 'Color', 'white');
                grid(axes_grafica, 'on');

            case 'Calcular altura después de cierto tiempo'
                h0 = campos{2}.Value;
                v0 = campos{4}.Value;
                t = campos{6}.Value;
                if h0 < 0
                    texto_resultados.Value = {'Error: La altura inicial no puede ser negativa.'};
                    return;
                end
                if t < 0
                    texto_resultados.Value = {'Error: El tiempo debe ser positivo.'};
                    return;
                end
                h = h0 + v0*t - 0.5*g*t^2;
                texto_resultados.Value = {sprintf('Altura después de %.2f s: %.2f m', t, h)};
                % Gráfica altura vs tiempo
                t_vec = linspace(0, t, 100);
                h_vec = h0 + v0*t_vec - 0.5*g*t_vec.^2;
                plot(axes_grafica, t_vec, h_vec, 'b-', 'LineWidth', 2);
                xlabel(axes_grafica, 'Tiempo (s)');
                ylabel(axes_grafica, 'Altura (m)');
                title(axes_grafica, 'Altura vs Tiempo', 'Color', 'white');
                grid(axes_grafica, 'on');
        end
    end
end