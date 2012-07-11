function y = FileNorm(dirname,norm)
%FILENORM Calculates the norm of the distributed data
%
%   FileNorm(DIRNAME,FILENAME,DIMENSIONS,NORM,FILE_PRECISION)
%
%   DIRNAME        - A string specifying the input directory
%   NORM           - Specifyies the norm type. Supported norms: inf, -inf,
%                    'fro', p-norm where p is scalar.
SDCpckg.io.isFileClean(dirname);
error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'input directory name must be a string')
assert(isdir(dirname),'Fatal error: input directory %s does not exist'...
    ,dirname)

global SDCbufferSize;
assert(~isempty(SDCbufferSize),'you first need to execute SeisDataContainer_init')

% Reading the header
header = SDCpckg.io.NativeBin.serial.HeaderRead(dirname);
file_precision = header.precision;
dimensions = header.size;

% Set byte size
bytesize  = SDCpckg.utils.getByteSize(file_precision);

maxbuffer = SDCbufferSize/bytesize;

if(norm == 'fro')
    norm = 2;
end

% Infinite norm
if(norm == inf)
    spmd
        dims      = [1 prod(header.distribution.size{labindex})];
        reminder  = prod(header.distribution.size{labindex});
        rstart    = 1;
        total     = -inf;
        while (reminder > 0)
            buffer = min(reminder,maxbuffer);
            rend = rstart + buffer - 1;
            lx = SDCpckg.io.NativeBin.serial.DataReadLeftChunk(...
                header.directories{labindex},'real',...
                dims,[rstart rend],[],file_precision,file_precision);            
            if header.complex
                dummy = SDCpckg.io.NativeBin.serial.DataReadLeftChunk(...
                    header.directories{labindex},'imag',...
                    dims,[rstart rend],[],file_precision,file_precision);
                lx = complex(lx,dummy);
            end
            if isempty(lx); lx = [total]; end
            rtotal   = max(abs(lx));
            total    = max(total,rtotal);
            reminder = reminder - buffer;
            rstart   = rend + 1;
        end
    end
    y = -inf;
    for i=1:matlabpool('size')
        y = max(y,cell2mat(total(i)));
    end

% Negative infinite norm
elseif(norm == -inf)
    spmd
        dims      = [1 prod(header.distribution.size{labindex})];
        reminder  = prod(header.distribution.size{labindex});
        rstart    = 1;
        total     = inf;
        while (reminder > 0)
            buffer = min(reminder,maxbuffer);
            rend = rstart + buffer - 1;
            lx = SDCpckg.io.NativeBin.serial.DataReadLeftChunk(...
                header.directories{labindex},'real',...
                dims,[rstart rend],[],file_precision,file_precision);            
            if header.complex
                dummy = SDCpckg.io.NativeBin.serial.DataReadLeftChunk(...
                    header.directories{labindex},'imag',...
                    dims,[rstart rend],[],file_precision,file_precision);
                lx = complex(lx,dummy);
            end
            if isempty(lx); lx = [total]; end
            rtotal   = min(abs(lx));
            total    = min(total,rtotal);
            reminder = reminder - buffer;
            rstart   = rend + 1;
        end
    end
    y = inf;
    for i=1:matlabpool('size')
        y = min(y,cell2mat(total(i)));
    end

% P-norm
elseif (isscalar(norm))
    total = 0;
    grandTotal = 0;
    spmd
        dims      = [1 prod(header.distribution.size{labindex})];
        reminder  = prod(header.distribution.size{labindex});
        rstart    = 1;
        total     = 0;
        while (reminder > 0)
            buffer = min(reminder,maxbuffer);
            rend = rstart + buffer - 1;
            lx = SDCpckg.io.NativeBin.serial.DataReadLeftChunk(...
                header.directories{labindex},'real',...
                dims,[rstart rend],[],file_precision,file_precision);            
            if header.complex
                dummy = SDCpckg.io.NativeBin.serial.DataReadLeftChunk(...
                    header.directories{labindex},'imag',...
                    dims,[rstart rend],[],file_precision,file_precision);
                lx = complex(lx,dummy);
            end
            total  = total + sum(abs(lx).^norm);
            for i=1:length(dimensions)-1
                total = sum(total);
            end
            reminder = reminder - buffer;
            rstart   = rend + 1;
        end
    end
    for i=1:matlabpool('size')
        grandTotal = grandTotal + cell2mat(total(i));
    end    
    y = grandTotal^(1/norm);
else
    error('Unsupported norm');
end

end
