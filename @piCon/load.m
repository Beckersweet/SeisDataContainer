function y = load(dirname)
%PICON.LOAD Loads the file as an piCon
    y        = SeisDataContainer.io.NativeBin.serial.FileRead(dirname);
    y        = distributed(y);
    y        = piCon(y);
    header   = SeisDataContainer.io.NativeBin.serial.HeaderRead(dirname);
    if(~iscell(header.size))
        header.size = num2cell(header.size);
    end
    y.header = header;    
end