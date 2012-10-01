function x = FileNorm(dirname,K,J,norm)
%FILENORM Calculates the norm of a given data
%
%   FileNorm(DIRNAME,FILENAME,DIMENSIONS,NORM,FILE_PRECISION)
%
%   DIRNAME        - A string specifying the input directory
%   NORM           - Specifyies the norm type. Supported norms: inf, -inf,
%                    'fro', p-norm where p is scalar.

SDCpckg.io.isFileClean(dirname);
%error(nargchk(2, 2, nargin, 'struct'));
assert(ischar(dirname), 'input directory name must be a string')
assert(isdir(dirname),'Fatal error: input directory %s does not exist'...
    ,dirname)



if(norm == 'fro')
    norm = 2;
end

% Infinite norm
if(norm == inf)
    total =0 ;
    x = -inf;
    
   
         for k = 1:K
           for j = 1:J-2
            
               r = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,[j j+2],[k 1]) ;
               size_r= size(r);
               
               for i=1:size_r(1)
                total    = total + max(abs(r(i,:))) ;
               end
               
               % replace for loop with JS call
               
               clear r
          
           end
         end
        
       
        x     = max(total,x);        
      
   
    
% Negative infinite norm    
elseif(norm == -inf)
   x=inf ;
   total = 0;     
        
       for k = 1:K
           for j = 1:J-2
            
               r = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,[j j+2],[k 1]) ;
               size_r= size(r);
              
               for i=1:size_r(1)
                total    = total + min(abs(r(i,:))) ;
               end
               
               % replace for loop with JS call
               
               clear r
          
           end
         end
        
       
        x    = min(total,x);        
        
       
    
    
% P-norm
elseif (isscalar(norm))
    total = 0;
  
        
        
        
         for k = 1:K
           for j = 1:J-2
            
               r = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,[j j+2],[k 1]) ;
               size_r= size(r);
              
               for i=1:size_r(2)
                total    = total + sum(abs(r(:,i)).^norm) ;
               end
               
               % replace for loop with JS call
               
               clear r
          
           end
         end
        
         
       
         
  
    x = total^(1/norm);
else
    error('Unsupported norm');
end
end
