function s = ylim_displaytext(d)
if isnumeric(d) 
    s = sprintf('%.2f, ', d); 
    s(end-1:end) = ''; 
else 
    if ~strcmpi(d, 'auto')
        warndlg('The YLim input needs to either be ''auto'' or [min, max]. Will switch to ''auto'''); 
    end
    s = 'auto'; 
end
end