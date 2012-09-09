function Calc2DFFT(dirname)

% Load dynamic libraries
% javaaddpath('/Users/bcollignon/Documents/workspace/dhale-jtk-78bca79.jar');
% javaaddpath('/Users/bcollignon/Documents/workspace/betajavaseis1819.jar');

% import beta.javaseis.fft.IFFT ;

% x = frame of traces

%[x header] = beta.javaseis.io.javaseis.serial.FileRead(dirname) ;

%nbVolumes = header.size(4) ;
%nbFrames = header.size(3) ;
%nbTraces = header.size(2) ;
%nbSamples = header.size(1) ;

% Set Shape for the 2D JAVA array (ARRAY OF ARRAYS: 
% double[][] array = new double[][] { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9
% })

% MATLAB
% TEST: Traces for frame #1
 arr1 = [1,2,3]; 
 arr2 = [4,5,6];
 arr3 = [7,8,9];

matarr = [arr1;arr2;arr3];

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

% JAVASEIS
% TESTFftNd
% FFT for IMultiArray (distributed FS)
% shape = [16,8,7,11,5]
% pad =  [0,0,0,0,0]
% fnd = beta.javaseis.fft.FftNd(shape,pad,beta.javaseis.fft.IFFT.Type.REAL)
% da = beta.javaseis.distributed.DistributedArray.DistributedArray(pc,2,fnd.beta.javaseis.fft.FftNd.getForwardShape());
% da.beta.javaseis.distributed.DistributedArray.setShape(1,shape);
% fnd.beta.javaseis.fft.FftNd.forward(da) ;
% fnd.beta.javaseis.fft.FftNd.inverse(da) ;

% 1DFFT the given axis, numbering from 0
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