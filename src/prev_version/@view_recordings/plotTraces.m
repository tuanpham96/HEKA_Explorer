function plotTraces(app)
max_sweeps = app.current_settings.sweeps.max; 
num_plots = app.NumberOfVariableMenu.Value; 
selected_plotvars = [app.VariableSelection_MenuList(1:num_plots).Value]; 

delete(app.TraceAxesList);

ax_bounds = app.TraceAxesBoundary; 
ax_height = ax_bounds(4)/num_plots; 
ax_bottoms = ax_bounds(2) + (num_plots-1:-1:0)*ax_height; 

app.TraceAxesList = arrayfun(@(b) axes(app.MainFigure, 'Position', ...
    [ax_bounds(1),b,ax_bounds(3),ax_height]),ax_bottoms); 

dt_ms = app.current_data.dt_ms; 

var_ids = fieldnames(app.current_variables); 
for ind_vars = 1:length(var_ids)
    app.current_variables.(var_ids{ind_vars}).axes_indices = []; 
end 

for ind_plt = 1:num_plots     
    var_id = sprintf('var%d', selected_plotvars(ind_plt));
    var_props = app.current_variables.(var_id); 
    var_color = var_props.color; 
    var_newname = var_props.new_name; 
    var_ylim = var_props.ylim; 
    
    app.TraceAxesList(ind_plt).Tag = var_id;
    
    hold(app.TraceAxesList(ind_plt), 'on'); 
    if mod(ind_plt,2) == 1        
        yyaxis(app.TraceAxesList(ind_plt), 'left');
        app.TraceAxesList(ind_plt).YAxis(1).Color = var_color;
        app.TraceAxesList(ind_plt).YAxis(2).Color = 'none'; 
    else
        yyaxis(app.TraceAxesList(ind_plt), 'right');
        app.TraceAxesList(ind_plt).YAxis(1).Color = 'none'; 
        app.TraceAxesList(ind_plt).YAxis(2).Color = var_color; 
    end
    
    main_data_struct = app.current_data.(var_props.identity); 
    trace_data = main_data_struct.data{var_props.index}; 
    trace_name = main_data_struct.names{var_props.index}; 
    trace_unit = main_data_struct.units{var_props.index}; 
    
    t_vec = (0:(size(trace_data,1)-1)) * dt_ms;

    if size(trace_data, 2) ~= max_sweeps
        line_tag = 'show_all'; 
        arrayfun(@(x) plot(app.TraceAxesList(ind_plt), t_vec, trace_data(:,x), ...
            'LineStyle', '-', ...
            'Marker', 'none', ...
            'Color', var_color, ...
            'Tag', line_tag), 1:size(trace_data, 2));
    else        
        arrayfun(@(x) plot(app.TraceAxesList(ind_plt), t_vec, trace_data(:,x), ...
            'LineStyle', '-', ...
            'Marker', 'none', ...
            'Color', var_color, ...
            'Tag', num2str(x)), 1:size(trace_data, 2));
    end 
    
    if ind_plt == num_plots
        xlabel(app.TraceAxesList(ind_plt), 'time (ms)');
    else 
        set(app.TraceAxesList(ind_plt), 'xcolor', 'none'); 
    end
    
    if strcmp(var_newname, trace_name) 
        ylabel(app.TraceAxesList(ind_plt), sprintf('%s (%s)', trace_name, trace_unit));
    else
        ylabel(app.TraceAxesList(ind_plt), sprintf('%s (%s)\\newline%s', var_newname, trace_unit, trace_name));
    end
    
    ylim(app.TraceAxesList(ind_plt),var_ylim);        
    
    cur_ax_inds = var_props.axes_indices; 
    app.current_variables.(var_id).axes_indices = unique([cur_ax_inds, ind_plt]); 

end 

xlim(app.TraceAxesList(ind_plt), app.current_settings.xlim); 

app.XAxisLinkButtonPushed; 
app.XAxisShowAllButtonPushed; 
end 