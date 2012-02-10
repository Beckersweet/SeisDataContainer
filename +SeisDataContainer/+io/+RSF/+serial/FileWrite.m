function FileWrite(filename,x,varargin)
%FILEWRITE Writes serial data to RSF file
%
%   FileWrite(FILENAME,DATA,HEADER) writes
%   the serial array X into RSF file FILENAME.
%
%   DIRNAME - A string specifying the directory name
%   DATA    - Non-distributed float data
%
%   Optional argument is HEADER as described
%   in help for SeisDataContainer.basicHeaderStruct
%
%   Note! needs MADAGASCAR 1.2 (SVN rev. 7470) or newer
%

    error(nargchk(2, 3, nargin, 'struct'));
    assert(ischar(filename), 'directory name must be a string')
    assert(isfloat(x), 'data must be float')
    assert(~isdistributed(x), 'data must not be distributed')

% Setup variables

% Preprocess input arguments
    if nargin>2
        assert(isstruct(varargin{1}),'argument mast be header struct')
        header = varargin{1};
    else
        header = SeisDataContainer.basicHeaderStructFromX(x);
    end;
    SeisDataContainer.verifyHeaderStructWithX(header,x);

% Write file
    rsf_write_all(filename,x,...
        header.delta,header.origin,header.label,header.unit);

end
