function y = mldivide(A,B,swp)
    if isscalar(A) && isscalar(B)
        y = oMatCon.zeros(1);
        y.putFile({1},A.getFile({1})\B.getFile({1}));
    else
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

        % checking sizes    
        sizeA = size(A);
        if(length(sizeA) > 2 || sizeA(1) ~= sizeA(2))
            error('Error: First parameter should be 2D and n-by-n');
        end
        % Reading input header
        headerB   = DataContainer.io.memmap.serial.HeaderRead(path(B.pathname));
        sizeB     = headerB.size;
        
        if(sizeA(2) == sizeB(1))
            sepDim = 2;
        else
            sepDim = 0;    
            for i=1:length(sizeB)
                if(prod(sizeB(1:i)) == sizeA(2))
                    sepDim = i+1;
                    break;
                end
            end
        end

        if(sepDim == 0)
            error('Bad division: Dimensions are not matching');
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
                (path(B.pathname),i);
            slice = reshape(slice,sizeA(2),numel(slice)/sizeA(2));
            prodz = mldivide(double(A),slice);
            DataContainer.io.memmap.serial.FileWriteLeftSlice...
                (path(y.pathname),prodz,i);
        end    
    end
end
