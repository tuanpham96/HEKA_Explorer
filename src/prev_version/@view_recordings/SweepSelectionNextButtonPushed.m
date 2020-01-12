function SweepSelectionNextButtonPushed(app)
selected_sweep_index = app.current_settings.sweeps.selected; 
if selected_sweep_index >= app.current_settings.sweeps.max
    return; 
end

selected_sweep_index =  selected_sweep_index + 1;
app.SweepSelectionInput.String = sprintf('%d', selected_sweep_index);
app.current_settings.sweeps.selected = selected_sweep_index;

app.showOnlySelectedSweep;

end