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

% Get file attributes
    sizes = rsf_dim(filename);
    if iscolumn(sizes); sizes=sizes'; end
    dims = length(sizes);
    
    for i=1:dims
        origin(i) = rsf_par(filename,['o' int2str(i)],'f',0);
        delta(i) = rsf_par(filename,['d' int2str(i)],'f',1);
        % unit not implemented in rsf_par
        % label not implemented in rsf_par
    end

% Read file
    x = zeros(sizes);           % allocate array
    try % try reading real first
        rsf_read(x,filename);
    catch cmplx % give complex a try
        x=complex(x,x);
        try
            rsf_read(x,filename);
        catch final % give up
            error('Fatal error: cannot guess RSF file type');
        end
    end

% Update header woth file atributes
    header = SeisDataContainer.basicHeaderStructFromX(x);
    [pathstr,header.varName,ext] = fileparts(filename);
    header.origin = origin;
    header.delta = delta;
    % unit not implemented in rsf_par
    % label not implemented in rsf_par

end
