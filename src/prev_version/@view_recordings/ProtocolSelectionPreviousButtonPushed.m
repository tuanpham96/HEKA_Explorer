function ProtocolSelectionPreviousButtonPushed(app)

selected_protocol_value = app.ProtocolSelectionMenu.Value; 
if selected_protocol_value > 1
    app.ProtocolSelectionMenu.Value = selected_protocol_value - 1; 
    app.ProtocolSelectionMenuChanged; 
end

end