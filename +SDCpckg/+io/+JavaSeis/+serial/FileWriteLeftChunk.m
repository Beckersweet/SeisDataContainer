function FileWriteLeftChunk(dirname,x,range,slice)
%FILEWRITELEFTCHUNK Writes serial left chunk data to binary file
%
% Edited for JavaSeis by Trisha
%
%   FileWriteLeftChunk(DIRNAME,DATA,RANGE,SLICE) writes
%   the real serial left chunk into DIRNAME/FILENAME.
%
%   DIRNAME - A string specifying the directory name
%   DATA    - Non-distributed float data
%   RANGE   - A vector with two elements representing the range of
%             data that we want to write            
%   SLICE   - A vector specifying the slice
%
%   Warning: If the specified dirname exists, it will be removed.
error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(x), 'data must be float')
%assert(~isdistributed(x), 'data must not be distributed')
% No distribution yet. This function is not defined.
assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Set up the Seisio object
import beta.javaseis.io.Seisio.*;    
seisio = beta.javaseis.io.Seisio( dirname );
seisio.open('rw');

% Get number of dimensions and set position accordingly
dimensions = seisio.getGridDefinition.getNumDimensions();
assert(isequal(slice,[]), 'Code only completed for slice == []');
asser(isequal(dimensions, 3), 'Code only completed for 3 dimensions');
    
position = zeros(dimensions,1);

% Write file
for i = range(1)+1:range(2)+1
    position(dimensions)=i-1;
    data = x(:,:,i);
    data=data';
    seisio.setTraceDataArray(data);
    seisio.setPosition(position);
    seisio.writeFrame(size(data,1));% writes one 2D "Frame"
end

    seisio.close();
end
