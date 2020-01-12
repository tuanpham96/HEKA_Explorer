function SweepSelectionInputChanged(app)
og_inputs = str2num(app.SweepSelectionInput.String); %#ok 
input_vals = unique(og_inputs); 

if isempty(input_vals)
    warndlg('The inputs for sweep indices cannot be resolved numerically. Please enter a MATLAB vector or scalar!'); 
    return; 
end

max_nsweeps = app.current_settings.sweeps.max; 
if max(input_vals) > max_nsweeps || min(input_vals) < 1
    warndlg(sprintf('The input sweep indices need to be from 1-%d, will rid of anything outside of this range', max_nsweeps)); 
    input_vals(input_vals < 1 | input_vals > max_nsweeps) = [];     
end

if length(input_vals) < length(og_inputs)
    input_restring = sprintf('%d,', input_vals); 
    app.SweepSelectionInput.String = input_restring(1:end-1); 
end
sweep_buttons_show = 'on'; 
if length(input_vals) > 1, sweep_buttons_show = 'off'; end 
app.SweepSelectionNextButton.Enable = sweep_buttons_show;
app.SweepSelectionPreviousButton.Enable = sweep_buttons_show;

app.current_settings.sweeps.selected = input_vals; 

app.showOnlySelectedSweep;

end
