function HeaderWrite(dirname,header)
%HEADERWRITE Writes header to specified directory
%
%   HeaderWrite(DIRNAME,HEADER) writes the serial HEADER
%   to file DIRNAME/FILENAME.
%
%   DIRNAME - A string specifying the directory name
%   HEADER  - A header struct specifying the distribution

%% Check of the input arguments
error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string');
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);
assert(isstruct(header),'header has to be a struct');

%% Imports
import org.javaseis.properties.*;
import SDCpckg.io.JavaSeis.utils.*;

%% Grid definition

nb_dims=header.dims; %Number of dimensions

if nb_dims<3
    warning('JavaSeis:dimension',['the number of dimensions should at'...
        ' least be 3. Creation of the missing dimension(s)...']);
    nb_dims=3;
    axisDef=javaArray('org.javaseis.properties.AxisDefinition',3);
else
    axisDef=javaArray('org.javaseis.properties.AxisDefinition',nb_dims);
end
for k=1:header.dims;
    axisDef(k)=AxisDefinition(AxisLabel(header.label{k},''),mb2jsUnit(...
        header.unit{k}),DataDomain.NULL,header.size(k),...
        header.origin(k)-1,1,0,header.delta(k));
end
for k=header.dims+1:3
    axisDef(k)=AxisDefinition(AxisLabel('Unknown',''),Units.UNKNOWN,...
        DataDomain.NULL,1,0,1,0,1);
end
gridDef=org.javaseis.grid.GridDefinition(nb_dims,axisDef);

%% Data definition
dataDef=DataDefinition(DataType.UNKNOWN,mb2jsDataFormat(header.precision));

%% Header definition
%JavaSeis header definition object could enable to define the traces
%properties. To add a header definition, use a JavaSeis TraceProperties
%object defined with the number of properties and a list of
%PropertyDescription objects.
%e.g.:
%propertyDescr=javaArray('org.javaseis.properties.PropertyDescription',...
%    nb_props);
%propertyDescr(1)=PropertyDescription('Property name',...
%    'Property description',PropertyDescription.HDR_FORMAT_...etc,...
%    counts (i.e. number of items in this property));
%headerDef=TraceProperties(nb_props,propertyDescr);
headerDef=[];

%% Supplementary properties
supplProps=java.util.HashMap;
supplProps.put('varName',header.varName);
supplProps.put('varUnits',header.varUnits);
supplProps.put('complex',header.complex);
supplProps.put('distributedIO',header.distributedIO);

%% Saving of SDC header's properties in a SeisioSDC object
seisio=slim.javaseis.utils.SeisioSDC(dirname,gridDef,dataDef,...
    headerDef,supplProps);
seisio.create();

end