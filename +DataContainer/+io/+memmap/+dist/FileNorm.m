function y = FileNorm(dirname,dimensions,norm,file_precision)
%FILENORM Calculates the norm of the distributed data
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
error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(dirname), 'input directory name must be a string')
assert(isvector(dimensions), 'dimensions must be a vector')
assert(isdir(dirname),'Fatal error: input directory %s does not exist'...
    ,dirname)

global SDCbufferSize;

% Reading the header
hdrin = DataContainer.io.memmap.serial.HeaderRead(dirname);

% Set byte size
bytesize  = DataContainer.utils.getByteSize(file_precision);

maxbuffer = SDCbufferSize/bytesize;

if(norm == 'fro')
    norm = 2;
end

% Infinite norm
if(norm == inf)
    spmd
        dims      = [1 prod(hdrin.distribution.size{labindex})];
        reminder  = prod(hdrin.distribution.size{labindex});
        rstart    = 1;
        while (reminder > 0)
            buffer = min(reminder,maxbuffer);
            rend = rstart + buffer - 1;
            lx = DataContainer.io.memmap.serial.DataReadLeftChunk(...
                hdrin.directories{labindex},'real',...
                dims,[rstart rend],[],file_precision,file_precision);            
            if hdrin.complex
                dummy = DataContainer.io.memmap.serial.DataReadLeftChunk(...
                    hdrin.directories{labindex},'imag',...
                    dims,[rstart rend],[],file_precision,file_precision);
                lx = complex(lx,dummy);
            end
            total    = max(abs(lx));
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
        dims      = [1 prod(hdrin.distribution.size{labindex})];
        reminder  = prod(hdrin.distribution.size{labindex});
        rstart    = 1;
        while (reminder > 0)
            buffer = min(reminder,maxbuffer);
            rend = rstart + buffer - 1;
            lx = DataContainer.io.memmap.serial.DataReadLeftChunk(...
                hdrin.directories{labindex},'real',...
                dims,[rstart rend],[],file_precision,file_precision);            
            if hdrin.complex
                dummy = DataContainer.io.memmap.serial.DataReadLeftChunk(...
                    hdrin.directories{labindex},'imag',...
                    dims,[rstart rend],[],file_precision,file_precision);
                lx = complex(lx,dummy);
            end
            total    = min(abs(lx));
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
        dims      = [1 prod(hdrin.distribution.size{labindex})];
        reminder  = prod(hdrin.distribution.size{labindex});
        rstart = 1;
        while (reminder > 0)
            buffer = min(reminder,maxbuffer);
            rend = rstart + buffer - 1;
            lx = DataContainer.io.memmap.serial.DataReadLeftChunk(...
                hdrin.directories{labindex},'real',...
                dims,[rstart rend],[],file_precision,file_precision);            
            if hdrin.complex
                dummy = DataContainer.io.memmap.serial.DataReadLeftChunk(...
                    hdrin.directories{labindex},'imag',...
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
