function y = transpose(x,sepDim)
%TRANSPOSE Transposes the datacontainer
%
%   Y = transpose(X)
%
%   X - The input dataContainer
%

import SeisDataContainer.io.NativeBin.serial.*

% Assert x is 2D
assert(size(x.exsize,2) == 2, 'Can only transpose 2D array');

% Find seperation dimension (last index of first collapsed group)
sepDim = x.exsize(end,1);

% Do all the out of core magic
td = ConDir();
SDCpckg.io.NativeBin.serial.FileTranspose...
    (path(x.pathname),path(td),sepDim);
y  = oMatCon.load(td);

% In-core continuation of class properties
y.strict      = x.strict;
y.perm        = fliplr(x.perm);
y.exsize      = fliplr(x.exsize);
indshift      = y.exsize(1);
y.exsize(:,1) = y.exsize(:,1) - indshift + 1;
y.exsize(:,2) = y.exsize(:,2) + y.exsize(end,1);
