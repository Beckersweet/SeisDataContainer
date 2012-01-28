function x = FileNorm( dirname,dimensions,norm,file_precision )
%FILENORM Calculates the norm of a given data
%
%   FileNorm(DIRNAME,FILENAME,DIMENSIONS,NORM,FILE_PRECISION)
%
%   DIRNAME        - A string specifying the input directory
%   FILENAME       - A string specifying the input filename
%   NORM           - Specifyies the norm type. Supported norms: inf, -inf,
%                    'fro', p-norm where p is scalar.
%   DIMENSIONS     - A scalar vector specifying the dimensions
%   FILE_PRECISION - An string specifying the file_precision of one unit of 
%                    data, Supported precisions: 'double' or 'single'

SeisDataContainer.io.isFileClean(dirname);
error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(dirname), 'input directory name must be a string')
assert(isvector(dimensions), 'dimensions must be a vector')
assert(isdir(dirname),'Fatal error: input directory %s does not exist'...
    ,dirname)

global SDCbufferSize;

% Reading the header
header    = SeisDataContainer.io.NativeBin.serial.HeaderRead(dirname);

% Set byte size
bytesize  = SeisDataContainer.utils.getByteSize(file_precision);

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
        r = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
            (dirname,'real',dims,[rstart rend],[],file_precision,file_precision);
        if header.complex
            dummy = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
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
        r = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
            (dirname,'real',dims,[rstart rend],[],file_precision,file_precision);
        if header.complex
            dummy = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
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
        r = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
            (dirname,'real',dims,[rstart rend],[],file_precision,file_precision);
        if header.complex
        dummy = SeisDataContainer.io.NativeBin.serial.DataReadLeftChunk...
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
