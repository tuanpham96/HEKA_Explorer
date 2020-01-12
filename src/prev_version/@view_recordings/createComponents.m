function createComponents(app)
if ~exist('app_layout', 'var'), load('config/app_layout.mat', 'app_layout'); end
if ~exist('app_styles', 'var'), load('config/app_styles.mat', 'app_styles'); end

%% MainFigure
app.MainFigure = figure(...
    'Units', 'normalized', ...
    'WindowState', 'maximized', ...
    'Color', 'w', ...
    'Resize', 'on');
addToolbarExplorationButtons(app.MainFigure); 

set(app.MainFigure, ...
    'DefaultUIPanelFontSize', app_styles.AppFontSize, ...
    'DefaultUIPanelBackgroundColor', 'w', ...
    'DefaultUIPanelUnits', 'normalized', ...
    'DefaultUIPanelBorderWidth', 1);

set(app.MainFigure, ...
    'DefaultUIButtonGroupFontSize', app_styles.AppFontSize, ...
    'DefaultUIButtonGroupBackgroundColor', 'w', ...
    'DefaultUIButtonGroupUnits', 'normalized', ...
    'DefaultUIButtonGroupBorderWidth', 1);

set(app.MainFigure, ...
    'DefaultUIControlFontSize', app_styles.AppFontSize, ...
    'DefaultUIControlBackgroundColor', 'w', ...    
    'DefaultUIControlUnits', 'normalized');

set(app.MainFigure, ...
    'DefaultAxesColor', 'none', ...
    'DefaultAxesUnits', 'normalized', ...
    'DefaultAxesFontSize', app_styles.TraceAxes_FontSize, ...
    'DefaultLineLineWidth', app_styles.TraceAxes_LineWidth, ...
    'DefaultAxesTitleFontWeight', app_styles.TraceAxes_TitleFontWeight, ...
    'DefaultAxesTitleFontSize', app_styles.TraceAxes_TitleFontSizeMultiplier, ...
    'DefaultAxesLabelFontSize', app_styles.TraceAxes_LabelFontSizeMultiplier, ...
    'DefaultAxesTickDirMode', 'manual', ...
    'DefaultAxesTickDir', app_styles.TraceAxes_TickDir, ...
    'DefaultAxesBoxMode', 'manual', ...
    'DefaultAxesLineWidth', app_styles.TraceAxes_BorderWidth, ...
    'DefaultAxesBox', app_styles.TraceAxes_BoxOption, ...
    'DefaultAxesCreateFcn',@(ax,~)set(ax.Toolbar,'Visible',app_styles.TraceAxes_ToolbarOption));

%% Initialize all components
component_names = fieldnames(app_layout);
for ind_comp = 1:length(component_names)
    comp_name = component_names{ind_comp};
    comp_struct = app_layout.(comp_name);
    
    % No style
    if ~isfield(comp_struct, 'style')
        app.(comp_name) = comp_struct.position;
        continue;
    end
    
    
    % With style (as in ui objects) 
    comp_style = comp_struct.style;
    parent_name = comp_struct.parent;
    
    % Adjust position based on parent's position 
    if ~strcmp(parent_name, 'MainFigure')        
        parent_pos = app_layout.(parent_name).position;
        comp_pos = comp_struct.position;
        comp_pos(1) = abs(comp_pos(1) - parent_pos(1))/parent_pos(3);
        comp_pos(2) = abs(comp_pos(2) - parent_pos(2))/parent_pos(4);
        comp_pos(3) = comp_pos(3)/parent_pos(3);
        comp_pos(4) = comp_pos(4)/parent_pos(4);
        comp_struct.position = comp_pos;
    end
    
    % If name contains template, return the entire struct
    if contains(comp_name, 'TEMPLATE', 'IgnoreCase', true)
        app.(comp_name) = comp_struct;
        continue;
    end
    
    % With stylegroup (as in additional stylings)
    stylepropvals = {};
    if isfield(comp_struct, 'stylegroup')
        stylegroup = upper(comp_struct.stylegroup);
        stylepropvals = struct2propvalpaircell(app_styles.(stylegroup));
        comp_struct = rmfield(comp_struct, 'stylegroup');
    end
    
    comp_struct = rmfield(comp_struct, {'parent', 'style'});
    
    
    comp_propvals = struct2propvalpaircell(comp_struct);
    
    % Handle each case separately     
    switch upper(comp_style)
        case 'TEXTBOX'    
            app.(comp_name) = annotation(app.(parent_name), 'textbox', ...
                'String', comp_struct.string, ...
                'Position', comp_struct.position, ...
                stylepropvals{:});
        case 'PANEL'
            app.(comp_name) = uipanel(app.(parent_name), ...
                comp_propvals{:}, stylepropvals{:});
        case 'IMAGE'
            app.(comp_name) = axes(app.(parent_name), ...
                'Position', comp_struct.position, ...
                'Visible', 'off');
            imshow(imread(comp_struct.imfile), 'Parent', app.(comp_name));
        case 'AXES'
            app.(comp_name) = axes(app.(parent_name), ...
                comp_propvals{:}, stylepropvals{:});
        case 'BUTTONGROUP'
            app.(comp_name) = uibuttongroup(app.(parent_name), ...
                comp_propvals{:}, stylepropvals{:});
        otherwise
            app.(comp_name) = uicontrol(app.(parent_name), 'Style', comp_style, ...
                comp_propvals{:}, stylepropvals{:});
    end
