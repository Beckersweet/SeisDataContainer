function mbDataFormat=js2mbDataFormat(jsDataFormat)
%JS2MBDATAFORMAT Converts JavaSeis data format to Matlab data format. 
%
%   MBDATAFORMAT=js2mbDataFormat(JSDATAFORMAT) converts the JavaSeis data 
%   format JSDATAFORMAT to Matlab data format MBDATAFORMAT
%
%   JSDATAFORMAT [DataFormat]- JavaSeis data format object
%   MBDATAFORMAT [char] - Matlab string specifying the data format
%
%JavaSeis classical data formats are:
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
%See also: MB2JSDATAFORMAT
dataFormat='UNKNOWN';

switch jsDataFormat
    case 'FLOAT'
        dataFormat='double';
    case 'INT08'
        dataFormat='int8';
    case 'INT16'
        dataFormat='int16';
    case 'COMPRESSED_INT16'
        dataFormat='compressed_int16';
    case 'COMPRESSED_INT08'
        dataFormat='compressed_int08';
    case 'SEISPEG'
        dataFormat='seispeg';
end

mbDataFormat=dataFormat;

end