function HeaderWrite(dirname,header)
%HEADERWRITE  Write header to specified directory
%
%   HeaderRead(DIRNAME,HEADER) writes the serial HEADER
%   to file DIRNAME/FILENAME.
%
error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(isstruct(header),'header has to be a struct')

% Write header
save(fullfile(dirname,'header.mat'),'-struct','header');

end
