function updateSelectedYLimChanged(app, var_id, new_ylim)
cur_ylim = app.current_variables.(var_id).ylim;

if isequal(new_ylim, cur_ylim), return; end

app.current_variables.(var_id).ylim = new_ylim;
ax_inds = app.current_variables.(var_id).axes_indices;

for ind_plt = ax_inds
    yyaxis_option = 'left';
    if mod(ind_plt,2) == 0
        yyaxis_option = 'right';
    end
    yyaxis(app.TraceAxesList(ind_plt), yyaxis_option);
    ylim(app.TraceAxesList(ind_plt), new_ylim);
end
end