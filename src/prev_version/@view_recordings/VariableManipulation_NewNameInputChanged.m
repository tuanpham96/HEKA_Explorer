function VariableManipulation_NewNameInputChanged(app)
new_name = app.VariableManipulation_NewNameInput.String; 
current_varind = app.VariableManipulation_OriginalNameMenu.Value; 

var_id = sprintf('var%d', current_varind); 
app.current_variables.(var_id).new_name = new_name; 
original_name = app.current_variables.(var_id).original_name;

if strcmp(original_name, new_name)  
    return; 
end

var_unit = app.current_variables.(var_id).unit;
var_axinds = app.current_variables.(var_id).axes_indices;
arrayfun(@(ax) ylabel(ax, sprintf('%s (%s) [%s]', ...
    new_name, var_unit, original_name), 'Interpreter', 'none'), app.TraceAxesList(var_axinds));

end