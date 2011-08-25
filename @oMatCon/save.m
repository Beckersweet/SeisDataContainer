function save(obj,dirname)
    dirname = cell2mat(dirname);
    DataContainer.io.memmap.serial.FileCopy(obj.dirname,dirname); 
end

