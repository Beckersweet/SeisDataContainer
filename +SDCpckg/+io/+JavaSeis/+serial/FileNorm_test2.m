function [x,y,zz] = FileNorm_test2(dirname,K,J,norm)
%FILENORM Calculates the norm of a given data
%
%   FileNorm(DIRNAME,FILENAME,DIMENSIONS,NORM,FILE_PRECISION)
%
%   DIRNAME        - A string specifying the input directory
%   NORM           - Specifyies the norm type. Supported norms: inf, -inf,
%                    'fro', p-norm where p is scalar.


% Load dynamic libraries
 javaaddpath('/Users/bcollignon/Documents/workspace/dhale-jtk-78bca79.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/betajavaseis1819.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/jama.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/javaSeisExample.jar');

SDCpckg.io.isFileClean(dirname);
%error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'input directory name must be a string')
assert(isdir(dirname),'Fatal error: input directory %s does not exist'...
    ,dirname)



% Reading the header
header    = SDCpckg.io.JavaSeis.serial.HeaderRead(dirname);
file_precision = 'double';
dimensions = header.size';

test = rand(dimensions) ;

% Set byte size
bytesize  = SDCpckg.utils.getByteSize(file_precision);

% Set the sizes
dims      = [1 prod(size(test))] ;
reminder  = prod(size(test)) ;
SDCbufferSize = reminder  ;
maxbuffer = SDCbufferSize/bytesize ;

if(norm == 'fro')
    norm = 2;
end

% Infinite norm
if(norm == inf)
   
    total = 0 ;
    totaltest2 = 0;
    x = -999 ;
    y = -999 ;
    z = 0;
    rstart = 1;
    buffer = min(reminder,maxbuffer);
    rend = rstart + buffer - 1;
    
    while (reminder > 0 && rend < SDCbufferSize)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        
        % We expect the Chunk to be already a vector
        r =  SDCpckg.io.JavaSeis.serial.DataReadLeftChunk(dirname,[1 K],[],[rstart rend],'double') ;
        size_r= size(r);
        
         for i=1:size_r(1)
             for t=1:size_r(2)
                  
                   matarr1D(1+z) = r(i,t) ;
                   z=z+1 ;
                  
             end
               
         end
         
        total     = max(abs(r)) ;
        x         = max(total,x) ;        
        reminder  = reminder - buffer;
        rstart    = rend + 1 ;
        clear r;
        
    end
     
   
     totaltest2 = beta.javaseis.examples.io.sum_inf.fileNormVectInf(matarr1D) ;
     y     = max(totaltest2,y);
     zz = y;
    
% Negative infinite norm    
elseif(norm == -inf)
 
    total =0 ;
    totaltest2 = 0;
    rstart = 1;
    
    x = inf;
    y = inf;
    z = 0;
    buffer = min(reminder,maxbuffer);
    rend = rstart + buffer - 1;
    
    while (reminder > 0 && rend < SDCbufferSize)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        
        % We expect the Chunk to be already a vector
        r =  SDCpckg.io.JavaSeis.serial.DataReadLeftChunk(dirname,[1 K],[],[rstart rend],'double') ;
        size_r= size(r);
        
         for i=1:size_r(1)
             for t=1:size_r(2)
                  
                   matarr1D(1+z) = r(i,t) ;
                   z=z+1 ;
                  
             end
               
         end
         
        total     = min(abs(r));
        x         = min(total,x);        
        reminder  = reminder - buffer;
        rstart    = rend + 1;
        clear r;
    end
    
    
    totaltest2 = beta.javaseis.examples.io.sum_inf.fileNormVectPInf(matarr1D) ;
    y = min(totaltest2,y) ;
    zz=y;
  %  x = total^(1/norm);
       
% P-norm
elseif (isscalar(norm))
 
    
    total = 0 ;
    totaltest2 = 0 ;
    z=0;
    anothertest = 0 ;
    rstart = 1;
    buffer = min(reminder,maxbuffer);
    rend = rstart + buffer - 1;
    while (reminder > 0 && rend < SDCbufferSize)
        buffer = min(reminder,maxbuffer);
        rend = rstart + buffer - 1;
        
        % We expect the Chunk to be already a vector
        r =  SDCpckg.io.JavaSeis.serial.DataReadLeftChunk(dirname,[1 K],[],[rstart rend],'double') ;
        size_r= size(r);
        
        % FileNormScalar works for 2D only
        anothertest = anothertest + beta.javaseis.examples.io.sum_inf.fileNormScalar(r,norm) ;
       
        
         for i=1:size_r(1)
             for t=1:size_r(2)
                  
                   matarr1D(1+z) = r(i,t) ;
                   z=z+1 ;
                  
              end
           
         end
        
        
      %  total    = total + sum(abs(r).^norm);
        reminder = reminder - buffer;
        rstart   = rend + 1;
        clear r;
    end
    
    zz = anothertest^(1/norm) 
    
    totaltest2 = beta.javaseis.examples.io.sum_inf.fileNormVectScalar(matarr1D,norm) ;
    y = totaltest2^(1/norm);
    
    x = total^(1/norm);
    
 %   total = 0;
 %   totaltest = 0;
 %   totaltest2 = 0;
 %   z = 0;    
 %   test = 0;    
    
 %        for k = 1:K
 %          for j = 1:J-2
            
 %              r = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,[j j+2],[k 1]) ;
 %              size_r= size(r)
 %              test = test + 1 
               
              
 %              for i=1:size_r(2)
 %               total    = total + sum(abs(r(:,i)).^norm) ;
 %              end
               
              % totaltest = totaltest+ beta.javaseis.examples.io.sum_inf.fileNormScalar(r,norm) ;
                
              % if length(size(r))>1
              %     r = reshape(r,[1 prod(size(r))]);
              % end
               
               
  %              for i=1:size_r(1)
                  
  %                 for t=1:size_r(2)
                   % Convert Matrix to Vector
                   % Be careful: Vector non-contigus in memory
                   % Meaning the size of the vector is larger
                   %a = r(i,t)
  %                 matarr1D(1+z) = r(i,t) ;
  %                 z=z+1 ;
                  
  %                 end
                   %total    = sumabs(r(i,:)) ;
                   % take the higher sum among rows
                   %x     = max(total,x);
                   
  %             end
               
               
              %totaltest2 = totaltest2 + beta.javaseis.examples.io.sum_inf.fileNormVectScalar(matarr1D,norm) ;
              
  %             clear r;
          
  %         end
  %       end
         
  %   SIZE =    size(matarr1D);
     
  %  totaltest2 = beta.javaseis.examples.io.sum_inf.fileNormVectScalar(matarr1D,norm) ;
  %  y = totaltest2^(1/norm);  
  
  %  x = total^(1/norm);
else
    error('Unsupported norm');
end
end
