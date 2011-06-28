function HeaderWrite(dirname,header)
%
error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(isstruct(header),'header has to be a struct')

% Write header
save(fullfile(dirname,'header.mat'),'-struct','header');

end
