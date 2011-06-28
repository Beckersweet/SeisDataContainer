function FileDelete(dirname)
%FILEDELETE  Delete file from specified directory
%
%   FileDelete(DIRNAME) removes the specified directory
%
%   Warning: The specified directory must exist.
error(nargchk(1, 1, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')

% Make Directory
if isdir(dirname)
    rmdir(dirname,'s')
else
    warning('SeisDataContainer:memmap:serial:FileDelete','directory %s does not exist',dirname);
end

end
