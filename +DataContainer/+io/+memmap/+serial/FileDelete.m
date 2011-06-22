function FileDelete(dirname)
%FILEWRITE  Write serial data to binary file
%
%   DataWrite(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
%   the real serial array X into file DIRNAME/FILENAME.
%   Addtional argument is either of:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%               defaults to type of x
%               Supported precisions: 'double', 'single'
%   HEADER_STRUCT - An optional header struct as created
%               by DataContainer.io.basicHeaderStructFromX
%               or DataContainer.io.basicHeaderStruct
%
%   Warning: If the specified dirname will be removed,
assert(ischar(dirname), 'directory name must be a string')

% Make Directory
if isdir(dirname)
    rmdir(dirname,'s')
else
    warning('SeisDataContainer:memmap:serial:FileDelete','directory %s does not exist',dirname);
end

end
