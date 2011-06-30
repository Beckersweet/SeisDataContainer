function header = addDistFileHeaderStruct(dirname,headerin)
    assert(ischar(dirname), 'directory name must be a string')
    assert(isstruct(headerin),'headerin has to be a header struct');

    header = headerin;
    header.distributed = 1;
    header.directories = DataContainer.io.makeDistDir(dirname);

end
