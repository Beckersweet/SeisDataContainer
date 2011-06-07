function result = isempty(x)
%ISEMPTY  Returns true if underlying data is an empty array

if any(size(x) == 0)
   result = true;
else
   result = false;
end