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

%Swapping of the header's properties so as to match Matlab dimensions
%conventions. The dimensions in Matlab are simply flipped. e.g.: (x y z)
%in JavaSeis becomes (z y x) in Matlab.
header.size=fliplr(header.size);
header.origin=fliplr(header.origin);
header.delta=fliplr(header.delta);
header.unit=fliplr(header.unit);
header.label=fliplr(header.label);

%% In the case where the number of dimensions is equal to 3, which means
%that additional dimensions may have been added in JavaSeis header (cf.
%HeaderWrite), check if the number of dimensions of x can be reduced

if header.dims==3
    if header.size(3)==1
        header.dims=2;
        header.size(3)=[];
        header.origin(3)=[];
        header.delta(3)=[];
        header.unit(3)=[];
        header.label(3)=[];
    end
end
end