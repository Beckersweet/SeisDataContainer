function save(obj,dirname)
%PICON.SAVE Saves piCon to file

    DataContainer.io.memmap.serial.FileWrite(dirname,gather(double(obj)));
    DataContainer.io.memmap.serial.HeaderWrite(dirname,obj.header);
end

