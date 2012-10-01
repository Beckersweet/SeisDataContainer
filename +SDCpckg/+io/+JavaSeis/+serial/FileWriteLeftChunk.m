function FileWriteLeftChunk(dirname,X,range,slice)
%FILEWRITELEFTCHUNK Writes serial left chunk data to binary file
%
% Edited for JavaSeis by Trisha, Barbara
%
%   FileWriteLeftChunk(DIRNAME,DATA,RANGE,SLICE) writes
%   the real serial left chunk into DIRNAME/FILENAME.
%
%   DIRNAME - A string specifying the directory name
%   DATA    - Non-distributed float data
%   RANGE   - A vector with two elements representing the range of
%             data that we want to write            
%   SLICE   - A vector specifying the slice
%
%   Warning: If the specified dirname exists, it will be removed.
error(nargchk(4, 4, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
%assert(~isdistributed(x), 'data must not be distributed')
% No distribution yet. This function is not defined.
assert(isvector(range)&length(range)==2, 'range index must be a vector with 2 elements')
assert(isvector(slice)|isequal(slice,[]), 'slice index must be a vector')

% Set up the Seisio object
import beta.javaseis.io.Seisio.*;    
seisio = beta.javaseis.io.Seisio( dirname );
seisio.open('rw');

% Get number of dimensions and set position accordingly
dimensions = seisio.getGridDefinition.getNumDimensions();
%assert(isequal(slice,[]), 'Code only completed for slice == []');
%asser(isequal(dimensions, 3), 'Code only completed for 3 dimensions');
    
position = zeros(dimensions,1);

% Write file
%for i = range(1)+1:range(2)+1
%    position(dimensions)=i-1;
%    data = x(:,:,i);
%    data=data';
%    seisio.setTraceDataArray(data);
%    seisio.setPosition(position);
%    seisio.writeFrame(size(data,1));% writes one 2D "Frame"
%end

%    seisio.close();

% Global variable
global globalTable


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

size_X = size(testx)

testzeros = zeros(size(X)) ;

% RangeCount
rangeCount=range(2)-range(1)+1;

if isequal(slice,[]) == 0 
   
   if(size(slice) == 2) 
    
   jstart = slice(2) 
   jend = jstart 
   istart = slice(1) 
   iend = istart 
   
   else
      
   jstart = 1 ;
   jend = jstart ;
   istart = slice(1);
   iend = istart ;
       
   end
   
   
   
   
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
     myvol = vol ;
     %loop over frames
      for frm=istart:iend 
          position(3) = frm-1
          myfrm = frm ;
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
              a = testx(:,:,frm,vol) ;
          end    
          
           size_a = size(a) 
           size_aT = size(a')
          
           matrixofframes(frm,:,:) = a' ;
           globalTable(frm,range(1):range(2),:) = a' ;
           size_Glob = size(globalTable) 
           shape_init = shape'


           if (size_Glob(2) == shape_init(2))
            globalFrame = globalTable(frm,:,:)  
            seisio.setTraceDataArray(globalTable(frm,:,:));
            seisio.setPosition(position);
            seisio.writeFrame(size(a,2));
           end

           
           
         %  seisio.setTraceDataArray(globalTable);
         %  seisio.setPosition(position);
         %  seisio.writeFrame(size(a,2));
          
          
     end
     
      
 end
 

end


seisio.close() ;




end
