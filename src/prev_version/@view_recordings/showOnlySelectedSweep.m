function showOnlySelectedSweep(app) 
selected_sweeps = app.current_settings.sweeps.selected; 
num_plots = app.NumberOfVariableMenu.Value; 
for ind_plt = 1:num_plots
    line_tags = cellfun(@str2double, {app.TraceAxesList(ind_plt).Children.Tag}, 'uni', 1); 
    shown_line_indices = arrayfun(@(x) any(x == selected_sweeps) || isnan(x), line_tags, 'uni', 1); 
    set(app.TraceAxesList(ind_plt).Children(shown_line_indices), 'LineStyle', '-'); 
    set(app.TraceAxesList(ind_plt).Children(~shown_line_indices), 'LineStyle', 'none', 'Marker', 'none'); 
    
end
end