function DataWrite(distribute,dirnames,filename,x,distribution,file_precision)
%DATAWRITE Writes serial data to binary file
%
%   DataWrite(DISTRIBUTE,DIRNAMES,FILENAME,DATA,DISTRIBUTION,FILE_PRECISION) writes
%   the real serial array X into file DIRNAME/FILENAME.
%
%   DISTRIBUTE     - A scalar that takes 1 for distribute or 0 for no distribute
%   DIRNAMES       - A string specifying the directory name
%   FILENAME       - A string specifying the file name
%   DATA           - Distributed real data
%   DISTRIBUTION   - A header struct specifying the distribution
%   FILE_PRECISION - An string specifying the precision of one unit of data,
%                    Supported precisions: 'double', 'single'
%
%   Warning: The specified file must exist.
error(nargchk(6, 6, nargin, 'struct'));
assert(isscalar(distribute),'distribute flag must be a scalar')
assert(ischar(filename), 'file name must be a string')
assert(isreal(x), 'data must be real')
assert(isdistributed(x), 'data must be distributed')
assert(isstruct(distribution), 'distribution must be a headser struct')
assert(ischar(file_precision), 'file_precision name must be a string')
assert(matlabpool('size')>0,'matlabpool must be open')
if distribute
    assert(iscell(dirnames), 'directory names must be a cell')
    dirname = SDCpckg.utils.Cell2Composite(dirnames);
else
    assert(ischar(dirnames), 'directory name must be a string')
    dirname = dirnames;
    cindx_rng = SDCpckg.utils.Cell2Composite(distribution.indx_rng);
end
csize = SDCpckg.utils.Cell2Composite(distribution.size);

spmd
    % Check File
    filecheck=fullfile(dirname,filename);
    assert(exist(filecheck)==2,'Fatal error: file %s does not exist',filecheck);
    % write data
    lx = getLocalPart(x);
    lxs = size(lx);
    if length(lxs)<length(csize); lxs(end+1) = 1; end
    assert(isequal(csize,lxs),'distribution.size does not match the size of LocalPart')
    if distribute
        SDCpckg.io.NativeBin.serial.DataWrite(dirname,filename,lx,file_precision);
    else
        SDCpckg.io.acquireIOlock(dirname);
        SDCpckg.io.NativeBin.serial.DataWriteLeftChunk(dirname,filename,lx,...
            size(x),cindx_rng,[],file_precision);
        SDCpckg.io.releaseIOlock(dirname);
    end
end

end
