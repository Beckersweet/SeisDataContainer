function y = load(dirname)
%ICON.LOAD Loads the file as an iCon
    y        = SDCpckg.io.NativeBin.serial.FileRead(dirname);
    y        = iCon(y);
    header   = SDCpckg.io.NativeBin.serial.HeaderRead(dirname);
    if(~iscell(header.size(1:end)))
        header.size = num2cell(header.size);
    end
    y.header = header;
end

