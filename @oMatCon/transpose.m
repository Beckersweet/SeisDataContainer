function y = transpose(x,sepDim)
%TRANSPOSE Transposes the datacontainer
%
%   Y = transpose(X)
%
%   X - The input dataContainer
%

% Assert x is 2D
assert(size(x.exsize,2) <= 2 , 'Can only transpose 2D array');

% Find seperation dimension (last index of first collapsed group)
sepDim = x.exsize(end,1);

% Do all the out of core magic
td = ConDir();
SDCpckg.io.NativeBin.serial.FileTranspose...
    (path(x.pathname),path(td),sepDim);
y  = oMatCon.load(td);

% In-core continuation of class properties
y.strict = x.strict;
y.perm   = fliplr(x.perm);
if isvector(x.exsize) % vec case
    y.header.size = [1 y.header.size];
    y.exsize = [ 1, x.exsize(1,1) + 1; 1, x.exsize(2,1) + 1 ];
else
    y.exsize = [x.exsize(:,2) - x.exsize(2,1),x.exsize(:,1) + y.exsize(2,1)];
end