function VariableManipulation_ColorButtonChanged(app)
cur_color = app.VariableManipulation_ColorButton.ForegroundColor; 
new_color = uisetcolor(cur_color);
if isequal(cur_color, new_color) 
    return; 
end

selected_ind = app.VariableManipulation_OriginalNameMenu.Value; 
var_id = sprintf('var%d', selected_ind); 

app.VariableManipulation_ColorButton.ForegroundColor = new_color; 
app.current_variables.(var_id).color = new_color; 

ax_inds = app.current_variables.(var_id).axes_indices; 

for ind_plt = ax_inds
    yyaxis_option = 'left'; 
    yaxis_ind_for_color = 1; 
    if mod(ind_plt,2) == 0
        yyaxis_option = 'right'; 
        yaxis_ind_for_color = 2; 
    end    
    
    yyaxis(app.TraceAxesList(ind_plt), yyaxis_option);
    app.TraceAxesList(ind_plt).YAxis(yaxis_ind_for_color).Color = new_color;
    set(get(app.TraceAxesList(ind_plt), 'children'), 'color', new_color); 
end

end