function DataWrite(dirname,filename,x,file_precision)
%DATAWRITE Writes serial data to binary file
%
%   DataWrite(DIRNAME,DATA,FILE_PRECISION) writes
%   the real serial array X into file DIRNAME/FILENAME.
%
%   DIRNAME        - A string specifying the directory name
%   FILENAME       - A string specifying the file name
%   DATA           - Non-distributed real data
%   FILE_PRECISION - A string specifying the precision of one unit of 
%                       data,
%               Supported precisions: 'double', 'single'
%
%   Warning: The specified file must exist.

error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(ischar(filename), 'file name must be a string')
assert(isreal(x), 'data must be real')
assert(~isdistributed(x), 'data must not be distributed')
assert(ischar(file_precision), 'file_precision name must be a string')

%Imports
import slim.javaseis.utils.*;

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Check File
assert(exist(filename,'file')==2,'Fatal error: file %s does not exist',...
    filename);

% swap file_precision
x = SDCpckg.utils.switchPrecisionIP(x,file_precision);

%Creation of the seisio object enabling to write into the JavaSeis file
seisio=slim.javaseis.utils.SeisioSDC(dirname);

%Loading of the file data set definition
seisio.loadDatasetDefinition;

%Properties of interest
props=seisio.getFileProperties({char(SeisioSDC.DATA_DIMENSIONS),'complex'});

%JavaSeis grid dimensions
dims=double(props.get(char(SeisioSDC.DATA_DIMENSIONS)));

%Writing of the data in the Trace file
seisio.open('rw');
if props.get('complex')==1 %Complex case
    x=single(x);
    seisio.writeMatlabMultiArray(permute(x,dims:-1:1),zeros(1,dims));
else %Real case
    x=single(x);
    seisio.writeMatlabMultiArray(permute(x,dims:-1:1),zeros(1,dims));
end
end