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
header.origin=(gridDef.getAxisLogicalOrigins+1)';
header.delta=(gridDef.getAxisPhysicalDeltas)';
header.precision=js2mbDataFormat(char(dataDef.getTraceFormat.getName));
header.complex=supplPropDef.get('complex');
header.unit=(cell(gridDef.getAxisUnitsStrings))';
header.label=(cell(gridDef.getAxisLabelsStrings))';
header.distributedIO=supplPropDef.get('distributedIO');

%Swapping of the 2 first dimensions to match Matlab convention
tmp=header.size(1);
header.size(1)=header.size(2);
header.size(2)=tmp;
tmp=header.origin(1);
header.origin(1)=header.origin(2);
header.origin(2)=tmp;
tmp=header.delta(1);
header.delta(1)=header.delta(2);
header.delta(2)=tmp;
tmp=header.unit{1};
header.unit{1}=header.unit{2};
header.unit{2}=tmp;
tmp=header.label{1};
header.label{1}=header.label{2};
header.label{2}=tmp;
end
