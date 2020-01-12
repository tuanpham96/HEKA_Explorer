function XAxisXLimInputChanged(app)
new_xlim = app.convert_axislim_string2double(app.XAxisXLimInput);
app.current_settings.xlim = new_xlim; 
xlim(app.TraceAxesList(1), new_xlim); 
end
