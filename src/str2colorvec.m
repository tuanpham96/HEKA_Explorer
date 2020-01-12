function v = str2colorvec(s)
% source: https://stackoverflow.com/questions/4922383/how-can-i-convert-a-color-name-to-a-3-element-rgb-vector#comment6926428_4922705
v = bitget(find('krgybmcw'==s)-1,1:3); 
end