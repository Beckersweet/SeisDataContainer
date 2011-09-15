function transpose(obj,dirnameOut,sepDim)
%TRANSPOSE Transposes the datacontainer
%
%   transpose(dirnameOut,sepDim)
%
%   DIRNAMEOUT - The output directory
%   SEPDIM     - Separation dimension for transpose
    DataContainer.io.memmap.serial.FileTranspose...
        (obj.dirname,dirnameOut,sepDim);
end