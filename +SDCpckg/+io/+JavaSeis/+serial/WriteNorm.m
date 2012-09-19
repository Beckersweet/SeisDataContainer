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
% TEST Case1 : Algo
%x = [250,30,100,10]
%slice(1) = 67 ;
%slice(2) = 1 ;
%range(1) = 1 ; % range is +1 compared to java
%range(2) = 2 ;

%TEST Case2
x = [3,3,4,5] ;
slice(1) = 2 ;
slice(2) = 3 ;
range(1) = 1 ; % range is +1 compared to java
range(2) = 2 ;

%TEST Case3
%x = [3,3,4,5] ;
%slice = [] ;
%range(1) = 1 ; % range is +1 compared to java
%range(2) = 2 ;

header = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'double',0)
SDCpckg.io.JavaSeis.serial.FileAlloc('newtest',header) ;
SDCpckg.io.JavaSeis.serial.FileWrite('newtest',x) ;
% [myslice header] = SDCpckg.io.JavaSeis.serial.FileReadLeftSlice('newtest',slice) ;
[mychunk header] = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk('newtest',range,slice) ;

y = mychunk 
mysize = size(mychunk) 

% Matlab norm (2-norm)
MATnorm = norm(mychunk) % works for a 2d chunk only
% JS norm (To be defined/completed)
JSnorm = beta.javaseis.examples.io.norm2.fileNorm(mysize(2),mychunk) 

% Convert Matrix to Vector
row1 = mychunk(1,:)
row2 = mychunk(2,:)
row3 = mychunk(3,:)
matarr1D = [row1,row2,row3]

% Jama norm (2-norm) - Matrix as input
tStart1 = tic ;
mat = jama.Matrix(mychunk)
JamaNorm = mat.norm2()
tElapsed1 = toc(tStart1)

% JAMA norm (2-norm) - Vector as input
tStart2 = tic ;
mat = jama.Matrix(matarr1D,3) 
JAMAmat = mat.norm2()
tElapsed2 =toc(tStart2) % Vector norm is faster than Matrix Norm. 






