function [x header] = FileRead(filename)
%FILEREAD  Read serial data and header from RSF file
%
%   [X, HEADER] = FileRead(FILENAME) reads
%       the serial array X from RSF file FILENAME and
%       puts RSF file attributes into HEADER struct as described
%       in help for SeisDataContainer.basicHeaderStruct
%
%   FILENAME     - A string specifying the RSF file name
%
%   Note! needs MADAGASCAR 1.2 (SVN rev. 7470) or newer
%
 
    error(nargchk(1, 1, nargin, 'struct'));
    assert(SeisDataContainer.io.isFile(filename),...
        'Fatal error: file %s does not exist',filename)

% Read file
    [x dims delta origin label unit]=rsf_read_all(filename);

% Update header woth file atributes
    header = SeisDataContainer.basicHeaderStructFromX(x);
    [pathstr,header.varName,ext] = fileparts(filename);
    header.origin = origin;
    header.delta = delta;
    header.label = label;
    header.unit = unit;
    % label not implemented in rsf_par
    SeisDataContainer.verifyHeaderStructWithX(header,x);

end
