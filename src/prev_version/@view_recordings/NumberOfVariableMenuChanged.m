function NumberOfVariableMenuChanged(app) 
turn_ons = 1:app.NumberOfVariableMenu.Value; 
turn_off = (turn_ons(end)+1):app.max_numplots; 

arrayfun(@(x) set(x, 'Enable', 'on'), app.VariableSelection_MenuList(turn_ons));
arrayfun(@(x) set(x, 'Enable', 'off'), app.VariableSelection_MenuList(turn_off));
end