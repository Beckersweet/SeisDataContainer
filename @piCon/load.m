function y = load(dirname)
%PICON.LOAD Loads the file as an piCon

y        = SDCpckg.io.NativeBin.serial.FileRead(dirname);
y        = distributed(y);
y        = piCon(y);
header   = SDCpckg.io.NativeBin.serial.HeaderRead(dirname);
y.header = header;  