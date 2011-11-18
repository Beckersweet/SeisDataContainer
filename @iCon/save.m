function save(obj,dirname)
%SAVE Saves iCon to file

    header      = obj.header;
    header.size = cell2mat(header.size);
    DataContainer.io.memmap.serial.FileWrite(dirname,double(obj));
    DataContainer.io.memmap.serial.HeaderWrite(dirname,header);
end

