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

% Set up the Seisio object
import beta.javaseis.io.Seisio.*;    
seisio = beta.javaseis.io.Seisio( dirname );
seisio.open('rw');

% Read header
% header = DataContainer.io.memmap.serial.HeaderRead(dirname);

% Get number of dimensions and set position accordingly
%dimensions = seisio.getGridDefinition.getNumDimensions();
%assert(isequal(dimensions,2)|isequal(dimensions,3)|isequal(dimensions,4)|...
 %   isequal(dimensions,5), 'Data in js file must have dimensions 2<=n<=5.')
%position = zeros(1,dimensions)
%position(dimensions) = slice

% Write file
%TEST = 'write'
%x=X';
%x=X'
%seisio.usesProperties(false);
%seisio.setTraceDataArray(x);
%seisio.setPosition(position);
%seisio.writeFrame(size(x,1));

% Read header
header = SDCpckg.io.JavaSeis.serial.HeaderRead(dirname)

% Get number of dimensions and set position accordingly
dimensions = header.dims ;
position = zeros(dimensions,1);

% Get Shape
shape = header.size 

%assert(isequal(slice,[]), 'Code only completed for slice == []');
%asser(isequal(dimensions, 3), 'Code only completed for 3 dimensions');
position = zeros(dimensions,1)

testx = X 

size(testx)


if isequal(slice,[]) == 0 
   
   jstart = slice(2) 
   jend = jstart 
   istart = slice(1) 
   iend = istart 
   
else 
   
   
   jstart = 1 
   jend = shape(4) 
   istart = 1 
   iend = shape(3) 
   
end

% Loop implementation
% Loop over 1 hypercube
for hyp=1:1
 
 %loop over volumes 
 for vol=jstart:jend  
     position(4) = vol-1 
     myvol = vol
     %loop over frames
      for frm=istart:iend 
          position(3) = frm-1
          myfrm = frm
          %Store matrixofframes - Java format (right slice contiguous in memory)
          %matrixofframes(frm,:,:) = testx(:,:,frm,vol) 
         
          if isequal(slice,[]) == 0
            
             % if frame exist 
             if seisio.frameExists(position)
       
                fprintf('%s\n','FRAME exist'); 
       
                seisio.getTracesInFrame() ;
                seisio.getTraceDataArray() ;
             
                a = testx(:,:,1,1) ;
       
             else
       
               fprintf('%s\n','NO FRAME'); 
               a = testx(:,:,frm,vol) ;
       
             end
             
          else
              a = testx(:,:,frm,vol) 
          end    
          
          %a = testx(:,:,frm,vol) 
          % a = testx(:,:,1,1)
           matrixofframes(frm,:,:) = a' 
           seisio.setTraceDataArray(a');
           seisio.setPosition(position);
           seisio.writeFrame(size(a,2));
          
     end
     
      
 end
 

end

end
