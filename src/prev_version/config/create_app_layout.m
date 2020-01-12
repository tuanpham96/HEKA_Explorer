[app_layout, dimensions] = return_figure_layout('view_recordings_layout.svg', ...
    struct('find_pattern', 'APP_.+', 'replace_pattern', 'APP_', 'replace_with', ''));

% fig = figure('windowstate', 'maximized', 'units', 'normalized');
% layout_names = fieldnames(app_layout); 
% for ind = 1:length(layout_names) 
%     ly_name = layout_names{ind}; 
%     ly_struct = app_layout.(ly_name);   
%     uipanel(fig, 'title', ly_name, 'units', 'normalized', 'position', ly_struct.position);
% end

save('app_layout.mat', 'app_layout'); 