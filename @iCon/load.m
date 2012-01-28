function y = load(dirname)
%ICON.LOAD Loads the file as an iCon
    y        = SeisDataContainer.io.memmap.serial.FileRead(dirname);
    y        = iCon(y);
    header   = SeisDataContainer.io.memmap.serial.HeaderRead(dirname);
    if(~iscell(header.size(1:end)))
        header.size = num2cell(header.size);
    end
    y.header = header;
end

