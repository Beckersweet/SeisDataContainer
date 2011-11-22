function y = load(dirname)
%PICON.LOAD Loads the file as an piCon
    y        = DataContainer.io.memmap.serial.FileRead(dirname);
    y        = distributed(y);
    y        = piCon(y);
    header   = DataContainer.io.memmap.serial.HeaderRead(dirname);
    if(~iscell(header.size))
        header.size = {header.size};
    end
    y.header = header;    
end