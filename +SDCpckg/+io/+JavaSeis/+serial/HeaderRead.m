function header = HeaderRead(dirname)
%HEADERREAD Reads header from specified directory
%
% Edited for JavaSeis by Trisha
%
%   HeaderRead(DIRNAME) reads the serial header
%   from file DIRNAME/FILENAME.
%
%   DIRNAME - A string specifying the directory name
%
error(nargchk(1, 1, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% Set up the Seisio object
import beta.javaseis.io.Seisio.*;    
seisio = beta.javaseis.io.Seisio( dirname );
seisio.open('r');

% Read header
% 2 options !
header = readFrameHeaders(); % returns an int; the number of traces in frame
%header = getHeaderIO(); % returns a virtual io "headerIO"

% header = load(fullfile(dirname,'header.mat')); % original matlab code 
 




end
