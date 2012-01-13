function header = addDistFileHeaderStruct(headerin,dirsout)
    error(nargchk(2, 2, nargin, 'struct'));
    assert(isstruct(headerin),'headerin has to be a header struct');
    assert(iscell(dirsout), 'distributed output directories names must form cell')

    header = headerin;
    header.distributedIO = 1;
    header.directories = dirsout;

end
