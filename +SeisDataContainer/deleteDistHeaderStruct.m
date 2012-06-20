function header = deleteDistHeaderStruct(headerin)
    assert(isstruct(headerin),'headerin has to be a header struct');
    header = headerin;

    if isfield(header,'distribution')
        header.distribution = struct();
        header = rmfield(header,'distribution');
    end

    if isfield(header,'directories')
        header.directories = struct();
        header = rmfield(header,'directories');
    end
    header.distributedIO = 0;
end
