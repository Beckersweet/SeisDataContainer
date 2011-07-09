function header = addDistFileHeaderStruct(headerin,dirname)
    assert(isstruct(headerin),'headerin has to be a header struct');
    assert(ischar(dirname), 'directory name must be a string')

    header = headerin;
    header.distributed = 1;
    header.directories = DataContainer.io.makeDistDir(dirname);

end
