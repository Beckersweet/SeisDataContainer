function y = iCon(x)
%ICON iCon wrapper for oMatCon
%   y = iCon(x) wraps oMatCon x and returns an iCon while conserving
%   header metadata

y = iCon(double(x));
y.header = x.header;
y.exsize = x.exsize;