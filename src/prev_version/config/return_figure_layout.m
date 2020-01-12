function [layout_map, dimensions] = return_figure_layout(file_name, additional_fieldpatterns)

layout_params = {'x', 'y', 'width', 'height'};
if ~exist('additional_fieldpatterns', 'var')
    additional_fieldpatterns = {}; 
    find_additional_patterns = {}; 
end 
if ~iscell(additional_fieldpatterns)
    additional_fieldpatterns = {additional_fieldpatterns}; 
    find_additional_patterns = cellfun(@(x) x.find_pattern, additional_fieldpatterns, 'uni', 0);
end 

svg_file = xml2struct(file_name);
svg_file = svg_file.svg; 

width_str = svg_file.Attributes.width;
height_str = svg_file.Attributes.height;
dim_unit = width_str(regexpi(width_str, '[a-z]'));
page_width = str2double(regexprep(width_str, '[a-zA-Z]', ''));
page_height = str2double(regexprep(height_str, '[a-zA-Z]', ''));

view_box = str2num(svg_file.Attributes.viewBox); %#ok<ST2NM> 
view_width = view_box(3); 
view_height = view_box(4); 

normz_fun = struct(...
    'x', @(x) x/view_width, ...
    'y', @(x) 1-(x/view_height), ...
    'width', @(x) x/view_width, ...
    'height', @(x) x/view_height);

graphic_obj = svg_file.g;
if length(graphic_obj) == 1, graphic_obj = {graphic_obj}; end
graphic_obj = graphic_obj(cellfun(@(x) isfield(x.Attributes, 'label'), graphic_obj, 'uni', 1)); 
if isempty(graphic_obj), error('Need at least one graphic object having "label" in its attributes'); end 
layout_objs = graphic_obj(cellfun(@(x) strcmpi(x.Attributes.label, 'layout'), graphic_obj, 'uni', 1)); 
if length(layout_objs) ~= 1, error('Need one and only one layout layer, marked by having "label"="layout" in attributes'); end 
layout_objs = layout_objs{1}; 

if any(isfield(layout_objs.Attributes, {'rotate', 'scale', 'transform'}))
    error('The file cannot include rotation, scaling or transformation in the layout layer'); 
end

layout_objs = cellfun(@(x) keep_subsetfield(x.Attributes, ...
    horzcat(layout_params, {'label'}), find_additional_patterns), layout_objs.rect, 'uni', 0); 
layout_objs = cellfun(@(x) structfun(@str2doubleifpossible, x, 'uni', 0), layout_objs, 'uni', 0); 

layout_map = struct; 
layout_params = layout_params'; 

if length(unique(cellfun(@(x) x.label, layout_objs, 'uni', 0))) ~= length(layout_objs)
    error('There were duplicate labels. Please check it again'); 
end
for ind_obj = 1:length(layout_objs)
    ly_struct = layout_objs{ind_obj};
    lbl = ly_struct.label;
    tmp_struct = cell2struct(cellfun(@(n) normz_fun.(n)(ly_struct.(n)), layout_params, 'uni', 0), layout_params); 
    tmp_struct.y = tmp_struct.y - tmp_struct.height;    
    
    ly_struct = rmfield(ly_struct, [layout_params; {'label'}]); 
    ly_struct.position = [tmp_struct.x, tmp_struct.y, tmp_struct.width, tmp_struct.height];
    
    if ~isempty(additional_fieldpatterns)
        ly_fields = fieldnames(ly_struct);
        ly_values = struct2cell(ly_struct);
        for ind_addfield = 1:length(additional_fieldpatterns)
            addfieldstruct = additional_fieldpatterns{ind_addfield};
            ly_fields = regexprep(ly_fields, addfieldstruct.replace_pattern, addfieldstruct.replace_with);
        end
        ly_struct = cell2struct(ly_values, ly_fields);
    end
    
    layout_map.(lbl) = ly_struct;
end
dimensions = struct('width', page_width, 'height', page_height, 'unit', dim_unit);
end

function og_struct = keep_subsetfield(og_struct, sub_fields, find_additional_patterns) 
field_names = fieldnames(og_struct);
cell_struct = struct2cell(og_struct);
keep_inds = cellfun(@(x) any(strcmp(sub_fields, x)), field_names, 'uni', 1);  
if ~isempty(find_additional_patterns) 
    add_inds = cellfun(@(x) ...
        cellfun(@(y) ~isempty(y), regexp(field_names, x), 'uni', 1), ...
        find_additional_patterns, 'uni', 0); 
    keep_inds = keep_inds + sum(horzcat(add_inds{:}), 2) > 0; 
end
og_struct = cell2struct(cell_struct(keep_inds), field_names(keep_inds));
end

function d = str2doubleifpossible(s)
d = str2double(s); 
if isnan(d), d = s; end 
end
