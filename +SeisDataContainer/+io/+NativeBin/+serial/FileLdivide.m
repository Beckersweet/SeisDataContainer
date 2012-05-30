function FileLdivide(A,B,dirnameOut)
%FILELDIVIDE Allocates file space and does the element-by-element division
%            of the two input files
%   FileLdivide(A,B,DIRNAMEOUT)
%
%   A,B        - Either string specifying the directory name of the input
%                files or a scalar
%   DIRNAMEOUT - A string specifying the output directory name
%    

import SeisDataContainer.io.*
import SeisDataContainer.utils.*
import SeisDataContainer.io.NativeBin.serial.*

isFileClean(dirnameOut);
global SDCbufferSize;

if(isnumeric(B))
    temp = B;
    B    = A;
    A    = temp;
end

if isscalar(A)
    A = A*ones(size(B));
end

if(isnumeric(A))
    if(~isdir(B))
        error('Fail: Wrong input type')
    end
    isFileClean(B);
    % Reading input headers
    headB     = HeaderRead(B);
    headOut   = headB;

    % Set byte size
    bytesize  = getByteSize(headOut.precision);

    FileAlloc(dirnameOut,headOut);
    xsize        = headOut.size;
    headOut.size = [1 prod(xsize)];
    HeaderWrite(dirnameOut,headOut);

    % Set the sizes
    dims      = [1 prod(xsize)];
    reminder  = prod(xsize);
    maxbuffer = SDCbufferSize/bytesize;
    rstart    = 1;

    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;            
        r2   = DataReadLeftChunk...
            (B,'real',dims,[rstart rend],[],headB.precision,...
            headB.precision);
        if headB.complex
        dummy = DataReadLeftChunk...
            (B,'imag',dims,[rstart rend],[],headB.precision,...
            headB.precision);
            r2 = complex(r2,dummy);
        end
        FileWriteLeftChunk...
            (dirnameOut,minus(A(rstart:rend),r2),[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    headOut.size = xsize;
    HeaderWrite(dirnameOut,headOut);
    
elseif(isdir(A))
    if(~isdir(B))
        error('Fail: Wrong input type')
    end
    isFileClean(A);
    isFileClean(B);
    % Reading input headers
    headA   = HeaderRead(A);
    headB   = HeaderRead(B);
    if(headA.size ~= headB.size)
            error('Epic fail: The inputs does not have the same size')
    end
    headOut = headA;

    % Set byte size
    bytesize  = getByteSize(headOut.precision);

    FileAlloc(dirnameOut,headOut);
    xsize        = headOut.size;
    headOut.size = [1 prod(xsize)];
    HeaderWrite(dirnameOut,headOut);

    % Set the sizes
    dims      = [1 prod(xsize)];
    reminder  = prod(xsize);
    maxbuffer = SDCbufferSize/bytesize;
    rstart = 1;

    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        r1 = DataReadLeftChunk...
            (A,'real',dims,[rstart rend],[],headA.precision,...
            headA.precision);
        if headA.complex
        dummy = DataReadLeftChunk...
            (A,'imag',dims,[rstart rend],[],headA.precision,...
            headA.precision);
            r1 = complex(r1,dummy);
        end
        r2 = DataReadLeftChunk...
            (B,'real',dims,[rstart rend],[],headB.precision,...
            headB.precision);
        if headB.complex
        dummy = DataReadLeftChunk...
            (B,'imag',dims,[rstart rend],[],headB.precision,...
            headB.precision);
            r2 = complex(r2,dummy);
        end
        FileWriteLeftChunk...
            (dirnameOut,ldivide(r1,r2),[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    headOut.size = xsize;
    HeaderWrite(dirnameOut,headOut);
else
    error('Fail: Wrong input type')
end