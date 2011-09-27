function y = mtimes(A,B,swp)

    % unswap
    if nargin == 3 && strcmp(swp,'swap')
        tmp = B;
        B   = A;
        A   = tmp;
        clear('tmp');
    end

    % Multiply
    if ~isa(A,'opSpot')
        error('First input should be an operator')
    else
        sizeA = size(A);
        if(length(sizeA) > 2)
            error('Fail: Wrong size for first parameter');
        end
        % Reading input header
        headerB   = DataContainer.io.memmap.serial.HeaderRead(B.dirname);
        sizeB     = headerB.size;
        
        sepDim = 0;    
        for i=1:size(sizeB)
            if(prod(sizeB(1:i)) == sizeA(2))
                sepDim = i+1;
                break;
            end
        end
        
        if(sepDim == 0)
            error('Bad multiplication');
        end
        
        % Creating the output dataContainer
        sizeOut    = [sizeA(1) sizeB(sepDim:end)];
        y          = oMatCon.zeros(sizeOut);
        prod(sizeB(sepDim+1:end));
        if(B.header.complex)
            y = complex(y,0);
        end
        
        for i=1:prod(sizeB(sepDim+1:end))
            slice = DataContainer.io.memmap.serial.FileReadLeftSlice...
                (B.dirname,i);
            prodz = mtimes(A,slice);
            DataContainer.io.memmap.serial.FileWriteLeftSlice...
                (y.dirname,prodz,i);
        end
    end
end
