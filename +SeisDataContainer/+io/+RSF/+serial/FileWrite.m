function FileWrite(filename,rsfargs,x,varargin)
%FILEWRITE Writes serial data to RSF file
%
%   FileWrite(FILENAME,RSFARGS,DATA,HEADER) writes
%   the serial array X into RSF file FILENAME.
%
%   FILENAME - A string specifying the directory name
%   RSFARGS  - extra RSF command-line options
%              cell array of strings; e.g., use
%                {'out=stdout'} to pack header and data
%              or use empty {} for no extra options
%   DATA     - Non-distributed float data
%
%   Optional argument is HEADER (described
%   in help for SeisDataContainer.basicHeaderStruct)
%
%   Note! needs MADAGASCAR SVN rev. 8140 or newer
%

    error(nargchk(3, 4, nargin, 'struct'));
    assert(ischar(filename), 'directory name must be a string')
    assert(isfloat(x), 'data must be float')
    assert(~isdistributed(x), 'data must not be distributed')

% Setup variables

% Preprocess input arguments
    if nargin>3
        assert(isstruct(varargin{1}),'argument mast be header struct')
        header = varargin{1};
    else
        header = SeisDataContainer.basicHeaderStructFromX(x);
    end;
    SeisDataContainer.verifyHeaderStructWithX(header,x);

% Write file
    rsf_write_all(filename,rsfargs,x,...
        header.delta,header.origin,header.label,header.unit);

end
