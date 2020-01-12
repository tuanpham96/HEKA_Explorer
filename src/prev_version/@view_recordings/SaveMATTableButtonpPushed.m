function SaveMATTableButtonpPushed(app)
if isempty(app.data_table) || isempty(app.current_settings.file_path) 
    app.SaveMATTableText.String = 'no data to save'; 
    return; 
end 

[save_datatable_name, save_datatable_path] = uiputfile('.mat', ...
    'Select a home for the MAT data table file', ...
    sprintf('%s.mat', fullfile(app.current_settings.file_path, app.current_settings.file_name(1:end-4))));

if save_datatable_name == 0, return; end 
save_filename = fullfile(save_datatable_path, save_datatable_name); 

data_table = app.data_table; 
save(save_filename, 'data_table'); 

end