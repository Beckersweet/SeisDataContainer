function x = DataRead(dirname,filename,dimensions,file_precision,x_precision)
%DATAREAD Reads serial data from binary file
%
%   X = DataRead(DIRNAME,FILENAME,DIMENSIONS,FILE_PRECISION,X_PRECISION) reads
%   the serial real array X from file DIRNAME/FILENAME.
%
%   DIRNAME     - A string specifying the directory name
%   FILENAME    - A string specifying the file name
%   DIMENSIONS  - A vector specifying the dimensions
%   *_PRECISION - An string specifying the precision of one unit of data,
%                 Supported precisions: 'double', 'single'
%
error(nargchk(5, 5, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isvector(dimensions), 'dimensions must be given as a vector')
assert(ischar(file_precision), 'file_precision name must be a string')
assert(ischar(x_precision), 'x_precision name must be a string')

%Imports
import slim.javaseis.utils.SeisioSDC;

% Preprocess input arguments
filename=fullfile(dirname,filename);

% Check File
assert(exist(filename,'file')==2,'Fatal error: file %s does not exist',...
    filename);

%Creation of the seisio object enabling to read from the JavaSeis file
seisio=slim.javaseis.utils.SeisioSDC(dirname);

%Loading of the file data set definition
seisio.loadDatasetDefinition;

%Properties of interest
props=seisio.getFileProperties({char(SeisioSDC.DATA_DIMENSIONS),'complex'});

%Number of dimensions
dims=double(props.get(char(SeisioSDC.DATA_DIMENSIONS)));

%Initialization of the output
x=zeros(dimensions);

%Reading of the data from the Trace file
seisio.open('rw');
if props.get('complex')==1 %Complex case
    x=permute(seisio.readMatlabMultiArray(dims,zeros(1,dims)),dims:-1:1);
else %Real case
    x=permute(seisio.readMatlabMultiArray(dims,zeros(1,dims)),dims:-1:1);
end

% swap x_precision
x = SDCpckg.utils.switchPrecisionIP(x,x_precision);

end