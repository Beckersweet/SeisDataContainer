function res = min( arg1,arg2 )
%MIN Summary of this function goes here
%   Detailed explanation goes here

if isa(arg1,'SeisDataContainer')
    header = arg1.header;
    ex_out = arg1.exsize;
elseif isa(arg2,'SeisDataContainer')
    header = arg2.header;
    ex_out = arg2.exsize;
end


res = iCon(min(double(arg1),double(arg2)));
res.header = header;
res.exsize = ex_out;

end

