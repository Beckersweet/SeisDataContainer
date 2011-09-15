function x = norm(obj,norm)
%NORM Calculates the norm of the datacontainer
%
%   norm(NORM)
%
%   NORM - Specifies the norm type. Supported norms: inf, -inf,
%                    'fro', p-norm where p is scalar.
    norm = cell2mat(norm);
    x = DataContainer.io.memmap.serial.FileNorm...
        (obj.dirname,obj.dimensions,norm,'double');
end

