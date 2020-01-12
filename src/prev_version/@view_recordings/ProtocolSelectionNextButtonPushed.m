function ProtocolSelectionNextButtonPushed(app) 

selected_protocol_value = app.ProtocolSelectionMenu.Value; 
if selected_protocol_value < length(app.current_settings.available_protocols) 
    app.ProtocolSelectionMenu.Value = selected_protocol_value + 1; 
    app.ProtocolSelectionMenuChanged; 
end

end