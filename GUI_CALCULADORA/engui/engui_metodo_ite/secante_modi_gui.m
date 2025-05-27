function secante_modi_gui()
    % SECANTE_MODIFICADA_GUI - Interfaz gráfica para el método de la secante modificada
    
    % Crear la figura principal
    fig = uifigure('Name', 'Método de la Secante Modificada', ...
                   'Position', [200, 100, 900, 700], ...
                   'Resize', 'off', ...
                   'Color', [0.95, 0.95, 0.95]);
    
    % Variables globales para almacenar resultados
    iteraciones_data = [];
    
    % Título principal
    titulo = uilabel(fig, 'Text', 'MÉTODO DE LA SECANTE MODIFICADA', ...
                     'Position', [50, 650, 800, 30], ...
                     'FontSize', 18, ...
                     'FontWeight', 'bold', ...
                     'HorizontalAlignment', 'center', ...
                     'BackgroundColor', [0.2, 0.5, 0.8], ...
                     'FontColor', 'white');
    
    % Subtítulo
    subtitulo = uilabel(fig, 'Text', 'Encuentra raíces de ecuaciones de la forma f(x) = 0', ...
                        'Position', [50, 620, 800, 20], ...
                        'FontSize', 12, ...
                        'HorizontalAlignment', 'center', ...
                        'FontColor', [0.3, 0.3, 0.3]);
    
    % Panel de entrada de datos
    panel_entrada = uipanel(fig, 'Title', 'Parámetros de Entrada', ...
                            'Position', [50, 420, 400, 180], ...
                            'FontSize', 12, ...
                            'FontWeight', 'bold', ...
                            'BackgroundColor', [0.98, 0.98, 1]);
    
    % Etiquetas y campos de entrada
    uilabel(panel_entrada, 'Text', 'Función f(x):', ...
            'Position', [10, 130, 80, 20], ...
            'FontWeight', 'bold');
    
    campo_funcion = uieditfield(panel_entrada, 'text', ...
                                'Position', [100, 130, 280, 22], ...
                                'Placeholder', 'Ej: x^2 - 4, sin(x), exp(x) - 2*x', ...
                                'Value', 'x^2 - 4');
    
    uilabel(panel_entrada, 'Text', 'Punto inicial (x₀):', ...
            'Position', [10, 100, 100, 20], ...
            'FontWeight', 'bold');
    
    campo_x0 = uieditfield(panel_entrada, 'numeric', ...
                           'Position', [120, 100, 80, 22], ...
                           'Value', 1);
    
    uilabel(panel_entrada, 'Text', 'Perturbación (δ):', ...
            'Position', [220, 100, 100, 20], ...
            'FontWeight', 'bold');
    
    campo_delta = uieditfield(panel_entrada, 'numeric', ...
                              'Position', [320, 100, 60, 22], ...
                              'Value', 0.01);
    
    uilabel(panel_entrada, 'Text', 'Tolerancia (ε):', ...
            'Position', [10, 70, 100, 20], ...
            'FontWeight', 'bold');
    
    campo_tol = uieditfield(panel_entrada, 'numeric', ...
                            'Position', [120, 70, 80, 22], ...
                            'Value', 1e-6, ...
                            'ValueDisplayFormat', '%.1e');
    
    uilabel(panel_entrada, 'Text', 'Máx. iteraciones:', ...
            'Position', [220, 70, 100, 20], ...
            'FontWeight', 'bold');
    
    campo_max_iter = uieditfield(panel_entrada, 'numeric', ...
                                 'Position', [320, 70, 60, 22], ...
                                 'Value', 100);
    
    % Botones de control
    btn_calcular = uibutton(panel_entrada, 'Text', 'CALCULAR', ...
                            'Position', [60, 20, 100, 30], ...
                            'BackgroundColor', [0.2, 0.7, 0.2], ...
                            'FontColor', 'white', ...
                            'FontWeight', 'bold', ...
                            'ButtonPushedFcn', @calcular_raiz);
    
    btn_limpiar = uibutton(panel_entrada, 'Text', 'LIMPIAR', ...
                           'Position', [180, 20, 100, 30], ...
                           'BackgroundColor', [0.8, 0.6, 0.2], ...
                           'FontColor', 'white', ...
                           'FontWeight', 'bold', ...
                           'ButtonPushedFcn', @limpiar_campos);
    
    % Panel de resultados
    panel_resultados = uipanel(fig, 'Title', 'Resultados', ...
                               'Position', [470, 420, 380, 180], ...
                               'FontSize', 12, ...
                               'FontWeight', 'bold', ...
                               'BackgroundColor', [0.98, 1, 0.98]);
    
    % Área de texto para resultados
    texto_resultados = uitextarea(panel_resultados, ...
                                  'Position', [10, 10, 360, 140], ...
                                  'Editable', 'off', ...
                                  'Value', {'Ingrese los parámetros y presione CALCULAR', ...
                                           'para encontrar la raíz de la función.'}, ...
                                  'BackgroundColor', [0.99, 0.99, 0.99]);
    
    % Tabla para mostrar iteraciones
    tabla_iteraciones = uitable(fig, 'Position', [50, 50, 600, 350], ...
                                'ColumnName', {'Iteración', 'x', 'f(x)', 'Error', 'Tasa Conv.'}, ...
                                'ColumnWidth', {80, 120, 120, 120, 120}, ...
                                'RowName', {});
    
    % Panel para gráfica
    panel_grafica = uipanel(fig, 'Title', 'Visualización', ...
                            'Position', [670, 50, 180, 350], ...
                            'FontSize', 12, ...
                            'FontWeight', 'bold', ...
                            'BackgroundColor', [1, 0.98, 0.98]);
    
    % Área para la gráfica
    axes_grafica = uiaxes(panel_grafica, 'Position', [10, 10, 160, 320]);
    axes_grafica.XLabel.String = 'Iteración';
    axes_grafica.YLabel.String = 'Error';
    axes_grafica.Title.String = 'Convergencia';
    
    % Función para calcular la raíz
    function calcular_raiz(~, ~)
        try
            % Obtener parámetros
            funcion_str = campo_funcion.Value;
            x0 = campo_x0.Value;
            delta = campo_delta.Value;
            tol = campo_tol.Value;
            max_iter = campo_max_iter.Value;
            
            % Validar la función
            if isempty(funcion_str)
                uialert(fig, 'Por favor ingrese una función válida.', 'Error');
                return;
            end
            
            % Crear función anónima
            try
                f = str2func(['@(x) ' funcion_str]);
                f(1); % Prueba
            catch
                uialert(fig, 'La función ingresada no es válida. Verifique la sintaxis.', 'Error');
                return;
            end
            
            % Implementar el método de la secante modificada
            iteraciones_data = zeros(max_iter, 5);
            x = x0;
            fx = f(x);
            iter = 0;
            error_actual = Inf;
            
            while abs(fx) > tol && iter < max_iter && error_actual > tol
                x_anterior = x;
                
                % Calcular f(x + δ*x)
                x_perturbado = x + delta * x;
                fx_perturbado = f(x_perturbado);
                
                % Calcular la aproximación de la derivada
                derivada_aprox = (fx_perturbado - fx) / (delta * x);
                
                if abs(derivada_aprox) < eps
                    derivada_aprox = sign(derivada_aprox) * eps;
                end
                
                % Aplicar la fórmula del método
                x = x - fx / derivada_aprox;
                fx = f(x);
                error_actual = abs(x - x_anterior);
                
                % Calcular tasa de convergencia
                if iter > 0 && iteraciones_data(iter, 4) > 0
                    tasa_conv = log(error_actual) / log(iteraciones_data(iter, 4));
                else
                    tasa_conv = NaN;
                end
                
                iter = iter + 1;
                iteraciones_data(iter, :) = [iter, x, fx, error_actual, tasa_conv];
                
                if abs(fx) < tol || error_actual < tol
                    break;
                end
            end
            
            % Recortar datos
            iteraciones_data = iteraciones_data(1:iter, :);
            
            % Actualizar tabla
            datos_tabla = cell(iter, 5);
            for i = 1:iter
                datos_tabla{i, 1} = iteraciones_data(i, 1);
                datos_tabla{i, 2} = sprintf('%.8f', iteraciones_data(i, 2));
                datos_tabla{i, 3} = sprintf('%.2e', iteraciones_data(i, 3));
                datos_tabla{i, 4} = sprintf('%.2e', iteraciones_data(i, 4));
                if isnan(iteraciones_data(i, 5))
                    datos_tabla{i, 5} = '---';
                else
                    datos_tabla{i, 5} = sprintf('%.4f', iteraciones_data(i, 5));
                end
            end
            tabla_iteraciones.Data = datos_tabla;
            
            % Crear mensaje de resultados
            if iter < max_iter && (abs(fx) < tol || error_actual < tol)
                status = 'CONVERGENCIA EXITOSA';
                color_status = [0.2, 0.8, 0.2];
            else
                status = 'NO CONVERGIÓ';
                color_status = [0.8, 0.2, 0.2];
            end
            
            % Estimar orden de convergencia
            if iter > 2
                errores = iteraciones_data(max(1, iter-3):iter, 4);
                if all(errores > 0)
                    coef = polyfit(log(errores(1:end-1)), log(errores(2:end)), 1);
                    orden_conv = coef(1);
                    if abs(orden_conv - 1) < 0.2
                        tipo_conv = 'lineal';
                    elseif abs(orden_conv - 2) < 0.2
                        tipo_conv = 'cuadrática';
                    else
                        tipo_conv = sprintf('orden %.2f', orden_conv);
                    end
                else
                    tipo_conv = 'indeterminado';
                    orden_conv = NaN;
                end
            else
                tipo_conv = 'pocas iteraciones';
                orden_conv = NaN;
            end
            
            % Mostrar resultados
            resultados = {
                ['ESTADO: ' status];
                ['Iteraciones: ' num2str(iter)];
                ['Raíz encontrada: x = ' sprintf('%.10f', x)];
                ['f(x) = ' sprintf('%.2e', fx)];
                ['Error estimado: ' sprintf('%.2e', error_actual)];
                ['Convergencia: ' tipo_conv];
                '';
                ['Función: f(x) = ' funcion_str];
                ['Punto inicial: x₀ = ' num2str(x0)]
            };
            
            texto_resultados.Value = resultados;
            
            % Graficar convergencia
            if iter > 1
                cla(axes_grafica);
                errores_plot = iteraciones_data(:, 4);
                semilogy(axes_grafica, 1:iter, errores_plot, 'bo-', 'LineWidth', 2, 'MarkerSize', 6);
                axes_grafica.XLabel.String = 'Iteración';
                axes_grafica.YLabel.String = 'Error (escala log)';
                axes_grafica.Title.String = 'Convergencia del Error';
                grid(axes_grafica, 'on');
            end
            
        catch e
            uialert(fig, ['Error en el cálculo: ' e.message], 'Error de Cálculo');
        end
    end
    
    % Función para limpiar campos
    function limpiar_campos(~, ~)
        campo_funcion.Value = '';
        campo_x0.Value = 1;
        campo_delta.Value = 0.01;
        campo_tol.Value = 1e-6;
        campo_max_iter.Value = 100;
        
        texto_resultados.Value = {'Campos limpiados.', 'Ingrese nuevos parámetros y presione CALCULAR.'};
        tabla_iteraciones.Data = {};
        cla(axes_grafica);
        
        iteraciones_data = [];
    end
    
    % Botón para exportar resultados
    btn_exportar = uibutton(fig, 'Text', 'EXPORTAR', ...
                            'Position', [380, 10, 100, 30], ...
                            'BackgroundColor', [0.5, 0.5, 0.8], ...
                            'FontColor', 'white', ...
                            'FontWeight', 'bold', ...
                            'ButtonPushedFcn', @exportar_resultados);
    
    % Función para exportar resultados
    function exportar_resultados(~, ~)
        if isempty(iteraciones_data)
            uialert(fig, 'No hay datos para exportar. Ejecute primero el cálculo.', 'Sin Datos');
            return;
        end
        
        try
            % Crear tabla para exportar
            T = table(iteraciones_data(:,1), iteraciones_data(:,2), ...
                     iteraciones_data(:,3), iteraciones_data(:,4), ...
                     iteraciones_data(:,5), ...
                     'VariableNames', {'Iteracion', 'x', 'fx', 'Error', 'TasaConvergencia'});
            
            % Guardar archivo
            [filename, pathname] = uiputfile('*.xlsx', 'Guardar resultados como...');
            if filename ~= 0
                writetable(T, fullfile(pathname, filename));
                uialert(fig, ['Resultados exportados exitosamente a: ' filename], ...
                        'Exportación Exitosa', 'Icon', 'success');
            end
        catch e
            uialert(fig, ['Error al exportar: ' e.message], 'Error de Exportación');
        end
    end
    
    % Botón de ayuda
    btn_ayuda = uibutton(fig, 'Text', 'AYUDA', ...
                         'Position', [500, 10, 100, 30], ...
                         'BackgroundColor', [0.6, 0.4, 0.8], ...
                         'FontColor', 'white', ...
                         'FontWeight', 'bold', ...
                         'ButtonPushedFcn', @mostrar_ayuda);
    
    % Función para mostrar ayuda
    function mostrar_ayuda(~, ~)
        mensaje_ayuda = {
            'MÉTODO DE LA SECANTE MODIFICADA';
            '';
            'Este método encuentra raíces de ecuaciones f(x) = 0';
            'sin necesidad de calcular derivadas analíticas.';
            '';
            'PARÁMETROS:';
            '• Función: Expresión matemática (ej: x^2-4, sin(x))';
            '• x₀: Punto inicial para la búsqueda';
            '• δ: Factor de perturbación (típicamente 0.01)';
            '• ε: Tolerancia de convergencia (típicamente 1e-6)';
            '• Máx. iter: Número máximo de iteraciones';
            '';
            'FUNCIONES DISPONIBLES:';
            '• Básicas: +, -, *, /, ^';
            '• Trigonométricas: sin, cos, tan, asin, acos, atan';
            '• Exponenciales: exp, log, log10, sqrt';
            '• Constantes: pi, e (usar como números)';
            '';
            'EJEMPLOS:';
            '• Ecuación cuadrática: x^2 - 4';
            '• Transcendental: exp(x) - 2*x';
            '• Trigonométrica: sin(x) - 0.5';
        };
        
        uialert(fig, mensaje_ayuda, 'Ayuda - Método de la Secante Modificada', ...
                'Icon', 'info');
    end
end