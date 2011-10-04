function FileWriteLeftSlice(dirname,X,slice)
%FILEWRITELEFTSLICE  Write serial left slice data to binary file
%
% Edited for JavaSeis by Trisha
%
%   FileWriteLeftSlice(DIRNAME,DATA,SLICE) writes
%   the real serial left slice into DIRNAME/FILENAME.
%
%   DIRNAME  - A string specifying the directory name
%   DATA     - Non-distributed float data
%   SLICE    - A vector specifying the slice index
%
%   Warning: If the specified dirname exists, it will be removed
error(nargchk(3, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(X), 'data must be float')
% assert(~isdistributed(x), 'data must not be distributed')
% Does not exist for this type - need to redo.
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Set up the Seisio object
import beta.javaseis.io.Seisio.*;    
seisio = beta.javaseis.io.Seisio( dirname );
seisio.open('rw');

% Read header
% header = DataContainer.io.memmap.serial.HeaderRead(dirname);

% Get number of dimensions and set position accordingly
dimensions = seisio.getGridDefinition.getNumDimensions();
assert(isequal(dimensions,2)|isequal(dimensions,3)|isequal(dimensions,4)|...
    isequal(dimensions,5), 'Data in js file must have dimensions 2<=n<=5.')
position = zeros(1,dimensions);
position(dimensions) = slice;

% Write file
x=X';
seisio.usesProperties(false);
seisio.setTraceDataArray(x);
seisio.setPosition(position);
seisio.writeFrame(size(x,1));

end
