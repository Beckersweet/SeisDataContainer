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


 %Load dynamic libraries
 javaaddpath('/Users/bcollignon/Documents/workspace/dhale-jtk-78bca79.jar');
 %javaaddpath('/Users/bcollignon/Documents/workspace/betajavaseis1819.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/JavaSeisSlim.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/OrgJavaSeis.jar');


% Import
%import slim.javaseis.utils.*;
import SDCpckg.io.JavaSeis.utils.*;
import org.javaseis.properties.*;

%% Grid definition

nb_dims=header.dims ; %Number of dimensions

 if nb_dims<4
    warning('JavaSeis:dimension',['the number of dimensions should at'...
        ' least be 3. Creation of the missing dimension(s)...']);
    header.dims=4;
    for k=nb_dims+1:header.dims
        header.size(k)=1;
        header.origin(k)=NaN;
        header.delta(k)=NaN;
        header.unit{k}='unknown';
        header.label{k}='unknown';
    end
 end
 
axisDef=javaArray('org.javaseis.properties.AxisDefinition',header.dims);

for k=1:header.dims;
    axisDef(k)=AxisDefinition(AxisLabel(header.label{k},''),mb2jsUnit(...
        header.unit{k}),DataDomain.NULL,header.size(k),0,1,...
        header.origin(k),header.delta(k));
end

gridDef=org.javaseis.grid.GridDefinition(header.dims,axisDef);

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
seisio.create;
end