end

%% Grouping 
app.VariableSelection_TextList = gobjects(app.max_numplots, 1);
app.VariableSelection_MenuList = gobjects(app.max_numplots, 1);
for ind_varsel = 1:app.max_numplots
    app.VariableSelection_TextList(ind_varsel) = app.(sprintf('VariableSelection_Text%02d', ind_varsel));
    app.VariableSelection_MenuList(ind_varsel) = app.(sprintf('VariableSelection_Menu%02d', ind_varsel));
end

%% Callbacks 
app.LoadDataButton.Callback = @(s,e) LoadDataButtonPushed(app); 
app.SaveMATTableButton.Callback = @(s,e) SaveMATTableButtonpPushed(app); 

app.ProtocolSelectionMenu.Callback = @(s,e) ProtocolSelectionMenuChanged(app); 
app.ProtocolSelectionNextButton.Callback = @(s,e) ProtocolSelectionNextButtonPushed(app); 
app.ProtocolSelectionPreviousButton.Callback = @(s,e) ProtocolSelectionPreviousButtonPushed(app); 
app.ProtocolSelectionChangeNameButton.Callback = @(s,e) ProtocolSelectionChangeNameButtonPushed(app);

app.SweepSelectionShowAllTickBox.Callback = @(s,e) SweepSelectionShowAllTickBoxTicked(app,0); 
app.SweepSelectionInput.Callback = @(s,e) SweepSelectionInputChanged(app); 
app.SweepSelectionNextButton.Callback = @(s,e) SweepSelectionNextButtonPushed(app); 
app.SweepSelectionPreviousButton.Callback = @(s,e) SweepSelectionPreviousButtonPushed(app); 

app.NumberOfVariableMenu.Callback = @(s,e) NumberOfVariableMenuChanged(app); 
arrayfun(@(x) set(x, 'Callback', @(s,e) VariableSelectionMenusChanged(app)), app.VariableSelection_MenuList); 

app.XAxisLinkButton.Callback = @(s,e) XAxisLinkButtonPushed(app);
app.XAxisShowAllButton.Callback = @(s,e) XAxisShowAllButtonPushed(app);
app.XAxisXLimInput.Callback = @(s,e) XAxisXLimInputChanged(app); 

app.VariableManipulation_OriginalNameMenu.Callback = @(s,e) VariableManipulation_OriginalNameMenuChanged(app);
app.VariableManipulation_NewNameInput.Callback = @(s,e) VariableManipulation_NewNameInputChanged(app);
app.VariableManipulation_ColorButton.Callback = @(s,e) VariableManipulation_ColorButtonChanged(app);
app.VariableManipulation_YLimInput.Callback = @(s,e) VariableManipulation_YLimInputChanged(app); 

app.PrintFigureButton.Callback = @(s,e) PrintFigureButtonPushed(app); 

set(zoom(app.MainFigure), 'ActionPostCallback', @(s,e) app.trackYLimChanges);
set(pan(app.MainFigure), 'ActionPostCallback', @(s,e) app.trackYLimChanges);

%% Defaults 
app.LoadDataFormatButtonGroup.SelectedObject = app.LoadDataFormatButtonGroup_DAT; 

end

function pvp = struct2propvalpaircell(s)
s_fields = fieldnames(s)';
s_values = struct2cell(s)';
pvp = vertcat(s_fields, s_values);
pvp = pvp(:);
end

