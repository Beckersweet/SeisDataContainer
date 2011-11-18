function save(obj,dirname)
%PICON.SAVE Saves piCon to file
    header      = obj.header;
    header.size = cell2mat(header.size);
    DataContainer.io.memmap.serial.FileWrite(dirname,gather(double(obj)));
    DataContainer.io.memmap.serial.HeaderWrite(dirname,header);
end

