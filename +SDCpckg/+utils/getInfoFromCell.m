function fieldData = getInfoFromCell( theCell, fieldName )
%GETCONTAINERRECOVERYINFO is for parsing information from cell in the
%         format of {{'<field 1 name>',<field 1 data>}, {'<field 2 name>',<field 2 data>}}
%         If can't find the entry, give NaN.
%         Originally designed to work with ContainerStack class

fieldData = nan;

len = length(theCell);

for ind = 1:len
    if strcmp(fieldName,theCell{ind}{1})
        fieldData = theCell{ind}{2};
        break;
    end
    
end

end

