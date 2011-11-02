function y = load(dirname)
%ICON.LOAD Loads the file as an iCon
    y        = DataContainer.io.memmap.serial.FileRead(dirname);
    y        = iCon(y);
    y.header = DataContainer.io.memmap.serial.HeaderRead(dirname);
end

