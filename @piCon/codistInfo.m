function [xd, xp, id, ip] = codistInfo(x)
%CODISTINFO Prints the codistributor info onto the Command Window
%   [xd, xp, id, ip] = codistInfo(x)
%   where
%   xd = x.excoddims;
%   xp = x.excodpart;
%   id = x.imcoddims;
%   ip = x.imcodpart;

xd = x.excoddims;
xp = x.excodpart;
id = x.imcoddims;
ip = x.imcodpart;
% 
% fprintf('excoddims: ')
% disp(x.excoddims)
% fprintf('excodpart: ')
% disp(x.excodpart)
% fprintf('imcoddims: ')
% disp(x.imcoddims)
% fprintf('imcodpart: ')
% disp(x.imcodpart)