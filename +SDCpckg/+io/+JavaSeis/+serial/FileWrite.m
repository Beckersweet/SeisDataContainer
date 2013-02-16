function FileWrite(dirname,x,varargin)
%FILEWRITE Writes serial data to binary file
%   Create a 5D MultiArray 
%  
%   FileWrite(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
%   the real serial array X into DIRNAME/FILENAME.
%
%   DIRNAME - A string specifying the directory name
%   DATA    - Non-distributed float data
%
%   Optional argument is either of:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%                    defaults to type of x
%                    Supported precisions: 'double', 'single'
%   HEADER_STRUCT  - An optional header struct as created
%                    by DataContainer.basicHeaderStructFromX
%                    or DataContainer.basicHeaderStruct
%
%   Warning: If the specified dirname exists, it will be removed.
error(nargchk(2, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(x), 'data must be float')
%assert(~isdistributed(x), 'data must not be distributed')

% Import External Functions
import edu.mines.jtk.util.*;

% Open Seisio File Structure
seisio = beta.javaseis.io.Seisio(dirname);
seisio.open('rw');

% Define number of Hypercubes, Volumes, Frames & Traces
AxisLengths = seisio.getGridDefinition.getAxisLengths() ;

% Get number of dimensions and set position accordingly
dimensions = seisio.getGridDefinition.getNumDimensions() 
position = zeros(dimensions,1);

% Test: Check Position
  checkpos = beta.javaseis.array.Position.checkPosition(seisio,position) ;

if checkpos

    fprintf('%s\n','checkpos is TRUE');
    
end    

% Create a format array with size of AxisLenghts
% as argument of the factory function 
% JS 2 MAT Conversion
y = ones(AxisLengths') ;
formatgridsize = size(y) ;

% if less than 4D: Reshape to 4D
  if length(formatgridsize) < 4
     for nullDim=length(formatgridsize):3
  
      formatgridsize(nullDim+1) = 1 ;
     
     
     end
  end
  

% formatgridsize works while gridsize or AxisLengths do not work as arguments of factory

% Define an array that will contain more than 2D datasets
% grid_multiarray = beta.javaseis.array.MultiArray.factory(dimensions,beta.javaseis.array.ElementType.DOUBLE,1,formatgridsize);

% TEST: Fill a test x with ones (size of formatgridsize)  
% It should be filled with DataCon or JS Call
%SeisDataContainer_init ;
%ConDir() ;
%test = rand(x);
%testx = complex(test,1) 
%testxsize = size(testx)
testx = x ;

% Loop implementation
% Loop over 1 hypercube
for hyp=1:1
 %loop over volumes 
 for vol=1:formatgridsize(4)
    % vola = formatgridsize(4) ;
     position(4) = vol-1;   
     %loop over frames
      for frm=1:formatgridsize(3)
         % frmb = formatgridsize(3) ;
          position(3) = frm-1;
         
          %Store matrixofframes - Java format (right slice contiguous in memory)
          %matrixofframes(frm,:,:) = testx(:,:,frm,vol) 
           a = testx(:,:,frm,vol) ;
          
          % matrixofframes(frm,:,:) = a' ;
           seisio.setTraceDataArray(a');
           seisio.setPosition(position);
           seisio.writeFrame(size(a,2));
          
     end
      %Store matrixofvolumes - For Imultiarray
      %matrixofvolumes(vol,:,:,:) = matrixofframes ;
      
      
 end
 
 %Store 1 Hypercube - For Imultiarray Only
 %seisio.setPosition(position);
 %matrixofhypercubes(1,:,:,:,:) = matrixofvolumes  
 %grid_multiarray.putHypercube(matrixofhypercubes,position) ;
 
 
end

  % Debugging
    checkpos = beta.javaseis.array.Position.checkPosition(seisio,position) ;
              
    if checkpos

    fprintf('%s\n','checkpos is TRUE');
    pos2 = position ;
    
    end 

  
  % DEBUGGING - For IMultiarray
  % getarrayLength = grid_multiarray.getArrayLength() 
  % getDim = grid_multiarray.getDimensions()
  % getShape = grid_multiarray.getShape()
  % getElemCount = grid_multiarray.getElementCount()
  % getFrameLenght = grid_multiarray.getFrameLength()
  % getVolumeLenght = grid_multiarray.getVolumeLength()
  % getHypL = grid_multiarray.getHypercubeLength()
  % getHypC = grid_multiarray.getTotalHypercubeCount()
  % getVolC = grid_multiarray.getTotalVolumeCount()
  % getFrmC = grid_multiarray.getTotalFrameCount()
  % getTraC = grid_multiarray.getTotalTraceCount()
  % getSamC = grid_multiarray.getTotalSampleCount()
  % getTotElC = grid_multiarray.getTotalElementCount()
  % Index = grid_multiarray.index(position) 
   
   % make sure arrays of samples have been filled
    
   
   
   % Debugging 
   if seisio.frameExists(position)
       
       fprintf('%s\n','FRAME'); 
       
       seisio.getTracesInFrame() ;
       seisio.getTraceDataArray() ;
       
   else
       
      fprintf('%s\n','NO FRAME'); 
       
   end    
   
   %make sure that _traceData is allocated (sio.create())
   %make sure backup_Array is allocated
   
   % Bebugging
   % arraycopy = beta.javaseis.array.MultiArray(grid_multiarray)
   % arraycopy.getShape()
   % grid_multiarray.transpose(beta.javaseis.array.TransposeType.T4321)
   % grid_multiarray.getShape()
  
   % Write 1 Hypercube - For IMultiarray Only
   % seisio.writeMultiArray(grid_multiarray,position) ; % do I get the array at the right position ? is my array correctly filled ? 
   % Null pointer Exeption line 409 in beta.javaseis.array.BigArrayJava1D.getArray:System.arraycopy(..source_array...dest_array..)
           % The destination array "dest_array" has not been allocated
           % Need to use Abstract function:setLength to allocate "dest_array"
           % setLength in IBigArray is overriden in BigArrayJava1D
           % Issue not fixed
           % Should I use beta.javaseis.array.arrayutil.arraycopy instead
           % of native method

    
   seisio.close();
   
end
