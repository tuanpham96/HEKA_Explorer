function VariableManipulation_YLimInputChanged(app)

new_ylim = app.convert_axislim_string2double(app.VariableManipulation_YLimInput);
selected_ind = app.VariableManipulation_OriginalNameMenu.Value;
var_id = sprintf('var%d', selected_ind);

app.updateSelectedYLimChanged(var_id, new_ylim); 

end