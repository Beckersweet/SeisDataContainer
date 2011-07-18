function header = deleteDistFileHeaderStruct(headerin)
    assert(isstruct(headerin),'headerin has to be a header struct');
    header = headerin;
    if isfield(header,'directories')
        header.directories = struct();
        header = rmfield(header,'directories');
    end
    header.distributed = 0;
end
