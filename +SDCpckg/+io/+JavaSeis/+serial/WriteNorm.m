function OOCNorm = WriteNorm(dirname,x)

% Load dynamic libraries
 javaaddpath('/Users/bcollignon/Documents/workspace/dhale-jtk-78bca79.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/betajavaseis1819.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/jama.jar');
 

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

% Use JS/Java calls
% TEST Case : Algo
x = [250,30,100,10]
slice(1) = 67 ;
slice(2) = 1 ;
range(1) = 1 ; % range is +1 compared to java
range(2) = 2 ;
header = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'double',0)
SDCpckg.io.JavaSeis.serial.FileAlloc('newtest',header) ;
SDCpckg.io.JavaSeis.serial.FileWrite('newtest',x) ;
[myslice header] = SDCpckg.io.JavaSeis.serial.FileReadLeftSlice('newtest',slice) ;
[mychunk header] = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk('newtest',range,slice) ;
mysize = size(mychunk) 
% Matlab norm (2-norm)
MATnorm = norm(mychunk)
% JS norm (To be defined/completed)
JSnorm = beta.javaseis.examples.io.norm2.fileNorm(mysize(2),mychunk) 
% Jama norm (2-norm)
mat = jama.Matrix(mychunk)
JamaNorm = mat.norm2()





