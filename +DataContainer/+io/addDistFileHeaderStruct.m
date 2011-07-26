function header = addDistFileHeaderStruct(headerin,varargin)
    error(nargchk(1, 2, nargin, 'struct'));
    assert(isstruct(headerin),'headerin has to be a header struct');

    header = headerin;
    header.distributed = 1;
    if nargin>1
        assert(ischar(varargin{1}), 'directory name must be a string')
        header.directories = DataContainer.io.makeDistDir(varargin{1});
    else
        header.directories = DataContainer.io.makeDistDir();
    end

end
