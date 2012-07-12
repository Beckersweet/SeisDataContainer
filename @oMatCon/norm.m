function x = norm(varargin)
%NORM Calculates the norm of the datacontainer
%
%   norm(NORM)
%
%   NORM - Specifies the norm type. Supported norms: inf, -inf,
%                    'fro', p-norm where p is scalar.
%

% Process and extract arguments
ip = inputParser; 
ip.addRequired('obj'); 
ip.addOptional('norm',2,@(x)ischar(x)||isscalar(x));
ip.parse(varargin{:});
x = ip.Results.obj;
p = ip.Results.norm;

% Get norm
x = SDCpckg.io.NativeBin.serial.FileNorm...
    (path(x.pathname),p);
end
