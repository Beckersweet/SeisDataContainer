function y = transpose(x,sepDim)
%TRANSPOSE Transposes the datacontainer
%
%   transpose(x,sepDim)
%
%   X      - The input dataContainer
%   SEPDIM - Separation dimension for transpose
%
if(nargin == 1)
    sepDim = 1;
end
td = ConDir();
DataContainer.io.memmap.serial.FileTranspose...
    (path(x.pathname),path(td),sepDim);
y  = oMatCon.load(td);
end
