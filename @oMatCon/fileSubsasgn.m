function x = fileSubsasgn(x,a,varargin)
%FILESUBSASGN   out-of-core-to-out-of-core subscripted assignment
%
%   X = fileSubsasgn(X,A,ind1,ind2,...) subsasgns the oMatCon X with
%   oMatCon A using indices (ind1,ind2,...) and returns X. The index range
%   must be totally contiguous
%
%   X = X.fileSubsasgn(A,ind1,ind2,...) also works if you are more
%   comfortable with this notation.

