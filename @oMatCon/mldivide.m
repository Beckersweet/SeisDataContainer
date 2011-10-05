function y = mldivide(A,B,swp)
    if ~isa(B,'dataContainer')
        error('Second input should be a dataContainer')
    end
    % unswap
    if nargin == 3 && strcmp(swp,'swap')
        tmp = B;
        B   = A;
        A   = tmp;
        clear('tmp');
    end

    % Multiply    
    sizeA = size(A);
    if(length(sizeA) > 2 || sizeA(1) ~= sizeA(2))
        error('Fail: Wrong size for first parameter');
    end
    % Reading input header
    headerB   = DataContainer.io.memmap.serial.HeaderRead(B.pathname);
    sizeB     = headerB.size;
    
    sepDim = 0;    
    for i=1:length(sizeB)
        if(prod(sizeB(1:i)) == sizeA(2))
            sepDim = i+1;
            break;
        end
    end
    
    if(sepDim == 0)
        error('Bad multiplication: Dimensions are not matching');
    end
    
    % Creating the output dataContainer
    sizeOut    = [sizeA(1) sizeB(sepDim:end)];
    y          = oMatCon.zeros(sizeOut);
    prod(sizeB(sepDim+1:end));
    if(B.header.complex)
        y = complex(y,0);
    end
    for i=1:prod(sizeB(sepDim:end))
        slice = DataContainer.io.memmap.serial.FileReadLeftSlice...
            (B.pathname,i);
        slice = reshape(slice,sizeA(2),numel(slice)/sizeA(2));
        prodz = mldivide(A,slice);
        DataContainer.io.memmap.serial.FileWriteLeftSlice...
            (y.pathname,prodz,i);
    end    
end
