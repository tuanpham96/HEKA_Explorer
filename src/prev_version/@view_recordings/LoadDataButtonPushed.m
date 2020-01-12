function LoadDataButtonPushed(app)
persistent file_path; 
if ~exist('file_path', 'var'), file_path = pwd; end 
%% Prompt get file 
file_format = app.LoadDataFormatButtonGroup.SelectedObject.String; 
[file_name, file_path] = uigetfile(fullfile(file_path,['*.' file_format]), sprintf('Select a %s file to read', upper(file_format))); 

if file_name == 0, return; end

app.current_settings.file_path = file_path; 
app.current_settings.file_name = file_name; 

def_datafiletext = app.DataFileText.String; 
app.DataFileText.String = 'wait for it ...'; 
pause(0.001); 

%% Obtain data table
DataAlreadyZeroed_inputoptions = {'I know they ARE',...
    'I know they are NOT', ...
    'Unsure but let''s go with YES', ...
    'Unsure but let''s go with NO'};
switch upper(file_format) 
    case 'DAT'
        DataAlreadyZeroed_answer = listdlg('PromptString', ...
            'Do you know if data have already been zeroed?', ...
            'SelectionMode', 'single', ...
            'ListString', DataAlreadyZeroed_inputoptions); 
        DataAlreadyZeroed_answer = DataAlreadyZeroed_answer == 1 || DataAlreadyZeroed_answer == 3; 
        
        tmp_data = HEKA_Importer(fullfile(file_path, file_name), 'DataAlreadyZeroed', DataAlreadyZeroed_answer);
        
        if isempty(tmp_data.RecTable)
            app.DataFileText.String = def_datafiletext;
            return;
        end
        
        app.data_table = tmp_data.RecTable;
    case 'MAT'
        load(fullfile(file_path, file_name), 'data_table');
        app.data_table = data_table;
    otherwise
        error('"%s" is not an acceptable file format to load', file_format);
end

app.DataFileText.String = file_name; 

%% Initialize  
% Protocol 
selected_protocol_value = 1; 
app.current_settings.available_protocols = cellfun(@(ind_rec, stim_name) ...
    sprintf('%02d: %s',ind_rec,stim_name), ...
    num2cell(app.data_table.Rec), app.data_table.Stimulus, ...
    'uni', 0);
app.current_settings.original_available_protocols = app.current_settings.available_protocols;
app.ProtocolSelectionMenu.String = app.current_settings.available_protocols; 
app.ProtocolSelectionMenu.Value = selected_protocol_value; 

app.NumberOfVariableMenu.String = 1:app.max_numplots; 
app.ProtocolSelectionMenuChanged; 


end
