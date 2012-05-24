function y = load(dirname)
%PICON.LOAD Loads the file as an piCon
    y        = SeisDataContainer.io.NativeBin.serial.FileRead(dirname);
    y        = distributed(y);
    y        = piCon(y);
    header   = SeisDataContainer.io.NativeBin.serial.HeaderRead(dirname);
    y.header = header;    
end