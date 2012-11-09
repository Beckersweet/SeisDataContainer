function OOCNorm = TestNorm_bis(normexp)
% Full File Norm
% Compare 3 methods to calculate Norm2
% The 3 norm results must be equal: 
% JSnorm == MatNorm == JSnorm2

% Load dynamic libraries
 javaaddpath('/Users/bcollignon/Documents/workspace/dhale-jtk-78bca79.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/betajavaseis1819.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/jama.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/javaSeisExample_test2.jar');
 

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
%x = [3,3,4,5] ;
%slice(1) = 2 ;
%slice(2) = 3 ;
%range(1) = 1 ; % range is +1 compared to java
%range(2) = 2 ;

%TEST Case3
%x = [3,3,4,5] ;
%slice = [] ;
%range(1) = 1 ; % range is +1 compared to java
%range(2) = 2 ;

%Test case4 ;
x  = [14,12,5] ;
slice = [] ;
range(1) = 1;
range(2) = 5;

if (exist('newtest','dir') == 1) 
SDCpckg.io.isFileClean('newtest');
end

header = SDCpckg.io.JavaSeis.serial.HeaderWrite(x,'double',0);
SDCpckg.io.JavaSeis.serial.FileAlloc('newtest',header) ;
% fill x
x = rand(x) ;
SDCpckg.io.JavaSeis.serial.FileWrite('newtest',x) ;
% [myslice header] = SDCpckg.io.JavaSeis.serial.FileReadLeftSlice('newtest',slice) ;
[mychunk header] = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk('newtest',range,slice) ;

% Dimension
dimensions = size(mychunk);
y = mychunk ;
mysize = size(y) ;

% Matlab norm (2-norm)
%MATnorm = norm(mychunk) % works for a 2d chunk only

sio = beta.javaseis.io.Seisio('newtest');
sio.open('r');

Axis = sio.getGridDefinition().getAxisLengths() ;

normComp = 0.0 ; 
%normexp = -999 ;
 
%for(myslice_m to myslice_m+n)
 for j=1:Axis(4) 
	 for i=1:Axis(3)  
	
	    	pos(1) = 0;
            pos(2) = 0;
            pos(3) = i-1;
            pos(4) = j-1;
            
            % JAVA CALL
            
            if (normexp == 0 || normexp == 1 || normexp == 2)
            
               normComp = normComp + beta.javaseis.examples.io.PartNorm.sliceNormComponent(sio,pos,normexp);
            
            else
                 
               normComp = beta.javaseis.examples.io.PartNorm.sliceNormComponent(sio,pos,normexp);
                    
            end        
       end
 end
 
 
if (normexp == 0 || normexp == 1 || normexp == 2)      
JSnorm = normComp^(1/double(normexp)) 
else
JSnorm = normComp     
end    

%JSnorm = sqrt(normComp) 

% Full File Norm
%tStart1 = tic 
MatNorm = SDCpckg.io.JavaSeis.serial.FileNorm('newtest',normexp,'double')
%tElapsed1 = toc(tStart1)
% Java call - Much faster
%tStart2 = tic 
JSnorm2 = beta.javaseis.examples.io.FileNorm.Norm('newtest',normexp) 
%tElapsed2 =toc(tStart2)       

% JSnorm must be equal to MatNorm must be equal to JSnorm2 
% if not equal , then there is a problem ..

if (exist('newtest2','dir') == 1) 
SDCpckg.io.isFileClean('newtest2');
end

%Test case4 ;
x2  = [14,12,5] ;
slice = [] ;
range(1) = 1;
range(2) = 5;

header2 = SDCpckg.io.JavaSeis.serial.HeaderWrite(x2,'double',0);
SDCpckg.io.JavaSeis.serial.FileAlloc('newtest2',header2) ;
% fill x
x2 = rand(x2) ;
% Write in JS file
SDCpckg.io.JavaSeis.serial.FileWrite('newtest2',x2) ;

% Return a multi-dimensional Java array to be used in FilePlus.m
beta.javaseis.examples.io.FileAdd.add('newtest','newtest2');

sio.close();








