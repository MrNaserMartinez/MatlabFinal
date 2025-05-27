function solucionador_ecuaciones_gui()
    % Interfaz gráfica completa para el solucionador de ecuaciones
    
    % Crear la figura principal
    fig = uifigure('Name', 'Solucionador de Ecuaciones', ...
                   'Position', [50, 30, 1400, 900], ...
                   'Resize', 'off', ...
                   'Color', [0.94, 0.94, 0.94]);
    
    % Título principal
    titulo = uilabel(fig, 'Text', 'SOLUCIONADOR DE ECUACIONES', ...
                     'Position', [50, 840, 1300, 40], ...
                     'FontSize', 26, ...
                     'FontWeight', 'bold', ...
                     'HorizontalAlignment', 'center', ...
                     'BackgroundColor', [0.1, 0.5, 0.3], ...
                     'FontColor', 'white');
    
    % Subtítulo
    subtitulo = uilabel(fig, 'Text', 'Herramienta completa para resolver diferentes tipos de ecuaciones', ...
                        'Position', [50, 810, 1300, 25], ...
                        'FontSize', 14, ...
                        'HorizontalAlignment', 'center', ...
                        'FontColor', [0.3, 0.3, 0.3]);
    
    % Panel de opciones principales
    panel_menu = uipanel(fig, 'Title', 'MENÚ PRINCIPAL', ...
                         'Position', [30, 600, 400, 200], ...
                         'FontSize', 12, ...
                         'FontWeight', 'bold', ...
                         'BackgroundColor', [0.98, 0.98, 1]);
    
    % Botones del menú principal
    btn_lineal = uibutton(panel_menu, 'Text', '1. Ecuación Lineal (ax + b = 0)', ...
                          'Position', [20, 150, 360, 30], ...
                          'FontSize', 12, ...
                          'HorizontalAlignment', 'left', ...
                          'BackgroundColor', [0.2, 0.7, 0.2], ...
                          'FontColor', 'white', ...
                          'ButtonPushedFcn', @(~,~) mostrar_panel('lineal'));
    
    btn_cuadratica = uibutton(panel_menu, 'Text', '2. Ecuación Cuadrática (ax² + bx + c = 0)', ...
                              'Position', [20, 120, 360, 30], ...
                              'FontSize', 12, ...
                              'HorizontalAlignment', 'left', ...
                              'BackgroundColor', [0.7, 0.2, 0.2], ...
                              'FontColor', 'white', ...
                              'ButtonPushedFcn', @(~,~) mostrar_panel('cuadratica'));
    
    btn_sistema = uibutton(panel_menu, 'Text', '3. Sistema de Ecuaciones Lineales 2x2', ...
                           'Position', [20, 90, 360, 30], ...
                           'FontSize', 12, ...
                           'HorizontalAlignment', 'left', ...
                           'BackgroundColor', [0.2, 0.2, 0.7], ...
                           'FontColor', 'white', ...
                           'ButtonPushedFcn', @(~,~) mostrar_panel('sistema'));
    
    btn_exponencial = uibutton(panel_menu, 'Text', '4. Ecuación Exponencial (a^x = b)', ...
                               'Position', [20, 60, 360, 30], ...
                               'FontSize', 12, ...
                               'HorizontalAlignment', 'left', ...
                               'BackgroundColor', [0.7, 0.4, 0.2], ...
                               'FontColor', 'white', ...
                               'ButtonPushedFcn', @(~,~) mostrar_panel('exponencial'));
    
    btn_logaritmica = uibutton(panel_menu, 'Text', '5. Ecuación Logarítmica (log(x) = b)', ...
                               'Position', [20, 30, 360, 30], ...
                               'FontSize', 12, ...
                               'HorizontalAlignment', 'left', ...
                               'BackgroundColor', [0.6, 0.2, 0.6], ...
                               'FontColor', 'white', ...
                               'ButtonPushedFcn', @(~,~) mostrar_panel('logaritmica'));
    
    % Panel para ecuación lineal
    panel_lineal = uipanel(fig, 'Title', 'ECUACIÓN LINEAL: ax + b = 0', ...
                           'Position', [450, 650, 350, 150], ...
                           'FontSize', 12, ...
                           'FontWeight', 'bold', ...
                           'BackgroundColor', [0.95, 1, 0.95], ...
                           'Visible', 'off');
    
    uilabel(panel_lineal, 'Text', 'a =', 'Position', [20, 100, 30, 22], 'FontWeight', 'bold');
    campo_a_lin = uieditfield(panel_lineal, 'numeric', 'Position', [60, 100, 80, 22], 'Value', 2);
    
    uilabel(panel_lineal, 'Text', 'b =', 'Position', [160, 100, 30, 22], 'FontWeight', 'bold');
    campo_b_lin = uieditfield(panel_lineal, 'numeric', 'Position', [200, 100, 80, 22], 'Value', -6);
    
    btn_resolver_lin = uibutton(panel_lineal, 'Text', 'RESOLVER', ...
                                'Position', [20, 60, 120, 30], ...
                                'BackgroundColor', [0.2, 0.7, 0.2], ...
                                'FontColor', 'white', ...
                                'ButtonPushedFcn', @resolver_lineal);
    
    btn_graficar_lin = uibutton(panel_lineal, 'Text', 'GRAFICAR', ...
                                'Position', [160, 60, 120, 30], ...
                                'BackgroundColor', [0.7, 0.4, 0.2], ...
                                'FontColor', 'white', ...
                                'ButtonPushedFcn', @graficar_lineal);
    
    % Panel para ecuación cuadrática
    panel_cuadratica = uipanel(fig, 'Title', 'ECUACIÓN CUADRÁTICA: ax² + bx + c = 0', ...
                               'Position', [450, 650, 350, 150], ...
                               'FontSize', 12, ...
                               'FontWeight', 'bold', ...
                               'BackgroundColor', [1, 0.95, 0.95], ...
                               'Visible', 'off');
    
    uilabel(panel_cuadratica, 'Text', 'a =', 'Position', [20, 100, 30, 22], 'FontWeight', 'bold');
    campo_a_cuad = uieditfield(panel_cuadratica, 'numeric', 'Position', [60, 100, 70, 22], 'Value', 1);
    
    uilabel(panel_cuadratica, 'Text', 'b =', 'Position', [140, 100, 30, 22], 'FontWeight', 'bold');
    campo_b_cuad = uieditfield(panel_cuadratica, 'numeric', 'Position', [180, 100, 70, 22], 'Value', -5);
    
    uilabel(panel_cuadratica, 'Text', 'c =', 'Position', [260, 100, 30, 22], 'FontWeight', 'bold');
    campo_c_cuad = uieditfield(panel_cuadratica, 'numeric', 'Position', [290, 100, 70, 22], 'Value', 6);
    
    btn_resolver_cuad = uibutton(panel_cuadratica, 'Text', 'RESOLVER', ...
                                 'Position', [20, 60, 120, 30], ...
                                 'BackgroundColor', [0.7, 0.2, 0.2], ...
                                 'FontColor', 'white', ...
                                 'ButtonPushedFcn', @resolver_cuadratica);
    
    btn_graficar_cuad = uibutton(panel_cuadratica, 'Text', 'GRAFICAR', ...
                                 'Position', [160, 60, 120, 30], ...
                                 'BackgroundColor', [0.7, 0.4, 0.2], ...
                                 'FontColor', 'white', ...
                                 'ButtonPushedFcn', @graficar_cuadratica);
    
    % Panel para sistema de ecuaciones
    panel_sistema = uipanel(fig, 'Title', 'SISTEMA 2x2: a₁x + b₁y = c₁; a₂x + b₂y = c₂', ...
                            'Position', [450, 600, 350, 200], ...
                            'FontSize', 12, ...
                            'FontWeight', 'bold', ...
                            'BackgroundColor', [0.95, 0.95, 1], ...
                            'Visible', 'off');
    
    uilabel(panel_sistema, 'Text', 'Primera ecuación:', 'Position', [20, 150, 120, 22], 'FontWeight', 'bold');
    uilabel(panel_sistema, 'Text', 'a₁=', 'Position', [20, 120, 30, 22]);
    campo_a1 = uieditfield(panel_sistema, 'numeric', 'Position', [50, 120, 50, 22], 'Value', 2);
    uilabel(panel_sistema, 'Text', 'b₁=', 'Position', [110, 120, 30, 22]);
    campo_b1 = uieditfield(panel_sistema, 'numeric', 'Position', [140, 120, 50, 22], 'Value', 3);
    uilabel(panel_sistema, 'Text', 'c₁=', 'Position', [200, 120, 30, 22]);
    campo_c1 = uieditfield(panel_sistema, 'numeric', 'Position', [230, 120, 50, 22], 'Value', 7);
    
    uilabel(panel_sistema, 'Text', 'Segunda ecuación:', 'Position', [20, 90, 120, 22], 'FontWeight', 'bold');
    uilabel(panel_sistema, 'Text', 'a₂=', 'Position', [20, 60, 30, 22]);
    campo_a2 = uieditfield(panel_sistema, 'numeric', 'Position', [50, 60, 50, 22], 'Value', 1);
    uilabel(panel_sistema, 'Text', 'b₂=', 'Position', [110, 60, 30, 22]);
    campo_b2 = uieditfield(panel_sistema, 'numeric', 'Position', [140, 60, 50, 22], 'Value', -1);
    uilabel(panel_sistema, 'Text', 'c₂=', 'Position', [200, 60, 30, 22]);
    campo_c2 = uieditfield(panel_sistema, 'numeric', 'Position', [230, 60, 50, 22], 'Value', 1);
    
    btn_resolver_sist = uibutton(panel_sistema, 'Text', 'RESOLVER', ...
                                 'Position', [20, 20, 120, 30], ...
                                 'BackgroundColor', [0.2, 0.2, 0.7], ...
                                 'FontColor', 'white', ...
                                 'ButtonPushedFcn', @resolver_sistema);
    
    btn_graficar_sist = uibutton(panel_sistema, 'Text', 'GRAFICAR', ...
                                 'Position', [160, 20, 120, 30], ...
                                 'BackgroundColor', [0.7, 0.4, 0.2], ...
                                 'FontColor', 'white', ...
                                 'ButtonPushedFcn', @graficar_sistema);
    
    % Panel para ecuación exponencial
    panel_exponencial = uipanel(fig, 'Title', 'ECUACIÓN EXPONENCIAL: a^x = b', ...
                                'Position', [450, 650, 350, 150], ...
                                'FontSize', 12, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', [1, 0.98, 0.95], ...
                                'Visible', 'off');
    
    uilabel(panel_exponencial, 'Text', 'a (base) =', 'Position', [20, 100, 80, 22], 'FontWeight', 'bold');
    campo_a_exp = uieditfield(panel_exponencial, 'numeric', 'Position', [110, 100, 80, 22], 'Value', 2);
    
    uilabel(panel_exponencial, 'Text', 'b (resultado) =', 'Position', [200, 100, 100, 22], 'FontWeight', 'bold');
    campo_b_exp = uieditfield(panel_exponencial, 'numeric', 'Position', [210, 70, 80, 22], 'Value', 8);
    
    btn_resolver_exp = uibutton(panel_exponencial, 'Text', 'RESOLVER', ...
                                'Position', [20, 30, 120, 30], ...
                                'BackgroundColor', [0.7, 0.4, 0.2], ...
                                'FontColor', 'white', ...
                                'ButtonPushedFcn', @resolver_exponencial);
    
    btn_graficar_exp = uibutton(panel_exponencial, 'Text', 'GRAFICAR', ...
                                'Position', [160, 30, 120, 30], ...
                                'BackgroundColor', [0.7, 0.4, 0.2], ...
                                'FontColor', 'white', ...
                                'ButtonPushedFcn', @graficar_exponencial);
    
    % Panel para ecuación logarítmica
    panel_logaritmica = uipanel(fig, 'Title', 'ECUACIÓN LOGARÍTMICA: log_a(x) = b', ...
                                'Position', [450, 650, 350, 150], ...
                                'FontSize', 12, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', [0.98, 0.95, 1], ...
                                'Visible', 'off');
    
    uilabel(panel_logaritmica, 'Text', 'a (base) =', 'Position', [20, 100, 80, 22], 'FontWeight', 'bold');
    campo_a_log = uieditfield(panel_logaritmica, 'numeric', 'Position', [110, 100, 80, 22], 'Value', 10);
    
    uilabel(panel_logaritmica, 'Text', 'b (resultado) =', 'Position', [200, 100, 100, 22], 'FontWeight', 'bold');
    campo_b_log = uieditfield(panel_logaritmica, 'numeric', 'Position', [210, 70, 80, 22], 'Value', 2);
    
    btn_resolver_log = uibutton(panel_logaritmica, 'Text', 'RESOLVER', ...
                                'Position', [20, 30, 120, 30], ...
                                'BackgroundColor', [0.6, 0.2, 0.6], ...
                                'FontColor', 'white', ...
                                'ButtonPushedFcn', @resolver_logaritmica);
    
    btn_graficar_log = uibutton(panel_logaritmica, 'Text', 'GRAFICAR', ...
                                'Position', [160, 30, 120, 30], ...
                                'BackgroundColor', [0.7, 0.4, 0.2], ...
                                'FontColor', 'white', ...
                                'ButtonPushedFcn', @graficar_logaritmica);
    
    % Panel de gráfica
    panel_grafica = uipanel(fig, 'Title', 'GRÁFICA', ...
                            'Position', [820, 400, 550, 400], ...
                            'FontSize', 12, ...
                            'FontWeight', 'bold', ...
                            'BackgroundColor', [0.99, 0.99, 0.99]);
    
    axes_grafica = uiaxes(panel_grafica, 'Position', [20, 20, 510, 350]);
    
    % Panel de resultados
    panel_resultados = uipanel(fig, 'Title', 'RESULTADOS Y SOLUCIÓN', ...
                               'Position', [30, 50, 1340, 340], ...
                               'FontSize', 12, ...
                               'FontWeight', 'bold', ...
                               'BackgroundColor', [0.98, 0.98, 0.98]);
    
    texto_resultados = uitextarea(panel_resultados, ...
                                  'Position', [20, 20, 1300, 290], ...
                                  'Editable', 'off', ...
                                  'FontSize', 11, ...
                                  'Value', {'=== SOLUCIONADOR DE ECUACIONES ===', ...
                                           '', ...
                                           'Seleccione el tipo de ecuación que desea resolver:', ...
                                           '', ...
                                           '• Ecuación Lineal: ax + b = 0', ...
                                           '• Ecuación Cuadrática: ax² + bx + c = 0', ...
                                           '• Sistema de Ecuaciones Lineales 2x2', ...
                                           '• Ecuación Exponencial: a^x = b', ...
                                           '• Ecuación Logarítmica: log_a(x) = b', ...
                                           '', ...
                                           'Cada tipo incluye:', ...
                                           '✓ Resolución paso a paso', ...
                                           '✓ Verificación de resultados', ...
                                           '✓ Visualización gráfica', ...
                                           '✓ Análisis de casos especiales'});
    
    % Variable para el panel actual
    panel_actual = '';
    
    % Función para mostrar paneles
    function mostrar_panel(tipo)
        % Ocultar todos los paneles
        panel_lineal.Visible = 'off';
        panel_cuadratica.Visible = 'off';
        panel_sistema.Visible = 'off';
        panel_exponencial.Visible = 'off';
        panel_logaritmica.Visible = 'off';
        
        % Mostrar el panel seleccionado
        switch tipo
            case 'lineal'
                panel_lineal.Visible = 'on';
                panel_actual = 'lineal';
            case 'cuadratica'
                panel_cuadratica.Visible = 'on';
                panel_actual = 'cuadratica';
            case 'sistema'
                panel_sistema.Visible = 'on';
                panel_actual = 'sistema';
            case 'exponencial'
                panel_exponencial.Visible = 'on';
                panel_actual = 'exponencial';
            case 'logaritmica'
                panel_logaritmica.Visible = 'on';
                panel_actual = 'logaritmica';
        end
        
        % Limpiar gráfica y resultados
        cla(axes_grafica);
        texto_resultados.Value = {['=== ' upper(tipo) ' SELECCIONADA ==='], ...
                                 '', ...
                                 'Ingrese los coeficientes y presione RESOLVER.'};
    end
    
    % Funciones de resolución
    function resolver_lineal(~, ~)
        try
            a = campo_a_lin.Value;
            b = campo_b_lin.Value;
            
            if a == 0
                if b == 0
                    resultado = {'=== ECUACIÓN LINEAL ===', ...
                                '', ...
                                'Ecuación: 0x + 0 = 0', ...
                                '', ...
                                '✓ RESULTADO: Infinitas soluciones', ...
                                'Cualquier valor de x satisface la ecuación.'};
                else
                    resultado = {'=== ECUACIÓN LINEAL ===', ...
                                '', ...
                                sprintf('Ecuación: 0x + %.2f = 0', b), ...
                                '', ...
                                '✗ RESULTADO: No hay solución', ...
                                'La ecuación es inconsistente.'};
                end
            else
                x = -b/a;
                verificacion = a*x + b;
                
                resultado = {'=== ECUACIÓN LINEAL ===', ...
                            '', ...
                            sprintf('Ecuación: %.2fx + %.2f = 0', a, b), ...
                            '', ...
                            sprintf('✓ SOLUCIÓN: x = %.6f', x), ...
                            '', ...
                            'VERIFICACIÓN:', ...
                            sprintf('%.2f(%.6f) + %.2f = %.10f ≈ 0', a, x, b, verificacion)};
            end
            
            texto_resultados.Value = resultado;
            
        catch e
            texto_resultados.Value = {'ERROR', '', e.message};
        end
    end
    
    function resolver_cuadratica(~, ~)
        try
            a = campo_a_cuad.Value;
            b = campo_b_cuad.Value;
            c = campo_c_cuad.Value;
            
            if a == 0
                texto_resultados.Value = {'ERROR', '', 'No es una ecuación cuadrática (a = 0)'};
                return;
            end
            
            discriminante = b^2 - 4*a*c;
            
            resultado = {'=== ECUACIÓN CUADRÁTICA ===', ...
                        '', ...
                        sprintf('Ecuación: %.2fx² + %.2fx + %.2f = 0', a, b, c), ...
                        '', ...
                        sprintf('Discriminante: Δ = %.4f', discriminante), ...
                        ''};
            
            if discriminante > 0
                x1 = (-b + sqrt(discriminante)) / (2*a);
                x2 = (-b - sqrt(discriminante)) / (2*a);
                
                resultado{end+1} = '✓ DOS RAÍCES REALES DIFERENTES:';
                resultado{end+1} = sprintf('x₁ = %.6f', x1);
                resultado{end+1} = sprintf('x₂ = %.6f', x2);
                resultado{end+1} = '';
                resultado{end+1} = 'VERIFICACIÓN:';
                ver1 = a*x1^2 + b*x1 + c;
                ver2 = a*x2^2 + b*x2 + c;
                resultado{end+1} = sprintf('Para x₁: %.10f', ver1);
                resultado{end+1} = sprintf('Para x₂: %.10f', ver2);
                
            elseif discriminante == 0
                x = -b / (2*a);
                
                resultado{end+1} = '✓ UNA RAÍZ REAL DOBLE:';
                resultado{end+1} = sprintf('x = %.6f', x);
                resultado{end+1} = '';
                resultado{end+1} = 'VERIFICACIÓN:';
                ver = a*x^2 + b*x + c;
                resultado{end+1} = sprintf('%.10f', ver);
                
            else
                parteReal = -b / (2*a);
                parteImag = sqrt(-discriminante) / (2*a);
                
                resultado{end+1} = '✓ DOS RAÍCES COMPLEJAS CONJUGADAS:';
                resultado{end+1} = sprintf('x₁ = %.4f + %.4fi', parteReal, parteImag);
                resultado{end+1} = sprintf('x₂ = %.4f - %.4fi', parteReal, parteImag);
            end
            
            texto_resultados.Value = resultado;
            
        catch e
            texto_resultados.Value = {'ERROR', '', e.message};
        end
    end
    
    function resolver_sistema(~, ~)
        try
            a1 = campo_a1.Value; b1 = campo_b1.Value; c1 = campo_c1.Value;
            a2 = campo_a2.Value; b2 = campo_b2.Value; c2 = campo_c2.Value;
            
            A = [a1 b1; a2 b2];
            B = [c1; c2];
            determinante = det(A);
            
            resultado = {'=== SISTEMA DE ECUACIONES LINEALES 2x2 ===', ...
                        '', ...
                        'Sistema:', ...
                        sprintf('%.2fx + %.2fy = %.2f', a1, b1, c1), ...
                        sprintf('%.2fx + %.2fy = %.2f', a2, b2, c2), ...
                        '', ...
                        sprintf('Determinante: %.6f', determinante), ...
                        ''};
            
            if abs(determinante) > 1e-10
                solucion = A \ B;
                x = solucion(1);
                y = solucion(2);
                
                resultado{end+1} = '✓ SOLUCIÓN ÚNICA:';
                resultado{end+1} = sprintf('x = %.6f', x);
                resultado{end+1} = sprintf('y = %.6f', y);
                resultado{end+1} = '';
                resultado{end+1} = 'VERIFICACIÓN:';
                ver1 = a1*x + b1*y;
                ver2 = a2*x + b2*y;
                resultado{end+1} = sprintf('Ecuación 1: %.6f ≈ %.2f', ver1, c1);
                resultado{end+1} = sprintf('Ecuación 2: %.6f ≈ %.2f', ver2, c2);
            else
                if rank(A) == rank([A B])
                    resultado{end+1} = '✓ INFINITAS SOLUCIONES';
                else
                    resultado{end+1} = '✗ NO HAY SOLUCIÓN';
                end
            end
            
            texto_resultados.Value = resultado;
            
        catch e
            texto_resultados.Value = {'ERROR', '', e.message};
        end
    end
    
    function resolver_exponencial(~, ~)
        try
            a = campo_a_exp.Value;
            b = campo_b_exp.Value;
            
            if a <= 0 || a == 1
                texto_resultados.Value = {'ERROR', '', 'La base debe ser positiva y diferente de 1'};
                return;
            end
            
            if b <= 0
                texto_resultados.Value = {'ERROR', '', 'El resultado debe ser positivo'};
                return;
            end
            
            x = log(b) / log(a);
            verificacion = a^x;
            
            resultado = {'=== ECUACIÓN EXPONENCIAL ===', ...
                        '', ...
                        sprintf('Ecuación: %.2f^x = %.2f', a, b), ...
                        '', ...
                        sprintf('✓ SOLUCIÓN: x = %.6f', x), ...
                        '', ...
                        'VERIFICACIÓN:', ...
                        sprintf('%.2f^%.6f = %.6f ≈ %.2f', a, x, verificacion, b), ...
                        '', ...
                        'MÉTODO ALTERNATIVO (log₁₀):', ...
                        sprintf('x = log₁₀(%.2f) / log₁₀(%.2f) = %.6f', b, a, log10(b)/log10(a))};
            
            texto_resultados.Value = resultado;
            
        catch e
            texto_resultados.Value = {'ERROR', '', e.message};
        end
    end
    
    function resolver_logaritmica(~, ~)
        try
            a = campo_a_log.Value;
            b = campo_b_log.Value;
            
            if a <= 0 || a == 1
                texto_resultados.Value = {'ERROR', '', 'La base debe ser positiva y diferente de 1'};
                return;
            end
            
            x = a^b;
            verificacion = log(x) / log(a);
            
            resultado = {'=== ECUACIÓN LOGARÍTMICA ===', ...
                        '', ...
                        sprintf('Ecuación: log₍%.2f₎(x) = %.2f', a, b), ...
                        '', ...
                        sprintf('✓ SOLUCIÓN: x = %.6f', x), ...
                        '', ...
                        'VERIFICACIÓN:', ...
                        sprintf('log₍%.2f₎(%.6f) = %.6f ≈ %.2f', a, x, verificacion, b)};
            
            if a == 10
                resultado{end+1} = '';
                resultado{end+1} = 'CASO ESPECIAL:';
                resultado{end+1} = sprintf('log₁₀(%.6f) = %.6f', x, log10(x));
            elseif abs(a - exp(1)) < 1e-10
                resultado{end+1} = '';
                resultado{end+1} = 'CASO ESPECIAL:';
                resultado{end+1} = sprintf('ln(%.6f) = %.6f', x, log(x));
            end
            
            texto_resultados.Value = resultado;
            
        catch e
            texto_resultados.Value = {'ERROR', '', e.message};
        end
    end
    
    % Funciones de graficación
    function graficar_lineal(~, ~)
        try
            a = campo_a_lin.Value;
            b = campo_b_lin.Value;
            
            if a ~= 0
                x_vals = linspace(-10, 10, 1000);
                y_vals = a * x_vals + b;
                
                cla(axes_grafica);
                plot(axes_grafica, x_vals, y_vals, 'b-', 'LineWidth', 2);
                hold(axes_grafica, 'on');
                
                % Línea y = 0
                plot(axes_grafica, [-10, 10], [0, 0], 'k--', 'LineWidth', 1);
                
                % Marcar la raíz
                x_raiz = -b/a;
                plot(axes_grafica, x_raiz, 0, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
                
                title(axes_grafica, sprintf('Ecuación Lineal: %.2fx + %.2f = 0', a, b));
                xlabel(axes_grafica, 'x');
                ylabel(axes_grafica, 'y');
                legend(axes_grafica, {'f(x) = ax + b', 'y = 0', sprintf('Raíz: x = %.3f', x_raiz)}, 'Location', 'best');
                grid(axes_grafica, 'on');
                hold(axes_grafica, 'off');
            end
        catch
            % Manejar errores silenciosamente
        end
    end
    
    function graficar_cuadratica(~, ~)
        try
            a = campo_a_cuad.Value;
            b = campo_b_cuad.Value;
            c = campo_c_cuad.Value;
            
            if a ~= 0
                x_vals = linspace(-10, 10, 1000);
                y_vals = a * x_vals.^2 + b * x_vals + c;
                
                cla(axes_grafica);
                plot(axes_grafica, x_vals, y_vals, 'r-', 'LineWidth', 2);
                hold(axes_grafica, 'on');
                
                % Línea y = 0
                plot(axes_grafica, [-10, 10], [0, 0], 'k--', 'LineWidth', 1);
                
                % Marcar raíces si existen
                discriminante = b^2 - 4*a*c;
                if discriminante >= 0
                    if discriminante > 0
                        x1 = (-b + sqrt(discriminante)) / (2*a);
                        x2 = (-b - sqrt(discriminante)) / (2*a);
                        plot(axes_grafica, [x1, x2], [0, 0], 'ro', 'MarkerSize', 8, 'LineWidth', 2);
                        legend_text = {sprintf('f(x) = %.2fx² + %.2fx + %.2f', a, b, c), 'y = 0', sprintf('Raíces: %.3f, %.3f', x1, x2)};
                    else
                        x_raiz = -b / (2*a);
                        plot(axes_grafica, x_raiz, 0, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
                        legend_text = {sprintf('f(x) = %.2fx² + %.2fx + %.2f', a, b, c), 'y = 0', sprintf('Raíz doble: %.3f', x_raiz)};
                    end
                else
                    legend_text = {sprintf('f(x) = %.2fx² + %.2fx + %.2f', a, b, c), 'y = 0'};
                end
                
                % Marcar vértice
                x_vertice = -b/(2*a);
                y_vertice = a*x_vertice^2 + b*x_vertice + c;
                plot(axes_grafica, x_vertice, y_vertice, 'go', 'MarkerSize', 6, 'LineWidth', 2);
                
                title(axes_grafica, sprintf('Ecuación Cuadrática: %.2fx² + %.2fx + %.2f = 0', a, b, c));
                xlabel(axes_grafica, 'x');
                ylabel(axes_grafica, 'y');
                legend(axes_grafica, legend_text, 'Location', 'best');
                grid(axes_grafica, 'on');
                hold(axes_grafica, 'off');
            end
        catch
            % Manejar errores silenciosamente
        end
    end
    
    function graficar_sistema(~, ~)
        try
            a1 = campo_a1.Value; b1 = campo_b1.Value; c1 = campo_c1.Value;
            a2 = campo_a2.Value; b2 = campo_b2.Value; c2 = campo_c2.Value;
            
            x_vals = linspace(-10, 10, 1000);
            
            cla(axes_grafica);
            
            % Primera ecuación: a1*x + b1*y = c1 -> y = (c1 - a1*x)/b1
            if b1 ~= 0
                y1_vals = (c1 - a1*x_vals) / b1;
                plot(axes_grafica, x_vals, y1_vals, 'b-', 'LineWidth', 2);
                hold(axes_grafica, 'on');
            end
            
            % Segunda ecuación: a2*x + b2*y = c2 -> y = (c2 - a2*x)/b2
            if b2 ~= 0
                y2_vals = (c2 - a2*x_vals) / b2;
                plot(axes_grafica, x_vals, y2_vals, 'r-', 'LineWidth', 2);
            end
            
            % Punto de intersección si existe
            A = [a1 b1; a2 b2];
            B = [c1; c2];
            if abs(det(A)) > 1e-10
                solucion = A \ B;
                plot(axes_grafica, solucion(1), solucion(2), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
                legend_text = {'Ecuación 1', 'Ecuación 2', sprintf('Solución: (%.3f, %.3f)', solucion(1), solucion(2))};
            else
                legend_text = {'Ecuación 1', 'Ecuación 2'};
            end
            
            title(axes_grafica, 'Sistema de Ecuaciones Lineales 2x2');
            xlabel(axes_grafica, 'x');
            ylabel(axes_grafica, 'y');
            legend(axes_grafica, legend_text, 'Location', 'best');
            grid(axes_grafica, 'on');
            axis(axes_grafica, 'equal');
            hold(axes_grafica, 'off');
            
        catch
            % Manejar errores silenciosamente
        end
    end
    
    function graficar_exponencial(~, ~)
        try
            a = campo_a_exp.Value;
            b = campo_b_exp.Value;
            
            if a > 0 && a ~= 1 && b > 0
                x_vals = linspace(-5, 5, 1000);
                y_vals = a .^ x_vals;
                
                cla(axes_grafica);
                plot(axes_grafica, x_vals, y_vals, 'Color', [0.8, 0.4, 0.2], 'LineWidth', 2);
                hold(axes_grafica, 'on');
                
                % Línea horizontal en y = b
                plot(axes_grafica, [-5, 5], [b, b], 'k--', 'LineWidth', 1);
                
                % Punto de intersección
                x_solucion = log(b) / log(a);
                plot(axes_grafica, x_solucion, b, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
                
                title(axes_grafica, sprintf('Ecuación Exponencial: %.2f^x = %.2f', a, b));
                xlabel(axes_grafica, 'x');
                ylabel(axes_grafica, 'y');
                legend(axes_grafica, {sprintf('y = %.2f^x', a), sprintf('y = %.2f', b), sprintf('Solución: x = %.3f', x_solucion)}, 'Location', 'best');
                grid(axes_grafica, 'on');
                hold(axes_grafica, 'off');
            end
        catch
            % Manejar errores silenciosamente
        end
    end
    
    function graficar_logaritmica(~, ~)
        try
            a = campo_a_log.Value;
            b = campo_b_log.Value;
            
            if a > 0 && a ~= 1
                x_vals = linspace(0.1, 10, 1000);
                y_vals = log(x_vals) / log(a);
                
                cla(axes_grafica);
                plot(axes_grafica, x_vals, y_vals, 'Color', [0.6, 0.2, 0.6], 'LineWidth', 2);
                hold(axes_grafica, 'on');
                
                % Línea horizontal en y = b
                plot(axes_grafica, [0, 10], [b, b], 'k--', 'LineWidth', 1);
                
                % Punto de intersección
                x_solucion = a^b;
                if x_solucion <= 10
                    plot(axes_grafica, x_solucion, b, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
                end
                
                title(axes_grafica, sprintf('Ecuación Logarítmica: log₍%.2f₎(x) = %.2f', a, b));
                xlabel(axes_grafica, 'x');
                ylabel(axes_grafica, 'y');
                legend(axes_grafica, {sprintf('y = log₍%.2f₎(x)', a), sprintf('y = %.2f', b), sprintf('Solución: x = %.3f', x_solucion)}, 'Location', 'best');
                grid(axes_grafica, 'on');
                hold(axes_grafica, 'off');
            end
        catch
            % Manejar errores silenciosamente
        end
    end
    
    % Botón de salir
    btn_salir = uibutton(fig, 'Text', 'SALIR', ...
                         'Position', [1250, 40, 100, 35], ...
                         'FontSize', 12, ...
                         'FontWeight', 'bold', ...
                         'BackgroundColor', [0.8, 0.2, 0.2], ...
                         'FontColor', 'white', ...
                         'ButtonPushedFcn', @(~,~) close(fig));
    
    % Mostrar panel lineal por defecto
    mostrar_panel('lineal');
end