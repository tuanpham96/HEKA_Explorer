function d = convert_axislim_string2double(obj)
d = obj.String; 
if strcmpi(d, 'auto'), return; end
d = str2num(d); %#ok
if isnan(d)
    warndlg('Something wrong with your limit input, will change to ''auto'' instead!');
    d = 'auto'; 
    obj.String = d; 
end 

end