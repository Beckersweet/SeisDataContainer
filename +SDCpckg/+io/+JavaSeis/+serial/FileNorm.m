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
    total =0 ;
    totaltest=0 ;
    totaltest2=0;
    x = -999 ;
    y = -999 ;
    
    z = 0; 
  %  matarr1D = dims 
    
   
         for k = 1:K
           for j = 1:J-2
              
               r = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,[j j+2],[k 1]) ;
               size_r= size(r);
               %test_r = r;
               
               % compare alapsed times between methods
               % telapsed1 < telapsed3 < telapsed2
               %tStart1 = tic 
               % sum all elements per row
               
               
               for i=1:size_r(1)
                  
                   for t=1:size_r(2)
                   % Convert Matrix to Vector
                   %a = r(i,t)
                   matarr1D(1+z) = r(i,t) ;
                   z=z+1;
                  
                   end
                   %total    = sumabs(r(i,:)) ;
                   % take the higher sum among rows
                   %x     = max(total,x);
                   
               end
               %tElapsed1 = toc(tStart1) 
              
               
               % No Need to transpose r (row to col)
               
               %tStart2 = tic 
               % totaltest = beta.javaseis.examples.io.sum_inf.fileNormInf(r) ;
               %tElapsed2 = toc(tStart2) 
               % y     = max(totaltest,y);
               % tElapsed2 = toc(tStart2) ; 
              
             
               %if length(size(r))>1
               %    r = reshape(r,[1 prod(size(r))]);
               %end
               
               %tStart3 = tic
               %totaltest2 = beta.javaseis.examples.io.sum_inf.fileNormVectInf(r) ;
               %y     = max(totaltest2,y);
               %tElapsed3 = toc(tStart3)
               % replace/compare for loop with JS/JAVA call 
               % need to calculate vector norm instead of matrix
               % chunk should be a vector 
              
               clear r
          
           end
         end
        
     size(matarr1D)
     totaltest2 = beta.javaseis.examples.io.sum_inf.fileNormVectInf(matarr1D) ;
     y     = max(totaltest2,y);
   
    
% Negative infinite norm    
elseif(norm == -inf)
    total =0 ;
    totaltest=0 ;
    x = 999 ;
    y = 999 ;
    z = 0; 
    
           for k = 1:K
           for j = 1:J-2
              
               r = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,[j j+2],[k 1]) ;
               size_r= size(r);
               %test_r = r;
               
               % compare alapsed times between methods
               % telapsed1 < telapsed3 < telapsed2
               %tStart1 = tic 
               % sum all elements per row
               
               
               for i=1:size_r(1)
                  
                   for t=1:size_r(2)
                   % Convert Matrix to Vector
                   %a = r(i,t)
                   matarr1D(1+z) = r(i,t) ;
                   z=z+1;
                  
                   end
                  
                   
               end
              
               clear r
          
           end
         end
        
     size(matarr1D)
     totaltest2 = beta.javaseis.examples.io.sum_inf.fileNormVectPInf(matarr1D) ;
     y     = min(totaltest2,y);      
    
         %for k = 1:K
         %  for j = 1:J-2
            
         %      r = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,[j j+2],[k 1]) ;
         %     size_r= size(r) ;
         %     test_r = r ;
               
               % sum all elements per row
         %     for i=1:size_r(1)
         % 
         %         r_row = r(i,:) ;
         %          total    = sumabs(r(i,:)) ;
                   % take the higher sum among rows
         %          x     = min(total,x);
         %      end
               
               
               
               % No Need to transpose r (row to col)
               
               
         %      totaltest = beta.javaseis.examples.io.sum_inf.fileNormPInf(r) ;
               
         %       y     = min(totaltest,y);
              
             
              
               
               % replace/compare for loop with JS/JAVA call 
               % need to calculate vector norm instead of matrix
               % chunk should be a vector 
              
         %      clear r
          
         %  end
         %end
        
       
    
    
% P-norm
elseif (isscalar(norm))
    total = 0;
    totaltest = 0;
    totaltest2 = 0;
    z = 0;    
        
         for k = 1:K
           for j = 1:J-2
            
               r = SDCpckg.io.JavaSeis.serial.FileReadLeftChunk(dirname,[j j+2],[k 1]) ;
               size_r= size(r);
              
               for i=1:size_r(2)
                total    = total + sum(abs(r(:,i)).^norm) ;
               end
               
              %  totaltest = beta.javaseis.examples.io.sum_inf.fileNormScalar(r,norm) ;
                
              % if length(size(r))>1
              %     r = reshape(r,[1 prod(size(r))]);
              % end
               
               
                for i=1:size_r(1)
                  
                   for t=1:size_r(2)
                   % Convert Matrix to Vector
                   %a = r(i,t)
                   matarr1D(1+z) = r(i,t) ;
                   z=z+1;
                  
                   end
                   %total    = sumabs(r(i,:)) ;
                   % take the higher sum among rows
                   %x     = max(total,x);
                   
               end
               
               
              %totaltest2 = totaltest2 + beta.javaseis.examples.io.sum_inf.fileNormVectScalar(matarr1D,norm) ;
              
              clear r
          
           end
         end
     
    totaltest2 = beta.javaseis.examples.io.sum_inf.fileNormVectScalar(matarr1D,norm) ;
    y = totaltest2^(1/norm);  
  
    x = total^(1/norm);
else
    error('Unsupported norm');
end
end
