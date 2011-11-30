function newHeader = permuteHeaderStruct( header,perm )
%PERMUTEHEADERSTRUCT Permutation for data container header
%   

header.delta  = permute(header.delta,perm);
header.origin = permute(header.origin,perm);

temp1 = header.label;
temp2 = header.unit;
for i=1:length(perm)
    header.label(i) = temp1(perm(i));
    header.unit(i)  = temp2(perm(i));
end

newHeader = header;
end
