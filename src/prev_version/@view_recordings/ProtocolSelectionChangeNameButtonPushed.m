function ProtocolSelectionChangeNameButtonPushed(app)
selected_protocol_value = app.ProtocolSelectionMenu.Value; 
app.current_settings.protocol.value = selected_protocol_value; 
app.current_settings.protocol.name = app.current_settings.available_protocols{selected_protocol_value}; 

new_protocol_name = inputdlg(sprintf('Change "%s" to:', app.current_settings.protocol.name), ...
    'Change protocol name', [1.5, 35]); 

if isempty(new_protocol_name), return; end
new_protocol_name = new_protocol_name{1}; 
app.current_settings.available_protocols{selected_protocol_value} = new_protocol_name; 
app.current_settings.protocol.name = new_protocol_name; 
app.ProtocolSelectionMenu.String{selected_protocol_value} = ...
    sprintf('%02d: %s', selected_protocol_value, new_protocol_name); 
end 