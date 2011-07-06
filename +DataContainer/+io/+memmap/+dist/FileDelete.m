function FileDelete(dirname)
%FILEDELETE  remove the specified directory
%
%   FILEDELETE(DIRNAME)
%
error(nargchk(1, 1, nargin, 'struct'));
assert(matlabpool('size')>0,'matlabpool must be open')
assert(ischar(dirname), 'directory name must be a string')

% Read header
header = DataContainer.io.memmap.serial.HeaderRead(dirname);
tmpdirs = DataContainer.utils.Cell2Composite(header.directories);
% Delete Directory
spmd
    if isdir(tmpdirs)
        rmdir(tmpdirs,'s');
    else
        warning('SeisDataContainer:memmap:serial:FileDelete','directory %s does not exist',tmpdirs);
    end
end
if isdir(dirname)
    rmdir(dirname,'s');
else
    warning('SeisDataContainer:memmap:serial:FileDelete','directory %s does not exist',dirname);
end

end
