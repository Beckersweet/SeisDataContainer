function FileImag(dirnameIn,dirnameOut)
%FILEIMAG Complex imaginary part.
%   FileImag(DIRNAMEIN,DIRNAMEOUT)
%
%   DIRNAMEIN  - A string specifying the input directory
%   DIRNAMEOUT - A string specifying the output directory name

SeisDataContainer.io.isFileClean(dirnameOut);
SeisDataContainer.io.isFileClean(dirnameIn);
headerOut = SeisDataContainer.io.memmap.serial.HeaderRead(dirnameIn);
if(~headerOut.complex)
    error('Epic fail: The dataContainer is not complex')
end
headerOut.complex = 0;
SeisDataContainer.io.memmap.serial.HeaderWrite(dirnameOut,headerOut);
copyfile(fullfile(dirnameIn,'imag'),fullfile(dirnameOut,'real'));
end
