function x = subsasgnHelper(x,s,b)
%SUBSASGNHELPER Helper function to assign container-specific data
%
%   Not for user to use.

x.data = subsasgn(double(x),s,double(b));