function y = load(dirname)
%PICON.LOAD Loads the file as an piCon
    y        = DataContainer.io.memmap.serial.FileRead(dirname);
    y        = distributed(y);
    y        = piCon(y);
    y.header = DataContainer.io.memmap.serial.HeaderRead(dirname);
end