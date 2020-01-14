function s = vec2str(v,fmt,brckt,delim)
if ~exist('fmt', 'var'), fmt = '%.1f'; end
if ~exist('brckt', 'var'), brckt = {'[',']'}; end
if length(brckt) ~= 2 || isempty(brckt),  brckt = {'',''}; end 
if ~exist('delim', 'var'), delim = ', '; end

s = sprintf([fmt, delim], v); 
s = [brckt{1}, s(1:end-length(delim)), brckt{2}]; 
end