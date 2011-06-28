function header = HeaderRead(dirname)
%
error(nargchk(1, 1, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% Read header
header = load(fullfile(dirname,'header.mat'));
 
end
