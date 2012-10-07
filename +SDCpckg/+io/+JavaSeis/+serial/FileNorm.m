function [x,y,z] = FileNorm(dirname,K,J,norm)
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



if(norm == 'fro')
    norm = 2;
end

% Infinite norm
if(norm == inf)
    total =0 ;
    totaltest=0 ;
    x = -999 ;
    y = -999 ;
    
   
         for k = 1:K
           for j = 1:J-2
            
               r = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,[j j+2],[k 1]) ;
               size_r= size(r);
               test_r = r;
               
               % sum all elements per row
               for i=1:size_r(1)
                   r_row = r(i,:) ;
                   total    = sumabs(r(i,:)) ;
                   % take the higher sum among rows
                   x     = max(total,x);
               end
               
               
               
               % No Need to transpose r (row to col)
               
               
               totaltest = beta.javaseis.examples.io.sum_inf.fileNormInf(r) ;
               
                y     = max(totaltest,y);
              
             
              
              
               % replace/compare for loop with JS/JAVA call 
               % need to calculate vector norm instead of matrix
               % chunk should be a vector 
              
               clear r
          
           end
         end
        
       
    
   
    
% Negative infinite norm    
elseif(norm == -inf)
    total =0 ;
    totaltest=0 ;
    x = 999 ;
    y = 999 ;
    
   
         for k = 1:K
           for j = 1:J-2
            
               r = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,[j j+2],[k 1]) ;
               size_r= size(r) ;
               test_r = r ;
               
               % sum all elements per row
               for i=1:size_r(1)
                   r_row = r(i,:) ;
                   total    = sumabs(r(i,:)) ;
                   % take the higher sum among rows
                   x     = min(total,x);
               end
               
               
               
               % No Need to transpose r (row to col)
               
               
               totaltest = beta.javaseis.examples.io.sum_inf.fileNormPInf(r) ;
               
                y     = min(totaltest,y);
              
             
              
              
               % replace/compare for loop with JS/JAVA call 
               % need to calculate vector norm instead of matrix
               % chunk should be a vector 
              
               clear r
          
           end
         end
        
       
    
    
% P-norm
elseif (isscalar(norm))
    total = 0;
    totaltest = 0;
        
        
         for k = 1:K
           for j = 1:J-2
            
               r = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,[j j+2],[k 1]) ;
               size_r= size(r);
              
               for i=1:size_r(2)
                total    = total + sum(abs(r(:,i)).^norm) ;
               end
               
                totaltest = beta.javaseis.examples.io.sum_inf.fileNormScalar(r,norm) ;
               
               clear r
          
           end
         end
        
         
       
   
    y = totaltest^(1/norm);  
  
    x = total^(1/norm);
else
    error('Unsupported norm');
end
end
