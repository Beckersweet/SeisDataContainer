function y = load(dirname)
%ICON.LOAD Loads the file as an iCon
    y        = iCon(...
        SeisDataContainer.io.NativeBin.serial.FileRead(dirname));
    y.header = ...
        SeisDataContainer.io.NativeBin.serial.HeaderRead(dirname);
end

