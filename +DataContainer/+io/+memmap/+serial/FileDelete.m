function FileDelete(dirname)
%FILEWRITE  Write serial data to binary file
%
%   DataWrite(DIRNAME) writes
%
error(nargchk(1, 1, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')

% Make Directory
if isdir(dirname)
    rmdir(dirname,'s')
else
    warning('SeisDataContainer:memmap:serial:FileDelete','directory %s does not exist',dirname);
end

end
