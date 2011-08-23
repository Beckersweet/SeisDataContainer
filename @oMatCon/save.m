function save(obj,dirname)
    dirname = cell2mat(dirname);
    assert(ischar(dirname), 'directory name must be a string')
    DataContainer.io.memmap.serial.FileCopy(obj.dirname,dirname); 
end

