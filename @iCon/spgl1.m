function [x,r,g,info] = spgl1( A, b, tau, sigma, x, options )
%SPGL1 spgl1 unwrapper and rewrapper for iCon
%   Detailed explanation goes here

if isa(A,'iCon')
    [x,r,g,info] = spgl1( double(A), b, tau, sigma, x, options )
elseif isa(b, 'iCon')
    [x,r,g,info] = spgl1( A, double(b), tau, sigma, x, options )
elseif isa(A, 'iCon') && isa(b, 'iCon')
    [x,r,g,info] = spgl1( double(A), double(b), tau, sigma, x, options )
end