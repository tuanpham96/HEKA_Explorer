function VariableManipulation_OriginalNameMenuChanged(app)

selected_ind = app.VariableManipulation_OriginalNameMenu.Value; 
var_props = app.current_variables.(sprintf('var%d', selected_ind)); 
app.VariableManipulation_NewNameInput.String = var_props.new_name; 
app.VariableManipulation_ColorButton.ForegroundColor = var_props.color; 
app.VariableManipulation_SaveTickBox.String = ''; 
app.VariableManipulation_SaveTickBox.Value = var_props.save; 
app.VariableManipulation_YLimInput.String = app.ylim_displaytext(var_props.ylim); 

end

