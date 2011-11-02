function save(obj,dirname)
%SAVE Saves iCon to file

    DataContainer.io.memmap.serial.FileWrite(dirname,double(obj));
    DataContainer.io.memmap.serial.HeaderWrite(dirname,obj.header);
end

