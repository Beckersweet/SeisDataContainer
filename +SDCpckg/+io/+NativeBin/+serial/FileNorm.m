function x = FileNorm(dirname,norm)
%FILENORM Calculates the norm of a given data
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
header    = SDCpckg.io.NativeBin.serial.HeaderRead(dirname);
file_precision = header.precision;
dimensions = header.size;

% Set byte size
bytesize  = SDCpckg.utils.getByteSize(file_precision);

% Set the sizes
dims      = [1 prod(dimensions)];
reminder  = prod(dimensions);
maxbuffer = SDCbufferSize/bytesize;

if(norm == 'fro')
    norm = 2;
end

% Infinite norm
if(norm == inf)
    rstart = 1;
    x = -inf;
    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
            (dirname,'real',dims,[rstart rend],[],file_precision,file_precision);
        if header.complex
            dummy = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
                (dirname,'imag',dims,[rstart rend],[],file_precision,file_precision);
            r = complex(r,dummy);
        end
        total     = max(abs(r));
        x         = max(total,x);          
        reminder  = reminder - buffer;
        rstart    = rend + 1;
        clear r;
    end
    
% Negative infinite norm    
elseif(norm == -inf)
    rstart = 1;
    x = inf;
    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
            (dirname,'real',dims,[rstart rend],[],file_precision,file_precision);
        if header.complex
            dummy = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
                (dirname,'imag',dims,[rstart rend],[],file_precision,file_precision);
            r = complex(r,dummy);
        end
        total     = min(abs(r));
        x         = min(total,x);        
        reminder  = reminder - buffer;
        rstart    = rend + 1;
        clear r;
    end
    
% P-norm
elseif (isscalar(norm))
    total = 0;
    rstart = 1;
    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
            (dirname,'real',dims,[rstart rend],[],file_precision,file_precision);
        if header.complex
        dummy = SDCpckg.io.NativeBin.serial.DataReadLeftChunk...
            (dirname,'imag',dims,[rstart rend],[],file_precision,file_precision);
            r = complex(r,dummy);
        end
        total    = total + sum(abs(r).^norm);
        reminder = reminder - buffer;
        rstart   = rend + 1;
        clear r;
    end
    x = total^(1/norm);
else
    error('Unsupported norm');
end
end
