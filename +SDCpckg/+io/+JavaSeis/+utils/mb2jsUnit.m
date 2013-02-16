function jsUnit=mb2jsUnit(mbUnit)
%MB2JSUNIT Converts Matlab unit to JavaSeis unit
%
%   JSUNIT=mb2jsDataFormat(MBUNIT) converts the Matlab unit MBUNIT to the
%   JavaSeis corresponding unit JSUNIT
%
%   MBUNIT [char] - Matlab string specifying the unit
%   JSUNIT [Units]- JavaSeis unit object

unit='NULL';

switch mbUnit
    %Feet/foot
    case 'feet'
        unit='FEET';
    case 'ft'
        unit='FEET';
        
        %Meters
    case 'meters'
        unit='METERS';
    case 'm'
        unit='METERS';
        
        %Milliseconds
    case 'milliseconds'
        unit='MILLISECONDS';
    case 'msec'
        unit='MILLISECONDS';
    case 'ms'
        unit='MILLISECONDS';
        
        %Seconds
    case 'seconds'
        unit='SECONDS';
    case 'sec'
        unit='SECONDS';
    case 's'
        unit='SECONDS';
        
        %Microsec
    case 'microseconds'
        unit='MICROSEC';
    case 'microsec'
        unit='MICROSEC';
    case 'µs'
        unit='MICROSEC';
        
        %Hertz
    case 'hertz'
        unit='HERTZ';
    case 'hz'
        unit='HERTZ';
        
        %Degrees
    case 'degrees'
        unit='DEGREES';
    case 'deg'
        unit='DEGREES';
        
        %Unknown
    case 'unknown'
        unit='UNKNOWN';
end

jsUnit=org.javaseis.properties.Units.(unit);

end