function varargout = spgl1( A, b, tau, sigma, x, options )
%SPGL1 spgl1 unwrapper and rewrapper for iCon
%   Detailed explanation goes here

if isa(A,'iCon')
    [varargout{1:nargout}] = spgl1( double(A), b, tau, sigma, x, options );
elseif isa(b, 'iCon')
    [varargout{1:nargout}] = spgl1( A, double(b), tau, sigma, x, options );
elseif isa(A, 'iCon') && isa(b, 'iCon')
    [varargout{1:nargout}] = spgl1( double(A), double(b), tau, sigma, x, options );
elseif isa(x, 'iCon')
    [varargout{1:nargout}] = spgl1( A, b, tau, sigma, double(x), options );
else
    error('Something was seriously fishy here');
end