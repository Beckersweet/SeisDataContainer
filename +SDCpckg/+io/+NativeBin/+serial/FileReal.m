function FileReal(dirnameIn,dirnameOut)
%FILEREAL Real part.
%   FileReal(DIRNAMEIN,DIRNAMEOUT)
%
%   DIRNAMEIN  - A string specifying the input directory
%   DIRNAMEOUT - A string specifying the output directory name

SDCpckg.io.isFileClean(dirnameIn);
SDCpckg.io.isFileClean(dirnameOut);
headerOut = SDCpckg.io.NativeBin.serial.HeaderRead(dirnameIn);
if(headerOut.complex)
    headerOut.complex = 0;
end
SDCpckg.io.NativeBin.serial.HeaderWrite(dirnameOut,headerOut);
copyfile(fullfile(dirnameIn,'real'),dirnameOut);
end
