function varargout = lsqr( A,B,varargin )
%LSQR Summary of this function goes here
%   Detailed explanation goes here

if isa(A,'iCon')
    [varargout{1:nargout}] = lsqr(double(A),B,varargin{:});
elseif isa(B,'iCon')
    [varargout{1:nargout}] = lsqr(A, double(B), varargin{:});
end