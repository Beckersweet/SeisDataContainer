function varargout = spgl1( A, b, tau, sigma, x, options )
%SPGL1 spgl1 unwrapper and rewrapper for oMatCon
%   Detailed explanation goes here

if isa(A,'oMatCon')
    [varargout{1:nargout}] = spgl1( double(A), b, tau, sigma, x, options );
elseif isa(b, 'oMatCon')
    [varargout{1:nargout}] = spgl1( A, double(b), tau, sigma, x, options );
elseif isa(A, 'oMatCon') && isa(b, 'oMatCon')
    [varargout{1:nargout}] = spgl1( double(A), double(b), tau, sigma, x, options );
elseif isa(x, 'oMatCon')
    [varargout{1:nargout}] = spgl1( A, b, tau, sigma, double(x), options );
else
    error('Something was seriously fishy here');
end