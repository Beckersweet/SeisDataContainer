function [x,y,zz] = FileNorm_test2(dirname,K,J,norm)
%FILENORM Calculates the norm of a given data
%
%   FileNorm(DIRNAME,FILENAME,DIMENSIONS,NORM,FILE_PRECISION)
%
%   DIRNAME        - A string specifying the input directory
%   NORM           - Specifyies the norm type. Supported norms: inf, -inf,
%                    'fro', p-norm where p is scalar.
%   K, J : Temporary arguments for unit testing/debugging
%          Final signature should be : FileNorm(dirname,norm) 


% Load dynamic libraries
 javaaddpath('/Users/bcollignon/Documents/workspace/dhale-jtk-78bca79.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/betajavaseis1819.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/jama.jar');
 javaaddpath('/Users/bcollignon/Documents/workspace/javaSeisExample_test2.jar');

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
         
        % TwoDArrayNormPlusInf works for 2D only
        % anothertest = beta.javaseis.examples.io.PartNorm.TwoDArrayNormPlusInf(r) ; 
         
        total     = max(abs(r)) ;
        x         = max(total,x) ;        
        reminder  = reminder - buffer;
        rstart    = rend + 1 ;
        clear r;
        
    end
     
   
     totaltest2 = beta.javaseis.examples.io.PartNorm.ArrayNormPlusInf(matarr1D) ;
     y     = max(totaltest2,y);
     zz = y;
    
% Negative infinite norm    
elseif(norm == -inf)
 
    total =0 ;
    totaltest2 = 0;
    rstart = 1;
    
    dnorm = -999;
    double(dnorm);
    
    
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
         
        % TwoDArrayNormMinusInf works for 2D only
        % anothertest = beta.javaseis.examples.io.PartNorm.TwoDArrayNormMinusInf(r) ; 
         
        total     = min(abs(r));
        x         = min(total,x);        
        reminder  = reminder - buffer;
        rstart    = rend + 1;
        clear r;
    end
    
    
    totaltest2 = beta.javaseis.examples.io.PartNorm.ArrayNormMinusInf(matarr1D) ;
    y = min(totaltest2,y) ;
    zz= y;
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
        
        %TwoDArrayNormScalar works for 2D only
        anothertest = anothertest + beta.javaseis.examples.io.PartNorm.TwoDArrayNormScalar(r,norm) ;
       
        
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
    
    totaltest2 = beta.javaseis.examples.io.PartNorm.ArrayNormScalar(matarr1D,norm) ;
    y = totaltest2^(1/norm);
    
    x = total^(1/norm);
    
 
else
    error('Unsupported norm');
end
end
