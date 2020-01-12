function PrintFigureButtonPushed(app) 

fig_name = fullfile(app.current_settings.file_path, sprintf('%s_%s_%02d.png', ...
    app.current_settings.file_name, app.current_settings.protocol.name, app.current_settings.protocol.value)); 
[fig_name, fig_path] = uiputfile('.png', ...
    'Select a home for the your PNG figure', fig_name);  

if fig_name == 0, return; end 

fig_name = fullfile(fig_path, fig_name); 

print(app.MainFigure, fig_name, '-dpng', '-r300');

end