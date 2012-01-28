function FileReal(dirnameIn,dirnameOut)
%FILEREAL Real part.
%   FileReal(DIRNAMEIN,DIRNAMEOUT)
%
%   DIRNAMEIN  - A string specifying the input directory
%   DIRNAMEOUT - A string specifying the output directory name

SeisDataContainer.io.isFileClean(dirnameIn);
SeisDataContainer.io.isFileClean(dirnameOut);
headerOut = SeisDataContainer.io.NativeBin.serial.HeaderRead(dirnameIn);
if(headerOut.complex)
    headerOut.complex = 0;
end
SeisDataContainer.io.NativeBin.serial.HeaderWrite(dirnameOut,headerOut);
copyfile(fullfile(dirnameIn,'real'),dirnameOut);
end
