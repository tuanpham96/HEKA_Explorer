function SweepSelectionShowAllTickBoxTicked(app, init)

if app.SweepSelectionShowAllTickBox.Value == 1 
    sweep_selection_choice = 'off'; 
    if isfield(app.current_data, 'num_sweeps') 
        app.current_settings.sweeps.selected = 1:app.current_settings.sweeps.max;
        app.SweepSelectionInput.String = sprintf('1:%d', app.current_settings.sweeps.max);
    end
else     
    sweep_selection_choice = 'on'; 
    app.SweepSelectionInput.String = '1'; 
    app.current_settings.sweeps.selected = 1; 
end

app.SweepSelectionInput.Enable = sweep_selection_choice;
app.SweepSelectionNextButton.Enable = sweep_selection_choice;
app.SweepSelectionPreviousButton.Enable = sweep_selection_choice; 

if init == 0
    app.showOnlySelectedSweep;
end
end