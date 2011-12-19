function save(obj,dirname,overwrite)
%SAVE Saves the data container
%
%   save(dirname)
%
%   DIRNAME - The output directory name
%
%   Optional argument:
%   OVERWRITE - is 1 for overwrite and 0 otherwise
%
if(nargin == 2)
    overwrite = 0;
end
if(overwrite == 1)
    rmdir(dirname, 's');
else
    assert(~isdir(dirname),'Fatal error: directory %s already exists',dirname);
end
status = mkdir(dirname);
assert(status,'Fatal error while creating directory %s',dirname);
DataContainer.io.memmap.serial.FileCopy...
    (path(obj.pathname),dirname); 
end
