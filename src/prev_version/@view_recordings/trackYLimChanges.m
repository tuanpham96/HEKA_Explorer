function trackYLimChanges(app)
if isempty(app.TraceAxesList), return; end 

changed_ax = gca; 
new_ylim = ylim(changed_ax); 
gca_var_id = changed_ax.Tag;
varmanip_var_id = sprintf('var%d', app.VariableManipulation_OriginalNameMenu.Value);

if strcmp(gca_var_id, varmanip_var_id) 
    app.VariableManipulation_YLimInput.String = app.ylim_displaytext(new_ylim);
end
app.updateSelectedYLimChanged(gca_var_id, new_ylim); 

end 