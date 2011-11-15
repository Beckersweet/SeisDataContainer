function y = transpose(x,sepDim)
%TRANSPOSE Transposes the datacontainer
%
%   transpose(dirnameOut,sepDim)
%
%   DIRNAMEOUT - The output directory
%   SEPDIM     - Separation dimension for transpose
    if(nargin == 1)
        sepDim = 1;
    end
    td = ConDir();
    DataContainer.io.memmap.serial.FileTranspose...
        (path(x.pathname),path(td),sepDim);
    y  = oMatCon.load(td);
end