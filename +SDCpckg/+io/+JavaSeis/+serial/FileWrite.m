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

%javaaddpath('/Users/bcollignon/Documents/workspace/betajavaseis1819.jar');

% Import External Functions
import edu.mines.jtk.util.*;
%import beta.javaseis.io.Seisio.*;

% Open Seisio File Structure
seisio = org.javaseis.io.Seisio(dirname);
seisio.open('rw');

% Define number of Hypercubes, Volumes, Frames & Traces
AxisLengths = seisio.getGridDefinition.getAxisLengths() ;

% Get number of dimensions and set position accordingly
dimensions = seisio.getGridDefinition.getNumDimensions() ;
position = zeros(dimensions,1);

% Test: Check Position
%  checkpos = org.javaseis.array.Position.checkPosition(seisio,position) ;

%if checkpos

%    fprintf('%s\n','checkpos is TRUE');
    
%end    

% Create a format array with size of AxisLenghts
y = ones(AxisLengths') ;
formatgridsize = size(y) ;

% if less than 4D: Reshape to 4D
  if length(formatgridsize) < 4
     for nullDim=length(formatgridsize):3
  
      formatgridsize(nullDim+1) = 1 ;
     
     
     end
  end
  
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
      
      
 end
 
end
   
   % Debugging 
   %if seisio.frameExists(position)
       
       %fprintf('%s\n','FRAME'); 
       
       %seisio.getTracesInFrame() ;
       %seisio.getTraceDataArray() ;
       
   %else
       
      %fprintf('%s\n','NO FRAME'); 
       
   %end    
    
   seisio.close();
   
end
