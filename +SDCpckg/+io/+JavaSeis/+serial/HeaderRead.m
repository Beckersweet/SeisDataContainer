function header = HeaderRead(dirname)
%HEADERREAD Reads header from specified directory
%
%   HeaderRead(DIRNAME) reads the serial header
%   from file DIRNAME/FILENAME.
%
%   DIRNAME - A string specifying the directory name
%

%% Check of the input arguments
error(nargchk(1, 1, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

%% Imports
import org.javaseis.properties.*;
import SDCpckg.io.JavaSeis.utils.*;

%% Loading of the Seisio file storing the header's properties
seisio=slim.javaseis.utils.SeisioSDC(dirname);
seisio.open('r');

%% Intermediate properties
gridDef=seisio.getGridDefinition;
dataDef=seisio.getDataDefinition;
% headerDef=seisio.getTraceProperties; %NON USED FOR THE CURRENT SDC TYPE
% OF HEADER
supplPropDef=seisio.getFileProperties({'varName','varUnits','complex',...
    'distributedIO'});
seisio.close;

%% Reading of the header's properties
header.varName=char(supplPropDef.get('varName'));
header.varUnits=char(supplPropDef.get('varUnits'));
header.dims=gridDef.getNumDimensions;
header.size=(gridDef.getAxisLengths)';
header.origin=(gridDef.getAxisPhysicalOrigins)';
header.delta=(gridDef.getAxisPhysicalDeltas)';
header.precision=js2mbDataFormat(char(dataDef.getTraceFormat.getName));
header.complex=supplPropDef.get('complex');
header.unit=(cell(gridDef.getAxisUnitsStrings))';
header.label=(cell(gridDef.getAxisLabelsStrings))';
header.distributedIO=supplPropDef.get('distributedIO');
end
