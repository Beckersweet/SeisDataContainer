function y = distributed(x)
%DISTRIBUTED    Distribute data container
%
%   distributed(x) distributes the underlying data in serial data container
%   x(iCon) and returns a parallel data container piCon
%
%   See also: piCon, piCon.gather

y = piCon.distributed(x);