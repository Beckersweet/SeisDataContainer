function y = fileSubsref(x,varargin)
%FILESUBSREF  out-of-core-to-out-of-core subscripted reference
%
%   Y = fileSubsref(X,ind1,ind2,....) subsrefs the omatCon X with indices
%   (ind1,ind2,...) and returns omatCon Y. The index range must be totally
%   contiguous.
%
%   Y = X.fileSubsref(ind1,ind2...) also works and may be more intuitive to
%   use.


