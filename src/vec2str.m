function s = vec2str(v,fmt)
if nargin == 1, fmt = '%.1f'; end 
delim = ', '; 
s = sprintf([fmt, delim], v); 
s = ['[', s(1:end-length(delim)), ']']; 
end