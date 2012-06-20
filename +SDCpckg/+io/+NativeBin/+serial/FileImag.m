function FileImag(dirnameIn,dirnameOut)
%FILEIMAG Complex imaginary part.
%   FileImag(DIRNAMEIN,DIRNAMEOUT)
%
%   DIRNAMEIN  - A string specifying the input directory
%   DIRNAMEOUT - A string specifying the output directory name

SDCpckg.io.isFileClean(dirnameOut);
SDCpckg.io.isFileClean(dirnameIn);
headerOut = SDCpckg.io.NativeBin.serial.HeaderRead(dirnameIn);
if(~headerOut.complex)
    error('Epic fail: The dataContainer is not complex')
end
headerOut.complex = 0;
SDCpckg.io.NativeBin.serial.HeaderWrite(dirnameOut,headerOut);
copyfile(fullfile(dirnameIn,'imag'),fullfile(dirnameOut,'real'));
end
