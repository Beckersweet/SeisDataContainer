function newHeader = permuteHeaderStruct( header,perm )
%PERMUTEHEADERSTRUCT Permutation for data container header
%   

temp1 = header.label;
temp2 = header.unit;
temp3 = header.delta;
temp4 = header.origin;

for i=1:length(perm)
    header.label(i)  = temp1(perm(i));
    header.unit(i)   = temp2(perm(i));
    header.delta(i)  = temp3(perm(i));
    header.origin(i) = temp4(perm(i));
end

newHeader = header;
end
