function y = load(dirname)
%ICON.LOAD Loads the file as an iCon
    y        = DataContainer.io.memmap.serial.FileRead(dirname);
    y        = iCon(y);
    header   = DataContainer.io.memmap.serial.HeaderRead(dirname);
    if(~iscell(header.size))
        header.size = mat2cell(header.size);
    end
    y.header = header;
end

