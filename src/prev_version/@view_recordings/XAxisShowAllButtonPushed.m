function XAxisShowAllButtonPushed(app) 

if length(app.TraceAxesList) < 2, return; end

x_color = 'k'; 
if app.XAxisShowAllButton.Value == 0, x_color = 'none'; end

arrayfun(@(ax) set(ax, 'xcolor', x_color), app.TraceAxesList(1:end-1))
end 