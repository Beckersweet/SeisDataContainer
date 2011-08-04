function y = FileNorm(dirname,norm)
%FILENORM Calculates the norm of the distributed data
%
%   FileNorm(DIRNAME,NORM)
%
%   DIRNAME        - A string specifying the input directory
%   NORM           - Specifyies the norm type. Supported norms: inf, -inf,
%                    'fro', p-norm where p is scalar.
error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'input directory name must be a string')
assert(isdir(dirname),'Fatal error: input directory %s does not exist'...
    ,dirname)

hdrin = DataContainer.io.memmap.serial.HeaderRead(dirname);
sldims = hdrin.size(hdrin.distribution.dim+1:end);
lngth = length(hdrin.size);
hdrin.precision
if(norm == 'fro')
    norm = 2;
end

% Infinite norm
if(norm == inf)
    m = -inf;
    for s=1:prod(sldims)
        slice = DataContainer.utils.getSliceIndexS2V(sldims,s);
        x=DataContainer.io.memmap.dist.DataReadLeftSlice(1,hdrin.directories,'real',...
            hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
        if hdrin.complex
            dummy=DataContainer.io.memmap.dist.DataReadLeftSlice(1,hdrin.directories,'imag',...
                hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
            x = complex(x,dummy);
        end
        for i=1:lngth
            x = max(abs(x));
        end
        x = max(x,m);
    end
    y = gather(x);
    
% Negative infinite norm
elseif(norm == -inf)
    m = inf;
    for s=1:prod(sldims)
        slice = DataContainer.utils.getSliceIndexS2V(sldims,s);
        x=DataContainer.io.memmap.dist.DataReadLeftSlice(1,hdrin.directories,'real',...
            hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
        if hdrin.complex
            dummy=DataContainer.io.memmap.dist.DataReadLeftSlice(1,hdrin.directories,'imag',...
                hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
            x = complex(x,dummy);
        end
        for i=1:lngth
            x = min(abs(x));
        end
        x = min(x,m);
    end
    y = gather(x);    
% P-norm
elseif (isscalar(norm))
    total = 0;
    for s=1:prod(sldims)
        slice = DataContainer.utils.getSliceIndexS2V(sldims,s);
        x=DataContainer.io.memmap.dist.DataReadLeftSlice(1,hdrin.directories,'real',...
            hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
        if hdrin.complex
            dummy=DataContainer.io.memmap.dist.DataReadLeftSlice(1,hdrin.directories,'imag',...
                hdrin.size,hdrin.distribution,slice,hdrin.precision,hdrin.precision);
            x = complex(x,dummy);
        end
        total = total + sum(abs(x).^norm);    
    end

    total = gather(total);

    for i=2:lngth
        total = sum(total);
    end

    y = total^(1/norm);
else
    error('Unsupported norm');
end

end

