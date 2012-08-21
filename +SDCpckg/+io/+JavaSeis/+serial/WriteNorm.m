function OOCNorm = WriteNorm(dirname,x)

% Import External Java functions
% import java.io.RandomAccessFile.* ;

% Make Directory
%if isdir(dirname)
%   rmdir(dirname,'s');
%end
%status =  mkdir(dirname);
%assert(status,'Fatal error while creating directory %s',dirname);

% Create a brand new file for serial I/O 
% delete('NormFile');
% java.io.RandomAccessFile('NormFile','rw');

% Create a Java object array
% Java Arr = array of arrays
javaArr = javaArray('java.lang.Double',4,5)

% Fill Array
for m=1:4
    for n=1:5

        javaArr(m,n) = java.lang.Double(m*n) ; 

    end
end

% TEST
test = javaArr
raw1 = javaArr(1)
raw2 = javaArr(2)
col1 = javaArr(:,1)
col2 = javaArr(:,2)

% Convert Java to Mat - Easy
j2mArray = cell2mat(cell(javaArr))
%j2mArray = arrayfun(@(x)x,javaArr)  

% Calc norm of column vector
newcol1 = j2mArray(:,1)
n1 = norm(newcol1)

% Convert Mat to Java - Not easy


% Create Java Frame Object
% frame = java.awt.Frame('testframe')
