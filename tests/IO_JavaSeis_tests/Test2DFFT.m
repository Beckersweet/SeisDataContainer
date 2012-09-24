function Test2DFFT(dirname)

% Load dynamic libraries
% javaaddpath('/Users/bcollignon/Documents/workspace/dhale-jtk-78bca79.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/betajavaseis1819.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/jama.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/javaSeisExample.jar');
 
% import jama.Matrix.* ;

% x = frame of traces
%[x header] = beta.javaseis.io.javaseis.serial.FileRead(dirname) ;

% TEST Case
% Set Shape for the 2D JAVA array (ARRAY OF ARRAYS: 
% double[][] array = new double[][] { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9
% })

% MATLAB
% TEST: Traces for frame #1
 arr1 = [1,2,3]; 
 arr2 = [4,5,6];
 arr3 = [7,8,9];

matarr = [arr1;arr2;arr3];

matarr1D = [arr1,arr2,arr3]

% Create an N-Dimensional FFT with N=3
A = opDFT(3)
array = matarr'*A

% Allocate an array long enough to hold the trace 
% myallocarray

% Fill the array with real trace
realtracearray = real(array)
% Fill the array with complex trace
imagtracearray = imag(array)

% Transpose arrays (JAVA format)
a = realtracearray(:,1) ;
b = realtracearray(:,2) ;
c = realtracearray(:,3) ;

aa = imagtracearray(:,1) ;
bb = imagtracearray(:,2) ;
cc = imagtracearray(:,3) ;

JAVa =a'
JAVb =b'
JAVc =c'

JAVaa = aa'
JAVbb = bb'
JAVcc = cc'

% TEST
% Create a Java object array
% Java Arr = array of arrays
javaArr = javaArray('java.lang.Double',3,3)

% Fill Array
for m=1:3
    for n=1:3

        javaArr(m,n) = java.lang.Double(m*n) ; 

    end
end

% TEST
test = javaArr
raw1 = javaArr(1)
raw2 = javaArr(2)
col1 = javaArr(:,1)
col2 = javaArr(:,2)


mat = jama.Matrix(matarr1D,3) 
JAMAmat = mat.norm2()

% 1DFFT on each axis 
% Get the real trace
realTrace = JAVaa
% Compute the window transform
fftr = beta.javaseis.fft.SeisFft 
fftr.beta.javaseis.fft.FftNd.ffts(1).realToComplex(realTrace) ;
fftr.beta.javaseis.fft.FftNd.ffts(0).complexForward(realTrace) ;
% Store the window transform
sio.putTrace(realTrace,position) ;


% for trc=1:nbtrace 
   
   % Get the real trace, transform and replace 
   % sio.getTrace(myallocarray,position) ;   
   
   % Forward Transform
   % fftParms[0].getFft().realToComplex(myallocarray)

   % Store back into the complex array
   % sio.putTrace(myallocarray,position)

   % Transpose arrays / the transpose can be done in the multiarray object
   % What is the faster way ? in sio or in multiarray ? 
   % sio.transpose(TransposeType.T213);

   % Get the complex trace, transform and replace 
   % sio.getTrace(myallocarray,position) ;
   % fftParms[1].getfft().complexForward(c) ;
   % sio.putTrace(myallocarray,position)

%end

end