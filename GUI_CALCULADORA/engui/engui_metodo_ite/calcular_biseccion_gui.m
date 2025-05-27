function calcular_biseccion_gui()
    % BISECCION_GUI - Interfaz gráfica para el método de bisección
    
    % Crear la figura principal
    fig = uifigure('Name', 'Método de Bisección', ...
                   'Position', [150, 50, 1000, 750], ...
                   'Resize', 'off', ...
                   'Color', [0.95, 0.95, 0.95]);
    
    % Variables globales para almacenar resultados
    iteraciones_data = [];
    func_actual = [];
    raiz_encontrada = [];
    
    % Título principal
    titulo = uilabel(fig, 'Text', 'MÉTODO DE BISECCIÓN', ...
                     'Position', [50, 700, 900, 30], ...
                     'FontSize', 20, ...
                     'FontWeight', 'bold', ...
                     'HorizontalAlignment', 'center', ...
                     'BackgroundColor', [0.2, 0.4, 0.8], ...
                     'FontColor', 'white');
    
    % Subtítulo
    subtitulo = uilabel(fig, 'Text', 'Encuentra raíces de funciones continuas en intervalos cerrados', ...
                        'Position', [50, 670, 900, 20], ...
                        'FontSize', 12, ...
                        'HorizontalAlignment', 'center', ...
                        'FontColor', [0.3, 0.3, 0.3]);
    
    % Panel de selección de función
    panel_funcion = uipanel(fig, 'Title', 'Definición de la Función', ...
                            'Position', [50, 520, 450, 140], ...
                            'FontSize', 12, ...
                            'FontWeight', 'bold', ...
                            'BackgroundColor', [0.98, 0.98, 1]);
    
    % Radio buttons para seleccionar tipo de función
    bg_funcion = uibuttongroup(panel_funcion, 'Position', [10, 80, 430, 50], ...
                               'SelectionChangedFcn', @cambio_tipo_funcion);
    
    rb_personalizada = uiradiobutton(bg_funcion, 'Text', 'Función personalizada', ...
                                     'Position', [10, 25, 150, 22]);
    
    rb_predefinida = uiradiobutton(bg_funcion, 'Text', 'Función predefinida', ...
                                   'Position', [170, 25, 150, 22], ...
                                   'Value', true);
    
    % Campo para función personalizada
    uilabel(panel_funcion, 'Text', 'f(x) =', ...
            'Position', [10, 50, 40, 20]);
    
    campo_funcion = uieditfield(panel_funcion, 'text', ...
                                'Position', [60, 50, 370, 22], ...
                                'Placeholder', 'Ej: x^3 - 6*x^2 + 11*x - 6', ...
                                'Enable', 'off');
    
    % Dropdown para funciones predefinidas
    uilabel(panel_funcion, 'Text', 'Seleccionar:', ...
            'Position', [10, 20, 80, 20]);
    
    [~, nombres_pred] = obtener_funciones_predefinidas();
    dropdown_predefinida = uidropdown(panel_funcion, 'Items', nombres_pred, ...
                                      'Position', [100, 20, 330, 22], ...
                                      'Value', nombres_pred{1});
    
    % Panel de parámetros
    panel_parametros = uipanel(fig, 'Title', 'Parámetros del Método', ...
                               'Position', [520, 520, 430, 140], ...
                               'FontSize', 12, ...
                               'FontWeight', 'bold', ...
                               'BackgroundColor', [0.98, 1, 0.98]);
    
    % Campos de parámetros
    uilabel(panel_parametros, 'Text', 'Intervalo [a, b]:', ...
            'Position', [10, 100, 100, 20], ...
            'FontWeight', 'bold');
    
    uilabel(panel_parametros, 'Text', 'a =', ...
            'Position', [120, 100, 30, 20]);
    campo_a = uieditfield(panel_parametros, 'numeric', ...
                          'Position', [150, 100, 80, 22], ...
                          'Value', 0);
    
    uilabel(panel_parametros, 'Text', 'b =', ...
            'Position', [250, 100, 30, 20]);
    campo_b = uieditfield(panel_parametros, 'numeric', ...
                          'Position', [280, 100, 80, 22], ...
                          'Value', 2);
    
    uilabel(panel_parametros, 'Text', 'Tolerancia:', ...
            'Position', [10, 70, 80, 20], ...
            'FontWeight', 'bold');
    campo_tolerancia = uieditfield(panel_parametros, 'numeric', ...
                                   'Position', [100, 70, 120, 22], ...
                                   'Value', 1e-6, ...
                                   'ValueDisplayFormat', '%.1e');
    
    uilabel(panel_parametros, 'Text', 'Máx. iteraciones:', ...
            'Position', [240, 70, 100, 20], ...
            'FontWeight', 'bold');
    campo_max_iter = uieditfield(panel_parametros, 'numeric', ...
                                 'Position', [350, 70, 70, 22], ...
                                 'Value', 100);
    
    % Botones de control
    btn_validar = uibutton(panel_parametros, 'Text', 'VALIDAR INTERVALO', ...
                           'Position', [10, 20, 120, 30], ...
                           'BackgroundColor', [0.8, 0.6, 0.2], ...
                           'FontColor', 'white', ...
                           'FontWeight', 'bold', ...
                           'ButtonPushedFcn', @validar_intervalo);
    
    btn_calcular = uibutton(panel_parametros, 'Text', 'CALCULAR', ...
                            'Position', [150, 20, 100, 30], ...
                            'BackgroundColor', [0.2, 0.7, 0.2], ...
                            'FontColor', 'white', ...
                            'FontWeight', 'bold', ...
                            'ButtonPushedFcn', @calcular_biseccion);
    
    btn_limpiar = uibutton(panel_parametros, 'Text', 'LIMPIAR', ...
                           'Position', [270, 20, 80, 30], ...
                           'BackgroundColor', [0.7, 0.2, 0.2], ...
                           'FontColor', 'white', ...
                           'FontWeight', 'bold', ...
                           'ButtonPushedFcn', @limpiar_todo);
    
    % Panel de resultados
    panel_resultados = uipanel(fig, 'Title', 'Resultados', ...
                               'Position', [50, 300, 450, 210], ...
                               'FontSize', 12, ...
                               'FontWeight', 'bold', ...
                               'BackgroundColor', [1, 0.98, 0.98]);
    
    % Área de texto para resultados
    texto_resultados = uitextarea(panel_resultados, ...
                                  'Position', [10, 10, 430, 170], ...
                                  'Editable', 'off', ...
                                  'Value', {'Defina una función y su intervalo,', ...
                                           'luego presione CALCULAR para encontrar la raíz.'}, ...
                                  'BackgroundColor', [0.99, 0.99, 0.99]);
    
    % Panel de gráfica
    panel_grafica = uipanel(fig, 'Title', 'Visualización de la Función', ...
                            'Position', [520, 300, 430, 210], ...
                            'FontSize', 12, ...
                            'FontWeight', 'bold', ...
                            'BackgroundColor', [0.98, 0.98, 1]);
    
    % Ejes para la gráfica
    axes_funcion = uiaxes(panel_grafica, 'Position', [20, 20, 390, 160]);
    axes_funcion.XLabel.String = 'x';
    axes_funcion.YLabel.String = 'f(x)';
    axes_funcion.Title.String = 'Función y su raíz';
    
    % Tabla de iteraciones
    tabla_iteraciones = uitable(fig, 'Position', [50, 50, 600, 240], ...
                                'ColumnName', {'Iteración', 'a', 'b', 'c', 'f(c)', 'Error'}, ...
                                'ColumnWidth', {80, 90, 90, 90, 90, 90}, ...
                                'RowName', {});
    
    % Panel de control de gráfica
    panel_control_graf = uipanel(fig, 'Title', 'Control de Gráfica', ...
                                 'Position', [670, 50, 280, 240], ...
                                 'FontSize', 12, ...
                                 'FontWeight', 'bold', ...
                                 'BackgroundColor', [0.95, 1, 0.95]);
    
    % Botones para gráfica
    btn_graficar = uibutton(panel_control_graf, 'Text', 'GRAFICAR FUNCIÓN', ...
                            'Position', [20, 180, 240, 30], ...
                            'BackgroundColor', [0.4, 0.6, 0.8], ...
                            'FontColor', 'white', ...
                            'FontWeight', 'bold', ...
                            'ButtonPushedFcn', @graficar_funcion);
    
    btn_mostrar_iteraciones = uibutton(panel_control_graf, 'Text', 'MOSTRAR ITERACIONES', ...
                                       'Position', [20, 140, 240, 30], ...
                                       'BackgroundColor', [0.6, 0.4, 0.8], ...
                                       'FontColor', 'white', ...
                                       'FontWeight', 'bold', ...
                                       'ButtonPushedFcn', @mostrar_iteraciones_grafica);
    
    btn_exportar = uibutton(panel_control_graf, 'Text', 'EXPORTAR RESULTADOS', ...
                            'Position', [20, 100, 240, 30], ...
                            'BackgroundColor', [0.8, 0.4, 0.6], ...
                            'FontColor', 'white', ...
                            'FontWeight', 'bold', ...
                            'ButtonPushedFcn', @exportar_resultados);
    
    btn_ayuda = uibutton(panel_control_graf, 'Text', 'AYUDA', ...
                         'Position', [20, 60, 240, 30], ...
                         'BackgroundColor', [0.5, 0.7, 0.5], ...
                         'FontColor', 'white', ...
                         'FontWeight', 'bold', ...
                         'ButtonPushedFcn', @mostrar_ayuda);
    
    % Función para cambio de tipo de función
    function cambio_tipo_funcion(~, event)
        if event.NewValue == rb_personalizada
            campo_funcion.Enable = 'on';
            dropdown_predefinida.Enable = 'off';
        else
            campo_funcion.Enable = 'off';
            dropdown_predefinida.Enable = 'on';
        end
    end
    
    % Función para obtener la función actual
    function [func, nombre] = obtener_funcion_actual()
        if rb_personalizada.Value
            % Función personalizada
            expr = campo_funcion.Value;
            if isempty(expr)
                error('Debe ingresar una función válida.');
            end
            try
                func = str2func(['@(x) ' expr]);
                func(1); % Prueba
                nombre = ['f(x) = ' expr];
            catch
                error('La función ingresada no es válida. Verifique la sintaxis.');
            end
        else
            % Función predefinida
            [funciones, nombres] = obtener_funciones_predefinidas();
            idx = find(strcmp(nombres, dropdown_predefinida.Value));
            func = funciones{idx};
            nombre = nombres{idx};
        end
    end
    
    % Función para validar intervalo
    function validar_intervalo(~, ~)
        try
            [func, nombre] = obtener_funcion_actual();
            a = campo_a.Value;
            b = campo_b.Value;
            
            % Validaciones
            if a >= b
                error('Debe cumplirse que a < b.');
            end
            
            if ~isfinite(a) || ~isfinite(b)
                error('Los límites del intervalo deben ser números finitos.');
            end
            
            % Evaluar función en extremos
            fa = func(a);
            fb = func(b);
            
            if ~isfinite(fa) || ~isfinite(fb)
                error('La función produce valores no finitos en los límites del intervalo.');
            end
            
            % Verificar cambio de signo
            if fa * fb >= 0
                warning_msg = sprintf(['La función no cambia de signo en [%.4f, %.4f].\n'...
                    'f(%.4f) = %.6f\nf(%.4f) = %.6f\n'...
                    'Para bisección se requiere f(a)*f(b) < 0.'], ...
                    a, b, a, fa, b, fb);
                
                if fa == 0
                    warning_msg = [warning_msg sprintf('\nNota: f(%.4f) = 0, por lo que %.4f ya es una raíz.', a, a)];
                elseif fb == 0
                    warning_msg = [warning_msg sprintf('\nNota: f(%.4f) = 0, por lo que %.4f ya es una raíz.', b, b)];
                end
                
                uialert(fig, warning_msg, 'Intervalo no válido', 'Icon', 'warning');
                return;
            end
            
            % Intervalo válido
            success_msg = sprintf(['Intervalo [%.4f, %.4f] validado correctamente.\n'...
                'f(%.4f) = %.6f\nf(%.4f) = %.6f\n'...
                'Cambio de signo detectado: ✓'], ...
                a, b, a, fa, b, fb);
            
            uialert(fig, success_msg, 'Intervalo válido', 'Icon', 'success');
            
        catch e
            uialert(fig, e.message, 'Error de validación', 'Icon', 'error');
        end
    end
    
    % Función principal para calcular bisección
    function calcular_biseccion(~, ~)
        try
            % Obtener función y parámetros
            [func, nombre_func] = obtener_funcion_actual();
            func_actual = func;
            a = campo_a.Value;
            b = campo_b.Value;
            tol = campo_tolerancia.Value;
            max_iter = campo_max_iter.Value;
            
            % Validar intervalo primero
            fa = func(a);
            fb = func(b);
            
            if a >= b
                error('Debe cumplirse que a < b.');
            end
            
            if fa * fb >= 0
                error('La función no cambia de signo en el intervalo. f(a)*f(b) debe ser < 0.');
            end
            
            % Ejecutar método de bisección
            [raiz, num_iter, error_final, datos_iter] = metodo_biseccion_completo(func, a, b, tol, max_iter);
            raiz_encontrada = raiz;
            iteraciones_data = datos_iter;
            
            % Mostrar resultados
            if num_iter < max_iter
                status = 'CONVERGENCIA EXITOSA';
                color_status = 'success';
            else
                status = 'MÁXIMO DE ITERACIONES ALCANZADO';
                color_status = 'warning';
            end
            
            resultados = {
                ['ESTADO: ' status];
                '';
                ['Función: ' nombre_func];
                ['Intervalo inicial: [' num2str(a) ', ' num2str(b) ']'];
                '';
                ['Raíz encontrada: x = ' sprintf('%.10f', raiz)];
                ['f(x) = ' sprintf('%.2e', func(raiz))];
                ['Iteraciones: ' num2str(num_iter)];
                ['Error final: ' sprintf('%.2e', error_final)];
                ['Tolerancia: ' sprintf('%.1e', tol)];
            };
            
            texto_resultados.Value = resultados;
            
            % Actualizar tabla
            actualizar_tabla_iteraciones();
            
            % Mensaje de éxito
            uialert(fig, ['Raíz encontrada: x = ' sprintf('%.8f', raiz)], ...
                    'Cálculo completado', 'Icon', color_status);
            
        catch e
            uialert(fig, e.message, 'Error en el cálculo', 'Icon', 'error');
        end
    end
    
    % Función para actualizar tabla de iteraciones
    function actualizar_tabla_iteraciones()
        if isempty(iteraciones_data)
            return;
        end
        
        datos_tabla = cell(size(iteraciones_data, 1), 6);
        for i = 1:size(iteraciones_data, 1)
            datos_tabla{i, 1} = iteraciones_data(i, 1); % Iteración
            datos_tabla{i, 2} = sprintf('%.6f', iteraciones_data(i, 2)); % a
            datos_tabla{i, 3} = sprintf('%.6f', iteraciones_data(i, 3)); % b
            datos_tabla{i, 4} = sprintf('%.6f', iteraciones_data(i, 4)); % c
            datos_tabla{i, 5} = sprintf('%.2e', iteraciones_data(i, 5)); % f(c)
            datos_tabla{i, 6} = sprintf('%.2e', iteraciones_data(i, 6)); % Error
        end
        tabla_iteraciones.Data = datos_tabla;
    end
    
    % Función para graficar la función
    function graficar_funcion(~, ~)
        try
            [func, ~] = obtener_funcion_actual();
            a = campo_a.Value;
            b = campo_b.Value;
            
            % Crear vector de puntos
            margen = (b - a) * 0.3;
            x = linspace(a - margen, b + margen, 500);
            
            % Evaluar función
            y = arrayfun(@(xi) evaluar_seguro(func, xi), x);
            
            % Graficar
            cla(axes_funcion);
            plot(axes_funcion, x, y, 'b-', 'LineWidth', 1.5);
            hold(axes_funcion, 'on');
            
            % Línea en y=0
            plot(axes_funcion, [x(1), x(end)], [0, 0], 'k--', 'LineWidth', 0.8);
            
            % Marcar intervalo inicial
            plot(axes_funcion, [a, a], ylim(axes_funcion), 'g--', 'LineWidth', 1);
            plot(axes_funcion, [b, b], ylim(axes_funcion), 'g--', 'LineWidth', 1);
            
            % Marcar raíz si existe
            if ~isempty(raiz_encontrada)
                plot(axes_funcion, raiz_encontrada, func(raiz_encontrada), 'ro', ...
                     'MarkerSize', 8, 'MarkerFaceColor', 'r');
            end
            
            grid(axes_funcion, 'on');
            hold(axes_funcion, 'off');
            
        catch e
            uialert(fig, ['Error al graficar: ' e.message], 'Error', 'Icon', 'error');
        end
    end
    
    % Función para mostrar iteraciones en gráfica
    function mostrar_iteraciones_grafica(~, ~)
        if isempty(iteraciones_data) || isempty(func_actual)
            uialert(fig, 'Primero debe ejecutar el cálculo.', 'Sin datos', 'Icon', 'warning');
            return;
        end
        
        % Crear figura separada para animación
        fig_anim = figure('Name', 'Bisección - Iteraciones', 'NumberTitle', 'off');
        
        a_orig = iteraciones_data(1, 2);
        b_orig = iteraciones_data(1, 3);
        margen = (b_orig - a_orig) * 0.2;
        x = linspace(a_orig - margen, b_orig + margen, 500);
        y = arrayfun(@(xi) evaluar_seguro(func_actual, xi), x);
        
        for i = 1:size(iteraciones_data, 1)
            clf(fig_anim);
            
            % Graficar función
            plot(x, y, 'b-', 'LineWidth', 1.5);
            hold on;
            plot([x(1), x(end)], [0, 0], 'k--', 'LineWidth', 0.8);
            
            % Marcar intervalo actual
            a_i = iteraciones_data(i, 2);
            b_i = iteraciones_data(i, 3);
            c_i = iteraciones_data(i, 4);
            
            plot([a_i, a_i], ylim, 'g--', 'LineWidth', 2);
            plot([b_i, b_i], ylim, 'r--', 'LineWidth', 2);
            plot([c_i, c_i], ylim, 'm-', 'LineWidth', 2);
            
            % Marcar puntos
            plot(a_i, func_actual(a_i), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
            plot(b_i, func_actual(b_i), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
            plot(c_i, func_actual(c_i), 'mo', 'MarkerSize', 8, 'MarkerFaceColor', 'm');
            
            grid on;
            xlabel('x');
            ylabel('f(x)');
            title(sprintf('Iteración %d: c = %.6f, Error = %.2e', ...
                  iteraciones_data(i, 1), c_i, iteraciones_data(i, 6)));
            
            legend('f(x)', 'y=0', 'a', 'b', 'c', 'f(a)', 'f(b)', 'f(c)', 'Location', 'best');
            
            pause(1);
        end
        
        title('¡Raíz encontrada!');
    end
    
    % Función para exportar resultados
    function exportar_resultados(~, ~)
        if isempty(iteraciones_data)
            uialert(fig, 'No hay datos para exportar.', 'Sin datos', 'Icon', 'warning');
            return;
        end
        
        try
            [filename, pathname] = uiputfile('*.xlsx', 'Guardar resultados como...');
            if filename ~= 0
                % Crear tabla
                T = table(iteraciones_data(:,1), iteraciones_data(:,2), ...
                         iteraciones_data(:,3), iteraciones_data(:,4), ...
                         iteraciones_data(:,5), iteraciones_data(:,6), ...
                         'VariableNames', {'Iteracion', 'a', 'b', 'c', 'fc', 'Error'});
                
                writetable(T, fullfile(pathname, filename));
                uialert(fig, 'Resultados exportados exitosamente.', 'Exportación exitosa', 'Icon', 'success');
            end
        catch e
            uialert(fig, ['Error al exportar: ' e.message], 'Error de exportación', 'Icon', 'error');
        end
    end
    
    % Función para limpiar todo
    function limpiar_todo(~, ~)
        campo_funcion.Value = '';
        campo_a.Value = 0;
        campo_b.Value = 2;
        campo_tolerancia.Value = 1e-6;
        campo_max_iter.Value = 100;
        
        texto_resultados.Value = {'Campos limpiados.', 'Defina una función y su intervalo.'};
        tabla_iteraciones.Data = {};
        cla(axes_funcion);
        
        iteraciones_data = [];
        func_actual = [];
        raiz_encontrada = [];
    end
    
    % Función para mostrar ayuda
    function mostrar_ayuda(~, ~)
        mensaje_ayuda = {
            'MÉTODO DE BISECCIÓN';
            '';
            'El método de bisección encuentra raíces de funciones continuas';
            'en intervalos donde la función cambia de signo.';
            '';
            'REQUISITOS:';
            '• f(a) * f(b) < 0 (cambio de signo)';
            '• Función continua en [a,b]';
            '';
            'PASOS:';
            '1. Defina la función (personalizada o predefinida)';
            '2. Ingrese el intervalo [a,b]';
            '3. Ajuste tolerancia y máximo de iteraciones';
            '4. Valide el intervalo (opcional)';
            '5. Presione CALCULAR';
            '';
            'FUNCIONES DISPONIBLES:';
            '• Aritméticas: +, -, *, /, ^';
            '• Trigonométricas: sin, cos, tan';
            '• Exponenciales: exp, log, sqrt';
            '• Constantes: pi, e';
            '';
            'EJEMPLO: x^3 - 6*x^2 + 11*x - 6';
        };
        
        uialert(fig, mensaje_ayuda, 'Ayuda - Método de Bisección', 'Icon', 'info');
    end
end

% ========== FUNCIONES AUXILIARES ==========

function [funciones, nombres] = obtener_funciones_predefinidas()
    % Funciones predefinidas para el método de bisección
    funciones = cell(6, 1);
    nombres = cell(6, 1);
    
    funciones{1} = @(x) x.^3 - 6*x.^2 + 11*x - 6;
    nombres{1} = 'x³ - 6x² + 11x - 6 (Raíces: 1, 2, 3)';
    
    funciones{2} = @(x) cos(x) - x;
    nombres{2} = 'cos(x) - x (Raíz ≈ 0.739)';
    
    funciones{3} = @(x) exp(x) - 3*x;
    nombres{3} = 'eˣ - 3x (Raíz ≈ 1.049)';
    
    funciones{4} = @(x) x.^2 - 2;
    nombres{4} = 'x² - 2 (Raíces: ±√2)';
    
    funciones{5} = @(x) sin(x) - 0.5;
    nombres{5} = 'sin(x) - 0.5 (Raíz ≈ 0.524)';
    
    funciones{6} = @(x) x.^3 - x - 1;
    nombres{6} = 'x³ - x - 1 (Raíz ≈ 1.325)';
end

function [raiz, iteraciones, error_est, datos] = metodo_biseccion_completo(func, a, b, tol, max_iter)
    % Implementación completa del método de bisección con seguimiento
    
    fa = func(a);
    fb = func(b);
    
    if fa * fb > 0
        error('No hay cambio de signo en el intervalo.');
    end
    
    iter = 0;
    error_est = abs(b - a);
    datos = zeros(max_iter, 6); % [iter, a, b, c, fc, error]
    
    while error_est > tol && iter < max_iter
        c = (a + b) / 2;
        fc = func(c);
        
        iter = iter + 1;
        error_est = abs(b - a) / 2;
        datos(iter, :) = [iter, a, b, c, fc, error_est];
        
        if abs(fc) < eps
            break;
        end
        
        if fa * fc < 0
            b = c;
            fb = fc;
        else
            a = c;
            fa = fc;
        end
    end
    
    raiz = c;
    iteraciones = iter;
    datos = datos(1:iter, :);
end

function y = evaluar_seguro(func, x)
    % Evalúa la función de manera segura
    try
        y = func(x);
        if ~isfinite(y)
            y = NaN;
        end
    catch
        y = NaN;
    end
end