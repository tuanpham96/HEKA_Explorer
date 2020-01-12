classdef view_recordings < matlab.apps.AppBase
    
    % Properties that correspond to app components
    properties (Access = private)
        %% Main figure to contain the elements 
        MainFigure
        
        %% App descriptions
        AppTitleText
        AppLogo
        
        %% Panels with axes to show traces
        TraceAxesBoundary
        TraceAxesList
        
        %% Load-data/selection panels
        LoadDataPanel        
        
        LoadDataButton
        DataFileText
        LoadDataFormatButtonGroup
        LoadDataFormatButtonGroup_DAT
        LoadDataFormatButtonGroup_MAT
        
        SaveMATTableButton
        SaveMATTableText
        
        %% Trace selection panels
        TraceSelectionPanel
        
        ProtocolSelectionText
        ProtocolSelectionMenu
        ProtocolSelectionChangeNameButton
        ProtocolSelectionNextButton
        ProtocolSelectionPreviousButton
        
        SweepSelectionText
        SweepSelectionInput
        SweepSelectionShowAllTickBox
        SweepSelectionNextButton
        SweepSelectionPreviousButton
        
        %% Variable selection panels
        VariableSelectionPanel
        VariableSelectionText
        
        NumberOfVariableText
        NumberOfVariableMenu
        
        VariableSelection_TextList
        VariableSelection_MenuList
        
        VariableSelection_Text01
        VariableSelection_Menu01
        
        VariableSelection_Text02
        VariableSelection_Menu02
        
        VariableSelection_Text03
        VariableSelection_Menu03
        
        VariableSelection_Text04
        VariableSelection_Menu04
        
        VariableSelection_Text05
        VariableSelection_Menu05
        
        VariableSelection_Text06
        VariableSelection_Menu06
        
        VariableSelection_Text07
        VariableSelection_Menu07
        
        VariableSelection_Text08
        VariableSelection_Menu08
        
        VariableSelection_Text09
        VariableSelection_Menu09
        
        %% Variable manipulation panel
        VariableManipulationPanel
        VairableManipulationText
        
        VariableManipulationColorText
        VariableManipulationSaveText
        VariableManipulationYLimText
        
        VariableManipulation_OriginalNameMenu
        VariableManipulation_NewNameInput
        VariableManipulation_ColorButton
        VariableManipulation_SaveTickBox
        VariableManipulation_YLimInput
        
        %% X-axis view options
        XAxisViewPanel
        
        XAxisShowAllButton
        XAxisLinkButton
        XAxisXLimInput
        
        %% Save selection panel
        SaveSelectionPanel
        SaveSelectionText
        
        SaveSelectionCurrentButtonGroup
        SaveSelectionCurrentButtonGroup_Button1
        SaveSelectionCurrentButtonGroup_Button2
        
        SaveSelectionFileFormatButtonGroup
        SaveSelectionFileFormatButtonGroup_MAT
        SaveSelectionFileFormatButtonGroup_CSV
        
        SaveSelectionButton
        PrintFigureButton
        
    end
    
    properties (Access = private)
        data_table        
    end
    
    properties (Access = private) % to be turned to private later
        max_numplots = 9;
        current_data = struct;         
        current_settings = struct; 
        current_variables = struct; 
    end
    
    methods (Access = private) 
        getRecording(app, ind_rec); 
    end
    
    methods (Access = private)
        createComponents(app)
        plotTraces(app) 
        showOnlySelectedSweep(app) 
        
        updateSelectedYLimChanged(app, var_id, new_ylim)
        trackYLimChanges(app)
        
        LoadDataButtonPushed(app) 
        SaveMATTableButtonpPushed(app) 
        
        ProtocolSelectionMenuChanged(app)
        ProtocolSelectionChangeNameButtonPushed(app)
        ProtocolSelectionNextButtonPushed(app)
        ProtocolSelectionPreviousButtonPushed(app)
        
        SweepSelectionShowAllTickBoxTicked(app,init) 
        SweepSelectionInputChanged(app)
        SweepSelectionNextButtonPushed(app)
        SweepSelectionPreviousButtonPushed(app)
        
        NumberOfVariableMenuChanged(app) 
        VariableSelectionMenusChanged(app) 
        
        XAxisShowAllButtonPushed(app)
        XAxisLinkButtonPushed(app)    
        XAxisXLimInputChanged(app)
        
        VariableManipulation_OriginalNameTextChanged(app) 
        VariableManipulation_NewNameInputChanged(app) 
        VariableManipulation_ColorButtonChanged(app) 
        VariableManipulation_YLimInputChanged(app)
        
        SaveSelectionCurrentButtonGroupChanged(app)
        SaveSelectionFileFormatButtonGroupChanged(app) 
        
        SaveSelectionButtonPushed(app) 
        PrintFigureButtonPushed(app) 
        
    end
    
    methods (Static, Access = private) 
        s = ylim_displaytext(d) 
        d = convert_axislim_string2double(obj)
    end 
    
    methods (Access = public)
        
        % Construct app
        function app = view_recordings  
            createComponents(app);
        end
        
        % Code that executes before app deletion
        function delete(app)
            delete(app.MainFigure);
        end
    end
end