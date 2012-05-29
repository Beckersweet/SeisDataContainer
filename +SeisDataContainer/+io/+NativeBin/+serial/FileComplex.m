function FileComplex(A,B,dirnameOut)
%FILECOMPLEX Allocates file space and makes the complex of two input files
%   FileComplex(A,B,DIRNAMEOUT)
%
%   A,B        - Either string specifying the directory name of the input
%                files or a scalar
%   DIRNAMEOUT - A string specifying the output directory name
%

% Import class packages
import SeisDataContainer.io.*
import SeisDataContainer.io.NativeBin.serial.*
import SeisDataContainer.utils.*

isFileClean(dirnameOut);
global SDCbufferSize;

% Taking care of the complex part
if(isscalar(B))
    isFileClean(A);
    headerA = HeaderRead(A);
    if(headerA.complex)
        error('Epic fail: the first input is complex')
    end        
    % Set byte size
    bytesize          = getByteSize(headerA.precision);

    headerOut         = headerA;
    xsize             = headerOut.size;
    headerOut.complex = 1;
    FileAlloc(dirnameOut,headerOut);        
    headerOut.size    = [1 prod(xsize)];
    HeaderWrite(dirnameOut,headerOut);

    % Set the sizes
    reminder  = prod(xsize);
    maxbuffer = SDCbufferSize/bytesize;
    rstart = 1;

    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend   = rstart + buffer - 1;
        r1     = ones(1,buffer);
        r1     = r1*B;
        FileWriteLeftChunk...
            (dirnameOut,r1,[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    movefile([dirnameOut filesep 'real'],[dirnameOut filesep 'imag']);
elseif(isdir(B))
    isFileClean(B);
    if(~isreal(A))
        error('Epic fail: the firt input is complex')
    end
    headerB = HeaderRead(B);
    if(headerB.complex)
        error('Epic fail: the second input is complex')
    end
    FileCopy(B,dirnameOut)
    movefile([dirnameOut filesep 'real'],[dirnameOut filesep 'imag'])        
else
    error('Wrong type of input for B')
end
    
% Taking care of the real part
if(isscalar(A))
    isFileClean(B);
    headerB = HeaderRead(B);
    % Set byte size
    bytesize       = getByteSize(headerB.precision);

    headerOut      = headerB;
    xsize          = headerOut.size;
    FileCopy(B,dirnameOut)
    headerOut.size    = [1 prod(xsize)];
    HeaderWrite(dirnameOut,headerOut);

    % Set the sizes
    reminder  = prod(xsize);
    maxbuffer = SDCbufferSize/bytesize;
    rstart = 1;

    while (reminder > 0)
        buffer = min(reminder,maxbuffer);
        rend   = rstart + buffer - 1;
        r1     = ones(1,buffer);
        r1     = r1*A;
        FileWriteLeftChunk...
            (dirnameOut,r1,[rstart rend],[]);
        reminder = reminder - buffer;
        rstart   = rend + 1;
    end
    headerOut.size    = xsize;
    headerOut.complex = 1;
    HeaderWrite(dirnameOut,headerOut);
elseif(isdir(A))
    isFileClean(A);
    headerA = HeaderRead(A);
    if(headerA.complex)
        error('Epic fail: the firt input is complex')
    end
    FileCopy(A,dirnameOut)
    headerOut = headerA;
    headerOut.complex = 1;
    HeaderWrite(dirnameOut,headerOut);
else
    error('Wrong type of input for A')
end