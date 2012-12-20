function FileWriteLeftSlice(dirname,X,slice)
%FILEWRITELEFTSLICE  Write serial left slice data to binary file
%
% Edited for JavaSeis by Trisha, Barbara
%
%   FileWriteLeftSlice(DIRNAME,DATA,SLICE) writes
%   the real serial left slice into DIRNAME/FILENAME.
%
%   DIRNAME  - A string specifying the directory name
%   DATA     - Non-distributed float data
%   SLICE    - A vector specifying the slice index
%
%   Warning: If the specified dirname exists, it will be removed
error(nargchk(3, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(X), 'data must be float')
% assert(~isdistributed(x), 'data must not be distributed')
% Does not exist for this type - need to redo.
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

javaaddpath('/Users/bcollignon/Documents/workspace/betajavaseis1819.jar');

% Set up the Seisio object
import beta.javaseis.io.Seisio.*;    
seisio = beta.javaseis.io.Seisio( dirname );
seisio.open('rw');

% Get number of dimensions and set position accordingly
header.dims = seisio.getGridDefinition.getNumDimensions() ;

% Define number of Hypercubes, Volumes, Frames & Traces
header.size = seisio.getGridDefinition.getAxisLengths() ;

% Get number of dimensions and set position accordingly
dimensions = header.dims ;
position = zeros(dimensions,1);

% Get Shape
shape = header.size ;

position = zeros(dimensions,1);

testx = X ;

size(testx);


if isequal(slice,[]) == 0 
   
   jstart = slice(2) ;
   jend = jstart ;
   istart = slice(1) ;
   iend = istart ;
   
else 
   
   
   jstart = 1 ;
   jend = shape(4) ;
   istart = 1 ;
   iend = shape(3) ;
   
end

% Loop implementation
% Loop over 1 hypercube
for hyp=1:1
 
 %loop over volumes 
 for vol=jstart:jend  
     position(4) = vol-1 ;
    
     %loop over frames
      for frm=istart:iend 
          position(3) = frm-1;
          
          %Store matrixofframes - Java format (right slice contiguous in memory)
          %matrixofframes(frm,:,:) = testx(:,:,frm,vol) 
         
          if isequal(slice,[]) == 0
            
             % if frame exist 
             if seisio.frameExists(position)
       
               % fprintf('%s\n','FRAME exist'); 
       
                seisio.getTracesInFrame() ;
                seisio.getTraceDataArray() ;
             
                a = testx(:,:,1,1) ;
       
             else
       
              % fprintf('%s\n','NO FRAME'); 
               a = testx(:,:,frm,vol) ;
       
             end
             
          else
              a = testx(:,:,frm,vol) ;
          end    
          
          
           matrixofframes(frm,:,:) = a' ;
           seisio.setTraceDataArray(a');
           seisio.setPosition(position);
           seisio.writeFrame(size(a,2));
          
     end
     
      
 end
 

end

end
