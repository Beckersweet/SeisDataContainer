function FileReal(dirnameIn,dirnameOut)
%FILEREAL Real part.
%   FileReal(DIRNAMEIN,DIRNAMEOUT)
%
%   DIRNAMEIN  - A string specifying the input directory
%   DIRNAMEOUT - A string specifying the output directory name

DataContainer.io.isFileClean(dirnameIn);
DataContainer.io.isFileClean(dirnameOut);
headerOut = DataContainer.io.memmap.serial.HeaderRead(dirnameIn);
if(headerOut.complex)
    headerOut.complex = 0;
end
DataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);
copyfile(fullfile(dirnameIn,'real'),dirnameOut);
end
