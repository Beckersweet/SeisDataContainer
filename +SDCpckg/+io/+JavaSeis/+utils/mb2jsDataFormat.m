function jsDataFormat=mb2jsDataFormat(mbDataFormat)
%MB2JSDATAFORMAT Converts Matlab data format to JavaSeis data format. 
%
%   JSDATAFORMAT=mb2jsDataFormat(MBDATAFORMAT) converts the Matlab data 
%   format MBDATAFORMAT to JavaSeis data format JSDATAFORMAT
%
%   MBDATAFORMAT [char] - Matlab string specifying the data format
%   JSDATAFORMAT [DataFormat]- JavaSeis data format object
%
%JavaSeis classical returned data formats are:
%
%   FLOAT - 32 bits float
%   INT08 - 8 bits integer
%   INT16 - 16 bits integer
%
%JavaSeis compressed formats are:
%
%   COMPRESSED_INT16: compressed 16 bits integer
%   COMPRESSED_INT08: compressed 8 bits integer
%   SEISPEG: SeisPeg 2D compression
%
%See also: JS2MBDATAFORMAT

dataFormat='UNKNOWN';

switch mbDataFormat
    
    case 'double'
        dataFormat='FLOAT';
    case 'single'
        dataFormat='FLOAT';
    case 'int8'
        dataFormat='INT08';
    case 'int16'
        dataFormat='INT16';
    case 'int32'
        dataFormat='FLOAT';
    case 'compressed_int16'
        dataFormat='COMPRESSED_INT16';
    case 'compressed_int08'
        dataFormat='COMPRESSED_INT06';
    case 'seispeg'
        dataFormat='SEISPEG';
end

%Check of possible unknown data format
if strcmp(dataFormat,'UNKNOWN')
    error('Unknown data format');
end

jsDataFormat=org.javaseis.properties.DataFormat.(dataFormat);

end