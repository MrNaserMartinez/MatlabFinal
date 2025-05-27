function calculadora_matrices_gui()
    % Interfaz gráfica completa para calculadora de matrices
    
    % Crear la figura principal
    fig = uifigure('Name', 'Calculadora de Matrices', ...
                   'Position', [30, 20, 1500, 950], ...
                   'Resize', 'off', ...
                   'Color', [0.94, 0.94, 0.94]);
    
    % Título principal
    titulo = uilabel(fig, 'Text', 'CALCULADORA DE MATRICES', ...
                     'Position', [50, 890, 1400, 40], ...
                     'FontSize', 28, ...
                     'FontWeight', 'bold', ...
                     'HorizontalAlignment', 'center', ...
                     'BackgroundColor', [0.2, 0.3, 0.6], ...
                     'FontColor', 'white');
    
    % Subtítulo
    subtitulo = uilabel(fig, 'Text', 'Herramienta completa para operaciones con matrices y sistemas de ecuaciones', ...
                        'Position', [50, 860, 1400, 25], ...
                        'FontSize', 14, ...
                        'HorizontalAlignment', 'center', ...
                        'FontColor', [0.3, 0.3, 0.3]);
    
    % Panel del menú principal
    panel_menu = uipanel(fig, 'Title', 'MENÚ PRINCIPAL', ...
                         'Position', [30, 700, 350, 150], ...
                         'FontSize', 12, ...
                         'FontWeight', 'bold', ...
                         'BackgroundColor', [0.98, 0.98, 1]);
    
    % Botones del menú
    btn_operaciones = uibutton(panel_menu, 'Text', '1. Operaciones Básicas', ...
                               'Position', [20, 100, 310, 25], ...
                               'FontSize', 11, ...
                               'HorizontalAlignment', 'left', ...
                               'BackgroundColor', [0.2, 0.7, 0.2], ...
                               'FontColor', 'white', ...
                               'ButtonPushedFcn', @(~,~) mostrar_panel('operaciones'));
    
    btn_determinante = uibutton(panel_menu, 'Text', '2. Calcular Determinante', ...
                                'Position', [20, 75, 310, 25], ...
                                'FontSize', 11, ...
                                'HorizontalAlignment', 'left', ...
                                'BackgroundColor', [0.7, 0.2, 0.2], ...
                                'FontColor', 'white', ...
                                'ButtonPushedFcn', @(~,~) mostrar_panel('determinante'));
    
    btn_inversa = uibutton(panel_menu, 'Text', '3. Matriz Inversa', ...
                           'Position', [20, 50, 310, 25], ...
                           'FontSize', 11, ...
                           'HorizontalAlignment', 'left', ...
                           'BackgroundColor', [0.2, 0.2, 0.7], ...
                           'FontColor', 'white', ...
                           'ButtonPushedFcn', @(~,~) mostrar_panel('inversa'));
    
    btn_transpuesta = uibutton(panel_menu, 'Text', '4. Matriz Transpuesta', ...
                               'Position', [20, 25, 150, 25], ...
                               'FontSize', 11, ...
                               'HorizontalAlignment', 'left', ...
                               'BackgroundColor', [0.6, 0.4, 0.2], ...
                               'FontColor', 'white', ...
                               'ButtonPushedFcn', @(~,~) mostrar_panel('transpuesta'));
    
    btn_sistema = uibutton(panel_menu, 'Text', '5. Sistema de Ecuaciones', ...
                           'Position', [180, 25, 150, 25], ...
                           'FontSize', 11, ...
                           'HorizontalAlignment', 'left', ...
                           'BackgroundColor', [0.6, 0.2, 0.6], ...
                           'FontColor', 'white', ...
                           'ButtonPushedFcn', @(~,~) mostrar_panel('sistema'));
    
    % Panel para operaciones básicas
    panel_operaciones = uipanel(fig, 'Title', 'OPERACIONES BÁSICAS CON MATRICES', ...
                                'Position', [400, 650, 500, 200], ...
                                'FontSize', 12, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', [0.95, 1, 0.95], ...
                                'Visible', 'off');
    
    % Submenú de operaciones
    btn_suma = uibutton(panel_operaciones, 'Text', 'SUMA (A + B)', ...
                        'Position', [20, 140, 220, 30], ...
                        'BackgroundColor', [0.2, 0.7, 0.2], ...
                        'FontColor', 'white', ...
                        'ButtonPushedFcn', @(~,~) ejecutar_operacion('suma'));
    
    btn_resta = uibutton(panel_operaciones, 'Text', 'RESTA (A - B)', ...
                         'Position', [260, 140, 220, 30], ...
                         'BackgroundColor', [0.7, 0.3, 0.2], ...
                         'FontColor', 'white', ...
                         'ButtonPushedFcn', @(~,~) ejecutar_operacion('resta'));
    
    btn_multiplicacion = uibutton(panel_operaciones, 'Text', 'MULTIPLICACIÓN (A × B)', ...
                                  'Position', [20, 100, 220, 30], ...
                                  'BackgroundColor', [0.2, 0.2, 0.7], ...
                                  'FontColor', 'white', ...
                                  'ButtonPushedFcn', @(~,~) ejecutar_operacion('multiplicacion'));
    
    btn_escalar = uibutton(panel_operaciones, 'Text', 'MULT. ESCALAR (k × A)', ...
                           'Position', [260, 100, 220, 30], ...
                           'BackgroundColor', [0.6, 0.4, 0.2], ...
                           'FontColor', 'white', ...
                           'ButtonPushedFcn', @(~,~) ejecutar_operacion('escalar'));
    
    % Información sobre operaciones
    uilabel(panel_operaciones, 'Text', 'Operaciones disponibles:', ...
            'Position', [20, 60, 200, 20], 'FontWeight', 'bold');
    uilabel(panel_operaciones, 'Text', '• Suma y resta: matrices del mismo tamaño', ...
            'Position', [20, 40, 300, 15], 'FontSize', 9);
    uilabel(panel_operaciones, 'Text', '• Multiplicación: columnas de A = filas de B', ...
            'Position', [20, 25, 300, 15], 'FontSize', 9);
    uilabel(panel_operaciones, 'Text', '• Multiplicación por escalar: cualquier tamaño', ...
            'Position', [20, 10, 300, 15], 'FontSize', 9);
    
    % Panel para determinante
    panel_determinante = uipanel(fig, 'Title', 'CÁLCULO DEL DETERMINANTE', ...
                                 'Position', [400, 700, 350, 150], ...
                                 'FontSize', 12, ...
                                 'FontWeight', 'bold', ...
                                 'BackgroundColor', [1, 0.95, 0.95], ...
                                 'Visible', 'off');
    
    uilabel(panel_determinante, 'Text', 'Tamaño de matriz cuadrada:', ...
            'Position', [20, 100, 180, 22], 'FontWeight', 'bold');
    
    campo_n_det = uieditfield(panel_determinante, 'numeric', ...
                              'Position', [210, 100, 80, 22], ...
                              'Value', 3, ...
                              'Limits', [1, 10]);
    
    btn_calc_det = uibutton(panel_determinante, 'Text', 'CALCULAR DETERMINANTE', ...
                            'Position', [20, 60, 270, 30], ...
                            'BackgroundColor', [0.7, 0.2, 0.2], ...
                            'FontColor', 'white', ...
                            'ButtonPushedFcn', @calcular_determinante);
    
    uilabel(panel_determinante, 'Text', 'El determinante indica si la matriz es invertible', ...
            'Position', [20, 30, 300, 15], 'FontSize', 9, 'FontColor', [0.5, 0.5, 0.5]);
    uilabel(panel_determinante, 'Text', 'det ≠ 0: invertible, det = 0: singular', ...
            'Position', [20, 15, 300, 15], 'FontSize', 9, 'FontColor', [0.5, 0.5, 0.5]);
    
    % Panel para matriz inversa
    panel_inversa = uipanel(fig, 'Title', 'MATRIZ INVERSA', ...
                            'Position', [400, 700, 350, 150], ...
                            'FontSize', 12, ...
                            'FontWeight', 'bold', ...
                            'BackgroundColor', [0.95, 0.95, 1], ...
                            'Visible', 'off');
    
    uilabel(panel_inversa, 'Text', 'Tamaño de matriz cuadrada:', ...
            'Position', [20, 100, 180, 22], 'FontWeight', 'bold');
    
    campo_n_inv = uieditfield(panel_inversa, 'numeric', ...
                              'Position', [210, 100, 80, 22], ...
                              'Value', 3, ...
                              'Limits', [1, 10]);
    
    btn_calc_inv = uibutton(panel_inversa, 'Text', 'CALCULAR INVERSA', ...
                            'Position', [20, 60, 270, 30], ...
                            'BackgroundColor', [0.2, 0.2, 0.7], ...
                            'FontColor', 'white', ...
                            'ButtonPushedFcn', @calcular_inversa);
    
    uilabel(panel_inversa, 'Text', 'A⁻¹ existe solo si det(A) ≠ 0', ...
            'Position', [20, 30, 300, 15], 'FontSize', 9, 'FontColor', [0.5, 0.5, 0.5]);
    uilabel(panel_inversa, 'Text', 'Verifica: A × A⁻¹ = I', ...
            'Position', [20, 15, 300, 15], 'FontSize', 9, 'FontColor', [0.5, 0.5, 0.5]);
    
    % Panel para transpuesta
    panel_transpuesta = uipanel(fig, 'Title', 'MATRIZ TRANSPUESTA', ...
                                'Position', [400, 700, 350, 150], ...
                                'FontSize', 12, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', [1, 0.98, 0.95], ...
                                'Visible', 'off');
    
    uilabel(panel_transpuesta, 'Text', 'Filas:', 'Position', [20, 100, 50, 22], 'FontWeight', 'bold');
    campo_filas_t = uieditfield(panel_transpuesta, 'numeric', 'Position', [80, 100, 60, 22], 'Value', 3, 'Limits', [1, 10]);
    
    uilabel(panel_transpuesta, 'Text', 'Columnas:', 'Position', [160, 100, 70, 22], 'FontWeight', 'bold');
    campo_cols_t = uieditfield(panel_transpuesta, 'numeric', 'Position', [240, 100, 60, 22], 'Value', 3, 'Limits', [1, 10]);
    
    btn_calc_transp = uibutton(panel_transpuesta, 'Text', 'CALCULAR TRANSPUESTA', ...
                               'Position', [20, 60, 280, 30], ...
                               'BackgroundColor', [0.6, 0.4, 0.2], ...
                               'FontColor', 'white', ...
                               'ButtonPushedFcn', @calcular_transpuesta);
    
    uilabel(panel_transpuesta, 'Text', 'Aᵀ convierte filas en columnas', ...
            'Position', [20, 30, 300, 15], 'FontSize', 9, 'FontColor', [0.5, 0.5, 0.5]);
    uilabel(panel_transpuesta, 'Text', 'Dimensiones: (m×n) → (n×m)', ...
            'Position', [20, 15, 300, 15], 'FontSize', 9, 'FontColor', [0.5, 0.5, 0.5]);
    
    % Panel para sistema de ecuaciones
    panel_sistema = uipanel(fig, 'Title', 'SISTEMA DE ECUACIONES: Ax = b', ...
                            'Position', [400, 700, 350, 150], ...
                            'FontSize', 12, ...
                            'FontWeight', 'bold', ...
                            'BackgroundColor', [0.98, 0.95, 1], ...
                            'Visible', 'off');
    
    uilabel(panel_sistema, 'Text', 'Número de ecuaciones/variables:', ...
            'Position', [20, 100, 200, 22], 'FontWeight', 'bold');
    
    campo_n_sis = uieditfield(panel_sistema, 'numeric', ...
                              'Position', [230, 100, 60, 22], ...
                              'Value', 3, ...
                              'Limits', [1, 10]);
    
    btn_resolver_sis = uibutton(panel_sistema, 'Text', 'RESOLVER SISTEMA', ...
                                'Position', [20, 60, 270, 30], ...
                                'BackgroundColor', [0.6, 0.2, 0.6], ...
                                'FontColor', 'white', ...
                                'ButtonPushedFcn', @resolver_sistema);
    
    uilabel(panel_sistema, 'Text', 'Resuelve sistemas lineales usando matrices', ...
            'Position', [20, 30, 300, 15], 'FontSize', 9, 'FontColor', [0.5, 0.5, 0.5]);
    uilabel(panel_sistema, 'Text', 'Analiza existencia y unicidad de soluciones', ...
            'Position', [20, 15, 300, 15], 'FontSize', 9, 'FontColor', [0.5, 0.5, 0.5]);
    
    % Panel de entrada de matrices
    panel_entrada = uipanel(fig, 'Title', 'ENTRADA DE DATOS', ...
                            'Position', [930, 650, 540, 200], ...
                            'FontSize', 12, ...
                            'FontWeight', 'bold', ...
                            'BackgroundColor', [0.99, 0.99, 0.99]);
    
    texto_entrada = uitextarea(panel_entrada, ...
                               'Position', [15, 15, 510, 155], ...
                               'Value', {'Seleccione una operación del menú principal', ...
                                        'para comenzar a trabajar con matrices.'}, ...
                               'FontSize', 11, ...
                               'Editable', 'off');
    
    % Panel de resultados
    panel_resultados = uipanel(fig, 'Title', 'RESULTADOS Y CÁLCULOS', ...
                               'Position', [30, 50, 1440, 600], ...
                               'FontSize', 12, ...
                               'FontWeight', 'bold', ...
                               'BackgroundColor', [0.98, 0.98, 0.98]);
    
    texto_resultados = uitextarea(panel_resultados, ...
                                  'Position', [20, 20, 1400, 550], ...
                                  'Editable', 'off', ...
                                  'FontSize', 11, ...
                                  'Value', {'=== CALCULADORA DE MATRICES ===', ...
                                           '', ...
                                           'Bienvenido a la calculadora completa de matrices.', ...
                                           '', ...
                                           'OPERACIONES DISPONIBLES:', ...
                                           '', ...
                                           '1. OPERACIONES BÁSICAS:', ...
                                           '   • Suma de matrices (A + B)', ...
                                           '   • Resta de matrices (A - B)', ...
                                           '   • Multiplicación de matrices (A × B)', ...
                                           '   • Multiplicación por escalar (k × A)', ...
                                           '', ...
                                           '2. DETERMINANTE:', ...
                                           '   • Cálculo para matrices cuadradas', ...
                                           '   • Interpretación de resultados', ...
                                           '   • Análisis de invertibilidad', ...
                                           '', ...
                                           '3. MATRIZ INVERSA:', ...
                                           '   • Cálculo de A⁻¹ para matrices invertibles', ...
                                           '   • Verificación: A × A⁻¹ = I', ...
                                           '   • Análisis de condicionamiento', ...
                                           '', ...
                                           '4. MATRIZ TRANSPUESTA:', ...
                                           '   • Cálculo de Aᵀ', ...
                                           '   • Verificación de propiedades', ...
                                           '   • Análisis de simetría', ...
                                           '', ...
                                           '5. SISTEMAS DE ECUACIONES:', ...
                                           '   • Resolución de Ax = b', ...
                                           '   • Análisis de existencia y unicidad', ...
                                           '   • Verificación de soluciones', ...
                                           '', ...
                                           'Seleccione una operación para comenzar.'});
    
    % Variables globales para almacenar matrices
    matriz_A = [];
    matriz_B = [];
    vector_b = [];
    operacion_actual = '';
    
    % Función para mostrar paneles
    function mostrar_panel(tipo)
        % Ocultar todos los paneles
        panel_operaciones.Visible = 'off';
        panel_determinante.Visible = 'off';
        panel_inversa.Visible = 'off';
        panel_transpuesta.Visible = 'off';
        panel_sistema.Visible = 'off';
        
        % Mostrar el panel seleccionado
        switch tipo
            case 'operaciones'
                panel_operaciones.Visible = 'on';
                operacion_actual = 'operaciones';
                texto_entrada.Value = {'=== OPERACIONES BÁSICAS SELECCIONADAS ===', ...
                                      '', ...
                                      'Operaciones disponibles:', ...
                                      '• SUMA: A + B (matrices del mismo tamaño)', ...
                                      '• RESTA: A - B (matrices del mismo tamaño)', ...
                                      '• MULTIPLICACIÓN: A × B (columnas A = filas B)', ...
                                      '• MULT. ESCALAR: k × A (cualquier matriz)', ...
                                      '', ...
                                      'Seleccione la operación deseada.'};
            case 'determinante'
                panel_determinante.Visible = 'on';
                operacion_actual = 'determinante';
                texto_entrada.Value = {'=== CÁLCULO DEL DETERMINANTE ===', ...
                                      '', ...
                                      'El determinante es un escalar que indica:', ...
                                      '• Si det(A) ≠ 0: matriz invertible', ...
                                      '• Si det(A) = 0: matriz singular', ...
                                      '', ...
                                      'Ingrese el tamaño n para matriz n×n', ...
                                      'y presione "CALCULAR DETERMINANTE".'};
            case 'inversa'
                panel_inversa.Visible = 'on';
                operacion_actual = 'inversa';
                texto_entrada.Value = {'=== MATRIZ INVERSA A⁻¹ ===', ...
                                      '', ...
                                      'La matriz inversa A⁻¹ cumple:', ...
                                      '• A × A⁻¹ = I (matriz identidad)', ...
                                      '• Solo existe si det(A) ≠ 0', ...
                                      '', ...
                                      'Ingrese el tamaño n para matriz n×n', ...
                                      'y presione "CALCULAR INVERSA".'};
            case 'transpuesta'
                panel_transpuesta.Visible = 'on';
                operacion_actual = 'transpuesta';
                texto_entrada.Value = {'=== MATRIZ TRANSPUESTA Aᵀ ===', ...
                                      '', ...
                                      'La transpuesta intercambia filas y columnas:', ...
                                      '• (Aᵀ)ᵢⱼ = Aⱼᵢ', ...
                                      '• Dimensiones: (m×n) → (n×m)', ...
                                      '', ...
                                      'Ingrese las dimensiones de la matriz', ...
                                      'y presione "CALCULAR TRANSPUESTA".'};
            case 'sistema'
                panel_sistema.Visible = 'on';
                operacion_actual = 'sistema';
                texto_entrada.Value = {'=== SISTEMA DE ECUACIONES Ax = b ===', ...
                                      '', ...
                                      'Resuelve sistemas lineales:', ...
                                      '• Si det(A) ≠ 0: solución única', ...
                                      '• Si det(A) = 0: sin solución o infinitas', ...
                                      '', ...
                                      'Ingrese n para sistema de n ecuaciones', ...
                                      'con n incógnitas y presione "RESOLVER".'};
        end
        
        % Limpiar resultados
        texto_resultados.Value = {['=== ' upper(strrep(tipo, '_', ' ')) ' SELECCIONADA ==='], ...
                                 '', ...
                                 'Configure los parámetros en el panel superior', ...
                                 'y ejecute la operación correspondiente.', ...
                                 '', ...
                                 'Use "EJEMPLO" para cargar datos de prueba.'};
    end
    
    % Función para ejecutar operaciones básicas
    function ejecutar_operacion(tipo_op)
        try
            % Mostrar progreso inicial
            mostrar_progreso(['Iniciando ' tipo_op '...']);
            
            switch tipo_op
                case 'suma'
                    [A, B, resultado] = operacion_suma_resta('suma');
                    if ~isempty(resultado)
                        matriz_A = A;
                        matriz_B = B;
                    end
                case 'resta'
                    [A, B, resultado] = operacion_suma_resta('resta');
                    if ~isempty(resultado)
                        matriz_A = A;
                        matriz_B = B;
                    end
                case 'multiplicacion'
                    [A, B, resultado] = operacion_multiplicacion();
                    if ~isempty(resultado)
                        matriz_A = A;
                        matriz_B = B;
                    end
                case 'escalar'
                    [A, resultado] = operacion_escalar();
                    if ~isempty(resultado)
                        matriz_A = A;
                    end
                otherwise
                    error('Operación no reconocida');
            end
            
            % Actualizar estado
            texto_entrada.Value = {['=== ' upper(tipo_op) ' COMPLETADA ==='], ...
                                  '', ...
                                  '✓ Operación ejecutada exitosamente', ...
                                  '✓ Resultados mostrados abajo', ...
                                  '', ...
                                  'Puede ejecutar otra operación', ...
                                  'o usar "LIMPIAR" para reiniciar.'};
            
        catch e
            % Manejo mejorado de errores
            if contains(e.message, 'cancelada') || contains(e.message, 'Entrada cancelada')
                texto_resultados.Value = {'=== OPERACIÓN CANCELADA ===', ...
                                         '', ...
                                         'La operación fue cancelada por el usuario.', ...
                                         'Puede intentar nuevamente cuando desee.'};
                texto_entrada.Value = {'Operación cancelada', '', 'Listo para nueva operación.'};
            else
                texto_resultados.Value = {'=== ERROR EN LA OPERACIÓN ===', ...
                                         '', ...
                                         ['❌ Error: ' e.message], ...
                                         '', ...
                                         'POSIBLES CAUSAS:', ...
                                         '• Dimensiones incompatibles', ...
                                         '• Valores no numéricos ingresados', ...
                                         '• Operación cancelada', ...
                                         '', ...
                                         'Verifique los datos e intente nuevamente.'};
                texto_entrada.Value = {'ERROR', '', e.message, '', 'Revise los datos e intente de nuevo.'};
            end
        end
    end
    
    % Función para suma y resta
    function [A, B, resultado] = operacion_suma_resta(operacion)
        A = []; B = []; resultado = [];
        
        % Solicitar dimensiones
        prompt_dims = inputdlg({'Número de filas:', 'Número de columnas:'}, ...
                              'Dimensiones de las matrices', [1 50], {'3', '3'});
        if isempty(prompt_dims)
            return;
        end
        
        filas = str2double(prompt_dims{1});
        cols = str2double(prompt_dims{2});
        
        if filas <= 0 || cols <= 0 || ~isfinite(filas) || ~isfinite(cols)
            error('Las dimensiones deben ser números enteros positivos');
        end
        
        % Mostrar progreso
        mostrar_progreso('Ingresando matriz A...');
        
        % Ingresar matriz A
        A = ingresar_matriz_dialogo('A', filas, cols);
        if isempty(A), error('Entrada de matriz A cancelada'); end
        
        % Mostrar progreso
        mostrar_progreso('Ingresando matriz B...');
        
        % Ingresar matriz B
        B = ingresar_matriz_dialogo('B', filas, cols);
        if isempty(B), error('Entrada de matriz B cancelada'); end
        
        % Verificar compatibilidad
        if ~verificar_dimensiones(operacion, A, B)
            error('Dimensiones incompatibles');
        end
        
        % Realizar operación
        mostrar_progreso('Calculando resultado...');
        if strcmp(operacion, 'suma')
            C = A + B;
            simbolo = '+';
            titulo = 'SUMA DE MATRICES';
        else
            C = A - B;
            simbolo = '-';
            titulo = 'RESTA DE MATRICES';
        end
        
        % Mostrar resultados
        resultado_texto = {['=== ' titulo ' ==='], '', ...
                          sprintf('Operación: A %s B (dimensión %dx%d)', simbolo, filas, cols), '', ...
                          'Matriz A:'};
        resultado_texto = [resultado_texto, mostrar_matriz_completa(A)];
        resultado_texto{end+1} = '';
        resultado_texto{end+1} = 'Matriz B:';
        resultado_texto = [resultado_texto, mostrar_matriz_completa(B)];
        resultado_texto{end+1} = '';
        resultado_texto{end+1} = ['Resultado A ' simbolo ' B:'];
        resultado_texto = [resultado_texto, mostrar_matriz_completa(C)];
        resultado_texto{end+1} = '';
        resultado_texto{end+1} = '✓ Operación completada exitosamente';
        
        % Verificación adicional
        if strcmp(operacion, 'suma')
            % Propiedad conmutativa: A + B = B + A
            C_conm = B + A;
            if isequal(C, C_conm)
                resultado_texto{end+1} = '✓ Verificado: A + B = B + A (propiedad conmutativa)';
            end
        end
        
        texto_resultados.Value = resultado_texto;
        resultado = C;
    end
    
    % Función para multiplicación
    function [A, B, resultado] = operacion_multiplicacion()
        A = []; B = []; resultado = [];
        
        % Solicitar dimensiones de A
        prompt_A = inputdlg({'Filas de A:', 'Columnas de A:'}, ...
                           'Dimensiones de matriz A', [1 50], {'3', '2'});
        if isempty(prompt_A), error('Entrada cancelada'); end
        
        filasA = str2double(prompt_A{1});
        colsA = str2double(prompt_A{2});
        
        if filasA <= 0 || colsA <= 0 || ~isfinite(filasA) || ~isfinite(colsA)
            error('Las dimensiones deben ser números enteros positivos');
        end
        
        % Solicitar dimensiones de B
        prompt_B = inputdlg({'Filas de B:', 'Columnas de B:'}, ...
                           'Dimensiones de matriz B', [1 50], {num2str(colsA), '3'});
        if isempty(prompt_B), error('Entrada cancelada'); end
        
        filasB = str2double(prompt_B{1});
        colsB = str2double(prompt_B{2});
        
        if filasB <= 0 || colsB <= 0 || ~isfinite(filasB) || ~isfinite(colsB)
            error('Las dimensiones deben ser números enteros positivos');
        end
        
        % Verificar compatibilidad previa
        if colsA ~= filasB
            error(sprintf('Dimensiones incompatibles:\nA: %dx%d, B: %dx%d\nColumnas de A (%d) ≠ filas de B (%d)', ...
                         filasA, colsA, filasB, colsB, colsA, filasB));
        end
        
        % Ingresar matrices
        mostrar_progreso('Ingresando matriz A...');
        A = ingresar_matriz_dialogo('A', filasA, colsA);
        if isempty(A), error('Entrada de matriz A cancelada'); end
        
        mostrar_progreso('Ingresando matriz B...');
        B = ingresar_matriz_dialogo('B', filasB, colsB);
        if isempty(B), error('Entrada de matriz B cancelada'); end
        
        % Multiplicar
        mostrar_progreso('Calculando multiplicación...');
        C = A * B;
        
        % Mostrar resultados
        resultado_texto = {'=== MULTIPLICACIÓN DE MATRICES ===', '', ...
                          sprintf('Operación: A × B'), ...
                          sprintf('Dimensiones: [%dx%d] × [%dx%d] = [%dx%d]', ...
                                 filasA, colsA, filasB, colsB, size(C,1), size(C,2)), '', ...
                          'Matriz A:'};
        resultado_texto = [resultado_texto, mostrar_matriz_completa(A)];
        resultado_texto{end+1} = '';
        resultado_texto{end+1} = 'Matriz B:';
        resultado_texto = [resultado_texto, mostrar_matriz_completa(B)];
        resultado_texto{end+1} = '';
        resultado_texto{end+1} = 'Resultado A × B:';
        resultado_texto = [resultado_texto, mostrar_matriz_completa(C)];
        resultado_texto{end+1} = '';
        resultado_texto{end+1} = '✓ Multiplicación completada exitosamente';
        
        % Información adicional sobre la multiplicación
        resultado_texto{end+1} = '';
        resultado_texto{end+1} = '=== INFORMACIÓN ADICIONAL ===';
        resultado_texto{end+1} = sprintf('• Número de operaciones realizadas: %d multiplicaciones y %d sumas', ...
                                        filasA * colsB * colsA, filasA * colsB * (colsA - 1));
        
        texto_resultados.Value = resultado_texto;
        resultado = C;
    end
    
    % Función para multiplicación por escalar
    function [A, resultado] = operacion_escalar()
        A = []; resultado = [];
        
        % Solicitar dimensiones
        prompt_dims = inputdlg({'Número de filas:', 'Número de columnas:'}, ...
                              'Dimensiones de la matriz', [1 50], {'3', '3'});
        if isempty(prompt_dims), error('Entrada cancelada'); end
        
        filas = str2double(prompt_dims{1});
        cols = str2double(prompt_dims{2});
        
        if filas <= 0 || cols <= 0 || ~isfinite(filas) || ~isfinite(cols)
            error('Las dimensiones deben ser números enteros positivos');
        end
        
        % Ingresar matriz
        mostrar_progreso('Ingresando matriz A...');
        A = ingresar_matriz_dialogo('A', filas, cols);
        if isempty(A), error('Entrada de matriz A cancelada'); end
        
        % Solicitar escalar
        prompt_k = inputdlg({'Valor del escalar k:'}, ...
                           'Multiplicación por escalar', [1 50], {'2'});
        if isempty(prompt_k), error('Entrada de escalar cancelada'); end
        
        k = str2double(prompt_k{1});
        if ~isfinite(k)
            error('El escalar debe ser un número finito');
        end
        
        % Multiplicar
        mostrar_progreso('Calculando multiplicación por escalar...');
        C = k * A;
        
        % Mostrar resultados
        resultado_texto = {'=== MULTIPLICACIÓN POR ESCALAR ===', '', ...
                          sprintf('Operación: %.4g × A', k), ...
                          sprintf('Dimensión: %dx%d', filas, cols), '', ...
                          'Matriz original A:'};
        resultado_texto = [resultado_texto, mostrar_matriz_completa(A)];
        resultado_texto{end+1} = '';
        resultado_texto{end+1} = sprintf('Escalar k = %.6g', k);
        resultado_texto{end+1} = '';
        resultado_texto{end+1} = 'Resultado k × A:';
        resultado_texto = [resultado_texto, mostrar_matriz_completa(C)];
        resultado_texto{end+1} = '';
        resultado_texto{end+1} = '✓ Multiplicación por escalar completada';
        
        % Propiedades del escalar
        resultado_texto{end+1} = '';
        resultado_texto{end+1} = '=== PROPIEDADES VERIFICADAS ===';
        if k == 0
            resultado_texto{end+1} = '• k = 0: Resultado es la matriz nula';
        elseif k == 1
            resultado_texto{end+1} = '• k = 1: Resultado es la matriz original';
        elseif k == -1
            resultado_texto{end+1} = '• k = -1: Resultado es la matriz opuesta';
        end
        
        texto_resultados.Value = resultado_texto;
        resultado = C;
    end
    
    % Función para calcular determinante
    function calcular_determinante(~, ~)
        try
            n = round(campo_n_det.Value);
            if n <= 0 || n > 10
                error('El tamaño debe estar entre 1 y 10');
            end
            
            mostrar_progreso('Ingresando matriz...');
            
            % Ingresar matriz
            A = ingresar_matriz_dialogo('A', n, n);
            if isempty(A)
                error('Entrada de matriz cancelada');
            end
            
            mostrar_progreso('Calculando determinante...');
            
            % Calcular determinante
            det_A = det(A);
            
            % Preparar resultado
            resultado_texto = {'=== CÁLCULO DEL DETERMINANTE ===', '', ...
                              sprintf('Matriz A (%dx%d):', n, n)};
            resultado_texto = [resultado_texto, mostrar_matriz_completa(A)];
            resultado_texto{end+1} = '';
            resultado_texto{end+1} = sprintf('det(A) = %.8f', det_A);
            resultado_texto{end+1} = '';
            resultado_texto{end+1} = '=== INTERPRETACIÓN ===';
            
            if abs(det_A) < 1e-10
                resultado_texto{end+1} = '❌ Matriz SINGULAR (no invertible)';
                resultado_texto{end+1} = '• Las filas/columnas son linealmente dependientes';
                resultado_texto{end+1} = '• El sistema asociado puede no tener solución única';
            else
                resultado_texto{end+1} = '✅ Matriz NO SINGULAR (invertible)';
                resultado_texto{end+1} = '• Las filas/columnas son linealmente independientes';
                resultado_texto{end+1} = '• El sistema asociado tiene solución única';
            end
            
            % Método de cálculo para matrices pequeñas
            if n <= 3
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = '=== MÉTODO DE CÁLCULO ===';
                if n == 1
                    resultado_texto{end+1} = sprintf('Para matriz 1×1: det(A) = %.4f', A(1,1));
                elseif n == 2
                    resultado_texto{end+1} = 'Para matriz 2×2: det(A) = ad - bc';
                    resultado_texto{end+1} = sprintf('det(A) = (%.4f)(%.4f) - (%.4f)(%.4f) = %.4f', ...
                                                   A(1,1), A(2,2), A(1,2), A(2,1), det_A);
                elseif n == 3
                    resultado_texto{end+1} = 'Para matriz 3×3: Regla de Sarrus o expansión por cofactores';
                end
            end
            
            texto_resultados.Value = resultado_texto;
            texto_entrada.Value = {'=== DETERMINANTE CALCULADO ===', '', ...
                                  sprintf('det(A) = %.8f', det_A), ...
                                  abs(det_A) < 1e-10 ? 'Matriz singular' : 'Matriz invertible'};
            
        catch e
            if contains(e.message, 'cancelada')
                texto_resultados.Value = {'=== CÁLCULO CANCELADO ===', '', 'Operación cancelada por el usuario.'};
                texto_entrada.Value = {'Cálculo cancelado', '', 'Listo para nueva operación.'};
            else
                texto_resultados.Value = {'=== ERROR EN DETERMINANTE ===', '', ['❌ ' e.message]};
                texto_entrada.Value = {'ERROR', '', e.message};
            end
        end
    end
    
    % Función para calcular matriz inversa
    function calcular_inversa(~, ~)
        try
            n = round(campo_n_inv.Value);
            if n <= 0 || n > 10
                error('El tamaño debe estar entre 1 y 10');
            end
            
            mostrar_progreso('Ingresando matriz...');
            
            % Ingresar matriz
            A = ingresar_matriz_dialogo('A', n, n);
            if isempty(A)
                error('Entrada de matriz cancelada');
            end
            
            mostrar_progreso('Calculando determinante...');
            
            % Calcular determinante para verificar invertibilidad
            det_A = det(A);
            
            resultado_texto = {'=== CÁLCULO DE LA MATRIZ INVERSA ===', '', ...
                              sprintf('Matriz A (%dx%d):', n, n)};
            resultado_texto = [resultado_texto, mostrar_matriz_completa(A)];
            resultado_texto{end+1} = '';
            resultado_texto{end+1} = sprintf('det(A) = %.8f', det_A);
            resultado_texto{end+1} = '';
            
            if abs(det_A) < 1e-10
                resultado_texto{end+1} = '❌ ERROR: La matriz NO es invertible';
                resultado_texto{end+1} = '• El determinante es cero (o muy cercano a cero)';
                resultado_texto{end+1} = '• La matriz es singular';
                resultado_texto{end+1} = '• No existe A⁻¹';
            else
                mostrar_progreso('Calculando matriz inversa...');
                
                % Calcular inversa
                A_inv = inv(A);
                
                resultado_texto{end+1} = '✅ La matriz ES invertible';
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = 'Matriz inversa A⁻¹:';
                resultado_texto = [resultado_texto, mostrar_matriz_completa(A_inv)];
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = '=== VERIFICACIÓN ===';
                
                mostrar_progreso('Verificando resultado...');
                
                % Verificar A * A^-1 = I
                producto = A * A_inv;
                identidad = eye(n);
                error_norm = norm(producto - identidad, 'fro');
                
                resultado_texto{end+1} = 'A × A⁻¹ =';
                resultado_texto = [resultado_texto, mostrar_matriz_completa(producto)];
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = sprintf('Error (norma de Frobenius): %.2e', error_norm);
                
                if error_norm < 1e-10
                    resultado_texto{end+1} = '✅ Verificación exitosa: A × A⁻¹ ≈ I';
                else
                    resultado_texto{end+1} = '⚠️ Verificación con error numérico (aceptable si pequeño)';
                end
                
                % Información adicional
                cond_A = cond(A);
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = '=== ANÁLISIS DE CONDICIONAMIENTO ===';
                resultado_texto{end+1} = sprintf('• Número de condición: %.2e', cond_A);
                
                if cond_A > 1e12
                    resultado_texto{end+1} = '⚠️ Matriz MAL CONDICIONADA';
                    resultado_texto{end+1} = '• La inversa puede ser numéricamente inestable';
                elseif cond_A > 1e6
                    resultado_texto{end+1} = '⚠️ Matriz MODERADAMENTE mal condicionada';
                else
                    resultado_texto{end+1} = '✅ Matriz BIEN CONDICIONADA';
                end
            end
            
            texto_resultados.Value = resultado_texto;
            
            if abs(det_A) > 1e-10
                texto_entrada.Value = {'=== INVERSA CALCULADA ===', '', ...
                                      '✓ Matriz invertible', ...
                                      sprintf('Número de condición: %.2e', cond(A))};
            else
                texto_entrada.Value = {'=== MATRIZ NO INVERTIBLE ===', '', ...
                                      'det(A) ≈ 0', ...
                                      'No existe A⁻¹'};
            end
            
        catch e
            if contains(e.message, 'cancelada')
                texto_resultados.Value = {'=== CÁLCULO CANCELADO ===', '', 'Operación cancelada por el usuario.'};
                texto_entrada.Value = {'Cálculo cancelado', '', 'Listo para nueva operación.'};
            else
                texto_resultados.Value = {'=== ERROR EN INVERSA ===', '', ['❌ ' e.message]};
                texto_entrada.Value = {'ERROR', '', e.message};
            end
        end
    end
    
    % Función para calcular transpuesta
    function calcular_transpuesta(~, ~)
        try
            filas = round(campo_filas_t.Value);
            cols = round(campo_cols_t.Value);
            
            if filas <= 0 || cols <= 0 || filas > 10 || cols > 10
                error('Las dimensiones deben estar entre 1 y 10');
            end
            
            mostrar_progreso('Ingresando matriz para transpuesta...');
            
            % Ingresar matriz
            A = ingresar_matriz_dialogo('A', filas, cols);
            if isempty(A)
                error('Entrada de matriz cancelada');
            end
            
            mostrar_progreso('Calculando transpuesta...');
            
            % Calcular transpuesta
            A_T = A';
            
            resultado_texto = {'=== CÁLCULO DE LA MATRIZ TRANSPUESTA ===', '', ...
                              sprintf('Matriz original A (%dx%d):', filas, cols)};
            resultado_texto = [resultado_texto, mostrar_matriz_completa(A)];
            resultado_texto{end+1} = '';
            resultado_texto{end+1} = sprintf('Matriz transpuesta Aᵀ (%dx%d):', cols, filas);
            resultado_texto = [resultado_texto, mostrar_matriz_completa(A_T)];
            resultado_texto{end+1} = '';
            resultado_texto{end+1} = '=== PROPIEDADES ===';
            resultado_texto{end+1} = sprintf('• Dimensiones originales: %dx%d', filas, cols);
            resultado_texto{end+1} = sprintf('• Dimensiones transpuesta: %dx%d', cols, filas);
            resultado_texto{end+1} = '• La transpuesta intercambia filas por columnas';
            resultado_texto{end+1} = '• (Aᵀ)ᵢⱼ = Aⱼᵢ';
            
            % Verificaciones adicionales para matrices cuadradas
            if filas == cols
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = '=== VERIFICACIONES (MATRIZ CUADRADA) ===';
                
                % Verificar simetría
                if isequal(A, A_T)
                    resultado_texto{end+1} = '✅ La matriz es SIMÉTRICA (A = Aᵀ)';
                else
                    resultado_texto{end+1} = '❌ La matriz NO es simétrica';
                end
                
                % Verificar antisimetría
                if isequal(A, -A_T)
                    resultado_texto{end+1} = '✅ La matriz es ANTISIMÉTRICA (A = -Aᵀ)';
                else
                    resultado_texto{end+1} = '❌ La matriz NO es antisimétrica';
                end
                
                % Propiedad: (A^T)^T = A
                A_TT = (A_T)';
                if isequal(A, A_TT)
                    resultado_texto{end+1} = '✅ Verificado: (Aᵀ)ᵀ = A';
                end
                
                % Determinantes
                det_A = det(A);
                det_AT = det(A_T);
                resultado_texto{end+1} = sprintf('• det(A) = %.6f', det_A);
                resultado_texto{end+1} = sprintf('• det(Aᵀ) = %.6f', det_AT);
                
                if abs(det_A - det_AT) < 1e-10
                    resultado_texto{end+1} = '✅ Verificado: det(A) = det(Aᵀ)';
                end
                
                % Verificar si es ortogonal
                if abs(det_A) > 1e-10
                    producto_AA_T = A * A_T;
                    identidad = eye(filas);
                    error_ortogonal = norm(producto_AA_T - identidad, 'fro');
                    
                    if error_ortogonal < 1e-10
                        resultado_texto{end+1} = '✅ La matriz es ORTOGONAL (A × Aᵀ = I)';
                    else
                        resultado_texto{end+1} = '❌ La matriz NO es ortogonal';
                    end
                end
            end
            
            % Propiedades generales de la transpuesta
            resultado_texto{end+1} = '';
            resultado_texto{end+1} = '=== PROPIEDADES GENERALES ===';
            resultado_texto{end+1} = '• (A + B)ᵀ = Aᵀ + Bᵀ';
            resultado_texto{end+1} = '• (kA)ᵀ = k(Aᵀ)';
            resultado_texto{end+1} = '• (AB)ᵀ = BᵀAᵀ';
            resultado_texto{end+1} = '• (Aᵀ)ᵀ = A';
            
            texto_resultados.Value = resultado_texto;
            texto_entrada.Value = {'=== TRANSPUESTA CALCULADA ===', '', ...
                                  sprintf('Dimensiones: (%dx%d) → (%dx%d)', filas, cols, cols, filas), ...
                                  ''};
            
            if filas == cols && isequal(A, A_T)
                texto_entrada.Value{end+1} = 'Matriz simétrica detectada';
            else
                texto_entrada.Value{end+1} = 'Transpuesta completada';
            end
            
        catch e
            if contains(e.message, 'cancelada')
                texto_resultados.Value = {'=== CÁLCULO CANCELADO ===', '', 'Operación cancelada por el usuario.'};
                texto_entrada.Value = {'Cálculo cancelado', '', 'Listo para nueva operación.'};
            else
                texto_resultados.Value = {'=== ERROR EN TRANSPUESTA ===', '', ['❌ ' e.message]};
                texto_entrada.Value = {'ERROR', '', e.message};
            end
        end
    end
    
    % Función para resolver sistema de ecuaciones
    function resolver_sistema(~, ~)
        try
            n = round(campo_n_sis.Value);
            if n <= 0 || n > 10
                error('El número de ecuaciones debe estar entre 1 y 10');
            end
            
            mostrar_progreso('Ingresando matriz de coeficientes...');
            
            % Ingresar matriz de coeficientes A
            A = ingresar_matriz_dialogo('A (coeficientes)', n, n);
            if isempty(A)
                error('Entrada de matriz A cancelada');
            end
            
            mostrar_progreso('Ingresando vector de términos independientes...');
            
            % Ingresar vector b
            b = ingresar_vector_dialogo('b (términos independientes)', n);
            if isempty(b)
                error('Entrada de vector b cancelada');
            end
            
            mostrar_progreso('Analizando el sistema...');
            
            % Calcular determinante
            det_A = det(A);
            
            resultado_texto = {'=== RESOLUCIÓN DE SISTEMA DE ECUACIONES ===', '', ...
                              sprintf('Sistema: Ax = b (%d ecuaciones, %d incógnitas)', n, n), '', ...
                              'Matriz de coeficientes A:'};
            resultado_texto = [resultado_texto, mostrar_matriz_completa(A)];
            resultado_texto{end+1} = '';
            resultado_texto{end+1} = 'Vector de términos independientes b:';
            resultado_texto = [resultado_texto, mostrar_matriz_completa(b)];
            resultado_texto{end+1} = '';
            resultado_texto{end+1} = sprintf('det(A) = %.10f', det_A);
            resultado_texto{end+1} = '';
            
            if abs(det_A) < 1e-10
                % Sistema sin solución única
                resultado_texto{end+1} = '❌ SISTEMA SIN SOLUCIÓN ÚNICA';
                resultado_texto{end+1} = '• El determinante es cero (o muy cercano a cero)';
                resultado_texto{end+1} = '• La matriz de coeficientes es singular';
                
                % Análisis usando rangos
                rank_A = rank(A);
                rank_Ab = rank([A b]);
                
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = '=== ANÁLISIS DE RANGOS ===';
                resultado_texto{end+1} = sprintf('• Rango de A: %d', rank_A);
                resultado_texto{end+1} = sprintf('• Rango de [A|b]: %d', rank_Ab);
                resultado_texto{end+1} = sprintf('• Número de incógnitas: %d', n);
                
                if rank_A == rank_Ab
                    resultado_texto{end+1} = '';
                    resultado_texto{end+1} = '✅ El sistema es COMPATIBLE (tiene solución)';
                    if rank_A < n
                        resultado_texto{end+1} = sprintf('✅ El sistema tiene INFINITAS SOLUCIONES');
                        resultado_texto{end+1} = sprintf('• Grados de libertad: %d', n - rank_A);
                        resultado_texto{end+1} = '• Existen múltiples vectores x que satisfacen Ax = b';
                    else
                        resultado_texto{end+1} = '✅ El sistema tiene SOLUCIÓN ÚNICA';
                    end
                else
                    resultado_texto{end+1} = '';
                    resultado_texto{end+1} = '❌ El sistema es INCOMPATIBLE (no tiene solución)';
                    resultado_texto{end+1} = '• No existe vector x tal que Ax = b';
                    resultado_texto{end+1} = '• Las ecuaciones son inconsistentes';
                end
                
            else
                % Sistema con solución única
                mostrar_progreso('Resolviendo sistema...');
                x = A \ b;
                
                resultado_texto{end+1} = '✅ SISTEMA CON SOLUCIÓN ÚNICA';
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = '=== SOLUCIÓN ===';
                
                for i = 1:n
                    resultado_texto{end+1} = sprintf('x₍%d₎ = %.10f', i, x(i));
                end
                
                % Verificación: Ax = b
                mostrar_progreso('Verificando solución...');
                verificacion = A * x;
                error_norm = norm(verificacion - b);
                
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = '=== VERIFICACIÓN ===';
                resultado_texto{end+1} = 'A × x =';
                resultado_texto = [resultado_texto, mostrar_matriz_completa(verificacion)];
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = 'Vector b (objetivo):';
                resultado_texto = [resultado_texto, mostrar_matriz_completa(b)];
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = sprintf('Error (norma euclidiana): %.2e', error_norm);
                
                if error_norm < 1e-10
                    resultado_texto{end+1} = '✅ Verificación exitosa: Ax ≈ b';
                else
                    resultado_texto{end+1} = '⚠️ Verificación con error numérico pequeño';
                end
                
                % Información adicional sobre estabilidad
                cond_A = cond(A);
                resultado_texto{end+1} = '';
                resultado_texto{end+1} = '=== ANÁLISIS DE ESTABILIDAD ===';
                resultado_texto{end+1} = sprintf('• Número de condición: %.2e', cond_A);
                
                if cond_A > 1e12
                    resultado_texto{end+1} = '⚠️ Sistema MAL CONDICIONADO (solución imprecisa)';
                    resultado_texto{end+1} = '• Pequeños cambios en A o b pueden causar grandes cambios en x';
                elseif cond_A > 1e6
                    resultado_texto{end+1} = '⚠️ Sistema MODERADAMENTE mal condicionado';
                    resultado_texto{end+1} = '• La solución puede tener cierta sensibilidad numérica';
                else
                    resultado_texto{end+1} = '✅ Sistema BIEN CONDICIONADO';
                    resultado_texto{end+1} = '• La solución es numéricamente estable';
                end
                
                % Interpretación geométrica para sistemas pequeños
                if n == 2
                    resultado_texto{end+1} = '';
                    resultado_texto{end+1} = '=== INTERPRETACIÓN GEOMÉTRICA (2D) ===';
                    resultado_texto{end+1} = '• Cada ecuación representa una recta en el plano';
                    resultado_texto{end+1} = '• La solución es el punto de intersección de las rectas';
                elseif n == 3
                    resultado_texto{end+1} = '';
                    resultado_texto{end+1} = '=== INTERPRETACIÓN GEOMÉTRICA (3D) ===';
                    resultado_texto{end+1} = '• Cada ecuación representa un plano en el espacio';
                    resultado_texto{end+1} = '• La solución es el punto de intersección de los planos';
                end
            end
            
            texto_resultados.Value = resultado_texto;
            
            if abs(det_A) > 1e-10
                texto_entrada.Value = {'=== SISTEMA RESUELTO ===', '', ...
                                      'Solución única encontrada', ...
                                      sprintf('Número de condición: %.2e', cond(A))};
            else
                rank_A = rank(A);
                rank_Ab = rank([A b]);
                if rank_A == rank_Ab
                    texto_entrada.Value = {'=== SISTEMA COMPATIBLE ===', '', ...
                                          rank_A < n ? 'Infinitas soluciones' : 'Solución única', ...
                                          sprintf('Rango: %d/%d', rank_A, n)};
                else
                    texto_entrada.Value = {'=== SISTEMA INCOMPATIBLE ===', '', ...
                                          'No tiene solución', ...
                                          'Ecuaciones inconsistentes'};
                end
            end
            
        catch e
            if contains(e.message, 'cancelada')
                texto_resultados.Value = {'=== RESOLUCIÓN CANCELADA ===', '', 'Operación cancelada por el usuario.'};
                texto_entrada.Value = {'Resolución cancelada', '', 'Listo para nueva operación.'};
            else
                texto_resultados.Value = {'=== ERROR EN SISTEMA ===', '', ['❌ ' e.message]};
                texto_entrada.Value = {'ERROR', '', e.message};
            end
        end
    end
    
    % Funciones auxiliares
    
    % Función auxiliar para ingresar matriz mediante diálogos
    function matriz = ingresar_matriz_dialogo(nombre, filas, cols)
        matriz = ingresar_matriz_mejorada(nombre, filas, cols);
    end
    
    % Función auxiliar para ingresar vector mediante diálogos
    function vector = ingresar_vector_dialogo(nombre, n)
        vector = ingresar_vector_mejorado(nombre, n);
    end
    
    % Función mejorada para entrada de matrices con validación
    function matriz = ingresar_matriz_mejorada(nombre, filas, cols)
        matriz = [];
        try
            % Opción 1: Entrada por filas completas
            respuesta = questdlg(['¿Cómo desea ingresar la matriz ' nombre '?'], ...
                               'Método de Entrada', ...
                               'Por filas', 'Elemento por elemento', 'Cancelar', ...
                               'Por filas');
            
            if strcmp(respuesta, 'Cancelar') || isempty(respuesta)
                return;
            end
            
            matriz = zeros(filas, cols);
            
            if strcmp(respuesta, 'Por filas')
                % Entrada por filas
                for i = 1:filas
                    while true
                        prompt = sprintf('Fila %d de la matriz %s\n(separar elementos con espacios):', i, nombre);
                        fila_str = inputdlg(prompt, sprintf('Matriz %s - Fila %d', nombre, i), [1 60]);
                        
                        if isempty(fila_str)
                            matriz = [];
                            return;
                        end
                        
                        try
                            fila_vals = str2num(fila_str{1});
                            if length(fila_vals) == cols
                                matriz(i, :) = fila_vals;
                                break;
                            else
                                warndlg(sprintf('Debe ingresar exactamente %d números.', cols), 'Error de Entrada');
                            end
                        catch
                            warndlg('Formato inválido. Use números separados por espacios.', 'Error de Formato');
                        end
                    end
                end
            else
                % Entrada elemento por elemento
                for i = 1:filas
                    for j = 1:cols
                        while true
                            prompt = sprintf('Elemento %s(%d,%d):', nombre, i, j);
                            elem_str = inputdlg(prompt, sprintf('Matriz %s', nombre), [1 50], {'0'});
                            
                            if isempty(elem_str)
                                matriz = [];
                                return;
                            end
                            
                            try
                                elem_val = str2double(elem_str{1});
                                if isfinite(elem_val)
                                    matriz(i,j) = elem_val;
                                    break;
                                else
                                    warndlg('Ingrese un número válido.', 'Error');
                                end
                            catch
                                warndlg('Ingrese un número válido.', 'Error');
                            end
                        end
                    end
                end
            end
            
            % Validar la matriz final
            if ~validar_matriz(matriz, nombre)
                matriz = [];
            end
            
        catch e
            msgbox(['Error al ingresar matriz: ' e.message], 'Error', 'error');
            matriz = [];
        end
    end
    
    % Función mejorada para entrada de vectores
    function vector = ingresar_vector_mejorado(nombre, n)
        vector = [];
        try
            respuesta = questdlg(['¿Cómo desea ingresar el vector ' nombre '?'], ...
                               'Método de Entrada', ...
                               'En una línea', 'Elemento por elemento', 'Cancelar', ...
                               'En una línea');
            
            if strcmp(respuesta, 'Cancelar') || isempty(respuesta)
                return;
            end
            
            vector = zeros(n, 1);
            
            if strcmp(respuesta, 'En una línea')
                while true
                    prompt = sprintf('Vector %s (%d elementos)\n(separar con espacios):', nombre, n);
                    vec_str = inputdlg(prompt, sprintf('Vector %s', nombre), [1 60]);
                    
                    if isempty(vec_str)
                        return;
                    end
                    
                    try
                        vec_vals = str2num(vec_str{1});
                        if length(vec_vals) == n
                            vector = vec_vals(:);
                            break;
                        else
                            warndlg(sprintf('Debe ingresar exactamente %d números.', n), 'Error');
                        end
                    catch
                        warndlg('Formato inválido. Use números separados por espacios.', 'Error');
                    end
                end
            else
                for i = 1:n
                    while true
                        prompt = sprintf('Elemento %s(%d):', nombre, i);
                        elem_str = inputdlg(prompt, sprintf('Vector %s', nombre), [1 50], {'0'});
                        
                        if isempty(elem_str)
                            vector = [];
                            return;
                        end
                        
                        try
                            elem_val = str2double(elem_str{1});
                            if isfinite(elem_val)
                                vector(i) = elem_val;
                                break;
                            else
                                warndlg('Ingrese un número válido.', 'Error');
                            end
                        catch
                            warndlg('Ingrese un número válido.', 'Error');
                        end
                    end
                end
            end
            
        catch e
            msgbox(['Error al ingresar vector: ' e.message], 'Error', 'error');
            vector = [];
        end
    end
    
    % Función para validar entrada de matrices
    function valido = validar_matriz(matriz, nombre)
        valido = true;
        if isempty(matriz)
            msgbox(['La matriz ' nombre ' está vacía.'], 'Error', 'error');
            valido = false;
            return;
        end
        
        if any(~isfinite(matriz(:)))
            msgbox(['La matriz ' nombre ' contiene valores no finitos (NaN o Inf).'], 'Error', 'error');
            valido = false;
            return;
        end
    end
    
    % Función mejorada para mostrar matrices con bordes completos
    function texto_completo = mostrar_matriz_completa(matriz)
        [filas, cols] = size(matriz);
        
        % Determinar ancho de columna
        max_val = max(abs(matriz(:)));
        if max_val == 0
            ancho = 8;
        else
            ancho = max(10, ceil(log10(max_val)) + 6);
        end
        
        texto_completo = {};
        
        % Línea superior
        linea_sup = '┌';
        for j = 1:cols
            linea_sup = [linea_sup repmat('─', 1, ancho)];
            if j < cols
                linea_sup = [linea_sup '┬'];
            end
        end
        linea_sup = [linea_sup '┐'];
        texto_completo{end+1} = linea_sup;
        
        % Filas de datos
        for i = 1:filas
            fila = '│';
            for j = 1:cols
                if abs(matriz(i,j) - round(matriz(i,j))) < 1e-10
                    fila = [fila sprintf(' %*.0f', ancho-1, matriz(i,j))];
                else
                    fila = [fila sprintf(' %*.4f', ancho-1, matriz(i,j))];
                end
                if j < cols
                    fila = [fila '│'];
                end
            end
            fila = [fila '│'];
            texto_completo{end+1} = fila;
            
            % Línea separadora (excepto en la última fila)
            if i < filas
                linea_sep = '├';
                for j = 1:cols
                    linea_sep = [linea_sep repmat('─', 1, ancho)];
                    if j < cols
                        linea_sep = [linea_sep '┼'];
                    end
                end
                linea_sep = [linea_sep '┤'];
                texto_completo{end+1} = linea_sep;
            end
        end
        
        % Línea inferior
        linea_inf = '└';
        for j = 1:cols
            linea_inf = [linea_inf repmat('─', 1, ancho)];
            if j < cols
                linea_inf = [linea_inf '┴'];
            end
        end
        linea_inf = [linea_inf '┘'];
        texto_completo{end+1} = linea_inf;
    end
    
    % Función para mostrar progreso en operaciones grandes
    function mostrar_progreso(mensaje)
        if isvalid(texto_entrada)
            texto_entrada.Value = {mensaje, '', 'Procesando...', datestr(now, 'HH:MM:SS')};
            drawnow;
        end
    end
    
    % Función para verificar compatibilidad dimensional
    function compatible = verificar_dimensiones(operacion, A, B)
        compatible = true;
        [filasA, colsA] = size(A);
        [filasB, colsB] = size(B);
        
        switch operacion
            case {'suma', 'resta'}
                if filasA ~= filasB || colsA ~= colsB
                    msgbox(sprintf('Dimensiones incompatibles para %s:\nA: %dx%d, B: %dx%d\nDeben ser iguales.', ...
                                  operacion, filasA, colsA, filasB, colsB), 'Error Dimensional', 'error');
                    compatible = false;
                end
            case 'multiplicacion'
                if colsA ~= filasB
                    msgbox(sprintf('Dimensiones incompatibles para multiplicación:\nA: %dx%d, B: %dx%d\nColumnas de A ≠ filas de B.', ...
                                  filasA, colsA, filasB, colsB), 'Error Dimensional', 'error');
                    compatible = false;
                end
        end
    end
    
    % Botones de control
    
    % Botón de salir
    btn_salir = uibutton(fig, 'Text', 'SALIR', ...
                         'Position', [1350, 10, 100, 35], ...
                         'FontSize', 12, ...
                         'FontWeight', 'bold', ...
                         'BackgroundColor', [0.8, 0.2, 0.2], ...
                         'FontColor', 'white', ...
                         'ButtonPushedFcn', @(~,~) close(fig));
    
    % Función para cargar ejemplos
    function cargar_ejemplo()
        switch operacion_actual
            case 'operaciones'
                % Ejemplo para suma: matrices 2x2
                matriz_A = [1, 2; 3, 4];
                matriz_B = [5, 6; 7, 8];
                texto_entrada.Value = {'=== EJEMPLO CARGADO ===', '', ...
                                      'Matrices de ejemplo 2×2:', ...
                                      'A = [1 2; 3 4]', ...
                                      'B = [5 6; 7 8]', ...
                                      '', ...
                                      'Puede probar cualquier operación.'};
                
            case 'determinante'
                campo_n_det.Value = 3;
                texto_entrada.Value = {'=== EJEMPLO SUGERIDO ===', '', ...
                                      'Matriz 3×3 de ejemplo:', ...
                                      'A = [2 1 3; 1 0 1; 1 1 1]', ...
                                      'det(A) = -2', ...
                                      '', ...
                                      'Configure el tamaño y calcule.'};
                
            case 'inversa'
                campo_n_inv.Value = 2;
                texto_entrada.Value = {'=== EJEMPLO SUGERIDO ===', '', ...
                                      'Matriz 2×2 invertible:', ...
                                      'A = [2 1; 1 1]', ...
                                      'A⁻¹ = [1 -1; -1 2]', ...
                                      '', ...
                                      'Configure el tamaño y calcule.'};
                
            case 'transpuesta'
                campo_filas_t.Value = 2;
                campo_cols_t.Value = 3;
                texto_entrada.Value = {'=== EJEMPLO SUGERIDO ===', '', ...
                                      'Matriz 2×3 de ejemplo:', ...
                                      'A = [1 2 3; 4 5 6]', ...
                                      'Aᵀ = [1 4; 2 5; 3 6]', ...
                                      '', ...
                                      'Configure las dimensiones y calcule.'};
                
            case 'sistema'
                campo_n_sis.Value = 2;
                texto_entrada.Value = {'=== EJEMPLO SUGERIDO ===', '', ...
                                      'Sistema 2×2:', ...
                                      '2x + y = 5', ...
                                      'x + y = 3', ...
                                      'Solución: x=2, y=1', ...
                                      '', ...
                                      'Configure el tamaño y resuelva.'};
        end
    end
    
    % Botón para ejemplos
    btn_ejemplo = uibutton(fig, 'Text', 'EJEMPLO', ...
                           'Position', [1130, 10, 100, 35], ...
                           'FontSize', 12, ...
                           'FontWeight', 'bold', ...
                           'BackgroundColor', [0.2, 0.6, 0.8], ...
                           'FontColor', 'white', ...
                           'ButtonPushedFcn', @(~,~) cargar_ejemplo());
    
    % Función de ayuda
    function mostrar_ayuda()
        ayuda_texto = {'=== AYUDA - CALCULADORA DE MATRICES ===', '', ...
                      'OPERACIONES DISPONIBLES:', '', ...
                      '1. OPERACIONES BÁSICAS:', ...
                      '   • Suma: A + B (mismo tamaño)', ...
                      '   • Resta: A - B (mismo tamaño)', ...
                      '   • Multiplicación: A × B (cols A = filas B)', ...
                      '   • Escalar: k × A (cualquier tamaño)', '', ...
                      '2. DETERMINANTE:', ...
                      '   • Solo matrices cuadradas', ...
                      '   • det ≠ 0: matriz invertible', ...
                      '   • det = 0: matriz singular', '', ...
                      '3. MATRIZ INVERSA:', ...
                      '   • Solo si det(A) ≠ 0', ...
                      '   • Verifica: A × A⁻¹ = I', '', ...
                      '4. TRANSPUESTA:', ...
                      '   • Convierte filas en columnas', ...
                      '   • Dimensiones: (m×n) → (n×m)', '', ...
                      '5. SISTEMAS DE ECUACIONES:', ...
                      '   • Ax = b', ...
                      '   • Analiza existencia/unicidad', '', ...
                      'CONSEJOS:', ...
                      '• Use "EJEMPLO" para ver casos de prueba', ...
                      '• "LIMPIAR" borra los resultados', ...
                      '• Los errores numéricos < 1e-10 son normales'};
        
        texto_resultados.Value = ayuda_texto;
    end
    
    % Botón de ayuda
    btn_ayuda = uibutton(fig, 'Text', 'AYUDA', ...
                         'Position', [1020, 10, 100, 35], ...
                         'FontSize', 12, ...
                         'FontWeight', 'bold', ...
                         'BackgroundColor', [0.8, 0.6, 0.2], ...
                         'FontColor', 'white', ...
                         'ButtonPushedFcn', @(~,~) mostrar_ayuda());
    
    % Función para limpiar resultados
    function limpiar_resultados()
        texto_resultados.Value = {'=== RESULTADOS LIMPIADOS ===', '', 'Seleccione una nueva operación.'};
    end
    
    % Botón para limpiar resultados
    btn_limpiar = uibutton(fig, 'Text', 'LIMPIAR', ...
                           'Position', [1240, 10, 100, 35], ...
                           'FontSize', 12, ...
                           'FontWeight', 'bold', ...
                           'BackgroundColor', [0.7, 0.7, 0.7], ...
                           'FontColor', 'white', ...
                           'ButtonPushedFcn', @(~,~) limpiar_resultados());
    
    % Función para exportar resultados
    function exportar_resultados()
        try
            % Obtener contenido actual
            contenido = texto_resultados.Value;
            
            % Crear nombre de archivo con timestamp
            timestamp = datestr(now, 'yyyymmdd_HHMMSS');
            nombre_archivo = ['matriz_resultados_' timestamp '.txt'];
            
            % Escribir archivo
            fid = fopen(nombre_archivo, 'w');
            if fid == -1
                error('No se pudo crear el archivo');
            end
            
            fprintf(fid, 'CALCULADORA DE MATRICES - RESULTADOS\n');
            fprintf(fid, 'Fecha: %s\n', datestr(now));
            fprintf(fid, '=====================================\n\n');
            
            for i = 1:length(contenido)
                fprintf(fid, '%s\n', contenido{i});
            end
            
            fclose(fid);
            
            % Mensaje de confirmación
            uialert(fig, ...
                ['Resultados exportados exitosamente como:' newline nombre_archivo], ...
                'Exportación Completa', ...
                'Icon', 'success');
                
        catch e
            uialert(fig, ...
                ['Error al exportar: ' e.message], ...
                'Error de Exportación', ...
                'Icon', 'error');
        end
    end
    
    % Botón de exportar
    btn_exportar = uibutton(fig, 'Text', 'EXPORTAR', ...
                            'Position', [910, 10, 100, 35], ...
                            'FontSize', 12, ...
                            'FontWeight', 'bold', ...
                            'BackgroundColor', [0.4, 0.7, 0.4], ...
                            'FontColor', 'white', ...
                            'ButtonPushedFcn', @(~,~) exportar_resultados());
    
    % Panel de información del sistema
    panel_info = uipanel(fig, 'Title', 'INFORMACIÓN DEL SISTEMA', ...
                         'Position', [30, 10, 350, 35], ...
                         'FontSize', 10, ...
                         'FontWeight', 'bold', ...
                         'BackgroundColor', [0.98, 0.98, 0.9]);
    
    info_texto = uilabel(panel_info, ...
                         'Text', sprintf('MATLAB %s | Fecha: %s', ...
                                       version('-release'), datestr(now, 'dd/mm/yyyy')), ...
                         'Position', [10, 5, 330, 15], ...
                         'FontSize', 9, ...
                         'FontColor', [0.4, 0.4, 0.4]);
    
    % Inicializar con información de bienvenida mejorada
    texto_resultados.Value = {'=== CALCULADORA DE MATRICES PROFESIONAL ===', ...
                             '', ...
                             '🔢 OPERACIONES DISPONIBLES:', ...
                             '', ...
                             '1️⃣ OPERACIONES BÁSICAS: Suma, Resta, Multiplicación, Escalar', ...
                             '2️⃣ DETERMINANTE: Cálculo e interpretación para matrices cuadradas', ...
                             '3️⃣ MATRIZ INVERSA: Cálculo de A⁻¹ con verificación automática', ...
                             '4️⃣ TRANSPUESTA: Aᵀ con análisis de propiedades', ...
                             '5️⃣ SISTEMAS: Resolución de Ax = b con análisis completo', ...
                             '', ...
                             '⚡ CARACTERÍSTICAS DESTACADAS:', ...
                             '• Verificación automática de resultados', ...
                             '• Análisis de propiedades matemáticas', ...
                             '• Manejo robusto de casos especiales', ...
                             '• Interpretación educativa de resultados', ...
                             '• Formato profesional de matrices', ...
                             '• Exportación de resultados', ...
                             '', ...
                             '📋 CONTROLES:', ...
                             '• EJEMPLO: Cargar casos de prueba', ...
                             '• LIMPIAR: Borrar resultados actuales', ...
                             '• AYUDA: Información detallada', ...
                             '• EXPORTAR: Guardar resultados en archivo', ...
                             '', ...
                             '🚀 ¡Seleccione una operación del menú para comenzar!'};
    
    % Mostrar panel de operaciones por defecto
    mostrar_panel('operaciones');
end