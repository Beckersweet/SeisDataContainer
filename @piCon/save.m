function save(obj,dirname,overwrite)
%PICON.SAVE Saves piCon to file
% piCon.save(DIRNAME, OVERWRITE) saves our piCon to DIRNAME
% Optional argument:
% overwrite is 1 for overwrite and 0 otherwise

if(nargin == 2)
    overwrite = 0;
end
if(overwrite == 1)
    rmdir(dirname, 's');
else
    assert(~isdir(dirname),'Fatal error: directory %s already exists',dirname);
end
header      = obj.header;
header.size = cell2mat(header.size);
status = mkdir(dirname);
assert(status,'Fatal error while creating directory %s',dirname);
SeisDataContainer.io.memmap.serial.FileWrite(dirname,gather(double(obj)));
SeisDataContainer.io.memmap.serial.HeaderWrite(dirname,header);
end

