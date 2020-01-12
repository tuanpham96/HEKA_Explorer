function XAxisLinkButtonPushed(app) 

if isempty(app.TraceAxesList), return; end

if app.XAxisLinkButton.Value == 1
    linkaxes(app.TraceAxesList, 'x');
    app.XAxisXLimInput.Enable = 'on'; 
    app.XAxisXLimInput.String = 'auto'; 
else 
    linkaxes(app.TraceAxesList, 'off');    
    app.XAxisXLimInput.Enable = 'off';     
    app.XAxisXLimInput.String = 'you''re on your own'; 
end

end