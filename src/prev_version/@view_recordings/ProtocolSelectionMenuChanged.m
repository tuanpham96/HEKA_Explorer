function ProtocolSelectionMenuChanged(app)

selected_protocol_value = app.ProtocolSelectionMenu.Value; 
app.current_settings.protocol.value = selected_protocol_value; 
app.current_settings.protocol.name = app.current_settings.available_protocols{selected_protocol_value}; 

getRecording(app, selected_protocol_value);
num_sweeps = app.current_data.num_sweeps; 
app.current_settings.sweeps.max = num_sweeps; 

app.SweepSelectionInput.String = sprintf('(max %d)', num_sweeps); 
app.SweepSelectionShowAllTickBox.Value = 1; 
app.SweepSelectionShowAllTickBoxTicked(1); 

var_names = struct2cell(structfun(@(x) x.original_name, app.current_variables, 'uni', 0));
app.NumberOfVariableMenu.Value = min(app.max_numplots, length(var_names)); 

selected_varinds = (1:app.max_numplots)'; 
selected_varinds(selected_varinds > length(var_names)) = 1;
arrayfun(@(x,v) set(x, 'String', var_names, 'Value', v), ...
    app.VariableSelection_MenuList, selected_varinds); 

app.NumberOfVariableMenuChanged; 

app.VariableManipulation_OriginalNameMenu.String = var_names; 
app.VariableManipulation_OriginalNameMenu.Value = 1; 
app.VariableManipulation_OriginalNameMenuChanged; 

app.XAxisLinkButton.Value = 1;
app.XAxisShowAllButton.Value = 0; 

app.plotTraces;
end