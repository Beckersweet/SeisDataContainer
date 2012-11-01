function y = load(dirname)
%ICON.LOAD Loads the file as an iCon

y        = SDCpckg.io.NativeBin.serial.FileRead(dirname);
y        = iCon(y);
header   = SDCpckg.io.NativeBin.serial.HeaderRead(dirname);
y.header = header;