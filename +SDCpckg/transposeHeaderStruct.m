function newHeader = transposeHeaderStruct( header, sepdim )
%PERMUTEHEADERSTRUCT Permutation for data container header
%   

newHeader = SDCpckg.deleteDistHeaderStruct(header);
newHeader.size   = circshift(newHeader.size,[1 -sepdim]);
newHeader.origin = circshift(newHeader.origin,[1 -sepdim]);
newHeader.delta  = circshift(newHeader.delta,[1 -sepdim]);
newHeader.unit   = circshift(newHeader.unit,[1 -sepdim]);
newHeader.label  = circshift(newHeader.label,[1 -sepdim]);

end
