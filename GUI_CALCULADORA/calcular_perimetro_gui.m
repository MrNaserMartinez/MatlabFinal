function calcular_perimetro_gui()
% CALCULADORA_PERIMETROS_GUI Interfaz gráfica mejorada con modo oscuro
% Esta función crea una GUI moderna y redimensionable para calcular perímetros

    % Variables globales para los controles y tema
    global edit_inputs text_resultado text_info popup_tipo current_figure;
    global uipanel_seleccion uipanel_datos uipanel_resultados uipanel_controles;
    global dark_mode theme_colors;
    
    current_figure = 'triangulo';
    dark_mode = true; % Empezar en modo oscuro
    
    % Definir colores para ambos temas
    setup_theme_colors();
    
    % Crear la figura principal con redimensionamiento
    fig = figure('Name', 'Calculadora de Perímetros - Modo Oscuro', ...
                 'Position', [150, 100, 850, 700], ...
                 'Resize', 'on', ...
                 'Color', theme_colors.bg_main, ...
                 'MenuBar', 'none', ...
                 'ToolBar', 'none', ...
                 'SizeChangedFcn', @resize_callback, ...
                 'CloseRequestFcn', @close_callback);
    
    % Título principal
    title_text = uicontrol('Style', 'text', ...
        'String', '📐 CALCULADORA DE PERÍMETROS', ...
        'Units', 'normalized', ...
        'Position', [0.05, 0.92, 0.7, 0.06], ...
        'FontSize', 16, ...
        'FontWeight', 'bold', ...
        'BackgroundColor', theme_colors.bg_main, ...
        'ForegroundColor', theme_colors.text_title, ...
        'HorizontalAlignment', 'left');
    
    % Switch para cambiar tema
    theme_switch = uicontrol('Style', 'togglebutton', ...
        'String', '☀️ Modo Claro', ...
        'Units', 'normalized', ...
        'Position', [0.8, 0.92, 0.15, 0.06], ...
        'FontSize', 10, ...
        'FontWeight', 'bold', ...
        'BackgroundColor', theme_colors.button_bg, ...
        'ForegroundColor', theme_colors.text_primary, ...
        'Value', dark_mode, ...
        'Callback', @toggle_theme);
    
    % Panel de selección de figura
    uipanel_seleccion = uipanel('Title', '🔷 Seleccionar Tipo de Figura', ...
        'Units', 'normalized', ...
        'Position', [0.02, 0.78, 0.96, 0.12], ...
        'BackgroundColor', theme_colors.panel_bg, ...
        'ForegroundColor', theme_colors.text_primary, ...
        'FontSize', 11, ...
        'FontWeight', 'bold', ...
        'BorderType', 'line', ...
        'HighlightColor', theme_colors.border);
    
    create_figure_buttons();
    
    % Panel de entrada de datos
    uipanel_datos = uipanel('Title', '⚙️ Configuración y Datos de Entrada', ...
        'Units', 'normalized', ...
        'Position', [0.02, 0.42, 0.96, 0.34], ...
        'BackgroundColor', theme_colors.panel_bg, ...
        'ForegroundColor', theme_colors.text_primary, ...
        'FontSize', 11, ...
        'FontWeight', 'bold', ...
        'BorderType', 'line', ...
        'HighlightColor', theme_colors.border);
    
    % Dropdown para subtipo
    uicontrol('Parent', uipanel_datos, ...
        'Style', 'text', ...
        'String', '🔧 Subtipo:', ...
        'Units', 'normalized', ...
        'Position', [0.02, 0.8, 0.15, 0.1], ...
        'FontSize', 10, ...
        'FontWeight', 'bold', ...
        'BackgroundColor', theme_colors.panel_bg, ...
        'ForegroundColor', theme_colors.text_primary, ...
        'HorizontalAlignment', 'left');
    
    popup_tipo = uicontrol('Parent', uipanel_datos, ...
        'Style', 'popupmenu', ...
        'String', {'Tres lados', 'Equilátero', 'Isósceles'}, ...
        'Units', 'normalized', ...
        'Position', [0.18, 0.8, 0.25, 0.1], ...
        'FontSize', 10, ...
        'BackgroundColor', theme_colors.edit_bg, ...
        'ForegroundColor', theme_colors.text_primary, ...
        'Callback', @actualizar_campos);
    
    % Campos de entrada (se crearán dinámicamente)
    edit_inputs = {};
    
    % Botón calcular mejorado
    calc_button = uicontrol('Parent', uipanel_datos, ...
        'Style', 'pushbutton', ...
        'String', '📊 CALCULAR PERÍMETRO', ...
        'Units', 'normalized', ...
        'Position', [0.35, 0.05, 0.3, 0.2], ...
        'FontSize', 11, ...
        'FontWeight', 'bold', ...
        'BackgroundColor', theme_colors.button_calc, ...
        'ForegroundColor', theme_colors.text_button, ...
        'Callback', @calcular_perimetro_callback);
    
    % Panel de resultados
    uipanel_resultados = uipanel('Title', '📈 Resultados del Cálculo', ...
        'Units', 'normalized', ...
        'Position', [0.02, 0.22, 0.96, 0.18], ...
        'BackgroundColor', theme_colors.panel_bg, ...
        'ForegroundColor', theme_colors.text_primary, ...
        'FontSize', 11, ...
        'FontWeight', 'bold', ...
        'BorderType', 'line', ...
        'HighlightColor', theme_colors.border);
    
    text_resultado = uicontrol('Parent', uipanel_resultados, ...
        'Style', 'text', ...
        'String', '✨ Seleccione una figura y configure los parámetros...', ...
        'Units', 'normalized', ...
        'Position', [0.02, 0.55, 0.96, 0.35], ...
        'FontSize', 12, ...
        'FontWeight', 'bold', ...
        'BackgroundColor', theme_colors.result_bg, ...
        'ForegroundColor', theme_colors.text_result, ...
        'HorizontalAlignment', 'center');
    
    text_info = uicontrol('Parent', uipanel_resultados, ...
        'Style', 'text', ...
        'String', '', ...
        'Units', 'normalized', ...
        'Position', [0.02, 0.1, 0.96, 0.35], ...
        'FontSize', 10, ...
        'BackgroundColor', theme_colors.panel_bg, ...
        'ForegroundColor', theme_colors.text_secondary, ...
        'HorizontalAlignment', 'center');
    
    % Panel de controles
    uipanel_controles = uipanel('Title', '🛠️ Herramientas de Control', ...
        'Units', 'normalized', ...
        'Position', [0.02, 0.02, 0.96, 0.18], ...
        'BackgroundColor', theme_colors.panel_bg, ...
        'ForegroundColor', theme_colors.text_primary, ...
        'FontSize', 11, ...
        'FontWeight', 'bold', ...
        'BorderType', 'line', ...
        'HighlightColor', theme_colors.border);
    
    create_control_buttons();
    
    % Inicializar con triángulo
    cambiar_figura('triangulo');
    
    % --- FUNCIONES DE CONFIGURACIÓN ---
    function setup_theme_colors()
        if dark_mode
            % Tema oscuro moderno
            theme_colors.bg_main = [0.12, 0.12, 0.15];
            theme_colors.panel_bg = [0.18, 0.18, 0.22];
            theme_colors.button_bg = [0.25, 0.25, 0.3];
            theme_colors.button_calc = [0.2, 0.6, 0.3];
            theme_colors.result_bg = [0.15, 0.2, 0.15];
            theme_colors.text_primary = [0.9, 0.9, 0.95];
            theme_colors.text_secondary = [0.7, 0.7, 0.8];
            theme_colors.text_title = [0.4, 0.8, 1.0];
            theme_colors.text_formula = [1.0, 0.8, 0.4];
            theme_colors.text_result = [0.4, 1.0, 0.6];
            theme_colors.text_button = [1, 1, 1];
            theme_colors.border = [0.4, 0.4, 0.5];
            theme_colors.edit_bg = [0.25, 0.25, 0.3];
        else
            % Tema claro moderno
            theme_colors.bg_main = [0.96, 0.96, 0.98];
            theme_colors.panel_bg = [1.0, 1.0, 1.0];
            theme_colors.button_bg = [0.9, 0.9, 0.95];
            theme_colors.button_calc = [0.2, 0.7, 0.4];
            theme_colors.result_bg = [0.9, 1.0, 0.9];
            theme_colors.text_primary = [0.1, 0.1, 0.2];
            theme_colors.text_secondary = [0.4, 0.4, 0.5];
            theme_colors.text_title = [0.1, 0.3, 0.8];
            theme_colors.text_formula = [0.6, 0.3, 0.1];
            theme_colors.text_result = [0.1, 0.6, 0.2];
            theme_colors.text_button = [1, 1, 1];
            theme_colors.border = [0.7, 0.7, 0.8];
            theme_colors.edit_bg = [1, 1, 1];
        end
    end
    
    function create_figure_buttons()
        figuras = {'triangulo', 'cuadrilatero', 'circulo', 'poligono'};
        nombres = {'🔺 Triángulo', '🔷 Cuadrilátero', '⭕ Círculo', '⬢ Polígono Regular'};
        colores = {[1.0, 0.7, 0.5], [0.7, 1.0, 0.5], [0.5, 0.7, 1.0], [1.0, 0.5, 0.7]};
        
        for i = 1:4
            x = 0.02 + (i-1) * 0.24;
            y = 0.3;
            
            color = colores{i};
            if dark_mode
                color = color * 0.7; % Oscurecer colores en modo oscuro
            end
            
            uicontrol('Parent', uipanel_seleccion, ...
                'Style', 'pushbutton', ...
                'String', nombres{i}, ...
                'Units', 'normalized', ...
                'Position', [x, y, 0.22, 0.5], ...
                'FontSize', 10, ...
                'FontWeight', 'bold', ...
                'BackgroundColor', color, ...
                'ForegroundColor', theme_colors.text_primary, ...
                'Callback', @(src,evt) cambiar_figura(figuras{i}));
        end
    end
    
    function create_control_buttons()
        botones = {{'📋 Fórmulas', @mostrar_formulas, [0.7, 0.7, 1.0]}, ...
                   {'🧹 Limpiar', @limpiar_campos, [1.0, 0.8, 0.6]}, ...
                   {'❌ Salir', @(~,~) close(fig), [1.0, 0.6, 0.6]}};
        
        for i = 1:3
            x = 0.15 + (i-1) * 0.25;
            color = botones{i}{3};
            if dark_mode
                color = color * 0.8;
            end
            
            uicontrol('Parent', uipanel_controles, ...
                'Style', 'pushbutton', ...
                'String', botones{i}{1}, ...
                'Units', 'normalized', ...
                'Position', [x, 0.3, 0.2, 0.4], ...
                'FontSize', 10, ...
                'FontWeight', 'bold', ...
                'BackgroundColor', color, ...
                'ForegroundColor', theme_colors.text_primary, ...
                'Callback', botones{i}{2});
        end
    end
    
    % --- FUNCIONES PRINCIPALES ---
    function toggle_theme(src, ~)
        dark_mode = get(src, 'Value');
        setup_theme_colors();
        update_all_colors();
        
        if dark_mode
            set(src, 'String', '☀️ Modo Claro');
            set(fig, 'Name', 'Calculadora de Perímetros - Modo Oscuro');
        else
            set(src, 'String', '🌙 Modo Oscuro');
            set(fig, 'Name', 'Calculadora de Perímetros - Modo Claro');
        end
    end
    
    function update_all_colors()
        % Actualizar figura principal
        set(fig, 'Color', theme_colors.bg_main);
        
        % Actualizar todos los elementos
        all_children = findall(fig);
        for i = 1:length(all_children)
            obj = all_children(i);
            if isprop(obj, 'BackgroundColor') && isprop(obj, 'Type')
                switch get(obj, 'Type')
                    case 'uipanel'
                        set(obj, 'BackgroundColor', theme_colors.panel_bg);
                        set(obj, 'ForegroundColor', theme_colors.text_primary);
                    case 'uicontrol'
                        style = get(obj, 'Style');
                        if strcmp(style, 'text')
                            if obj == text_resultado
                                set(obj, 'BackgroundColor', theme_colors.result_bg);
                                set(obj, 'ForegroundColor', theme_colors.text_result);
                            else
                                set(obj, 'BackgroundColor', theme_colors.panel_bg);
                                set(obj, 'ForegroundColor', theme_colors.text_primary);
                            end
                        elseif strcmp(style, 'edit') || strcmp(style, 'popupmenu')
                            set(obj, 'BackgroundColor', theme_colors.edit_bg);
                            set(obj, 'ForegroundColor', theme_colors.text_primary);
                        end
                end
            end
        end
        
        % Recrear botones con nuevos colores
        delete(get(uipanel_seleccion, 'Children'));
        delete(get(uipanel_controles, 'Children'));
        create_figure_buttons();
        create_control_buttons();
        
        % Recrear botón calcular
        calc_button = uicontrol('Parent', uipanel_datos, ...
            'Style', 'pushbutton', ...
            'String', '📊 CALCULAR PERÍMETRO', ...
            'Units', 'normalized', ...
            'Position', [0.35, 0.05, 0.3, 0.2], ...
            'FontSize', 11, ...
            'FontWeight', 'bold', ...
            'BackgroundColor', theme_colors.button_calc, ...
            'ForegroundColor', theme_colors.text_button, ...
            'Callback', @calcular_perimetro_callback);
        
        % Recrear dropdown
        popup_tipo = uicontrol('Parent', uipanel_datos, ...
            'Style', 'popupmenu', ...
            'String', get(popup_tipo, 'String'), ...
            'Value', get(popup_tipo, 'Value'), ...
            'Units', 'normalized', ...
            'Position', [0.18, 0.8, 0.25, 0.1], ...
            'FontSize', 10, ...
            'BackgroundColor', theme_colors.edit_bg, ...
            'ForegroundColor', theme_colors.text_primary, ...
            'Callback', @actualizar_campos);
            
        % Recrear label del dropdown
        uicontrol('Parent', uipanel_datos, ...
            'Style', 'text', ...
            'String', '🔧 Subtipo:', ...
            'Units', 'normalized', ...
            'Position', [0.02, 0.8, 0.15, 0.1], ...
            'FontSize', 10, ...
            'FontWeight', 'bold', ...
            'BackgroundColor', theme_colors.panel_bg, ...
            'ForegroundColor', theme_colors.text_primary, ...
            'HorizontalAlignment', 'left');
    end
    
    function cambiar_figura(tipo)
        current_figure = tipo;
        
        % Configurar opciones según el tipo
        switch tipo
            case 'triangulo'
                set(popup_tipo, 'String', {'🔺 Tres lados', '🔺 Equilátero', '🔺 Isósceles'});
                set(popup_tipo, 'Value', 1);
            case 'cuadrilatero'
                set(popup_tipo, 'String', {'⬜ Cuadrado', '▭ Rectángulo', '◊ Rombo', '▱ Paralelogramo', '🔷 Irregular', '📍 Por coordenadas'});
                set(popup_tipo, 'Value', 1);
            case 'circulo'
                set(popup_tipo, 'String', {'📏 Por radio', '📐 Por diámetro', '📊 Por área', '🌙 Por arco y ángulo'});
                set(popup_tipo, 'Value', 1);
            case 'poligono'
                set(popup_tipo, 'String', {'⬢ Polígono regular'});
                set(popup_tipo, 'Value', 1);
        end
        
        actualizar_campos();
    end
    
    function actualizar_campos(~, ~)
        % Limpiar campos anteriores
        for i = 1:length(edit_inputs)
            if ishandle(edit_inputs{i}.label)
                delete(edit_inputs{i}.label);
            end
            if ishandle(edit_inputs{i}.edit)
                delete(edit_inputs{i}.edit);
            end
        end
        edit_inputs = {};
        
        % Crear campos según la selección
        opcion = get(popup_tipo, 'Value');
        
        switch current_figure
            case 'triangulo'
                switch opcion
                    case 1 % Tres lados
                        crear_campo('📏 Lado 1:', 0.05, 0.65);
                        crear_campo('📏 Lado 2:', 0.35, 0.65);
                        crear_campo('📏 Lado 3:', 0.65, 0.65);
                    case 2 % Equilátero
                        crear_campo('📏 Lado:', 0.35, 0.65);
                    case 3 % Isósceles
                        crear_campo('📏 Base:', 0.25, 0.65);
                        crear_campo('📏 Lados iguales:', 0.55, 0.65);
                end
                
            case 'cuadrilatero'
                switch opcion
                    case 1 % Cuadrado
                        crear_campo('📏 Lado:', 0.35, 0.65);
                    case 2 % Rectángulo
                        crear_campo('📏 Largo:', 0.25, 0.65);
                        crear_campo('📏 Ancho:', 0.55, 0.65);
                    case 3 % Rombo
                        crear_campo('📏 Lado:', 0.35, 0.65);
                    case 4 % Paralelogramo
                        crear_campo('📏 Lado 1:', 0.25, 0.65);
                        crear_campo('📏 Lado 2:', 0.55, 0.65);
                    case 5 % Irregular
                        crear_campo('📏 Lado 1:', 0.05, 0.65);
                        crear_campo('📏 Lado 2:', 0.28, 0.65);
                        crear_campo('📏 Lado 3:', 0.51, 0.65);
                        crear_campo('📏 Lado 4:', 0.74, 0.65);
                    case 6 % Por coordenadas
                        crear_campo('x1:', 0.05, 0.65);
                        crear_campo('y1:', 0.18, 0.65);
                        crear_campo('x2:', 0.31, 0.65);
                        crear_campo('y2:', 0.44, 0.65);
                        crear_campo('x3:', 0.57, 0.65);
                        crear_campo('y3:', 0.7, 0.65);
                        crear_campo('x4:', 0.05, 0.45);
                        crear_campo('y4:', 0.18, 0.45);
                end
                
            case 'circulo'
                switch opcion
                    case 1 % Por radio
                        crear_campo('📏 Radio:', 0.35, 0.65);
                    case 2 % Por diámetro
                        crear_campo('📐 Diámetro:', 0.35, 0.65);
                    case 3 % Por área
                        crear_campo('📊 Área:', 0.35, 0.65);
                    case 4 % Por arco y ángulo
                        crear_campo('📏 Long. arco:', 0.25, 0.65);
                        crear_campo('📐 Ángulo (°):', 0.55, 0.65);
                end
                
            case 'poligono'
                crear_campo('🔢 N° lados:', 0.25, 0.65);
                crear_campo('📏 Long. lado:', 0.55, 0.65);
        end
        
        % Limpiar resultados
        set(text_resultado, 'String', '✨ Configure los parámetros y presione calcular...');
        set(text_info, 'String', '');
    end
    
    function crear_campo(etiqueta, x, y)
        n = length(edit_inputs) + 1;
        
        edit_inputs{n}.label = uicontrol('Parent', uipanel_datos, ...
            'Style', 'text', ...
            'String', etiqueta, ...
            'Units', 'normalized', ...
            'Position', [x, y, 0.2, 0.1], ...
            'FontSize', 9, ...
            'FontWeight', 'bold', ...
            'BackgroundColor', theme_colors.panel_bg, ...
            'ForegroundColor', theme_colors.text_primary, ...
            'HorizontalAlignment', 'left');
        
        edit_inputs{n}.edit = uicontrol('Parent', uipanel_datos, ...
            'Style', 'edit', ...
            'Units', 'normalized', ...
            'Position', [x, y-0.12, 0.2, 0.08], ...
            'FontSize', 10, ...
            'BackgroundColor', theme_colors.edit_bg, ...
            'ForegroundColor', theme_colors.text_primary);
    end
    
    function calcular_perimetro_callback(~, ~)
        try
            % Obtener valores de los campos
            valores = [];
            for i = 1:length(edit_inputs)
                valor = str2double(get(edit_inputs{i}.edit, 'String'));
                if isnan(valor)
                    set(text_resultado, 'String', '⚠️ Error: Todos los campos deben contener números válidos');
                    set(text_info, 'String', '');
                    return;
                end
                valores(end+1) = valor;
            end
            
            % Calcular según el tipo seleccionado
            opcion = get(popup_tipo, 'Value');
            [perimetro, info_adicional] = calcular_segun_tipo(current_figure, opcion, valores);
            
            % Mostrar resultado con formato mejorado
            if perimetro < 1
                perim_str = sprintf('%.6f', perimetro);
            elseif perimetro < 1000
                perim_str = sprintf('%.4f', perimetro);
            else
                perim_str = sprintf('%.2f', perimetro);
            end
            
            set(text_resultado, 'String', sprintf('📐 Perímetro: %s unidades', perim_str));
            set(text_info, 'String', info_adicional);
            
        catch ME
            set(text_resultado, 'String', '❌ Error en el cálculo');
            set(text_info, 'String', ME.message);
        end
    end
    
    function [perimetro, info] = calcular_segun_tipo(figura, opcion, valores)
        info = '';
        
        switch figura
            case 'triangulo'
                switch opcion
                    case 1 % Tres lados
                        if (valores(1) + valores(2) > valores(3)) && ...
                           (valores(1) + valores(3) > valores(2)) && ...
                           (valores(2) + valores(3) > valores(1))
                            perimetro = sum(valores);
                            area = calcular_area_triangulo_heron(valores(1), valores(2), valores(3));
                            info = sprintf('📏 Lados: %.2f, %.2f, %.2f | 📊 Área: %.4f', valores(1), valores(2), valores(3), area);
                        else
                            error('⚠️ Los lados no pueden formar un triángulo válido (desigualdad triangular)');
                        end
                    case 2 % Equilátero
                        perimetro = 3 * valores(1);
                        area = (sqrt(3)/4) * valores(1)^2;
                        altura = (sqrt(3)/2) * valores(1);
                        info = sprintf('📏 Lado: %.2f | 📊 Área: %.4f | 📐 Altura: %.4f', valores(1), area, altura);
                    case 3 % Isósceles
                        perimetro = valores(1) + 2 * valores(2);
                        % Verificar que puede formar un triángulo
                        if valores(1) < 2 * valores(2) && 2 * valores(2) > valores(1)
                            altura = sqrt(valores(2)^2 - (valores(1)/2)^2);
                            area = 0.5 * valores(1) * altura;
                            info = sprintf('📏 Base: %.2f | 📏 Lados: %.2f | 📊 Área: %.4f', valores(1), valores(2), area);
                        else
                            error('⚠️ Las dimensiones no forman un triángulo isósceles válido');
                        end
                end
                
            case 'cuadrilatero'
                switch opcion
                    case 1 % Cuadrado
                        perimetro = 4 * valores(1);
                        area = valores(1)^2;
                        diagonal = valores(1) * sqrt(2);
                        info = sprintf('📏 Lado: %.2f | 📊 Área: %.4f | 🔷 Diagonal: %.4f', valores(1), area, diagonal);
                    case 2 % Rectángulo
                        perimetro = 2 * (valores(1) + valores(2));
                        area = valores(1) * valores(2);
                        diagonal = sqrt(valores(1)^2 + valores(2)^2);
                        info = sprintf('📏 Dimensiones: %.2f × %.2f | 📊 Área: %.4f | 🔷 Diagonal: %.4f', valores(1), valores(2), area, diagonal);
                    case 3 % Rombo
                        perimetro = 4 * valores(1);
                        info = sprintf('📏 Lado: %.2f | ⚠️ Para el área se necesitan las diagonales', valores(1));
                    case 4 % Paralelogramo
                        perimetro = 2 * (valores(1) + valores(2));
                        info = sprintf('📏 Lados paralelos: %.2f y %.2f', valores(1), valores(2));
                    case 5 % Irregular
                        perimetro = sum(valores);
                        info = sprintf('📏 Lados: %.2f, %.2f, %.2f, %.2f', valores(1), valores(2), valores(3), valores(4));
                    case 6 % Por coordenadas
                        lado1 = sqrt((valores(3) - valores(1))^2 + (valores(4) - valores(2))^2);
                        lado2 = sqrt((valores(5) - valores(3))^2 + (valores(6) - valores(4))^2);
                        lado3 = sqrt((valores(7) - valores(5))^2 + (valores(8) - valores(6))^2);
                        lado4 = sqrt((valores(1) - valores(7))^2 + (valores(2) - valores(8))^2);
                        perimetro = lado1 + lado2 + lado3 + lado4;
                        % Fórmula del cordón de zapatos para el área
                        area = 0.5 * abs((valores(1)*valores(4) - valores(3)*valores(2)) + ...
                                        (valores(3)*valores(6) - valores(5)*valores(4)) + ...
                                        (valores(5)*valores(8) - valores(7)*valores(6)) + ...
                                        (valores(7)*valores(2) - valores(1)*valores(8)));
                        info = sprintf('📍 Coordenadas: (%.1f,%.1f) (%.1f,%.1f) (%.1f,%.1f) (%.1f,%.1f) | 📊 Área: %.4f', ...
                                      valores(1), valores(2), valores(3), valores(4), valores(5), valores(6), valores(7), valores(8), area);
                end
                
            case 'circulo'
                switch opcion
                    case 1 % Por radio
                        if valores(1) <= 0
                            error('⚠️ El radio debe ser positivo');
                        end
                        perimetro = 2 * pi * valores(1);
                        area = pi * valores(1)^2;
                        diametro = 2 * valores(1);
                        info = sprintf('📏 Radio: %.4f | 📐 Diámetro: %.4f | 📊 Área: %.4f', valores(1), diametro, area);
                    case 2 % Por diámetro
                        if valores(1) <= 0
                            error('⚠️ El diámetro debe ser positivo');
                        end
                        perimetro = pi * valores(1);
                        radio = valores(1) / 2;
                        area = pi * radio^2;
                        info = sprintf('📐 Diámetro: %.4f | 📏 Radio: %.4f | 📊 Área: %.4f', valores(1), radio, area);
                    case 3 % Por área
                        if valores(1) <= 0
                            error('⚠️ El área debe ser positiva');
                        end
                        radio = sqrt(valores(1) / pi);
                        perimetro = 2 * pi * radio;
                        diametro = 2 * radio;
                        info = sprintf('📊 Área: %.4f | 📏 Radio: %.4f | 📐 Diámetro: %.4f', valores(1), radio, diametro);
                    case 4 % Por arco y ángulo
                        if valores(1) <= 0 || valores(2) <= 0 || valores(2) >= 360
                            error('⚠️ Longitud del arco debe ser positiva y ángulo entre 0 y 360 grados');
                        end
                        perimetro = valores(1) * 360 / valores(2);
                        radio = valores(1) / (valores(2) * pi / 180);
                        area = pi * radio^2;
                        info = sprintf('📏 Arco: %.4f | 📐 Ángulo: %.2f° | 📏 Radio: %.4f | 📊 Área: %.4f', valores(1), valores(2), radio, area);
                end
                
            case 'poligono'
                if valores(1) < 3 || valores(1) ~= round(valores(1))
                    error('⚠️ El número de lados debe ser un entero mayor o igual a 3');
                end
                if valores(2) <= 0
                    error('⚠️ La longitud del lado debe ser positiva');
                end
                n_lados = round(valores(1));
                perimetro = n_lados * valores(2);
                % Área de polígono regular
                apotema = valores(2) / (2 * tan(pi / n_lados));
                area = 0.5 * perimetro * apotema;
                angulo_interior = (n_lados - 2) * 180 / n_lados;
                info = sprintf('⬢ %d lados de %.4f c/u | 📊 Área: %.4f | 📐 Ángulo interior: %.2f°', n_lados, valores(2), area, angulo_interior);
        end
    end
    
    function area = calcular_area_triangulo_heron(a, b, c)
        % Fórmula de Herón para calcular el área
        s = (a + b + c) / 2; % Semiperímetro
        area = sqrt(s * (s - a) * (s - b) * (s - c));
    end
    
    function mostrar_formulas(~, ~)
        formulas_msg = sprintf(['📐 FÓRMULAS DE PERÍMETRO 📐\n\n' ...
            '🔺 TRIÁNGULOS:\n' ...
            '• Cualquiera: P = a + b + c\n' ...
            '• Equilátero: P = 3 × lado\n' ...
            '• Isósceles: P = base + 2 × lados_iguales\n\n' ...
            '🔷 CUADRILÁTEROS:\n' ...
            '• Cuadrado: P = 4 × lado\n' ...
            '• Rectángulo: P = 2 × (largo + ancho)\n' ...
            '• Rombo: P = 4 × lado\n' ...
            '• Paralelogramo: P = 2 × (lado₁ + lado₂)\n' ...
            '• Irregular: P = suma de todos los lados\n\n' ...
            '⭕ CÍRCULO:\n' ...
            '• Por radio: P = 2 × π × radio\n' ...
            '• Por diámetro: P = π × diámetro\n' ...
            '• Por área: P = 2 × π × √(área/π)\n\n' ...
            '⬢ POLÍGONO REGULAR:\n' ...
            '• P = número_lados × longitud_lado\n\n' ...
            '💡 Todos los valores deben ser positivos\n' ...
            '📊 Se calculan áreas adicionales cuando es posible']);
        
        msgbox(formulas_msg, '📐 Fórmulas de Perímetro', 'help');
    end
    
    function limpiar_campos(~, ~)
        for i = 1:length(edit_inputs)
            set(edit_inputs{i}.edit, 'String', '');
        end
        set(text_resultado, 'String', '🧹 Campos limpiados. Configure nuevos parámetros...');
        set(text_info, 'String', '');
    end
    
    function resize_callback(~, ~)
        % La función se ejecuta automáticamente al redimensionar
        % Los elementos con 'Units' = 'normalized' se ajustan automáticamente
    end
    
    function close_callback(~, ~)
        selection = questdlg('¿Está seguro que desea cerrar la calculadora?', ...
                           'Confirmar Cierre', ...
                           'Sí', 'No', 'No');
        if strcmp(selection, 'Sí')
            delete(fig);
        end
    end
end