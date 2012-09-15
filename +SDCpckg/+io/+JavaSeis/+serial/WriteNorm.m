function OOCNorm = WriteNorm(dirname,x)

% Load dynamic libraries
 javaaddpath('/Users/bcollignon/Documents/workspace/dhale-jtk-78bca79.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/betajavaseis1819.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/jama-1.0.2.jar');
 

% Import External Java functions
% import java.io.RandomAccessFile.* ;
% import edu.mines.jtk.lapack.* ;
% import jama.* ;
% L = import
 
% Make Directory
%if isdir(dirname)
%   rmdir(dirname,'s');
%end
%status =  mkdir(dirname);
%assert(status,'Fatal error while creating directory %s',dirname);

% Create a brand new file for serial I/O 
 delete('NormFile');
 myfile = java.io.RandomAccessFile('NormFile','rw');

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
myfile.write(n1) 
myfile.close()

% Use JS/Java calls
% TEST Case : Algo
x = [23,34,6,67]
slice(1) = 4 ;
slice(2) = 5 ;
range(1) = 6 ;
range(2) = 8 ;
header = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'double',0)
SDCpckg.io.JavaSeis.serial.FileAlloc('newtest',header) ;
SDCpckg.io.JavaSeis.serial.FileWrite('newtest',x) ;
[myslice header] = SDCpckg.io.JavaSeis.serial.FileReadLeftSlice('newtest',slice) ;
[mychunk header] = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk('newtest',range,slice) ;
nbTrc = size(mychunk) ;
norm = beta.javaseis.examples.io.norm2.fileNorm(nbTrc(2),mychunk) ;


