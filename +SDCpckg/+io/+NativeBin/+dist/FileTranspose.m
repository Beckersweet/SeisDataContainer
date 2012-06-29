function FileTranspose(dirnameIn,dirnameOut,varargin)
%DATATRANSPOSE Transposes input data and writes it to output file
%
%   FileTranspose(DIRNAMEIN,DIRNAMEOUT,SEPDIM)
%   allocates binary file for serial data writing.
%
%   DIRNAMEIN      - A string specifying the input directory
%   DIRNAMEOUT     - A string specifying the output directory
%   Conditional arguments in order:
%       for distributed IO
%           DISTDIRNAMEOUT - A cell specifying the distributed output directories
%           PARTITION      - A vector with partion for new distributed dimension
%       for serial IO
%           SEPDIM         - A scalar specifying the separation dimension
%
%   Warning: For now this function only works for distributed data that 
%   has matlab default distribution
%
error(nargchk(2, 5, nargin, 'struct'));
assert(matlabpool('size')>0,'matlabpool must be open')
assert(ischar(dirnameIn), 'input directory name must be a string')
assert(isdir(dirnameIn),'Fatal error: input directory %s does not exist',dirnameIn);
assert(ischar(dirnameOut), 'output directory name must be a string')
assert(isdir(dirnameOut), 'output directory name must be a string')

% Read header
hdrin = SDCpckg.io.NativeBin.serial.HeaderRead(dirnameIn);
if ~hdrin.distributedIO % serial redirect to serial transpose
    error(nargchk(3, 3, nargin, 'struct'));
    assert(isscalar(varargin{1}),'seperation dimension must be a scalar')
    sepdim = varargin{1};
    SDCpckg.io.NativeBin.serial.FileTranspose(dirnameIn,dirnameOut,sepdim);
else % here starts the distributed transpose
    %disp('distributedIO')
    %hdrin.distribution

    % Process arguments
    error(nargchk(3, 4, nargin, 'struct'));
    assert(iscell(varargin{1}), 'distributed output directories names must form cell')
    distdirs = varargin{1};
    sizeIn = hdrin.size;
    if nargin>3
        assert(isvector(varargin{2}),'partition must be a vector')
        partition = varargin{2};
        assert(length(partition)==matlabpool('size'),'length(partition) does not match the matlabpool')
        assert(sum(partition)==sizeIn(end),'sum(partition) does not match the diemnsion')
    else
        partition = SDCpckg.utils.defaultDistribution(sizeIn(end));
    end
    % Setting up the output header
    assert(hdrin.distribution.dim<hdrin.dims,'distributed dimension of the input must not be the rightmost one')
    hdrout = SDCpckg.transposeHeaderStruct(hdrin,hdrin.distribution.dim);
    hdrout = SDCpckg.addDistHeaderStruct(hdrout,hdrin.dims-hdrin.distribution.dim,partition);
    hdrout = SDCpckg.addDistFileHeaderStruct(hdrout,distdirs);
    hdcmplx = hdrin.complex;
    fprecision = hdrin.precision;
    %hdrout.distribution

    % Allocate file
    SDCpckg.io.NativeBin.dist.FileAlloc(dirnameOut,hdrout);

    % Prepare global params for transposing
    ds = hdrin.size(1:hdrin.distribution.dim);
    pds = prod(ds);
    pds1 = prod(ds(1:end-1));
    dds = pds1*hdrin.distribution.partition;
    de = hdrout.size(1:hdrout.distribution.dim);
    pde = prod(de);
    pde1 = prod(de(1:end-1));
    dde = pde1*hdrout.distribution.partition;
    % indecies
    irng = zeros(matlabpool('size'),2);
    indx_rng = hdrin.distribution.indx_rng;
    for l = 1:matlabpool('size')
        irng(l,1) = (indx_rng{l}(1)-1)*pds1+1;
        irng(l,2) = (indx_rng{l}(2))*pds1;
    end
    % composites
    distdirin = SDCpckg.utils.Cell2Composite(hdrin.directories);
    distdirout = SDCpckg.utils.Cell2Composite(hdrout.directories);

    spmd
        % transpose
        for s=1:pds
            % find sender
            for l=1:numlabs
                if s>=irng(l,1) & s<=irng(l,2); sender = l; end
            end
            % read data
            if s>=irng(labindex,1) & s<=irng(labindex,2)
                start = s-irng(labindex,1)+1;
                skip = dds(labindex);
                count = pde;
                %disp([sender start count skip])
                lp = SDCpckg.io.NativeBin.serial.DataReadStriped(distdirin,'real',...
                    [dds(labindex) pde],start,count,skip,fprecision,fprecision);
                if hdcmplx
                    dummy = SDCpckg.io.NativeBin.serial.DataReadStriped(distdirin,'imag',...
                        [dds(labindex) pde],start,count,skip,fprecision,fprecision);
                    lp = complex(lp,dummy);
                end
            else
                lp = zeros(0,1);
                if hdcmplx
                    lp = complex(lp,lp);
                end
            end
            % crate codistributed
            prt = zeros(1,numlabs); prt(1,sender) = pde;
            cin = codistributor1d(1,prt,[pde 1]);
            LP = codistributed.build(lp,cin,'noCommunication');
            % redistribute
            cout = codistributor1d(1,dde,[pde 1]);
            LP = redistribute(LP,cout);
            % write slice
            SDCpckg.io.NativeBin.dist.DataWriteLeftSlice(1,distdirout,'real',real(LP),...
                hdrout.size,[dde(labindex) pds],[],1,s,fprecision);
            if hdcmplx
                SDCpckg.io.NativeBin.dist.DataWriteLeftSlice(1,distdirout,'imag',imag(LP),...
                    hdrout.size,[dde(labindex) pds],[],1,s,fprecision);
            end
        end
    end

end

end
